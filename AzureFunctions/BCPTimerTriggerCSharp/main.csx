#r "System.Configuration"
#r "System.Data"
#r "System.IO.Compression.FileSystem"
#r "Microsoft.WindowsAzure.Storage"

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.IO.Compression;
using Microsoft.WindowsAzure.Storage;
using System.Threading.Tasks;

public static void Run(TimerInfo myTimer, TraceWriter log)
{
    log.Info($"C# Timer trigger function executed at: {DateTime.Now}");

    log.Info("Downloading zip file from storage....");

    var storageAccount = CloudStorageAccount.Parse("DefaultEndpointsProtocol=https;AccountName=;AccountKey=");
    var blobClient = storageAccount.CreateCloudBlobClient();
    var container = blobClient.GetContainerReference("bcp");
    var blob = container.GetBlockBlobReference("Cars.zip");
    blob.DownloadToFile($"{Path.GetTempPath()}\\cars.zip", FileMode.CreateNew);

    log.Info("Downloaded zip file from storage");

    log.Info("Try to unzip....");

    var d = Directory.CreateDirectory($"{Path.GetTempPath()}\\unzipcars");

    log.Info($"folder name is {d.FullName}");

    Directory.Delete(d.FullName, true);
    d = Directory.CreateDirectory($"{Path.GetTempPath()}\\unzipcars");
    ZipFile.ExtractToDirectory($"{Path.GetTempPath()}\\cars.zip", d.FullName);

    log.Info("unzip done");

    var filename = d.GetFiles("*.csv")[0].FullName;

    log.Info($"CSV filename is {filename}");

    DataTable sourceData = new DataTable();

    sourceData.Columns.Add("CarMake");
    sourceData.Columns.Add("CarModel");
    sourceData.Columns.Add("CarYear");

    log.Info("Reading CSV file...");

    using (var rd = new StreamReader(filename))
    {
        while (!rd.EndOfStream)
        {
            var splits = rd.ReadLine().Split(',');
            sourceData.Rows.Add(splits[0], splits[1], splits[2]);
        }
    }

    log.Info("BCP....");

    SqlBulkCopy bcp = new SqlBulkCopy("Server=tcp:.database.windows.net,1433;Initial Catalog=;Persist Security Info=False;User ID=;Password=;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
    bcp.DestinationTableName = "AzureFunctions.Cars";
    bcp.WriteToServer(sourceData);

    log.Info("upload to SQL done");

}
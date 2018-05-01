#r "System.Configuration"
#r "System.Data"

using System.Configuration;
using System.Data.SqlClient;
using System.Threading.Tasks;

public static async Task Run(TimerInfo myTimer, TraceWriter log)
{
    var str = ConfigurationManager.ConnectionStrings["sqldb_connection"].ConnectionString;
    using (SqlConnection conn = new SqlConnection(str))
    {
        conn.Open();
        var text = "UPDATE AzureFunctions.tblTest SET OrderDate = GETDATE() WHERE [Status] = 3";
        using (SqlCommand cmd = new SqlCommand(text, conn))
        {
            // Execute the command and log the # rows affected.
            var rows = await cmd.ExecuteNonQueryAsync();
            log.Info($"{rows} rows were updated");
        }

    }
}
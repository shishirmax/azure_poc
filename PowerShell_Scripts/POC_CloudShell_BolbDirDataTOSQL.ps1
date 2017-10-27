$ResourceGroupName="datalakepnpocrg"
$StorageAccountName="blobprateekn"
$ContainerName = "testfiles"

$params = @{

  'Database' = 'Edina'

  'ServerInstance' =  'contata.database.windows.net'

  'Username' = 'contata.admin'

  'Password' = 'C@ntata123'

  'OutputSqlErrors' = $true

  }

Set-AzureRmCurrentStorageAccount -ResourceGroupName $ResourceGroupName -StorageAccountName $StorageAccountName

$FileDetails = Get-AzureStorageBlob -Container $ContainerName

$FileName = $FileDetails.name

Invoke-Sqlcmd @params -Query "DROP TABLE IF EXISTS TempFileName; TRUNCATE TABLE tempList; "
  
Invoke-Sqlcmd @params -Query "	SELECT REPLACE('$($FileName)',' ', ',') AS FileName INTO TempFileName;"
	
Invoke-Sqlcmd @params -Query "INSERT INTO TempList(FileName) SELECT Split.a.value('.', 'VARCHAR(100)') AS FileName FROM (SELECT CAST ('<M>' + REPLACE(FileName, ',', '</M><M>') + '</M>' AS XML) AS Data FROM TempFileName) AS A CROSS APPLY Data.nodes ('/M') AS Split(a); "
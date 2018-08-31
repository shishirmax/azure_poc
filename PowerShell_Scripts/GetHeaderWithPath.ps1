#Get Header of file by passing the file with path location
#on executing this, it ask for the inFilePath parameter
#give the path 'C:/Folder/File.csv'

[CmdletBinding()]
Param(
  [Parameter(Mandatory=$True)][string]$inFilePath
)
$csvColumnNames = (Get-Content $inFilePath | Select-Object -First 1)
Write-Host $csvColumnNames
#Replace all LF EOF to CRLF
param([string]$paramString)
$path = $paramString
#$path = "D:\GIT\Azure_poc\PowerShell_Scripts\File\edina_contata_sessions.csv"
#$path = "D:\GIT\Azure_poc\PowerShell_Scripts\File\test.csv"
$text = [IO.File]::ReadAllText($path) -replace "`n", "`r`n"
[IO.File]::WriteAllText($path, $text)
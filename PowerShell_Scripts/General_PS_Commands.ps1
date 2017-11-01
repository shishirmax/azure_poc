#Check PowerShell Version
$PSversionTable

#Saving Data Directly to a Text File
Get-Process | Out-File c:\scripts\test.txt

#Saves all the running process in the system to the test.txt file.
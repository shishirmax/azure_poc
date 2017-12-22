#Check PowerShell Version
$PSversionTable

#Saving Data Directly to a Text File
Get-Process | Out-File D:\GIT\Azure_poc\PowerShell_Scripts\File\ProcessList.txt

#Saves all the running process in the system to the ProcessList.txt file.
#Get Header of only sys.txt file available at the location
Write-Host –NoNewLine (gc .\sys.txt |select -first 1)
#Get header of all csv files available at the location
Write-Host –NoNewLine (gc .\*.csv |select -first 1)
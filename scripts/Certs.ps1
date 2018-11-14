#Creates certReports directory if it doesnt exist
if(!(Test-Path $outputDirectory\certReports -PathType Container)) {
	#Creates directory to move CSV file to
	New-Item -ItemType directory -Path $outputDirectory\"certReports" | Out-Null
	Write-Host $outputDirectory\"certReports Created"
} else {
	#Do nothing, path was found
	Write-Host $outputDirectory\"certReports Exists"
}

if(!(Test-Path $outputDirectory\certReports\$date -PathType Container)) {
	#Creates directory to move CSV file to
	New-Item -ItemType directory -Path $outputDirectory\"certReports"\$date | Out-Null
	Write-Host $outputDirectory\"certReports"\$date "Created"
} else {
	#Do nothing, path was found
	Write-Host $outputDirectory\"certReports\"$date "Exists"
}

#Check to see if Log for server was generated already. Script will exit if log already exists
if(!(Test-Path $outputDirectory\"certReports\"$date\$computername"_"certfields.csv -PathType Leaf)) {
	Write-Host "Running script"
} else {
	Write-Host $outputDirectory\"certReports\"$date\$computername"_"certfields.csv "Already exists"
	exit
}

Get-ChildItem -recurse -path Cert:\LocalMachine\My | Select-Object SerialNumber, FriendlyName, Subject, NotBefore, NotAfter, issuer |  Export-Csv -append -NoTypeInformation $outputDirectory\"certReports\"$date\$computername"_"certfields.csv

Write-Host "Script has been run, CSV file was generated in: " $outputDirectory\"certReports\"$date
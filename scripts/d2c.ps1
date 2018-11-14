cls
#Creates diskSpaceReports directory if it doesnt exist
if(!(Test-Path $outputDirectory\diskSpaceReports -PathType Container)) {
	#Creates directory to move CSV file to
	New-Item -ItemType directory -Path $outputDirectory\"diskSpaceReports" | Out-Null
	Write-Host $outputDirectory\"diskSpaceReports Created"
} else {
	#Do nothing, path was found
	Write-Host $outputDirectory\"diskSpaceReports Exists"
}

#Creates $date directory if it doesn't exist
if(!(Test-Path $outputDirectory\"diskSpaceReports"\$date -PathType Container)) {
	#Creates directory to move CSV file to
	New-Item -ItemType directory -Path $outputDirectory\"diskSpaceReports"\$date | Out-Null
	Write-Host $outputDirectory\"diskSpaceReports"\$date "Created"
} else {
	#Do nothing, path was found
	Write-Host $outputDirectory\"diskSpaceReports"\$date "Exists"
}

#Check to see if Log for server was generated already. Script will exit if log already exists
if(!(Test-Path $outputDirectory\"diskSpaceReports"\$date\$computername"_"$date.csv -PathType Leaf)) {
	Write-Host "Running script"
} else {
	Write-Host $outputDirectory\"diskSpaceReports"\$date\$computername"_"$date.csv "Already exists"
	exit
}

#Creates the csv file
New-Item $outputDirectory\"diskSpaceReports"\$date\$computername"_"$date.csv | Out-Null

#Creates header file
New-Item $outputDirectory\"diskSpaceReports"\$date\$computername"_"$date.txt | Out-Null

#Sets header variable
$header = ('"' + $computername + '","' + $date + '"')

#Outputs contents of header to the header file
$header | Out-File -append $outputDirectory\"diskSpaceReports"\$date\$computername"_"$date.txt

#Creates a table showing Drive Letter, Used Space, Free Space, and Free Space as percentage. Then information from the table is piped to Export-CSV to populate the previously created CSV file
Get-PSDrive -PSProvider FileSystem |
Select-Object -Property Root,
@{Name='UsedGB';Expression={[math]::round($_.used/1gb,2)}}, 
@{Name='FreeGB';Expression={[math]::round($_.free/1gb,2)}}, 
@{Name='PctFree';Expression={[math]::round($_.free/($_.free+$_.used)*100,2)}} | Export-CSV -NoTypeInformation -append $outputDirectory\"diskSpaceReports"\$date\$computername"_"$date.csv

#Addes the header file to the bottom of the table in the CSV File
Add-Content -Path $outputDirectory\"diskSpaceReports"\$date\$computername"_"$date.csv -Value (Get-Content $outputDirectory\"diskSpaceReports"\$date\$computername"_"$date.txt)

#Deletes the useless header file
Remove-Item -Path $outputDirectory\"diskSpaceReports"\$date\$computername"_"$date.txt

#Tells user where CSV was put
Write-Host "Script has been run, CSV file was generated in: " $outputDirectory\"diskSpaceReports"\$date\
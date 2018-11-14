#Global Variables
#Permanent Variables
$Global:date = Get-Date -UFormat "%m-%d-%y"
$Global:computerName = $env:computerName

#Changeable Variables
$Global:outputDirectory = ".\logs"
$Global:inputDirectory
$Global:scriptDirectory = ".\scripts"

#Checks if directories exist
if(!(Test-Path $outputDirectory -PathType Container)) {
	#Creates Output Directory
	New-Item -ItemType directory -Path $outputDirectory | Out-Null
}else {
	#Continue Silently
}
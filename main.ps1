#Modular Script Suite

Clear-Host

#Load Modules
.\config\var | Out-Null

$menuOptions = $null
$choice = $null
$userInput = $null

#Sets menu option array to list all scripts in $scriptDirectory directory
$menuOptions = Get-ChildItem $scriptDirectory | Where-Object {-not $_.PsIsContainer} | Foreach-Object {$_}


Write-Host "Choose a script to run: "
While($userInput -ne "q") {
	#Displays Menu
	for($i = 0; $i -lt $menuOptions.Length; $i++){
		Write-Host $i"." $menuOptions[$i].BaseName
	}
	
	Write-Host "Type 'q' to quit"
	
	#Reads user input
	$userInput = Read-Host -Prompt 'Choose an option: '

	foreach($line in $menuOptions[$userInput].fullname) {
		if($line -match $regex){
			# Work here
			invoke-expression $line
			pause
			Clear-Host
		}
	}	
	
}
Clear-Host
cls

Write-Host "0. Output Directory: "

#Checks to see if variable is NULL
if($outputDirectory -eq $null){
	Write-Host "Output Directory is Null"
}else {
$outputDirectory
}

Write-Host "1 .Input Directory: "

#Checks to see if variable is NULL
if($inputDirectory -eq $null){
	Write-Host "Imput Directory is Null"
}else {
$inputDirectory
}

Write-Host 'Type "q" to quit'
#Initiates Selection loop
#Loop ends when q is set as $userInput
While($userInput -ne "q") {
	$userInput = Read-Host -Prompt 'Choose a variable to change'
	Switch($userinput) {
		"0" {$userInput = Read-Host -Prompt 'Input Directory for Output';
			 $Global:outputDirectory = $userInput; 
			 $outputDirectory; 
			 Write-Host "Output directory is: "
			 break;}
		"1" {$userInput = Read-Host -Prompt 'Input Directory for Output';
			 $Global:inputDirectory = $userInput; 
			 $inputDirectory; 
			 Write-Host "Input directory is: "
			 break;}

		"q" {break;}
		default {Write-Host "That is not a valid choice"}
	}
}
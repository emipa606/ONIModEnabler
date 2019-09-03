#pragma compile(Icon, .\oni.ico)
#pragma compile(ProductName, ONIModEnabler)
#pragma compile(ProductVersion, 1.0)
#pragma compile(FileVersion, 1.0.1.0)
#pragma compile(FileDescription, Auto-enables all previously enabled mods before starting ONI)
#include <File.au3>
#include <FileConstants.au3>
#include <Array.au3>

$modConfig = "C:\Users\" & @UserName & "\Documents\Klei\OxygenNotIncluded\mods\mods.json"
$modFile = FileOpen($modConfig, 0)
$fileContent = FileRead($modFile)
FileClose($modFile)
$fileContentSplitted = StringSplit($fileContent, @LF, 2)
$lastLine = ""
$newFileContent = ""
For $line in $fileContentSplitted
   If $lastLine = "" Then
	  $lastLine = $line & @LF
	  ContinueLoop
   EndIf
   If Not StringInStr($line, "crash_count") Or StringInStr($line, '"crash_count": 0') Then
	  $newFileContent = $newFileContent & $lastLine
   Else
	  $newFileContent = $newFileContent & (StringReplace($lastLine, "false", "true"))
   EndIf
   $lastLine = $line & @LF
Next
$modFile = FileOpen($modConfig, 2)
FileWrite($modFile, $newFileContent)
FileClose($modFile)

$uninstallString = RegRead("HKLM64\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 457140", "UninstallString")
$steamPath = (StringSplit($uninstallString, '"', 2))[1]
Run($steamPath & ' -applaunch 457140')
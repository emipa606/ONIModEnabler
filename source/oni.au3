#pragma compile(Icon, .\oni.ico)
#pragma compile(ProductName, ONIModEnabler)
#pragma compile(ProductVersion, 1.0)
#pragma compile(FileVersion, 1.0.2.0)
#pragma compile(FileDescription, Auto-enables all previously enabled mods before starting ONI)
#include <File.au3>
#include <Array.au3>

$modConfig = "C:\Users\" & @UserName & "\Documents\Klei\OxygenNotIncluded\mods\mods.json"
$modFile = FileOpen($modConfig, 0)
$fileContent = FileRead($modFile)
FileClose($modFile)
$fileContentSplitted = StringSplit($fileContent, @CRLF, 3)
$lastLine = ""
$i = -1
For $line in $fileContentSplitted
   $i = $i + 1
   If $lastLine = "" Then
	  $lastLine = $line
	  ContinueLoop
   EndIf
   If StringInStr($line, "crash_count") And Not StringInStr($line, '"crash_count": 0') Then
	  _FileWriteToLine($modConfig, $i, (StringReplace($lastLine, "false", "true")), True)
   EndIf
   $lastLine = $line
Next

$uninstallString = RegRead("HKLM64\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 457140", "UninstallString")
$steamPath = (StringSplit($uninstallString, '"', 2))[1]
Run($steamPath & ' -applaunch 457140')
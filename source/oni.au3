#pragma compile(Icon, .\oni.ico)
#pragma compile(ProductName, ONIModEnabler)
#pragma compile(ProductVersion, 1.0)
#pragma compile(FileVersion, 1.0.0.0)
#pragma compile(FileDescription, Auto-enables all mods before starting ONI)
#include <File.au3>
$modConfig = "C:\Users\" & @UserName & "\Documents\Klei\OxygenNotIncluded\mods\mods.json"
_ReplaceStringInFile ( $modConfig, '"enabled": false', '"enabled": true')

$uninstallString = RegRead("HKLM64\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 457140", "UninstallString")
$steamPath = (StringSplit($uninstallString, '"', 2))[1]
Run($steamPath & ' -applaunch 457140')
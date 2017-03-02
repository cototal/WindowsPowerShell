$modulePath = Split-Path -Path $profile
$moduleName = "CustomModule.psm1"
Import-Module "$($modulePath)\$($moduleName)"
Set-CustomProfile
Clear-Host
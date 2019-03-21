$modulePath = Split-Path -Path $profile
$dockerUtilsModule = "DockerUtilsModule.psm1"
Import-Module "$($modulePath)\$($dockerUtilsModule)"
$customModule = "CustomModule.psm1"
Import-Module "$($modulePath)\$($customModule)"

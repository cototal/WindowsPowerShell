$modulePath = Split-Path -Path $profile
$dockerUtilsModule = "DockerUtilsModule.psm1"
Import-Module "$($modulePath)\$($dockerUtilsModule)"
$customModule = "CustomModule.psm1"
Import-Module "$($modulePath)\$($customModule)"

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

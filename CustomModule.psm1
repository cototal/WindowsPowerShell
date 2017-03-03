<#
Set up your profile with:

    New-Item -path $profile -type file -force

Erase that new .ps1 file and clone this repo into the directory created
#>

# Find files that contain the searchString text. Excluding node_modules for now,
# may add more directories to exclude later.
function Select-ItemsInDirectory($searchString) {
    Get-ChildItem -Recurse *.* |
    Where-Object { !($_.FullName).Contains("node_modules") } |
    Select-String -Pattern $searchString |
    Select-Object -Unique Path
}
Set-Alias ack Select-ItemsInDirectory

function Add-GitCommit($message) {
    git add . -A
    git commit -m $message
}
Set-Alias gam Add-GitCommit

function Update-GitCommit() {
    git add . -A
    git commit --amend --no-edit
}
Set-Alias gamend Update-GitCommit

function Get-RecentGitLog() {
    git log --max-count=15 --pretty=format:\"%h - %an, %ar : %s\"
}
Set-Alias gitlog Get-RecentGitLog

Clear-Host
Write-Host "Profile Loaded"
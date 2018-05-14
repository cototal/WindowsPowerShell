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

# Call with: 'rb sample one, two, three'
function Start-RubyScript($scriptName, $arguments) {
    # Convert string to array if only one argument is given
    if ($arguments.GetType() -eq [String]) {
        $arguments = @($arguments)
    }
    ruby $env:USERPROFILE\Scripts\$scriptName.rb @arguments
}
Set-Alias rb Start-RubyScript

function Set-WordPressDirectory($themePlugin, $name) {
    cd "wp-content`\$themePlugin`\$name"
}
Set-Alias wpd Set-WordPressDirectory

function Write-BlankFile($filename) {
    [IO.File]::WriteAllLines($filename, "")
}
Set-Alias touch Write-BlankFile

# Use with docker as:
#   docker run --name cont -it --rm -v "$(upwd):/myapp" -p 5000:5000 img
function Set-UnixPwd() {
    $path = $pwd
    $path = $path -replace "\\", "/"
    $path = $path -replace "C:", "/c"
    return $path
}
Set-Alias upwd Set-UnixPwd

function Set-WorkingDirectory() {
    $(Get-Location).Path | Out-File "/tmp/swd"
}

function Get-WorkingDirectory() {
    Set-Location -Path $(Get-Content "/tmp/swd")
}

Set-Variable VSProjects "$HOME\Documents\Visual Studio 2017\Projects"
Set-Alias ll Get-ChildItem
Set-Alias swd Set-WorkingDirectory
Set-Alias lwd Get-WorkingDirectory

Clear-Host
Write-Host "Profile Loaded"

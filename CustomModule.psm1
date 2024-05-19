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

function Start-SshProxy($hostName) {
    ssh -D 8123 -f -C -q -N $hostName
}
Set-Alias spx Start-SshProxy

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

function Get-RandomString($length = 16) {
    -join ((48..57) * 10 + (97..122) * 10 | Get-Random -Count $length | ForEach-Object {[char]$_})
}
Set-Alias rnd Get-RandomString

# @deprecated: Just use ${PWD}
# Use with docker as:
#   docker run --name cont -it --rm -v "$(upwd):/myapp" -p 5000:5000 img
function Set-UnixPwd() {
    $path = $pwd
    $path = $path -replace "\\", "/"
    $path = $path -replace "C:", "/c"
    return $path
}
Set-Alias upwd Set-UnixPwd

# @deprecated: Use Go versions for better handling
function Set-WorkingDirectory($Project = "default") {
    $(Get-Location).Path | Out-File "/tmp/swd-$Project"
}

# @deprecated: Use Go versions for better handling
function Get-WorkingDirectory($Project = "default") {
    Set-Location -Path $(Get-Content "/tmp/swd-$Project")
}

# Depends on the save-working-directory being installed to path
function Set-GoWorkingDirectory($Project = "default") {
    save-working-directory -s $Project
}
Set-Alias swd Set-GoWorkingDirectory

# Depends on the save-working-directory being installed to path
function Get-GoWorkingDirectory($Project = "default") {
    $output = save-working-directory -l $Project
    if ($LASTEXITCODE -ne 1) {
        Set-Location -Path $output
    }
}
Set-Alias lwd Get-GoWorkingDirectory

# Depends on the save-working-directory being installed to path
function Remove-GoWorkingDirectory($Project) {
    save-working-directory -d $Project
}
Set-Alias dwd Remove-GoWorkingDirectory

# Depends on the save-working-directory being installed to path
function Show-GoWorkingDirectories() {
    save-working-directory --list
}
Set-Alias wdlist Show-GoWorkingDirectories

Set-Alias ll Get-ChildItem

Clear-Host
Write-Host "Profile Loaded"

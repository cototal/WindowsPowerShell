Set up your profile with:

    New-Item -path $profile -type file -force

Erase that new .ps1 file and clone this repo into the directory created.

Change the execution policy from an administrator session:

    Set-ExecutionPolicy RemoteSigned

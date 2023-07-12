function Create-Symlink {
    param(
        [string]$Source,
        [string]$Target
    )
    if (Test-Path $Target) {
        Rename-Item $Target "$Target`_old"
    }
    New-Item -ItemType SymbolicLink -Path $Target -Value $Source
}
# Import scoop application list
& $PSScriptRoot\scoop.ps1
scoop import $PSScriptRoot\program_list.json
Remove-Item $PSScriptRoot\program_list.json
# Set mpv portable config folder
[System.Environment]::SetEnvironmentVariable('MPV_HOME', "$PSScriptRoot\mpv", 'User')
# Install powershell modules and set profile
Install-Module posh-git -Scope CurrentUser
Install-Module Terminal-Icons -Scope CurrentUser
Create-Symlink -Source $PSScriptRoot\git\.gitconfig -Target $HOME\.gitconfig
Create-Symlink -Source $PSScriptRoot\git\.gitconfig-work -Target $HOME\.gitconfig-work
Create-Symlink -Source $PSScriptRoot\powershell\main.ps1 -Target $PROFILE
Create-Symlink -Source $PSScriptRoot\nvim -Target $env:LOCALAPPDATA\nvim
Create-Symlink -Source $PSScriptRoot\scoop -Target $HOME\.config\scoop
Create-Symlink -Source $PSScriptRoot\komorebi\whkdrc -Target $HOME\.config\whkdrc

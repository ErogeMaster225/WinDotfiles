# Import scoop application list
& $PSScriptRoot\scoop.ps1
scoop import $PSScriptRoot\program_list.json
Remove-Item $PSScriptRoot\program_list.json
# Set mpv portable config folder
[System.Environment]::SetEnvironmentVariable('MPV_HOME', "$PSScriptRoot\mpv", 'User')
if (-Not (Test-Path -Path "$HOME\.gitconfig")) {
	New-Item -Path $HOME\.gitconfig -ItemType SymbolicLink -Value $PSScriptRoot\git\.gitconfig
}
Install-Module posh-git -Scope CurrentUser
Install-Module Terminal-Icons -Scope CurrentUser
if (-Not (Test-Path -Path "$PROFILE")) {
	New-Item -Path $PROFILE -ItemType SymbolicLink -Value $PSScriptRoot\powershell\main.ps1
}
New-Item -Path $HOME\.config\scoop -ItemType SymbolicLink -Value $PSScriptRoot\scoop
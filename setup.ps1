# Set mpv portable config folder
[System.Environment]::SetEnvironmentVariable('MPV_HOME', "$PSScriptRoot\mpv", 'User')
if (-Not (Test-Path -Path "$HOME\.gitconfig")) {
	New-Item -Path $HOME\.gitconfig -ItemType SymbolicLink -Value $PSScriptRoot\git\.gitconfig
}
if (-Not (Test-Path -Path "$PROFILE")) {
	New-Item -Path $PROFILE -ItemType SymbolicLink -Value $PSScriptRoot\powershell\main.ps1
}
# Set mpv portable config folder
[System.Environment]::SetEnvironmentVariable('MPV_HOME', "$PSScriptRoot\mpv", 'User')
NEW-Item -Path $PROFILE -ItemType SymbolicLink -Value $PSScriptRoot\powershell\main.ps1
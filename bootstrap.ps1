# Install Scoop package manager
if ($null -eq $env:SCOOP) {
	Invoke-RestMethod get.scoop.sh | Invoke-Expression
	scoop bucket add .SM 'https://github.com/okibcn/ScoopMaster'
	if ($null -eq (Get-Command "git.exe" -ErrorAction SilentlyContinue)) {
		scoop install git
	}
	# Import scoop application list
	scoop import $PSScriptRoot\scoop.json
}
# Set mpv portable config folder
[System.Environment]::SetEnvironmentVariable('MPV_HOME', "$PSScriptRoot\mpv", 'User')


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
if (-Not (Test-Path -Path "$HOME\WinDotfiles")) {
	git clone https://github.com/ErogeMaster225/WinDotfiles $HOME\WinDotfiles
}
& $HOME\WinDotfiles\setup.ps1
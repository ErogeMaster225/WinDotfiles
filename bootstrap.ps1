# Install Scoop package manager
if ($null -eq (Get-Command "scoop" -ErrorAction SilentlyContinue)) {
	Invoke-RestMethod get.scoop.sh | Invoke-Expression
	if ($null -eq (Get-Command "git.exe" -ErrorAction SilentlyContinue)) {
		scoop install git
	}
	scoop bucket add .SM 'https://github.com/okibcn/ScoopMaster'
}
if (-Not (Test-Path -Path "$HOME\WinDotfiles")) {
	git clone https://github.com/ErogeMaster225/WinDotfiles $HOME\WinDotfiles
	git clone https://github.com/ErogeMaster225/Nilvim $HOME\WinDotfiles\nvim
}
& $HOME\WinDotfiles\setup.ps1

# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
# Prompt theme
oh-my-posh init pwsh --config "$HOME\WinDotfiles\powershell\erogemaster225.omp.json" | Invoke-Expression
# Fnm
fnm env --use-on-cd | Out-String | Invoke-Expression
# PSReadLine
# Fzf
# Alias
Set-Alias ll ls
Set-Alias vim nvim
Set-Alias p pnpm
Set-Alias abm pnpm
function d () {
  pnpm dev
}
function b () {
  pnpm build
}
# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
  Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
# Lazyload
$LazyLoadProfile = [PowerShell]::Create()
[void]$LazyLoadProfile.AddScript(@'
    Import-Module PSFzf
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
'@)
$LazyLoadProfileRunspace = [RunspaceFactory]::CreateRunspace()
$LazyLoadProfile.Runspace = $LazyLoadProfileRunspace
$LazyLoadProfileRunspace.Open()
[void]$LazyLoadProfile.BeginInvoke()

$null = Register-ObjectEvent -InputObject $LazyLoadProfile -EventName InvocationStateChanged -Action {
  Import-Module -Name Terminal-Icons
  Import-Module -Name posh-git
  Import-Module PSFzf
  Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
  Set-PSReadLineOption -PredictionSource History
  Set-PSReadLineOption -PredictionViewStyle ListView
  Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
  $LazyLoadProfile.Dispose()
  $LazyLoadProfileRunspace.Close()
  $LazyLoadProfileRunspace.Dispose()
}
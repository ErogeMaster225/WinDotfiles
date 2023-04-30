[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
# Load the JSON file
$json = Get-Content -Raw -Path "$PSScriptRoot\scoop.json" | ConvertFrom-Json

# Create the GUI form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Program Installer"
$form.Width = 1280
$form.Height = 720
$form.StartPosition = "CenterScreen"
$form.AutoScroll = $true
# Create a checkbox for each program in the JSON
$i = 0
foreach ($program in $json.apps) {
	$checkbox = New-Object System.Windows.Forms.CheckBox
	$checkbox.Text = $program.Name
	$checkbox.Size = New-Object System.Drawing.Size(300, 20)
	$checkbox.Tag = $i
	$checkbox.Checked = $true
	if ($i % 2 -eq 0) {
		$checkbox.Location = New-Object System.Drawing.Point(20, ($i * 20 + 10 + 50))
	}
	else {
		$checkbox.Location = New-Object System.Drawing.Point(660, ($i * 20 - 10 + 50))
	}
	$form.Controls.Add($checkbox)
	$i++
}

# Create an "Install" button
$button = New-Object System.Windows.Forms.Button
$button.Text = "Install"
$button.Size = New-Object System.Drawing.Size(100, 30)
$button.Location = New-Object System.Drawing.Point(20, 20)
$button.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $button
$form.Controls.Add($button)

# Show the form and wait for the user to select programs
$result = $form.ShowDialog()

# Create a new JSON file containing only the checked programs
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
	$new_json = @{
		apps    = @()
		buckets = $json.buckets
	}
	foreach ($control in $form.Controls) {
		if ($control.GetType().Name -eq "CheckBox" -and $control.Checked) {
			$index = $control.Tag
			$program = $json.apps[$index]
			$new_json.apps += $program
		}
	}
	$new_json | ConvertTo-Json | Out-File "program_list.json"
}
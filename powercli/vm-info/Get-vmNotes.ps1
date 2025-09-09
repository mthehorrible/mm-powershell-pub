$vCenter = Read-Host "Enter vCenter Name"

# Open window to select txt file containing server list
$wshell = New-Object -ComObject Wscript.Shell
$wshell.Popup("Enter text file with names of VMs")|OUT-NULL
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |Out-Null
$openFileDialog = New-Object System.Windows.Forms.openFileDialog
$openFileDialog.filter = "TXT Files (*.txt)|*.txt"
$openFileDialog.ShowDialog() | Out-Null
$filesv=$openFileDialog.filename
$vmList = Get-Content $filesv

# Connect to vCenter
[void](Connect-VIServer $vCenter)

ForEach ($vm in $vmList){
    # Get VM info
    $vmInfo=Get-VM $vm -ErrorAction Stop -Server $vCenter

	# Display Info
	Write-Host "`n"
	Write-Host "Name:           " $vm -ForegroundColor Magenta
	Write-Host "Cluster:        " ($vmInfo|VMware.VimAutomation.Core\Get-Cluster).Name
	Write-Host "Folder:         " ($vmInfo).Folder.Name
	Write-Host "Notes:          " ($vmInfo).Notes
	Write-Host "Tags:           " ($vmInfo|Get-TagAssignment).Tag
	Write-Host "`n"
}

# Disconnect from vCenter
Disconnect-VIServer * -Confirm:$false

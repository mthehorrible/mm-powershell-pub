# Set vCenter and Cluster
$vc = Read-Host "Enter vCenter FQDN"
$cluster = Read-Host "Enter vCenter Cluster"

# Output File
$path = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
$file = "$path\$((Get-Date).ToString("yyyy-MM-dd"))_($cluster)_drs_rules.csv"

# Connect to vCenter
[void](Connect-VIServer $vc)

# Create array for report
$report = @()

# Get current DRS rules
$drsrules = Get-Cluster -Name $cluster | Get-DrsRule

# Gather rule info
foreach ($rule in $drsrules) {
	$row = "" | Select-Object ClusterName, RuleName, RuleEnabled, KeepTogether, VMs
	$row.ClusterName = (Get-View -Id $rule.ClusterId).Name
	$row.RuleName = $rule.Name
	$row.RuleEnabled = $rule.Enabled
	$row.KeepTogether = $rule.KeepTogether
	$vms = ""
	foreach ($vmId in $rule.VMIds) {
		$vms += ((Get-View -Id $vmId).Name + ",")
	}
	$row.VMs = $VMs
	$report += $row
}

# Export to CSV
$report | Export-Csv $file -NoTypeInformation

# Disconnect from vCenter
Disconnect-VIServer * -Confirm:$false
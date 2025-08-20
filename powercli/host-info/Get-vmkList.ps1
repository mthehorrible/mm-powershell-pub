# Prompt for vCenter to connect to
$vcenter = Read-Host "Enter vCenter address"

# Export to a CSV file
$exportCsv = $TRUE
$path = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
$csv = "$path\$((Get-Date).ToString("yyyy-MM-dd"))-$vcenter-vmk-list.csv"

# Connect to vCenter
[void](Connect-VIServer $vcenter)

# Gather VMKernel Information for each host
$output = Get-VMHost * | 
    sort | 
    Get-VMHostNetworkAdapter -VMKernel | 
    Select-Object VMHost, IP, SubNetMask, PortGroupName, DeviceName, VMotionEnabled

# Disconnect from vCenter
Disconnect-VIServer -Confirm:$false

# Output results to CSV or terminal
if ($exportCsv -eq $TRUE) { 
    $output | Export-Csv $csv -NoTypeInformation -Encoding utf8
} else {
    $output | Format-Table -AutoSize
}
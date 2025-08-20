# Prompt for vCenter to connect to
$vcenter = Read-Host "Enter vCenter address"

# Export to a CSV file
$exportCsv = $TRUE
$path = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
$csv = "$path\$((Get-Date).ToString("yyyy-MM-dd"))-$vcenter-host-specs.csv"

# Connect to vCenter
[void](Connect-VIServer $vcenter)

# Gather Info
$output = Get-VMHost | 
    Select-Object -Property Name, 
        Model, 
        ProcessorType, 
        NumCpu, 
        @{N='MemTotGB';E={[math]::Round($_.MemoryTotalGB,2)}},
        Version,
        Build

# Disconnect from vCenter
Disconnect-VIServer * -Confirm:$false

# Output results to CSV or terminal
if ($exportCsv -eq $TRUE) { 
    $output | Export-Csv $csv -NoTypeInformation -Encoding utf8
} else {
    $output | Format-Table -AutoSize
}
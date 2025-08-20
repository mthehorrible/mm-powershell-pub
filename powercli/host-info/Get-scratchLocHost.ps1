$vCenter = Read-Host "Enter vCenter address"
$ESXiHost = Read-Host "Enter ESXi hostname"

# Connect to vCenter
[void](Connect-VIServer $vcenter)

# Gather Info
$hostInfo = Get-VMHost -Name $ESXiHost
$advConfig = $hostInfo | Get-AdvancedSetting -Name 'ScratchConfig.ConfiguredScratchLocation'
$advCurrent = $hostInfo | Get-AdvancedSetting -Name 'ScratchConfig.CurrentScratchLocation'

# Set Info as Variables
$hName = $hostInfo.Name
$hVersion = $hostInfo.Version
$hBuild = $hostInfo.Build
$hUptime = $hostInfo.ExtensionData.Summary.Runtime.BootTime
$scratchConfig = $advConfig.Value
$scratchCurrent = $advCurrent.Value

# Display Info
Write-Host "`n"
Write-Host "Name:                 $hName"
Write-Host "Version:              $hVersion"
Write-Host "Build:                $hBuild"
Write-Host "Boot Time:            $hUptime"
Write-Host "Configured Scratch:   $scratchConfig"
Write-Host "Current Scratch:      $scratchCurrent"
Write-Host "`n"

# Disconnect from vCenter
Disconnect-VIServer * -Confirm:$false
function Get-ESXiScratch {
    [CmdletBinding()]
    Param(
            [Parameter(Mandatory=$True)][string]$vCenter
            )

	# Connect to vCenter
	[void](Connect-VIServer $vcenter)

	# Get and display configured scratch location
	$scrConf="ScratchConfig.ConfiguredScratchLocation"

	Write-Host "`nConfigured Scratch Locations" -ForegroundColor Magenta

	&{foreach($esx in Get-VMHost){
	  Get-AdvancedSetting -Entity $esx -Name $scrConf |
	  Select @{N="Host";E={$esx.Name}},Value
	}} | ft -autosize

	# Get and display current scratch location
	$scrCurr="ScratchConfig.CurrentScratchLocation"

	Write-Host "`nCurrent Scratch Locations" -ForegroundColor Magenta

	&{foreach($esx in Get-VMHost){
	  Get-AdvancedSetting -Entity $esx -Name $scrCurr |
	  Select @{N="Host";E={$esx.Name}},Value
	}} | ft -autosize

	# Disconnect from vCenter
	Disconnect-VIServer * -Confirm:$false

}

#######################################

Get-ESXiScratch
# Prompt for vCenter to connect to and IP address to find
$vCenter = Read-Host "Enter vCenter address"
$IP = Read-Host "Enter IP to find"

# Connect to vCenter
[void](Connect-VIServer $vcenter)

# Gather VM info, select VMs matching the IP then display results
Get-VM * |
where-object{$_.Guest.IPAddress -match "$IP"} |
Select-Object Name,
    VMHost,
    PowerState,
    GuestId,
    @{N="IP  Address";E={@($_.guest.IPAddress[0])}} |
Format-Table

# Disconnect from vCenter
Disconnect-VIServer * -Confirm:$false

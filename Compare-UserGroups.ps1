# Get users to compare
$userA = Read-Host "Enter the first user"
$userB = Read-Host "Enter the user to compare to"

# Get and sort list of groups for each user
$groupsA = (Get-AdprincipalGroupMembership $UserA|Sort-Object name).name
$groupsB = (Get-AdprincipalGroupMembership $UserB|Sort-Object name).name

# Compare lists
$comp = Compare-Object $($groupsA) $($groupsB) -IncludeEqual

# List groups unique to UserA
Write-Host "`n`nGroups unique to user $UserA`n********" -ForegroundColor Magenta
$comp|where-object{$_.sideindicator -eq "<="}|Sort-Object inputobject|Select-Object -ExpandProperty inputobject

# List groups unique to UserB
write-host "`n`nGroups unique to user $UserB`n********" -ForegroundColor Magenta
$comp|where-object{$_.sideindicator -eq "=>"}|Sort-Object inputobject|Select-Object -ExpandProperty inputobject

# List groups both users are members of
Write-Host "`n`nCommon Groups`n********" -ForegroundColor Cyan
$comp|where-object{$_.sideindicator -eq "=="}|Sort-Object inputobject|Select-Object -ExpandProperty inputobject

$year = Read-Host "`nEnter year (YYYY)"
$month = Read-Host "Enter month (number)"

$output = $month |
    ForEach-Object {$f=[datetime]([string]$_ + "/1/$year");(0..30 |
    ForEach-Object {$f.adddays($_)} |
    Where-Object {$_.dayofweek -like "Tue*"})[1]}

Write-Host "`n" $output.tostring("D") "`n" -ForegroundColor Green
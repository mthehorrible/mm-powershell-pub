$SysInfo = Get-WmiObject win32_operatingsystem

Write-Host "Computer Name:            " $env:COMPUTERNAME -ForegroundColor Magenta
Write-Host "Active Directory Domain:  " $env:USERDNSDOMAIN -ForegroundColor Magenta
Write-Host "Username:                 " $env:username -ForegroundColor Magenta
Write-Host "Windows Version:          " $SysInfo.Version -ForegroundColor Magenta
Write-Host "Last Boot Time:           " $SysInfo.ConverttoDateTime($SysInfo.lastbootuptime) -ForegroundColor Magenta
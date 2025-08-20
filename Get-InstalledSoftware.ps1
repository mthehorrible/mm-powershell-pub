Get-WmiObject -Class Win32_InstalledWin32Program |
    Select-Object Name, Version, Vendor |
    Export-Csv "$($env:computername)_InstalledSoftware.csv" -NoTypeInformation -Encoding UTF8
Get-WmiObject Win32_OperatingSystem | Select-Object PSComputerName, Caption, OSArchitecture, Version, BuildNumber | Format-List

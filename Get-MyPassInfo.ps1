Get-AdUser $env:username -properties SamAccountName,PasswordLastSet,PasswordExpired,PasswordNeverExpires,msDS-UserPasswordExpiryTimeComputed,AccountExpirationDate |
    Select-Object -Property Name,SamAccountName,PasswordLastSet,PasswordExpired,PasswordNeverExpires,@{Name="PasswordExpirationDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}},AccountExpirationDate

Read-Host -Prompt "Press any key to close"
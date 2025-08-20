[CmdletBinding()]
    Param([Parameter(Mandatory=$False,Position=1)][string[]]$users)

$users = Read-Host "Enter users or leave blank to use a text file"
$users = $users.split(",")

if (!$users) {
    $wshell = New-Object -ComObject Wscript.Shell
    $wshell.Popup("Enter Text File with usernames")|OUT-NULL
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |Out-Null
    $openFileDialog = New-Object System.Windows.Forms.openFileDialog
    $openFileDialog.filter = "TXT Files (*.txt)|*.txt"
    $openFileDialog.ShowDialog() | Out-Null
    $filesv=$openFileDialog.filename
    $users = Get-Content $filesv
}

$Output=@() 

ForEach($user in $users){
    $Output+=get-aduser $user -properties SamAccountName,PasswordLastSet,PasswordExpired,PasswordNeverExpires,msDS-UserPasswordExpiryTimeComputed,AccountExpirationDate
}

$Output|Format-Table Name,SamAccountName,PasswordLastSet,PasswordExpired,PasswordNeverExpires,@{Name="PasswordExpirationDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}},AccountExpirationDate

try{
    Start-Process -FilePath cmd.exe /c -Credential (get-credential -Credential "$env:USERDOMAIN\$env:username")
    Write-Host "Correct Credentials" -ForegroundColor Green
}
catch{
    Write-Host "Incorrect Credentials" -ForegroundColor Red
}
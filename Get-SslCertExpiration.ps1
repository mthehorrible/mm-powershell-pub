$domains = @(
    "https://google.com",
    "https://yahoo.com"
    )

# Ignore SSL Warning
[Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }

ForEach($domain in $domains){
    # Create Web Http request and gather info
    $webRequest = [Net.HttpWebRequest]::Create($domain)
    [void]($webRequest.ServicePoint)
    [void]($webRequest.GetResponse())

    # Get SSL Certificate Expiration Date
    $expirationDate = $webRequest.ServicePoint.Certificate.GetExpirationDateString()

    # Remove https:// for output
    $domainOut = $domain -Replace ".*//",''

    # Display output
    Write-Host "The SSL Certificate for " -NoNewline;
    Write-Host "$domainOut" -ForegroundColor Magenta -NoNewline;
    Write-Host " expires on " -NoNewline;
    Write-Host "$expirationDate" -ForegroundColor Cyan
}

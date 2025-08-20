$awsAccessKey = "<AWS-ACCESS-KEY>"
$awsSecretKey = "<AWS-SECRET-KEY>"
$smtpServer = "email-smtp.us-east-1.amazonaws.com" #update if using different region
$smtpPort = "587"
$emailTo = "<TO-ADDRESS>"
$emailFrom = "<FROM-ADDRESS>"
$emailSubject = "<SUBJECT>"
$emailBody = "<MESSAGE>"

#creds
$sesPasswd = ConvertTo-SecureString $awsSecretKey -AsPlainText -Force
$sesCred = New-Object System.Management.Automation.PSCredential ($awsAccessKey, $sesPasswd)

Send-MailMessage -To $emailTo -Subject $emailSubject -BodyAsHtml:$true -Body $emailBody -From $emailFrom -SmtpServer $smtpServer -Port $smtpPort -Credential $sesCred -UseSsl
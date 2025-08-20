$smtpServer = "<SMTP-SERVER>"
$smtpPort = "25"
$emailTo = "<TO-ADDRESS>"
$emailFrom = "<FROM-ADDRESS>"
$emailSubject = "<SUBJECT>"
$emailBody = "<MESSAGE>"

Send-MailMessage -To $emailTo -Subject $emailSubject -BodyAsHtml:$true -Body $emailBody -From $emailFrom -SmtpServer $smtpServer -Port $smtpPort
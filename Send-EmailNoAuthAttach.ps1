#Create test file in Windows
#fsutil file createnew test.txt 30720000

$smtpServer = "<SMTP-SERVER>"
$smtpPort = "25"
$emailTo = "<TO-ADDRESS>"
$emailFrom = "<FROM-ADDRESS>"
$emailSubject = "<SUBJECT>"
$emailBody = "<MESSAGE>"
$attachment = "<ATTACHMENT>"

Send-MailMessage -To $emailTo -Subject $emailSubject -BodyAsHtml:$true -Body $emailBody -From $emailFrom -Attachment $attachment -SmtpServer $smtpServer -Port $smtpPort

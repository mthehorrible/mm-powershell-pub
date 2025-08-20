$ntpServer=Read-Host "Enter the NTP server to test"
$testCount=Read-Host "Enter the number of tests to run"

w32tm /stripchart /computer:$ntpServer /dataonly /samples:$testCount
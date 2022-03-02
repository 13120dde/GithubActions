$atConfiguration = $args[0]
$siteName = $args[1]
$user = $args[2]
$password = $args[3]

Write-Host "Starting FW upgrade script for following configuration:"

write-host "\t AT: " + $atConfiguration
write-host "\t Site: " + $siteName
write-host "\t User: " + $user
write-host "\tPassword: " + $password
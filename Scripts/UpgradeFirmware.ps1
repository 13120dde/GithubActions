$atConfiguration = $args[0]
$siteName = $args[1]
$user = $args[2]
$password = $args[3]

Write-Host "Starting FW upgrade script for following configuration:"

write-host "`tAT: $atConfiguration"
write-host "`tSite: $siteName"
write-host "`tUser: $user"
write-host "`tPassword: $password"
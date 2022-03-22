$atConfiguration = $args[0]
$siteName = $args[1]
$user = $args[2]
$password = $args[3]

Write-Host "Starting FW upgrade script for following configuration:"

write-host "`tAT: $atConfiguration"
write-host "`tSite: $siteName"
write-host "`tUser: $user"
write-host "`tPassword: $password"

$Char = [PSCustomObject]@{
    Name = "Value"
    Id = "aaa"
}

$CurrentDir = Get-Location
Write-Host $FilePath
$FilePath = $CurrentDir.ToString()+"artifacts/characters/"+$Char.Name+"_"+$Char.Id+".json"

Write-Host $FilePath
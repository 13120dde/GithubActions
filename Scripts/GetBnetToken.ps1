
#$ClientID = $args[0]
#$ClientSecret = $args[1]
#$Realm = $args[2]

$ClientID = "b2398853129540a9b736381f2b65007e"
$ClientSecret = "2X8z6QpMhfXQuXwaqW6Dq9iDpX7Ci9pN"

#$Url = "https://"+$Region+".battle.net/oauth/token"

$Url = "https://eu.battle.net/oauth/token"
$RequestBody = @{
    client_id  = $ClientID
    client_secret  = $ClientSecret
    grant_type = 'client_credentials'
}
$Result = Invoke-WebRequest -Uri $Url -Method Post -Body $RequestBody
$Token = ConvertFrom-Json $Result.Content

Write-Host $Token
return $Token.access_token
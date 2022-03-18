
$ClientID = $args[0]
$ClientSecret = $args[1]
$Region = $args[2]
Write-Host "region $Region"
$Url = "https://"+$Region+".battle.net/oauth/token"
$RequestBody = @{
    client_id  = $ClientID
    client_secret  = $ClientSecret
    grant_type = 'client_credentials'
}
$Result = Invoke-WebRequest -Uri $Url -Method Post -Body $RequestBody
$Token = ConvertFrom-Json $Result.Content
return $Token.access_token
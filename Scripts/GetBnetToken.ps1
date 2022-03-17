
$ClientID = $args[0]
$ClientSecret = $args[1]

$Uri = "https://eu.battle.net/oauth/token"
$FormRequest = @{
    client_id  = $ClientID
    client_secret  = $ClientSecret
    grant_type = 'client_credentials'
}
$Result = Invoke-WebRequest -Uri $Uri -Method Post -Body $FormRequest
$token = ConvertFrom-Json $Result.Content
return $token.access_token
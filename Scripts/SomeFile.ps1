$Uri = "https://us.battle.net/oauth/token"
$Form = @{
    client_id  = 'b2398853129540a9b736381f2b65007e'
    client_secret  = '2X8z6QpMhfXQuXwaqW6Dq9iDpX7Ci9pN'
    grant_type = 'client_credentials'
}
$Result = Invoke-RestMethod -Uri $Uri -Method Post -Form $Form
Write-Host $Result
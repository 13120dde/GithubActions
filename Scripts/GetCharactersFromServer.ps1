
$AccessToken = "Bearer "+$args[0]
$Region = $args[1]
$GAMER_PROFILE =[System.Web.HTTPUtility]::UrlEncode($args[2])

$Url = "https://$Region.api.blizzard.com/d3/profile/$GAMER_PROFILE/?locale=en_US"
Write-Host $Url
Write-Host "accToken: $AccessToken"

$Result = Invoke-WebRequest -Uri $Url -Method Get -Headers @{'Authorization' = $AccessToken}

$ResultContent = ConvertFrom-Json $Result.Content
$Heroes = $ResultContent.heroes

$HeroesParsed = @()
foreach($Hero in $Heroes){
    $HeroesParsed += [PSCustomObject] @{
        Id = $Hero.id.ToString()
        ClassSlug = $Hero.classSlug
    }
}

return ConvertTo-Json -Compress $HeroesParsed



#$AccessToken = "Bearer $args[0]"
#$Region = $args[1]
#$GAMER_PROFILE =[System.Web.HTTPUtility]::UrlEncode($args[2])

$AccessToken = "EUFSlH3SMa8N5qJiCVv7RixovrezD8tySk"

$Region = "eu"
$GAMER_PROFILE = [System.Web.HTTPUtility]::UrlEncode("Brodde#2647")


$Url = "https://$Region.api.blizzard.com/d3/profile/$GAMER_PROFILE/?locale=en_US"
Write-Host $Url

$Result = Invoke-WebRequest -Uri $Url -Method Get -Body $RequestBody -Headers @{'Authorization' = "Bearer US0HEZzeN79S5oqPMDyL2Ds2E0i9Ahe5jv"}

$ResultContent = ConvertFrom-Json $Result.Content
$Heroes = $ResultContent.heroes

$HeroesParsed = @()
foreach($Hero in $Heroes){
    $HeroesParsed += [PSCustomObject] @{
        Id = $Hero.id
        ClassSlug = $Hero.classSlug
    }

}
return ConvertTo-Json $HeroesParsed


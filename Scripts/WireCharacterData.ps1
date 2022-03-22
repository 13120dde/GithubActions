$Region = $args[0]
$GAMER_PROFILE =[System.Web.HTTPUtility]::UrlEncode($args[1])
$AccessToken = "Bearer "+$args[2]
$HeroID = $args[3]
$ClassSlug = $args[4]

Write-Host $Region
Write-Host $GAMER_PROFILE
Write-Host $AccessToken
Write-Host $HeroID
Write-Host $ClassSlug


$Region = "eu"
$GAMER_PROFILE ="Brodde%232647"
$AccessToken ="Bearer EUrOo6zeFePgP7LFps3aiS0mrHNGPeRqYH"
$HeroID = 134165191
$ClassSlug = "crusader"
$UrlHero = "https://$Region.api.blizzard.com/d3/profile/$GAMER_PROFILE/hero/$HeroID?locale=en_US"
$Result = Invoke-WebRequest -Uri $UrlHero -Method Get -Headers @{'Authorization' = $AccessToken}

$HeroContent = ConvertFrom-Json -InputObject $Result.Content

Write-Host $HeroContent
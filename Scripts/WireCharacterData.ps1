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
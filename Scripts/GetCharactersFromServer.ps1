$AccessToken = "Bearer "+$args[0]
#$AccessToken = "Bearer EUFSlH3SMa8N5qJiCVv7RixovrezD8tySk"
$Region = $args[1]
#$Region ="eu"
$GAMER_PROFILE =[System.Web.HTTPUtility]::UrlEncode($args[2])
#$GAMER_PROFILE ="Brodde%232647"
$Url = "https://$Region.api.blizzard.com/d3/profile/$GAMER_PROFILE/?locale=en_US"
Write-Host $Url
Write-Host "at: $AccessToken"

$Result = Invoke-WebRequest -Uri $Url -Method Get -Headers @{'Authorization' = $AccessToken}
$Result
$ResultContent = ConvertFrom-Json $Result.Content
$Heroes = $ResultContent.heroes

$HeroesParsed = @()
foreach($Hero in $Heroes){
    $HeroesParsed += [PSCustomObject] @{
        Id = $Hero.id.ToString()
        ClassSlug = $Hero.classSlug

    }
}
Write-Host "heroes parsed: $HeroesParsed"
$Matrix = [PSCustomObject]@{
    include = $HeroesParsed
}

Write-Host "matrix: $Matrix"
return ConvertTo-Json  -Compress -InputObject $Matrix
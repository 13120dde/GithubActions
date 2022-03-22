$AccessToken = "Bearer "+$args[0]
#$AccessToken = "Bearer EUrOo6zeFePgP7LFps3aiS0mrHNGPeRqYH"
$Region = $args[1]
#$Region ="eu"
$GAMER_PROFILE =[System.Web.HTTPUtility]::UrlEncode($args[2])
#$GAMER_PROFILE ="Brodde%232647"
$Url = "https://$Region.api.blizzard.com/d3/profile/$GAMER_PROFILE/?locale=en_US"
Write-Host $Url
Write-Host "at: $AccessToken"

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

$Matrix = [PSCustomObject]@{
    include = $null
}
$Matrix.include = $HeroesParsed

Write-Host "matrix: $Matrix"
return ConvertTo-Json  -Compress -InputObject $Matrix
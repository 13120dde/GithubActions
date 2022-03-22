function Get-HighestProgression()
{
    param
    (
        [PSCustomObject]$Progression
    )

    $HighestProgression = [PSCustomObject]@{
        Act = $null;
        ActCompleted = $null;
        Quest = $null;
    }
    if($Progression.act1.completedQuests.Length -gt 0){

        $HighestProgression.Quest = $Progression.act1.completedQuests[$Progression.act1.completedQuests.Length-1].name
        $HighestProgression.Act = 1
        $HighestProgression.ActCompleted = $Progression.act1.completed
    }
    if($Progression.act2.completedQuests.Length -gt 0){

        $HighestProgression.Quest = $Progression.act2.completedQuests[$Progression.act2.completedQuests.Length-1].name
        $HighestProgression.Act = 2
        $HighestProgression.ActCompleted = $Progression.act2.completed
    }
    if($Progression.act3.completedQuests.Length -gt 0){

        $HighestProgression.Quest = $Progression.act3.completedQuests[$Progression.act3.completedQuests.Length-1].name
        $HighestProgression.Act = 3
        $HighestProgression.ActCompleted = $Progression.act3.completed
    }
    if($Progression.act4.completedQuests.Length -gt 0){

        $HighestProgression.Quest = $Progression.act4.completedQuests[$Progression.act4.completedQuests.Length-1].name
        $HighestProgression.Act = 4
        $HighestProgression.ActCompleted = $Progression.act4.completed
    }
    if($Progression.act5.completedQuests.Length -gt 0){

        $HighestProgression.Quest = $Progression.act5.completedQuests[$Progression.act5.completedQuests.Length-1].name
        $HighestProgression.Act = 5
        $HighestProgression.ActCompleted = $Progression.act5.completed

    }
    return $HighestProgression

}

function Get-HeroItems()
{
    param
    (
        [PSCustomObject]$Items
    )

    $ItemTableRaw =@{}
    $Items.psobject.Properties | foreach {$ItemTableRaw[$_.Name] = $_.Value}

    [hashtable]$ItemTableClean=@{}
    foreach($Item in $ItemTableRaw.GetEnumerator())
    {
        $Value = [PSCustomObject]@{
            Name = $Item.Value.name;
            ItemLevel = $Item.Value.itemLevel;
            MinDamage = $Item.Value.minDamage;
            MaxDamage = $Item.Value.maxDamage;
            Aps = $Item.Value.attacksPerSecond;
            Armor = $Item.Value.armor
            TypeName = $Item.Value.typeName;
            Attributes = $Item.Value.attributes
            SetName = $Item.Value.set.name
        }

        $ItemTableClean.Add($Item.Key, $Value)

    }

    return $ItemTableClean
}

$Region = $args[0]
$GAMER_PROFILE =[System.Web.HTTPUtility]::UrlEncode($args[1])
$AccessToken = "Bearer "+$args[2]
$HeroID = $args[3].ToString()
$ClassSlug = $args[4]


#$Region = "eu"
#$GAMER_PROFILE ="Brodde%232647"
#$AccessToken ="Bearer EUrOo6zeFePgP7LFps3aiS0mrHNGPeRqYH"
#$HeroId = "154019444"
#$ClassSlug = "necromancer"

Write-Host "Wiring data for $HeroID $ClassSlug"

### FETCH DATA ###
$UrlHero = "https://$Region.api.blizzard.com/d3/profile/$GAMER_PROFILE/hero/"+$HeroId+"?locale=en_US"
Write-Host "Fetching Hero data from: $UrlHero"
$Result = Invoke-WebRequest -Uri $UrlHero -Method Get -Headers @{'Authorization' = $AccessToken}
$HeroContent = ConvertFrom-Json -InputObject $Result.Content

$UrlHeroItems = "https://$Region.api.blizzard.com/d3/profile/$GAMER_PROFILE/hero/"+$HeroId+"/items?locale=en_US"
Write-Host "Fetching Hero Item data from: $UrlHeroItems"
$Result = Invoke-WebRequest -Uri $UrlHeroItems -Method Get -Headers @{'Authorization' = $AccessToken}
$HeroItemsContent = ConvertFrom-Json -InputObject $Result.Content

### CLEAN DATA ###
$HighestProgression = Get-HighestProgression($HeroContent.progression)
$ItemsCleaned = Get-HeroItems($HeroItemsContent)

### CREATE JSON ###
$Hero = [PSCustomObject]@{
    Class = $HeroContent.class;
    Name = $HeroContent.name;
    Id = $HeroContent.id;
    Level = $HeroContent.level;
    ParagonLevel = $HeroContent.paragonLevel;
    EliteKills = $HeroContent.kills.elites;
    Progression = $HighestProgression;
    Stats = $HeroContent.stats
    Gear = $ItemsCleaned
}

$HeroJson = ConvertTo-Json -Compress -InputObject $Hero -Depth 10
Write-Host "HERO JSON:"
Write-Host $HeroJson
return $HeroJson

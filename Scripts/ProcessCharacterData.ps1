$CurrentDir = Get-Location
$CurrentDirParent = (Get-Item $CurrentDir).Parent.FullName
$ArtilfactFolder = $CurrentDirParent.ToString()+"\artifacts\characters\"
Write-Host "Artifact folder: $ArtilfactFolder"

$HighestKills = 0
$HighestHero = $null
foreach($File in Get-ChildItem $ArtilfactFolder)
{
    # Processing code goes here
    $Hero = Get-Content -Raw -Path $File.FullName | ConvertFrom-Json
    if($Hero.EliteKills -gt $HighestKills)
    {
        $HighestKills = $Hero.EliteKills
        $HighestHero = $Hero
    }
}

Write-Host $HighestHero
$Message = "### HIGHEST  CHARACTER###`n`n"
$Message += "Name: "+$HighestHero.Name+"`n"
$Message += "Class: "+$HighestHero.Class+"`n"
$Message += "Elite Kills: "+$HighestHero.EliteKills+"`n`n"
$Message += "Stats: `n"

$ItemTableRaw =@{}
$HighestHero.Stats.psobject.Properties | foreach {$ItemTableRaw[$_.Name] = $_.Value}
foreach($Item in $ItemTableRaw.GetEnumerator())
{
    $Message +="`t"+$Item.Key+": "+$Item.Value+"`n"
}
$Message += "Gear:`n"
$ItemTableRaw =@{}
$HighestHero.Gear.psobject.Properties | foreach {$ItemTableRaw[$_.Name] = $_.Value}
foreach($Item in $ItemTableRaw.GetEnumerator())
{
    $GearSummary = $Item.Value.Name+" - "+$Item.Value.TypeName
    $Message +="`t"+$Item.Key+": "+$GearSummary+"`n"
}

Write-Host $Message
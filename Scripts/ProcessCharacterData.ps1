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
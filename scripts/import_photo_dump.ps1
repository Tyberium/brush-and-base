# Import photo_dump -> assets/photos with site naming convention.
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not (Test-Path "$root\photo_dump")) { $root = Split-Path -Parent $PSScriptRoot }
$dump = Join-Path $root "photo_dump"
$photos = Join-Path $root "assets\photos"
$review = Join-Path $photos "review"
New-Item -ItemType Directory -Force -Path $review | Out-Null

$items = @(
  @{ o = "IMG_20211209_103521.jpg"; s = "heroquest_orc"; n = "Finished Ork Kommando squad on bases" }
  @{ o = "IMG_20220212_115830.jpg"; s = "rubric_marine"; n = "Gold spray prime on assembled rubrics" }
  @{ o = "IMG_20220614_150407045.jpg"; s = "scarab_occult_terminators"; n = "Bare plastic assembly" }
  @{ o = "IMG_20220628_221306633.jpg"; s = "rubric_marine"; n = "Teal armour and gold trim complete" }
  @{ o = "IMG_20220701_223413802.jpg"; s = "rubric_marine"; n = "Rear view WIP with gold base rim" }
  @{ o = "IMG_20220711_221936443.jpg"; s = "rubric_marine"; n = "Pink-striped headdress and purple base" }
  @{ o = "IMG_20220719_140434391.jpg"; s = "rubric_marine"; n = "Soulreaper gunner in gold and teal" }
  @{ o = "IMG_20230223_135452155.jpg"; s = "tzaangor_enlightened"; n = "WIP base coats on painting handle" }
  @{ o = "IMG_20230319_220655513.jpg"; s = "review"; n = "Necromunda Escher ganger - no entry yet" }
  @{ o = "IMG_20231013_220401550.jpg"; s = "heroquest_orc"; n = "Female orc warrior near paint pots" }
  @{ o = "IMG_20231014_164738651.jpg"; s = "heroquest_orc"; n = "Three fantasy orcs on grey bases" }
  @{ o = "IMG_20231017_124519687.jpg"; s = "review"; n = "Thousand Sons Helbrute - no entry yet" }
  @{ o = "IMG_20231017_124758282.jpg"; s = "review"; n = "Helbrute side angle" }
  @{ o = "IMG_20231102_143831708.jpg"; s = "rubric_marine"; n = "Teal and silver rubric with orcs nearby" }
  @{ o = "IMG_20231102_143834091.jpg"; s = "rubric_marine"; n = "Bronze trim rubric on textured base" }
  @{ o = "IMG_20231102_143837116.jpg"; s = "review"; n = "Helbrute close-up with warp flesh" }
  @{ o = "IMG_20231102_143846473.jpg"; s = "wip_chaos_marine"; n = "Red Chaos Terminator on white base" }
  @{ o = "IMG_20231219_223223399.jpg"; s = "review"; n = "Necromunda Escher gang" }
  @{ o = "IMG_20231221_220538571.jpg"; s = "scarab_occult_terminators"; n = "WIP teal base coat" }
  @{ o = "IMG_20231229_143822432.jpg"; s = "rubric_marine"; n = "Gunmetal silver base coat" }
  @{ o = "IMG_20240122_230527723.jpg"; s = "tzaangor_enlightened"; n = "Four Tzaangors plus Exalted Sorcerer" }
  @{ o = "IMG_20240124_230400156.jpg"; s = "tzaangor_enlightened"; n = "Finished Tzaangor on red base" }
  @{ o = "IMG_20240127_213107580.jpg"; s = "review"; n = "Chaos Knight plus finished Tzaangor scale shot" }
  @{ o = "IMG_20240208_134551279.jpg"; s = "exalted_sorcerer"; n = "Finished Exalted Sorcerer with warp sword" }
  @{ o = "IMG_20240211_210207849.jpg"; s = "exalted_sorcerer"; n = "WIP detail pass on blade OSL" }
  @{ o = "IMG_20240228_211914924.jpg"; s = "exalted_sorcerer"; n = "Force stave and sandy base" }
  @{ o = "IMG_20240302_172721824.jpg"; s = "review"; n = "HeroQuest skeleton - no entry yet" }
  @{ o = "IMG_20240325_215544885.jpg"; s = "magnus"; n = "Unpainted wing subassembly" }
  @{ o = "IMG_20240325_215612886.jpg"; s = "magnus"; n = "Unpainted wing subassembly angle two" }
  @{ o = "IMG_20240517_232940129.jpg"; s = "rubric_marine"; n = "Bare plastic unprimed torso" }
  @{ o = "IMG_20240530_155456009.jpg"; s = "review"; n = "TSons-colour Daemon Prince" }
  @{ o = "IMG_20240530_155530035.jpg"; s = "review"; n = "Daemon Prince front view" }
  @{ o = "IMG_20240615_144519533_BURST000_COVER.jpg"; s = "mutalith_vortex_beast"; n = "Grey primer on cutting mat" }
  @{ o = "IMG_20241019_220617601.jpg"; s = "exalted_sorcerer"; n = "Sorcerer on red base in handle" }
  @{ o = "IMG_20241024_131456961_HDR.jpg"; s = "exalted_sorcerer"; n = "Two sorcerers on discs - partial vs gold coat" }
  @{ o = "IMG_20241129_154053006.jpg"; s = "airbrush_priming"; n = "Goblin airbrush coated lime green" }
  @{ o = "IMG_20241223_222234874.jpg"; s = "review"; n = "HeroQuest Barbarian" }
  @{ o = "IMG_20241223_222240825_BURST000_COVER.jpg"; s = "review"; n = "HeroQuest Wizard" }
  @{ o = "IMG_20241223_222248118_BURST000_COVER.jpg"; s = "review"; n = "Silver elf warrior - not HeroQuest orc" }
  @{ o = "IMG_20241223_222300666.jpg"; s = "review"; n = "Orange-bearded dwarf warrior" }
  @{ o = "IMG_20241225_184828890_BURST000_COVER.jpg"; s = "review"; n = "Elven warrior in painting handle" }
  @{ o = "IMG_20241228_162037169.jpg"; s = "airbrush_priming"; n = "Exalted Sorcerer on Disc - zenithal highlight" }
  @{ o = "IMG_20241231_215709108_HDR.jpg"; s = "snot_goblin_terrain"; n = "Snot goblin figure WIP in handle" }
  @{ o = "IMG_20250101_214809545_HDR.jpg"; s = "review"; n = "HeroQuest Barbarian close-up" }
  @{ o = "IMG_20250101_220555146.jpg"; s = "review"; n = "HeroQuest Barbarian sword macro" }
  @{ o = "IMG_20250111_131317082_HDR.jpg"; s = "airbrush_priming"; n = "HeroQuest Barbarian brown primer" }
  @{ o = "IMG_20250118_205548625_BURST000_COVER.jpg"; s = "review"; n = "Barbarian green OSL sword - Mutalith behind" }
  @{ o = "IMG_20250118_210326671_HDR.jpg"; s = "mutalith_vortex_beast"; n = "Airbrushing vortex ring glow" }
  @{ o = "IMG_20250120_220742992.jpg"; s = "mutalith_vortex_beast"; n = "Full model purple body and vortex" }
  @{ o = "IMG_20250203_222517154_HDR.jpg"; s = "scarab_occult_terminators"; n = "Rear view turquoise and bronze" }
  @{ o = "IMG_20250203_231347908_HDR.jpg"; s = "scarab_occult_terminators"; n = "Front view combi-bolter and khopesh" }
  @{ o = "IMG_20250205_122240133_HDR.jpg"; s = "scarab_occult_terminators"; n = "Side macro lime-green cables" }
  @{ o = "IMG_20250228_221008512_HDR.jpg"; s = "rubric_marine"; n = "WIP leg and tabard - torso unpainted" }
  @{ o = "IMG_20250306_215849029_HDR.jpg"; s = "ahriman"; n = "Finished on Disc of Tzeentch" }
  @{ o = "IMG_20250314_225729608.jpg"; s = "magnus"; n = "Collar sub-assembly magenta recesses" }
  @{ o = "IMG_20250322_162551943_HDR.jpg"; s = "magnus"; n = "Head WIP on pin" }
  @{ o = "IMG_20250323_202141481_HDR.jpg"; s = "magnus"; n = "Head WIP held in hand" }
  @{ o = "IMG_20250421_174953297.jpg"; s = "magnus"; n = "Torso sub-assembly magenta primer" }
  @{ o = "IMG_20250424_161841197.jpg"; s = "scarab_occult_terminators"; n = "Sorcerer finished with desert base" }
  @{ o = "IMG_20250424_202636738.jpg"; s = "review"; n = "Blue winged Daemon Prince" }
  @{ o = "IMG_20250425_224156558_HDR.jpg"; s = "magnus"; n = "Head WIP on Blu-Tack" }
  @{ o = "IMG_20250429_213043793.jpg"; s = "exalted_sorcerer"; n = "Three sorcerers group shot" }
  @{ o = "IMG_20250505_214210711_HDR.jpg"; s = "ahriman"; n = "WIP on Disc - cyan head" }
  @{ o = "IMG_20250520_143635500.jpg"; s = "exalted_sorcerer"; n = "Striped headdress and silver staff" }
  @{ o = "IMG_20250523_164005688.jpg"; s = "exalted_sorcerer"; n = "Horned helmet warpflame cosmic base" }
  @{ o = "IMG_20250716_104940592.jpg"; s = "scarab_occult_terminators"; n = "Sorcerer with red crystal base" }
  @{ o = "IMG_20250907_202535170.jpg"; s = "tzaangor_enlightened"; n = "Zenithal prime Greatbow Tzaangor" }
  @{ o = "IMG_20251009_194556253.jpg"; s = "magnus"; n = "Red skin and black hair WIP" }
  @{ o = "IMG_20251115_221055423.jpg"; s = "review"; n = "Necromunda Escher archer" }
  @{ o = "IMG_20251118_221424133.jpg"; s = "review"; n = "Escher Wild Runner in handle" }
  @{ o = "IMG_20251210_213554679.jpg"; s = "review"; n = "Escher ganger WIP stubber" }
  @{ o = "IMG_20251218_184207104.jpg"; s = "heroquest_orc"; n = "Grey plastic orc on hex base" }
  @{ o = "IMG_20251221_172622086.jpg"; s = "review"; n = "Escher archer finished" }
  @{ o = "IMG_20251221_172909576_HDR.jpg"; s = "review"; n = "Escher archer aiming pose" }
  @{ o = "IMG_20251226_225125970.jpg"; s = "mutalith_vortex_beast"; n = "Purple body teal armour WIP" }
  @{ o = "IMG_20260117_184647509.jpg"; s = "review"; n = "HeroQuest Barbarian on hex base" }
  @{ o = "IMG_20260117_215629074.jpg"; s = "review"; n = "Barbarian with pink grass tufts" }
  @{ o = "IMG_20260123_211458446.jpg"; s = "tzaangor_enlightened"; n = "Zenithal prime on Disc of Tzeentch" }
  @{ o = "IMG_20260220_094325623.jpg"; s = "tzaangor_enlightened"; n = "Two Tzaangors on discs WIP" }
  @{ o = "IMG_20260226_213753823.jpg"; s = "tzaangor_enlightened"; n = "Three Tzaangors desk progress" }
  @{ o = "IMG_20260304_211433646.jpg"; s = "tzaangor_enlightened"; n = "Greatbow Tzaangor blue and gold" }
  @{ o = "IMG_20260304_211537647.jpg"; s = "tzaangor_enlightened"; n = "Spear Tzaangor side profile" }
  @{ o = "IMG_20260324_223202605.jpg"; s = "tzaangor_enlightened"; n = "Front view blue and gold armour" }
  @{ o = "IMG_20260331_222647223_HDR.jpg"; s = "tzaangor_enlightened"; n = "Torso WIP arms not attached" }
  @{ o = "IMG_20260331_222722836_HDR.jpg"; s = "tzaangor_enlightened"; n = "Dynamic pose feather tabard" }
  @{ o = "IMG_20260424_080023752_HDR.jpg"; s = "tzaangor_enlightened"; n = "Three finished Tzaangors on discs" }
  @{ o = "IMG_20260509_131018940_HDR.jpg"; s = "exalted_sorcerer"; n = "Back view on Disc of Tzeentch" }
  @{ o = "IMG_20260607_210600143.jpg"; s = "wip_chaos_marine"; n = "Black-primed assembly" }
)

function Get-DateFromOriginal($name) {
  if ($name -match 'IMG_(\d{4})(\d{2})(\d{2})') {
    return "{0}{1}{2}" -f $Matches[3], $Matches[2], $Matches[1]
  }
  throw "No date in $name"
}

$imported = @{}
$reviewItems = @()
$bySlug = @{}

foreach ($item in $items) {
  $src = Join-Path $dump $item.o
  if (-not (Test-Path $src)) { Write-Warning "Missing: $($item.o)"; continue }
  $date = Get-DateFromOriginal $item.o
  $key = "$($item.s)|$date"
  if (-not $bySlug.ContainsKey($key)) { $bySlug[$key] = 0 }
  $bySlug[$key]++
  $seq = "{0:D2}" -f $bySlug[$key]

  if ($item.s -eq "review") {
    $destName = "review_${date}_$seq.jpg"
    $dest = Join-Path $review $destName
    $web = "/assets/photos/review/$destName"
  }
  else {
    $count = @($items | Where-Object { $_.s -eq $item.s -and (Get-DateFromOriginal $_.o) -eq $date }).Count
    if ($count -eq 1) { $destName = "$($item.s)_$date.jpg" }
    else { $destName = "$($item.s)_${date}_$seq.jpg" }
    $dest = Join-Path $photos $destName
    $web = "/assets/photos/$destName"
  }

  if (-not (Test-Path $dest)) {
    Copy-Item $src $dest
  }
  elseif ((Get-Item $src).Length -ne (Get-Item $dest).Length) {
    $base = [IO.Path]::GetFileNameWithoutExtension($destName)
    $ext = [IO.Path]::GetExtension($destName)
    $destName = "${base}_alt$seq$ext"
    if ($item.s -eq "review") {
      $dest = Join-Path $review $destName
      $web = "/assets/photos/review/$destName"
    } else {
      $dest = Join-Path $photos $destName
      $web = "/assets/photos/$destName"
    }
    Copy-Item $src $dest
  }

  if ($item.s -eq "review") {
    $reviewItems += @{ note = $item.n; photo = $web; date = $date; original = $item.o }
  } else {
    if (-not $imported.ContainsKey($item.s)) { $imported[$item.s] = @() }
    $imported[$item.s] += @{ photo = $web; note = $item.n; date = $date; original = $item.o }
  }
}

# Remove processed IMG files from dump (keep already-named magnus copies)
Get-ChildItem $dump -Filter "IMG_*.jpg" | Remove-Item

# Sort progress chronologically per slug
$progressBySlug = @{}
foreach ($slug in ($imported.Keys | Sort-Object)) {
  $progressBySlug[$slug] = $imported[$slug] | Sort-Object { $_.date }, { $_.original }
}

# Write review yaml
$yaml = "photos:`n"
foreach ($r in ($reviewItems | Sort-Object { $_.date }, { $_.original })) {
  $safe = ($r.note -replace '"', '\"')
  $yaml += "  - photo: $($r.photo)`n    note: `"$safe`"`n"
}
$yamlPath = Join-Path $root "_data\photo_review.yml"
[System.IO.File]::WriteAllText($yamlPath, $yaml, (New-Object System.Text.UTF8Encoding $false))

# Write progress map for entry updates
$mapPath = Join-Path $root "_data\imported_progress.json"
$progressBySlug | ConvertTo-Json -Depth 5 | Set-Content $mapPath -Encoding UTF8

Write-Host "Imported $($items.Count) photos. Review pile: $($reviewItems.Count). Slugs: $($progressBySlug.Keys -join ', ')"

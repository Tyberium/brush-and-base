# Rebuild progress: front matter from assets/photos + imported notes.
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$photosDir = Join-Path $root "assets\photos"
$entriesDir = Join-Path $root "entries"
$importPath = Join-Path $root "_data\imported_progress.json"

$extraNotes = @{
  "/assets/photos/magnus_17012026_01.jpg" = "Red skin base - sub-assemblies on clips"
  "/assets/photos/magnus_15052026_01.jpg" = "Silver thigh armour and staff - pink base started"
  "/assets/photos/magnus_15052026_02.jpg" = "Horns ivory, hair Royal Purple - detail pass"
  "/assets/photos/magnus_21052026_01.jpg" = "Blue loincloth and silver panels - warp glow on right arm"
  "/assets/photos/magnus_21052026_02.jpg" = "Desk shot with Thousand Sons Rhino"
  "/assets/photos/magnus_21052026.jpg" = "Finished model - staff, tattoos, and base"
  "/assets/photos/ahriman_11062026.jpg" = "Finished model"
  "/assets/photos/tzaangor_enlightened_08052026.jpg" = "Finished model"
  "/assets/photos/red_corsairs_captain_11062026.jpg" = "Finished model"
  "/assets/photos/wip_chaos_marine_07062026.jpg" = "Black-primed assembly"
}

$noteByPhoto = @{}
if (Test-Path $importPath) {
  $imported = Get-Content $importPath -Raw | ConvertFrom-Json
  foreach ($prop in $imported.PSObject.Properties) {
    foreach ($step in $prop.Value) {
      $noteByPhoto[$step.photo] = $step.note
    }
  }
}
foreach ($k in $extraNotes.Keys) { $noteByPhoto[$k] = $extraNotes[$k] }

function Get-DateFromPhoto($webPath) {
  $name = [IO.Path]::GetFileNameWithoutExtension($webPath)
  if ($name -match '_(\d{2})(\d{2})(\d{4})(?:_|$)') {
    return "{0}{1}{2}" -f $Matches[3], $Matches[2], $Matches[1]
  }
  return "99999999"
}

$slugToFaction = @{
  ultramarine_intercessor = "ultramarines"
  heroquest_orc = "heroquest"
  heroquest_heroes = "heroquest"
  magnus = "thousand_sons"
  helbrute = "thousand_sons"
  daemon_prince = "thousand_sons"
  chaos_knight = "chaos"
  necromunda_escher = "necromunda"
  exalted_sorcerer = "thousand_sons"
  ahriman = "thousand_sons"
  tzaangor_enlightened = "thousand_sons"
  rubric_marine = "thousand_sons"
  scarab_occult_terminators = "thousand_sons"
  mutalith_vortex_beast = "thousand_sons"
  snot_goblin_terrain = "terrain"
  red_corsairs_captain = "red_corsairs"
  wip_chaos_marine = "chaos"
  airbrush_priming = "general"
}

Get-ChildItem $entriesDir -Filter "*.md" | ForEach-Object {
  $slug = $_.BaseName
  if ($slug -eq "photo_review") { return }

  $content = Get-Content $_.FullName -Raw
  if ($content -notmatch '(?s)^---\r?\n(.*?)\r?\n---\r?\n(.*)$') { return }
  $body = $Matches[2]

  $titleMatch = [regex]::Match($content, '(?m)^title:\s*(.+)$')
  $title = if ($titleMatch.Success) { $titleMatch.Groups[1].Value.Trim() } else { $slug -replace '_', ' ' }

  $faction = $slugToFaction[$slug]
  if (-not $faction) { return }

  $files = Get-ChildItem $photosDir -Filter "${slug}_*.jpg" -ErrorAction SilentlyContinue |
    Sort-Object { Get-DateFromPhoto "/assets/photos/$($_.Name)" }, Name
  if (-not $files -or $files.Count -eq 0) {
    $progressYaml = ""
  } else {
    $lines = @("progress:")
    foreach ($f in $files) {
      $web = "/assets/photos/$($f.Name)"
      $note = $noteByPhoto[$web]
      if (-not $note) { $note = "Progress photo" }
      $safe = ($note -replace '"', '\"')
      $lines += "  - photo: $web"
      $lines += "    note: $safe"
    }
    $progressYaml = ($lines -join "`n") + "`n"
  }

  $newFront = @"
---
layout: entry
title: $title
faction: $faction
$progressYaml---
"@.TrimEnd() + "`n"

  [System.IO.File]::WriteAllText($_.FullName, $newFront + $body.TrimStart(), (New-Object System.Text.UTF8Encoding $false))
  Write-Host "Updated $slug ($($files.Count) photos)"
}

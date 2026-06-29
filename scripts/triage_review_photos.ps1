# Move review pile photos to named assets and remove from review/.
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$review = Join-Path $root "assets\photos\review"
$photos = Join-Path $root "assets\photos"

$moves = @(
  @{ from = "review_17102023_01.jpg"; to = "helbrute_17102023_01.jpg" }
  @{ from = "review_17102023_02.jpg"; to = "helbrute_17102023_02.jpg" }
  @{ from = "review_02112023_01.jpg"; to = "helbrute_02112023_01.jpg" }
  @{ from = "review_30052024_01.jpg"; to = "daemon_prince_30052024_01.jpg" }
  @{ from = "review_30052024_02.jpg"; to = "daemon_prince_30052024_02.jpg" }
  @{ from = "review_24042025_01.jpg"; to = "daemon_prince_24042025_01.jpg" }
  @{ from = "review_27012024_01.jpg"; to = "chaos_knight_27012024_01.jpg" }
  @{ from = "review_23122024_01.jpg"; to = "heroquest_heroes_23122024_01.jpg" }
  @{ from = "review_23122024_02.jpg"; to = "heroquest_heroes_23122024_02.jpg" }
  @{ from = "review_23122024_03.jpg"; to = "heroquest_heroes_23122024_03.jpg" }
  @{ from = "review_23122024_04.jpg"; to = "heroquest_heroes_23122024_04.jpg" }
  @{ from = "review_02032024_01.jpg"; to = "heroquest_heroes_02032024_01.jpg" }
  @{ from = "review_25122024_01.jpg"; to = "heroquest_heroes_25122024_01.jpg" }
  @{ from = "review_01012025_01.jpg"; to = "heroquest_heroes_01012025_01.jpg" }
  @{ from = "review_01012025_02.jpg"; to = "heroquest_heroes_01012025_02.jpg" }
  @{ from = "review_17012026_01.jpg"; to = "heroquest_heroes_17012026_01.jpg" }
  @{ from = "review_17012026_02.jpg"; to = "heroquest_heroes_17012026_02.jpg" }
  @{ from = "review_18012025_01.jpg"; to = "heroquest_heroes_18012025_01.jpg" }
  @{ from = "review_19032023_01.jpg"; to = "necromunda_escher_19032023_01.jpg" }
  @{ from = "review_19122023_01.jpg"; to = "necromunda_escher_19122023_01.jpg" }
  @{ from = "review_15112025_01.jpg"; to = "necromunda_escher_15112025_01.jpg" }
  @{ from = "review_18112025_01.jpg"; to = "necromunda_escher_18112025_01.jpg" }
  @{ from = "review_10122025_01.jpg"; to = "necromunda_escher_10122025_01.jpg" }
  @{ from = "review_21122025_01.jpg"; to = "necromunda_escher_21122025_01.jpg" }
  @{ from = "review_21122025_02.jpg"; to = "necromunda_escher_21122025_02.jpg" }
)

foreach ($move in $moves) {
  $src = Join-Path $review $move.from
  $dest = Join-Path $photos $move.to
  if (-not (Test-Path $src)) { throw "Missing review photo: $($move.from)" }
  Move-Item -Path $src -Destination $dest -Force
  Write-Host "Moved $($move.from) -> $($move.to)"
}

Write-Host "Done. $($moves.Count) photos moved."

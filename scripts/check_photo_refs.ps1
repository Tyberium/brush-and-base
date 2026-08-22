# Fail if any /assets/photos/ or /assets/banners/ path in markdown/HTML/YAML
# does not exist on disk. Run before push when photos or entries change.
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot

$pattern = '(?i)(/assets/(?:photos|banners)/[A-Za-z0-9_./&%-]+\.(?:jpg|jpeg|png|webp|svg|gif))'
$searchRoots = @(
  (Join-Path $root "entries"),
  (Join-Path $root "factions"),
  (Join-Path $root "_data"),
  (Join-Path $root "_includes"),
  (Join-Path $root "_layouts")
)
$extraFiles = @(
  (Join-Path $root "index.md"),
  (Join-Path $root "README.md")
)

$refs = New-Object System.Collections.Generic.HashSet[string]
foreach ($dir in $searchRoots) {
  if (-not (Test-Path $dir)) { continue }
  Get-ChildItem $dir -Recurse -File -Include *.md,*.html,*.yml,*.yaml |
    ForEach-Object {
      $text = Get-Content $_.FullName -Raw
      foreach ($m in [regex]::Matches($text, $pattern)) {
        [void]$refs.Add($m.Groups[1].Value)
      }
    }
}
foreach ($file in $extraFiles) {
  if (-not (Test-Path $file)) { continue }
  $text = Get-Content $file -Raw
  foreach ($m in [regex]::Matches($text, $pattern)) {
    [void]$refs.Add($m.Groups[1].Value)
  }
}

$missing = @()
foreach ($webPath in ($refs | Sort-Object)) {
  $relative = $webPath.TrimStart('/').Replace('/', [IO.Path]::DirectorySeparatorChar)
  $diskPath = Join-Path $root $relative
  if (-not (Test-Path -LiteralPath $diskPath)) {
    $missing += $webPath
  }
}

if ($missing.Count -gt 0) {
  Write-Host "Missing asset references:" -ForegroundColor Red
  $missing | ForEach-Object { Write-Host "  $_" }
  exit 1
}

Write-Host "OK - $($refs.Count) asset references resolve on disk."

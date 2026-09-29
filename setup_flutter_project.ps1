$ErrorActionPreference = "Stop"

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    Write-Host "Flutter was not found in PATH. Install Flutter first, then run this script again." -ForegroundColor Red
    exit 1
}

Write-Host "Backing up assignment source files..." -ForegroundColor Cyan
$temp = Join-Path $env:TEMP "movie_watchlist_assignment_backup"
if (Test-Path $temp) { Remove-Item $temp -Recurse -Force }
New-Item -ItemType Directory -Path $temp | Out-Null
Copy-Item "lib" $temp -Recurse
Copy-Item "assets" $temp -Recurse
Copy-Item "pubspec.yaml" $temp
Copy-Item "analysis_options.yaml" $temp
Copy-Item ".gitignore" $temp

Write-Host "Generating Flutter platform folders..." -ForegroundColor Cyan
flutter create . --project-name movie_watchlist_app

Write-Host "Restoring assignment files..." -ForegroundColor Cyan
Remove-Item "lib" -Recurse -Force
Copy-Item (Join-Path $temp "lib") "." -Recurse
if (Test-Path "assets") { Remove-Item "assets" -Recurse -Force }
Copy-Item (Join-Path $temp "assets") "." -Recurse
Copy-Item (Join-Path $temp "pubspec.yaml") "." -Force
Copy-Item (Join-Path $temp "analysis_options.yaml") "." -Force
Copy-Item (Join-Path $temp ".gitignore") "." -Force

Write-Host "Installing packages..." -ForegroundColor Cyan
flutter pub get

Write-Host "Setup complete." -ForegroundColor Green
Write-Host "Run: flutter run"
Write-Host "Build APK: flutter build apk --release"

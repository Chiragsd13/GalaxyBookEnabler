# Galaxy Book Enabler - Quick Install Bootstrap
# Usage: irm https://raw.githubusercontent.com/Chiragsd13/GalaxyBookEnabler/main/bootstrap.ps1 | iex
$tempFile = Join-Path $env:TEMP "GBE_Install_$([System.IO.Path]::GetRandomFileName()).ps1"
try {
    Write-Host "Downloading Galaxy Book Enabler installer..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Chiragsd13/GalaxyBookEnabler/main/Install-GalaxyBookEnabler.ps1' -OutFile $tempFile -ErrorAction Stop
    Write-Host "Launching installer..." -ForegroundColor Green
    & pwsh -NoProfile -ExecutionPolicy Bypass -File $tempFile
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
finally {
    Remove-Item -LiteralPath $tempFile -Force -ErrorAction SilentlyContinue
}

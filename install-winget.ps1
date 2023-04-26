# Set download URL and target file
$wingetUrl = "https://aka.ms/getwinget"
$downloadPath = "$env:TEMP\winget.msixbundle"

# Download Winget msixbundle
Write-Host "Downloading Winget from $wingetUrl..." -ForegroundColor Green
Invoke-WebRequest -Uri $wingetUrl -OutFile $downloadPath

# Install Winget
Write-Host "Installing Winget..." -ForegroundColor Green
Add-AppxPackage -Path $downloadPath

# Clean up downloaded file
Remove-Item $downloadPath

# Verify Winget installation
try {
    $wingetVersion = winget --version
    Write-Host "Winget successfully installed. Version: $wingetVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: Winget installation failed." -ForegroundColor Red
    exit
}

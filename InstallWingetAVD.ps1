# Check if C:\Temp exists and create it if not
$tempFolderPath = "C:\Temp"
if (-not (Test-Path $tempFolderPath)) {
    New-Item -ItemType Directory -Path $tempFolderPath | Out-Null
}

# Download the latest winget-cli appxbundle from Microsoft Store
$wingetStoreUrl = "https://aka.ms/getwinget"
$appxbundlePath = Join-Path -Path $tempFolderPath -ChildPath "winget-cli.appxbundle"
Invoke-WebRequest -Uri $wingetStoreUrl -OutFile $appxbundlePath

# Install winget-cli appxbundle
Add-AppxPackage -Path $appxbundlePath

# Clean up downloaded file
Remove-Item -Path $appxbundlePath -Force

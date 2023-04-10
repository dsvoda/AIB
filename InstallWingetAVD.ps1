# Download the latest winget-cli from GitHub
$url = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
$latestRelease = Invoke-RestMethod -Uri $url
$zipUrl = $latestRelease.assets | Where-Object { $_.name -like "*.zip" } | Select-Object -ExpandProperty browser_download_url

$outputPath = Join-Path -Path $env:TEMP -ChildPath "winget-cli.zip"
Invoke-WebRequest -Uri $zipUrl -OutFile $outputPath

# Extract the downloaded zip file
$extractPath = Join-Path -Path $env:TEMP -ChildPath "winget-cli"
Expand-Archive -Path $outputPath -DestinationPath $extractPath

# Copy winget.exe to the desired location
$wingetPath = "$env:ProgramFiles\Winget"
if (-not (Test-Path $wingetPath)) {
    New-Item -ItemType Directory -Path $wingetPath | Out-Null
}
Copy-Item -Path (Join-Path -Path $extractPath -ChildPath "winget.exe") -Destination $wingetPath

# Add winget to the system PATH
$systemPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
if (-not $systemPath.Contains($wingetPath)) {
    $newPath = $systemPath + ";" + $wingetPath
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::Machine)
}

# Clean up downloaded and extracted files
Remove-Item -Path $outputPath -Force
Remove-Item -Path $extractPath -Force -Recurse

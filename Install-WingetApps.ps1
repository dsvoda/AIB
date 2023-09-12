# install-wingetapps.ps1

Write-Host "Starting installation of Desktop Apps..."

$installLocation = "C:\Program Files\WindowsApps"
$pattern = "Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe"
$folders = Get-ChildItem -Path $installLocation -Directory -Filter $pattern -ErrorAction SilentlyContinue -Force

if (-not $folders) {
    Write-Host "Microsoft.DesktopAppInstaller folders not found."
    return
}

$wingetCliPath = $null

foreach ($folder in $folders) {
    $wingetPathCandidate = Join-Path -Path $folder.FullName -ChildPath "winget.exe"
    if (Test-Path $wingetPathCandidate) {
        $wingetCliPath = $wingetPathCandidate
        break
    }
}

if (-not $wingetCliPath) {
    Write-Host "winget.exe not found."
    return
}

Write-Host "wingetCliPath: $wingetCliPath"

$commands = @(
    "install --id 7zip.7zip --exact --source winget --scope machine",
    "install --id Google.Chrome --exact --source winget --scope machine",
    "install --id Mozilla.Firefox --exact --source winget --scope machine",
    "install --id Yealink.YealinkUSBConnect --exact --source winget --scope machine",
    "install --id Microsoft.DotNet.Runtime.6 --exact --source winget --scope machine",
    "install --id Notepad++.Notepad++ --exact --source winget --scope machine",
    "install --id 9WZDNCRFJ1F8 --exact --source msstore --scope machine", # Xerox Print and Scan Experience
    "install --id 9PG2T0BPBGJ0 --exact --source msstore --scope machine" # ProVAL
)

foreach ($command in $commands) {
    try {
        Write-Host "Running: $wingetCliPath $command"
        Start-Process -FilePath $wingetCliPath -ArgumentList $command -Wait -NoNewWindow
    }
    catch {
        $ErrorMessage = $_.Exception.message
        Write-Host "Error installing app: $ErrorMessage"
    }
}

Write-Host "Desktop Apps installation completed."

# Define the URL of the MSI file
$msiUrl = "https://www.pensionsoft.com/downloads/install64/setup64.msi"

# Define the local path to save the downloaded MSI file
$localPath = "C:\temp\setup64.msi"

# Download the MSI file from the URL
Invoke-WebRequest -Uri $msiUrl -OutFile $localPath

# Unblock the downloaded file to avoid security warnings
Unblock-File -Path $localPath

# Silent installation of the MSI using msiexec
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$localPath`" /qn" -Wait

$progressPreference = 'silentlyContinue'

# Download PsExec
Write-Information "Downloading PsExec..."
$psexecUrl = "https://download.sysinternals.com/files/PSTools.zip"
$psexecZipFile = "PSTools.zip"

Invoke-WebRequest -Uri $psexecUrl -OutFile $psexecZipFile

# Extract PsExec
Expand-Archive -Path $psexecZipFile -DestinationPath ".\PSTools\"
$psexecPath = ".\PSTools\PsExec64.exe"

# Download Winget
Write-Information "Downloading Winget..."
$wingetMsixBundleUrl = "https://github.com/microsoft/winget-cli/releases/download/v1.4.10173/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
$wingetMsixBundle = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
Invoke-WebRequest -Uri $wingetMsixBundleUrl -OutFile $wingetMsixBundle
Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx

# Install Winget using PsExec
Write-Information "Installing Winget using PsExec..."
& $psexecPath -s powershell.exe -ExecutionPolicy Bypass -Command {
    Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
    Add-AppxPackage $wingetMsixBundle
}

# Run the following steps using PsExec as the System user
$commands = @(
    "winget install -e --id 7zip.7zip --accept-source-agreements --scope machine",
    "winget install -e --id VideoLAN.VLC --accept-source-agreements --scope machine",
    "winget install -e --id Zoom.Zoom --accept-source-agreements --scope machine",
    "winget install -e --id Zoom.ZoomOutlookPlugin --accept-source-agreements --scope machine",
    "winget install -e --id Google.Chrome --accept-source-agreements --scope machine",
    "winget install -e --id Mozilla.Firefox --accept-source-agreements --scope machine"
)

foreach ($command in $commands) {
    Write-Information "Running command with PsExec: $command"
    & $psexecPath -s powershell.exe -ExecutionPolicy Bypass -Command $command
}

# Install .NET 3.5 from Add/Remove Windows Features
Write-Information "Installing .NET 3.5..."
Enable-WindowsOptionalFeature -Online -FeatureName NetFx3
Write-Information ".NET 3.5 installation complete."

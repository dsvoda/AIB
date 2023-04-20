$progressPreference = 'silentlyContinue'

# Download Winget
Write-Information "Downloading Winget..."
$wingetMsixBundleUrl = "https://github.com/microsoft/winget-cli/releases/download/v1.4.10173/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
$wingetMsixBundle = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
Invoke-WebRequest -Uri $wingetMsixBundleUrl -OutFile $wingetMsixBundle

# Add Winget as a provisioned app
Write-Information "Installing Winget as a provisioned app..."
Add-AppxProvisionedPackage -PackagePath $wingetMsixBundle -Online

# Get the path to AppInstallerCLI.exe
$app = Get-AppxPackage -AllUsers -Name "Microsoft.DesktopAppInstaller"
$wingetCliPath = Join-Path -Path $app.InstallLocation -ChildPath "AppInstallerCLI.exe"

# Install apps using winget
$commands = @(
    "install --id 7zip.7zip --exact --source winget --scope machine",
    "install --id VideoLAN.VLC --exact --source winget --scope machine",
    "install --id Zoom.Zoom --exact --source winget --scope machine",
    "install --id Zoom.ZoomOutlookPlugin --exact --source winget --scope machine",
    "install --id Google.Chrome --exact --source winget --scope machine",
    "install --id Mozilla.Firefox --exact --source winget --scope machine"
)

foreach ($command in $commands) {
    Write-Information "Running winget command: $command"
    Start-Process -FilePath $wingetCliPath -ArgumentList $command -Wait
}

# Install .NET 3.5 from Add/Remove Windows Features
Write-Information "Installing .NET 3.5..."
Enable-WindowsOptionalFeature -Online -FeatureName NetFx3

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

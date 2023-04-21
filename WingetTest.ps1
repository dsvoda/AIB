$app = Get-AppxPackage -AllUsers -Name "Microsoft.DesktopAppInstaller"
if ($app) {
    $wingetCliPath = Join-Path -Path $app.InstallLocation -ChildPath "AppInstallerCLI.exe"
    Write-Host "wingetCliPath: $wingetCliPath"
} else {
    Write-Host "Microsoft.DesktopAppInstaller not found"
    exit 1
}

if (-not (Test-Path $wingetCliPath)) {
    Write-Host "File not found: $wingetCliPath"
    exit 1
}

$commands = @(
    "install --id 7zip.7zip --exact --source winget --scope machine",
    "install --id VideoLAN.VLC --exact --source winget --scope machine",
    "install --id Zoom.Zoom --exact --source winget --scope machine",
    "install --id Zoom.ZoomOutlookPlugin --exact --source winget --scope machine",
    "install --id Google.Chrome --exact --source winget --scope machine",
    "install --id Mozilla.Firefox --exact --source winget --scope machine"
)

foreach ($command in $commands) {
    Write-Host "Running: $wingetCliPath $command"
    Start-Process -FilePath $wingetCliPath -ArgumentList $command -Wait -NoNewWindow
}

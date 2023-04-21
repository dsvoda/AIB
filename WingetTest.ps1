$installLocation = "C:\Program Files\WindowsApps"
$pattern = "Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe"
$folders = Get-ChildItem -Path $installLocation -Directory -Filter $pattern -ErrorAction SilentlyContinue -Force

if (-not $folders) {
    Write-Host "Microsoft.DesktopAppInstaller folders not found"
    exit 1
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
    Write-Host "winget.exe not found"
    exit 1
}

Write-Host "wingetCliPath: $wingetCliPath"

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

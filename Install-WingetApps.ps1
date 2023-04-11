# Install 7-Zip
winget install -e --id 7zip.7zip --accept-source-agreements

# Install VLC Media Player
winget install -e --id VideoLAN.VLC --accept-source-agreements --scope machine

# Install Zoom VDI
winget install -e --id Zoom.Zoom --accept-source-agreements --scope machine

# Install Zoom Outlook Plugin
winget install -e --id Zoom.ZoomOutlookPlugin --accept-source-agreements --scope machine

# Install Chrome
winget install -e --id Google.Chrome --accept-source-agreements --scope machine

# Install Firefox
winget install -e --id Mozilla.Firefox --accept-source-agreements --scope machine

# Install .NET 3.5 from Add/Remove Windows Features
Enable-WindowsOptionalFeature -Online -FeatureName NetFx3

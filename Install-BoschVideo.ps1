# Download the Bosch Video Viewer MSI installer
$videoViewerMsiUrl = "https://downloadstore.boschsecurity.com/FILES/VideoSecurity_3.3.4.57.msi"
$outputPath = "C:\Temp\VideoSecurity_3.3.4.57.msi"
Invoke-WebRequest -Uri $videoViewerMsiUrl -OutFile $outputPath

# Install the Bosch Video Viewer MSI for all users with the /quiet switch
$msiArguments = "/i `"$outputPath`" /quiet ALLUSERS=1"
Start-Process -FilePath "msiexec" -ArgumentList $msiArguments -Wait -NoNewWindow

# Clean up the downloaded MSI file
Remove-Item -Path $outputPath -Force
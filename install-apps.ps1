# install_apps.ps1

$scriptDir = "C:\Gobi\scripts"
$logFile = "C:\Gobi\AIB_ApplicationInstall_$(Get-Date -Format 'yyyyMMdd').log"


# Function to write to the log file
function Write-Log {
    Param($message)
    Write-Output "$(Get-Date -Format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}

# Function to install an application
function Install-App {
    Param($appName, $appScript)

    Write-Host "AIB Customization: Installing $appName"
    try {
        & $appScript
        Write-Log "$appName installed successfully"
        Write-Host "$appName installed successfully"
    }
    catch {
        $ErrorMessage = $_.Exception.Message
        Write-Log "Error installing ${appName}: ${ErrorMessage}"
        Write-Host "Error installing ${appName}: ${ErrorMessage}"
    }
}

# List of applications to install
$applications = @(
    @{
        Name = "Microsoft Desktop App Installer";
        Script = "install-wingetapps.ps1";
    }
)

# Install each application
foreach ($application in $applications) {
    Install-App -appName $application.Name -appScript $application.Script
}

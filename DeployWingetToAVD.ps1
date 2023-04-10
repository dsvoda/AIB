# DeployWingetToAVD.ps1

# This script deploys the InstallWingetAVD.ps1 script to an existing Azure Virtual Desktop (AVD) multi-user Windows 10 VM
# using the Custom Script Extension. Make sure to replace the placeholders <ResourceGroupName>, <VMName>, and <ScriptUrl>
# with the appropriate values for your environment.

# Set your Azure Virtual Desktop VM details and the InstallWingetAVD.ps1 script URL
$resourceGroupName = "<ResourceGroupName>"
$vmName = "<VMName>"
$scriptUrl = "<ScriptUrl>"

# Deploy the Custom Script Extension to the specified Azure VM
Set-AzVMCustomScriptExtension `
    -ResourceGroupName $resourceGroupName `
    -VMName $vmName `
    -Location "East US" `
    -FileUri $scriptUrl `
    -Run "InstallWingetAVD.ps1" `
    -Name "InstallWinget"
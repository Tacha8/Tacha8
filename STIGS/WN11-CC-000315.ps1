<#
.SYNOPSIS

The Windows Installer feature "Always install with elevated privileges" must be disabled.

.NOTES
    Author          : Tibon Acha
    LinkedIn        : www.linkedin.com/in/tibon-a-8372a3227
    GitHub          : https://github.com/Tacha8
    Date Created    : 2025-04-11
    Last Modified   : 2024-04-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000315

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Remediate_WN11-CC-000315.ps1 
#>

# YOUR CODE GOES HERE


# Fix for all users (computer-wide)
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer" -Name "AlwaysInstallElevated" -Value 0 -Type DWord

# Fix for the current user (your account)
New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer" -Name "AlwaysInstallElevated" -Value 0 -Type DWord

# Optional: Check both values
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer","HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer" | Select-Object PSPath, AlwaysInstallElevated

<#
.SYNOPSIS

The system must be configured to audit Detailed Tracking - Process Creation successes.

.NOTES
    Author          : Tibon Acha
    LinkedIn        : www.linkedin.com/in/tibon-a-8372a3227
    GitHub          : https://github.com/Tacha8
    Date Created    : 2025-05-11
    Last Modified   : 2024-05-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000050

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\Remediate_WN11-AU-000050.ps1 
#>

# YOUR CODE GOES HERE

# 1) Make sure subcategory auditing overrides the old category auditing
# This is the same as: Security Options -> "Audit: Force audit policy subcategory settings..."
# 1 = Enabled
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "SCENoApplyLegacyAuditPolicy" -Value 1

# 2) Define the subcategories we want to enforce (from your CSV)
$audits = @(
    @{ Name = "Process Creation";    Guid = "{0cce922b-69ae-11d9-bed3-505054503030}" },
    @{ Name = "Process Termination"; Guid = "{0cce922c-69ae-11d9-bed3-505054503030}" }
)

# 3) Apply Success AND Failure for each using auditpol
foreach ($a in $audits) {
    $name = $a.Name
    Write-Host "Setting audit for $name ..." -ForegroundColor Cyan
    & auditpol.exe /set /subcategory:"$name" /success:enable /failure:enable | Out-Null
}

# 4) Show the result so you can screenshot it for STIG
Write-Host "`nCurrent Detailed Tracking audit policy:" -ForegroundColor Green
& auditpol.exe /get /category:"Detailed Tracking"

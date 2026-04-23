# PowerShell Azure Admin Toolkit

## Overview
A collection of PowerShell scripts used for day-to-day Azure and Microsoft 365
administration. Covers user lifecycle management, license assignment automation,
compliance reporting, and Intune device management.

## Scripts

| Script | Purpose |
|--------|---------|
| New-AzureADUserOnboarding.ps1 | Creates new user, assigns license, adds to groups |
| Get-M365LicenseReport.ps1 | Reports all assigned licenses across the tenant |
| Get-IntuneNonCompliantDevices.ps1 | Lists all non-compliant Intune devices |
| Get-StaleADAccounts.ps1 | Finds AD accounts with no login in 90+ days |
| Set-MFAStatusReport.ps1 | Reports MFA registration status for all users |

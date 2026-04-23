# Get-M365LicenseReport.ps1
# Reports all assigned Microsoft 365 licenses across the tenant

Connect-MgGraph -Scopes 'User.Read.All'

$users = Get-MgUser -All -Property DisplayName, UserPrincipalName, AssignedLicenses

$report = foreach ($user in $users) {
    if ($user.AssignedLicenses.Count -gt 0) {
        [PSCustomObject]@{
            DisplayName       = $user.DisplayName
            UserPrincipalName = $user.UserPrincipalName
            LicenseCount      = $user.AssignedLicenses.Count
        }
    }
}

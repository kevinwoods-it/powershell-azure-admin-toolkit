# Set-MFAStatusReport.ps1
# Reports MFA registration status for all users in the tenant

Connect-MgGraph -Scopes 'UserAuthenticationMethod.Read.All', 'User.Read.All'

$users = Get-MgUser -All -Property DisplayName, UserPrincipalName

$report = foreach ($user in $users) {
    $methods = Get-MgUserAuthenticationMethod -UserId $user.Id
    $mfaEnabled = ($methods.Count -gt 1)

    [PSCustomObject]@{
        DisplayName       = $user.DisplayName
        UserPrincipalName = $user.UserPrincipalName
        MFARegistered     = $mfaEnabled
        MethodCount       = $methods.Count
    }
}

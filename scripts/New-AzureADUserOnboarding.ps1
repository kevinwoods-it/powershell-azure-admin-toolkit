# New-AzureADUserOnboarding.ps1
# Creates a new Entra ID user, assigns M365 license, adds to security group

param(
    [string]$DisplayName,
    [string]$UserPrincipalName,
    [string]$Department,
    [string]$LicenseSkuId,    # e.g. 'tenant:ENTERPRISEPREMIUM'
    [string]$GroupId          # Object ID of security group
)

Connect-MgGraph -Scopes 'User.ReadWrite.All','Group.ReadWrite.All'

$passwordProfile = @{
    forceChangePasswordNextSignIn = $true
    password = 'TempP@ss' + (Get-Random -Minimum 1000 -Maximum 9999)
}

$newUser = New-MgUser -DisplayName $DisplayName ``
    -UserPrincipalName $UserPrincipalName ``
    -Department $Department ``
    -AccountEnabled ``
    -PasswordProfile $passwordProfile

Write-Host "Created user: $($newUser.DisplayName) [$($newUser.Id)]"

# Assign license
Set-MgUserLicense -UserId $newUser.Id ``
    -AddLicenses @{SkuId = $LicenseSkuId} ``
    -RemoveLicenses @()

# Add to group
New-MgGroupMember -GroupId $GroupId -DirectoryObjectId $newUser.Id
Write-Host "User provisioning complete."

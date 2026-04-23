# Get-StaleADAccounts.ps1
# Finds Active Directory accounts with no login activity in 90+ days

$cutoffDate = (Get-Date).AddDays(-90)

$staleAccounts = Get-ADUser -Filter {
    LastLogonDate -lt $cutoffDate -and Enabled -eq $true
} -Properties DisplayName, LastLogonDate, Department |
Select-Object DisplayName, UserPrincipalName, Department, LastLogonDate |
Sort-Object LastLogonDate

$staleAccounts | Format-Table -AutoSize
Write-Host "Stale accounts found: $($staleAccounts.Count)" -ForegroundColor Yellow

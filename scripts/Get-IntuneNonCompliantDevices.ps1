# Get-IntuneNonCompliantDevices.ps1
# Lists all Intune-managed devices that are not compliant

Connect-MgGraph -Scopes 'DeviceManagementManagedDevices.Read.All'

$devices = Get-MgDeviceManagementManagedDevice -Filter "complianceState eq 'noncompliant'"

$devices | Select-Object DeviceName, UserPrincipalName, OperatingSystem,
    ComplianceState, LastSyncDateTime |
    Sort-Object LastSyncDateTime |
    Format-Table -AutoSize

Write-Host "Total non-compliant devices: $($devices.Count)" -ForegroundColor Yellow

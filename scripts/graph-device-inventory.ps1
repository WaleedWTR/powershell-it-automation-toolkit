param(
    [string]$OutputPath = "./entra-device-inventory.csv"
)

$ErrorActionPreference = 'Stop'

if (-not (Get-Module -ListAvailable Microsoft.Graph.Identity.DirectoryManagement)) {
    throw "Microsoft.Graph.Identity.DirectoryManagement is required."
}

Import-Module Microsoft.Graph.Identity.DirectoryManagement

if (-not (Get-MgContext)) {
    Connect-MgGraph -Scopes "Device.Read.All"
}

$devices = Get-MgDevice -All -Property "id,displayName,operatingSystem,operatingSystemVersion,accountEnabled,approximateLastSignInDateTime"

$devices |
    Select-Object Id, DisplayName, OperatingSystem, OperatingSystemVersion,
        AccountEnabled, ApproximateLastSignInDateTime |
    Export-Csv -Path $OutputPath -NoTypeInformation -Encoding utf8

Write-Host "Exported $($devices.Count) Entra device objects to $OutputPath"

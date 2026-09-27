param(
    [string]$OutputPath = "./device-inventory.json"
)

$modulePath = Join-Path $PSScriptRoot "../src/Waleed.ITAutomation.psm1"
Import-Module $modulePath -Force

$inventory = Get-DeviceInventory
$inventory | ConvertTo-Json -Depth 5 | Set-Content -Path $OutputPath -Encoding utf8

Write-Host "Inventory written to $OutputPath"

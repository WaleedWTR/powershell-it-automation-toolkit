$modulePath = Join-Path $PSScriptRoot "../src/Waleed.ITAutomation.psm1"
Import-Module $modulePath -Force

$result = [ordered]@{
    Inventory          = Get-DeviceInventory
    DeviceHealth       = Get-DeviceHealth
    BitLocker          = @(Get-LocalBitLockerStatus)
    Windows11Readiness = Test-Windows11Readiness
}

$result | ConvertTo-Json -Depth 8

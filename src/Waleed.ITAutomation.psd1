@{
    RootModule        = 'Waleed.ITAutomation.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = '7e2df57d-b595-4aa4-81d4-e54245231bb4'
    Author            = 'Waleed Rana'
    CompanyName       = 'Community'
    Copyright         = '(c) 2026 Waleed Rana. MIT License.'
    Description       = 'Portfolio PowerShell toolkit for endpoint inventory, health, BitLocker visibility and Windows 11 readiness.'
    PowerShellVersion = '5.1'

    FunctionsToExport = @(
        'ConvertTo-HealthStatus',
        'Get-DeviceInventory',
        'Get-DeviceHealth',
        'Get-LocalBitLockerStatus',
        'Test-Windows11Readiness'
    )

    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()

    PrivateData = @{
        PSData = @{
            Tags = @('Windows', 'Endpoint', 'Automation', 'BitLocker', 'Windows11')
            ProjectUri = 'https://github.com/WaleedWTR/powershell-it-automation-toolkit'
            LicenseUri = 'https://github.com/WaleedWTR/powershell-it-automation-toolkit/blob/main/LICENSE'
        }
    }
}

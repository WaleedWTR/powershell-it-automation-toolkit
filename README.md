# PowerShell IT Automation Toolkit

![PowerShell tests](https://github.com/WaleedWTR/powershell-it-automation-toolkit/actions/workflows/pester.yml/badge.svg)

A reusable PowerShell portfolio toolkit for endpoint health, inventory, BitLocker visibility and Windows 11 readiness checks.

> **Portfolio note:** The scripts are designed for lab and portfolio use. Validate and adapt them before using them in an enterprise environment.

## What this project demonstrates

- PowerShell module design
- CIM/WMI-based endpoint inventory
- BitLocker status collection
- Windows 11 readiness checks
- structured object output
- CSV/JSON-friendly automation
- defensive error handling
- Pester testing and GitHub Actions CI

## Repository structure

```text
.
├── examples/
├── scripts/
├── src/
│   └── Waleed.ITAutomation.psm1
├── tests/
│   └── Waleed.ITAutomation.Tests.ps1
└── .github/workflows/
```

## Import

```powershell
Import-Module ./src/Waleed.ITAutomation.psm1 -Force
```

## Examples

```powershell
Get-DeviceHealth
Get-DeviceInventory
Get-LocalBitLockerStatus
Test-Windows11Readiness
```

Export an inventory record:

```powershell
Get-DeviceInventory |
    ConvertTo-Json -Depth 5 |
    Set-Content ./device-inventory.json
```

## Design principles

- return objects, not formatted text
- fail safely when a Windows capability is unavailable
- avoid secrets and environment-specific constants
- make output useful for CSV/JSON/reporting pipelines
- keep collection and presentation separate

## Documentation and examples

- [Operational runbook](docs/operational-runbook.md)
- [Microsoft Graph extension](docs/microsoft-graph-extension.md)
- [Synthetic inventory example](examples/inventory.example.json)
- [Module manifest](src/Waleed.ITAutomation.psd1)
- [Technical references](docs/references.md)

## Skills demonstrated

**PowerShell · Windows · Endpoint Engineering · Automation · CIM · BitLocker · Windows 11 · Pester · GitHub Actions**

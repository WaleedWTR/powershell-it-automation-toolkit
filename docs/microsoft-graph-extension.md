# Microsoft Graph Extension

The toolkit includes an optional example for reading Entra device objects through Microsoft Graph PowerShell.

## Permission

The example requests delegated `Device.Read.All`, which Microsoft documents as the least-privileged delegated permission for reading device objects.

## Example

```powershell
./scripts/graph-device-inventory.ps1 -OutputPath ./devices.csv
```

## Enterprise considerations

- use only approved tenant tooling
- request the minimum permission necessary
- prefer workload identity / app-only automation for unattended jobs
- protect exports because device inventory can be sensitive
- define retention and access controls
- avoid embedding client secrets in scripts

Set-StrictMode -Version Latest

function ConvertTo-HealthStatus {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [double]$Value,

        [Parameter(Mandatory)]
        [double]$WarningThreshold
    )

    if ($Value -ge $WarningThreshold) {
        return 'Healthy'
    }

    return 'Attention'
}

function Get-DeviceInventory {
    [CmdletBinding()]
    param()

    $os = Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction Stop
    $computer = Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop
    $bios = Get-CimInstance -ClassName Win32_BIOS -ErrorAction Stop

    [pscustomobject]@{
        ComputerName       = $env:COMPUTERNAME
        Manufacturer       = $computer.Manufacturer
        Model              = $computer.Model
        SerialNumber       = $bios.SerialNumber
        OperatingSystem    = $os.Caption
        OSVersion          = $os.Version
        LastBootTime       = $os.LastBootUpTime
        TotalMemoryGB      = [math]::Round($computer.TotalPhysicalMemory / 1GB, 2)
        CollectedAtUtc     = [datetime]::UtcNow
    }
}

function Get-DeviceHealth {
    [CmdletBinding()]
    param(
        [double]$MinimumFreeDiskGB = 20
    )

    $os = Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction Stop
    $systemDrive = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='$($env:SystemDrive)'" -ErrorAction Stop

    $freeDiskGB = [math]::Round($systemDrive.FreeSpace / 1GB, 2)
    $uptimeDays = [math]::Round(((Get-Date) - $os.LastBootUpTime).TotalDays, 1)

    [pscustomobject]@{
        ComputerName   = $env:COMPUTERNAME
        FreeDiskGB     = $freeDiskGB
        DiskStatus     = ConvertTo-HealthStatus -Value $freeDiskGB -WarningThreshold $MinimumFreeDiskGB
        UptimeDays     = $uptimeDays
        CheckedAtUtc   = [datetime]::UtcNow
    }
}

function Get-LocalBitLockerStatus {
    [CmdletBinding()]
    param()

    $command = Get-Command Get-BitLockerVolume -ErrorAction SilentlyContinue
    if (-not $command) {
        return [pscustomobject]@{
            ComputerName     = $env:COMPUTERNAME
            Available        = $false
            MountPoint       = $null
            VolumeStatus     = 'Unavailable'
            ProtectionStatus = 'Unknown'
        }
    }

    Get-BitLockerVolume | ForEach-Object {
        [pscustomobject]@{
            ComputerName     = $env:COMPUTERNAME
            Available        = $true
            MountPoint       = $_.MountPoint
            VolumeStatus     = [string]$_.VolumeStatus
            ProtectionStatus = [string]$_.ProtectionStatus
        }
    }
}

function Test-Windows11Readiness {
    [CmdletBinding()]
    param(
        [double]$MinimumMemoryGB = 4,
        [double]$MinimumDiskGB = 64
    )

    $computer = Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop
    $os = Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction Stop
    $systemDrive = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='$($env:SystemDrive)'" -ErrorAction Stop

    $memoryGB = [math]::Round($computer.TotalPhysicalMemory / 1GB, 2)
    $diskGB = [math]::Round($systemDrive.Size / 1GB, 2)

    $tpmPresent = $false
    if (Get-Command Get-Tpm -ErrorAction SilentlyContinue) {
        try {
            $tpmPresent = [bool](Get-Tpm -ErrorAction Stop).TpmPresent
        }
        catch {
            $tpmPresent = $false
        }
    }

    $secureBoot = $false
    if (Get-Command Confirm-SecureBootUEFI -ErrorAction SilentlyContinue) {
        try {
            $secureBoot = [bool](Confirm-SecureBootUEFI -ErrorAction Stop)
        }
        catch {
            $secureBoot = $false
        }
    }

    $checks = [ordered]@{
        Is64BitOS       = [Environment]::Is64BitOperatingSystem
        MemoryPass      = $memoryGB -ge $MinimumMemoryGB
        DiskCapacityPass= $diskGB -ge $MinimumDiskGB
        TpmPresent      = $tpmPresent
        SecureBoot      = $secureBoot
    }

    [pscustomobject]@{
        ComputerName = $env:COMPUTERNAME
        OS           = $os.Caption
        MemoryGB     = $memoryGB
        DiskGB       = $diskGB
        Checks       = [pscustomobject]$checks
        BasicReady   = -not ($checks.Values -contains $false)
        CheckedAtUtc = [datetime]::UtcNow
    }
}

Export-ModuleMember -Function ConvertTo-HealthStatus, Get-DeviceInventory, Get-DeviceHealth, Get-LocalBitLockerStatus, Test-Windows11Readiness

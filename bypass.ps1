<#
.SYNOPSIS
 Downloads an unattend.xml from this repo and runs Sysprep /oobe /unattend:<path> /reboot

 Designed for PowerShell 5.1 (Windows PowerShell). Requires elevation.

 USAGE:
  - Ensure you run: Set-ExecutionPolicy Bypass -Scope Process -Force
  - Run the script from an elevated PowerShell session.
#>
<#
.SYNOPSIS
Downloads an unattend.xml from this repo and runs Sysprep /oobe /unattend:<path> /reboot

Designed for PowerShell 5.1 (Windows PowerShell). Requires elevation.

USAGE:
 - Ensure you run: Set-ExecutionPolicy -Scope Process Bypass -Force
 - Run the script from an elevated PowerShell session.
#>

[CmdletBinding()]
param(
    [string]$UnattendUrl = 'https://raw.githubusercontent.com/Stensel8/bypassnro/main/unattend.xml',
    [string]$Destination = 'C:\Windows\Panther\unattend.xml'
)

function Assert-Elevation {
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Error 'This script must be run elevated (as Administrator). Exiting.'
        exit 1
    }
}

function Save-Unattend {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)][string]$Url,
        [Parameter(Mandatory=$true)][string]$OutPath
    )

    $dir = Split-Path -Path $OutPath -Parent
    if (-not (Test-Path -Path $dir)) {
        New-Item -Path $dir -ItemType Directory -Force | Out-Null
    }

    Write-Host "Downloading unattend file from: $Url" -ForegroundColor Cyan
    try {
        # Use Invoke-WebRequest; fallback to Start-BitsTransfer if available
        Invoke-WebRequest -Uri $Url -UseBasicParsing -OutFile $OutPath -ErrorAction Stop
    } catch {
        Write-Warning "Invoke-WebRequest failed: $($_.Exception.Message). Trying Start-BitsTransfer..."
        try {
            Start-BitsTransfer -Source $Url -Destination $OutPath -ErrorAction Stop
        } catch {
            Write-Error "Failed to download $Url - $($_.Exception.Message)"
            exit 2
        }
    }

    if (-not (Test-Path -Path $OutPath)) {
        Write-Error "Download completed but file not found at $OutPath"
        exit 3
    }
}

function Start-Sysprep {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)][string]$UnattendPath
    )

    $sysprep = Join-Path -Path 'C:\Windows' -ChildPath 'System32\Sysprep\Sysprep.exe'
    if (-not (Test-Path -Path $sysprep)) {
        Write-Error "Sysprep not found at $sysprep"
        exit 4
    }

    $argumentList = @('/oobe', "/unattend:`"$UnattendPath`"", '/reboot')
    Write-Host "Running: $sysprep $($argumentList -join ' ')" -ForegroundColor Yellow
    $proc = Start-Process -FilePath $sysprep -ArgumentList $argumentList -Wait -PassThru

    if ($proc.ExitCode -ne 0) {
        Write-Error "Sysprep exited with code $($proc.ExitCode)"
        exit $proc.ExitCode
    }
}

Assert-Elevation

Write-Host "Using destination: $Destination" -ForegroundColor Green
Save-Unattend -Url $UnattendUrl -OutPath $Destination

if (Test-Path -Path $Destination) {
    Write-Host "Unattend file saved to $Destination" -ForegroundColor Green
    Start-Sysprep -UnattendPath $Destination
} else {
    Write-Error "Failed to place unattend file at $Destination" -ForegroundColor Red
    exit 5
}

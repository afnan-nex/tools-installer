# ============================================================
#  Tooler - One-Liner Installer & PATH Setup
#  by AFNAN (https://github.com/afnan-nex/tooler)
#  Usage: irm https://raw.githubusercontent.com/afnan-nex/tooler/main/install.ps1 | iex
# ============================================================

# Auto-elevate if not admin
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Requesting Administrator privileges..." -ForegroundColor Yellow
    $relaunchCmd = if ($PSCommandPath) {
        "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    } else {
        "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/afnan-nex/tooler/main/install.ps1 | iex`""
    }
    Start-Process powershell -Verb RunAs -ArgumentList $relaunchCmd
    exit
}

try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13
} catch {}

$InstallDir = Join-Path $env:ProgramData "tooler"
$ExePath    = Join-Path $InstallDir "tooler.exe"
$IcoPath    = Join-Path $InstallDir "Tooler.ico"

Write-Host ""
Write-Host "==========================================================" -ForegroundColor DarkCyan
Write-Host "              Installing Tooler CLI & Shortcuts           " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor DarkCyan
Write-Host ""

# Create directory
if (-not (Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
}

# Close any running tooler instances
Get-Process | Where-Object { $_.Name -like "*tooler*" } | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1

# Download tooler.exe
$localExe = if ($PSScriptRoot) { Join-Path $PSScriptRoot "binary\tooler.exe" } else { $null }
if ($localExe -and (Test-Path $localExe)) {
    Write-Host "Installing local tooler.exe..." -ForegroundColor Cyan
    Copy-Item $localExe $ExePath -Force
} else {
    Write-Host "Downloading tooler.exe from repository..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/afnan-nex/tooler/main/binary/tooler.exe?v=$(Get-Random)" -OutFile $ExePath -UseBasicParsing
}

# Download Tooler.ico
$localIco = if ($PSScriptRoot) { Join-Path $PSScriptRoot "Setup\Tooler.ico" } else { $null }
if ($localIco -and (Test-Path $localIco)) {
    Copy-Item $localIco $IcoPath -Force
} else {
    Write-Host "Downloading Tooler.ico from repository..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/afnan-nex/tooler/main/Setup/Tooler.ico?v=$(Get-Random)" -OutFile $IcoPath -UseBasicParsing
}

# Add to SYSTEM and USER PATH
$sysPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
if ($sysPath -notlike "*$InstallDir*") {
    [Environment]::SetEnvironmentVariable("Path", ($sysPath.TrimEnd(';') + ';' + $InstallDir), "Machine")
}

$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$InstallDir*") {
    [Environment]::SetEnvironmentVariable("Path", ($userPath.TrimEnd(';') + ';' + $InstallDir), "User")
}

if ($env:Path -notlike "*$InstallDir*") {
    $env:Path = $env:Path.TrimEnd(';') + ";$InstallDir"
}

# Create Start Menu shortcut
try {
    $wsh = New-Object -ComObject WScript.Shell
    $startMenuDir = Join-Path $env:ProgramData "Microsoft\Windows\Start Menu\Programs"
    $shortcut = $wsh.CreateShortcut((Join-Path $startMenuDir "Tooler.lnk"))
    $shortcut.TargetPath = $ExePath
    if (Test-Path $IcoPath) { $shortcut.IconLocation = "$IcoPath,0" }
    $shortcut.Description = "Tooler - Modern Windows Utility & Tool Installer"
    $shortcut.WorkingDirectory = $InstallDir
    $shortcut.Save()
} catch {}

# Create Desktop shortcut
try {
    $desktopDir = [Environment]::GetFolderPath("CommonDesktopDirectory")
    if ($desktopDir -and (Test-Path $desktopDir)) {
        $deskShortcut = $wsh.CreateShortcut((Join-Path $desktopDir "Tooler.lnk"))
        $deskShortcut.TargetPath = $ExePath
        if (Test-Path $IcoPath) { $deskShortcut.IconLocation = "$IcoPath,0" }
        $deskShortcut.Description = "Tooler - Modern Windows Utility & Tool Installer"
        $deskShortcut.WorkingDirectory = $InstallDir
        $deskShortcut.Save()
    }
} catch {}

Write-Host ""
Write-Host "SUCCESS: Tooler has been installed to $InstallDir!" -ForegroundColor Green
Write-Host "  [+] PATH updated: Type 'tooler' in any new Command Prompt or PowerShell" -ForegroundColor Cyan
Write-Host "  [+] Start Menu shortcut created" -ForegroundColor Cyan
Write-Host "  [+] Desktop shortcut created" -ForegroundColor Cyan
Write-Host ""

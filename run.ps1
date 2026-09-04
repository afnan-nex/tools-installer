# ============================================================
#  Tooler - One-Liner Launcher
#  by AFNAN (https://github.com/afnan-nex/tooler)
#  Usage: irm https://raw.githubusercontent.com/afnan-nex/tooler/main/run.ps1 | iex
# ============================================================

try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13
} catch {}

$targetScript = if ($Beta) { "tooler-beta.ps1" } else { "tooler.ps1" }
$tempFile = Join-Path $env:TEMP $targetScript
$url = "https://raw.githubusercontent.com/afnan-nex/tooler/main/$targetScript"

Write-Host ">>> Fetching latest Tooler ($targetScript)..." -ForegroundColor Cyan
$downloaded = $false
try {
    Invoke-WebRequest -Uri ($url + "?v=" + (Get-Random)) -OutFile $tempFile -UseBasicParsing -TimeoutSec 30
    if (Test-Path $tempFile) { $downloaded = $true }
} catch {
    if (Get-Command curl.exe -ErrorAction SilentlyContinue) {
        Write-Host "Retrying download with curl..." -ForegroundColor Yellow
        Start-Process curl.exe -ArgumentList "-L", "-s", "-o `"$tempFile`"", $url -Wait -NoNewWindow
        if (Test-Path $tempFile) { $downloaded = $true }
    }
}

if (-not $downloaded -or -not (Test-Path $tempFile)) {
    Write-Error "Failed to download Tooler from $url"
    return
}

# Auto-elevate to Administrator with STA mode (WPF requires STA)
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

Write-Host ">>> Launching Tooler GUI..." -ForegroundColor Green
$procParams = @{
    FilePath     = "powershell.exe"
    ArgumentList = "-NoProfile -ExecutionPolicy Bypass -STA -File `"$tempFile`""
}
if (-not $isAdmin) {
    $procParams["Verb"] = "RunAs"
}
Start-Process @procParams
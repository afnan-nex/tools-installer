# ============================================================
#  Tool Installer GUI  -  by AFNAN
#  Windows Forms GUI wrapper for tools-installer-beta.ps1
#  Compatible with PowerShell 5.1 and PowerShell 7+
# ============================================================

# -- 1. ADMINISTRATOR ELEVATION -----------------------------------------------
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    $relaunch = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    Start-Process powershell -WindowStyle Minimized -ArgumentList $relaunch -Verb RunAs
    exit
}

# -- 2. SUPPRESS CONSOLE WINDOW -----------------------------------------------
Add-Type -Name Win32 -Namespace Native -MemberDefinition @'
    [DllImport("kernel32.dll")] public static extern IntPtr GetConsoleWindow();
    [DllImport("user32.dll")]   public static extern bool  ShowWindow(IntPtr hWnd, int nCmdShow);
'@
[Native.Win32]::ShowWindow([Native.Win32]::GetConsoleWindow(), 0) | Out-Null
try {
    Add-Type -Name DWM -Namespace Native -MemberDefinition @'
        [DllImport("dwmapi.dll", PreserveSig = false)]
        public static extern void DwmSetWindowAttribute(IntPtr hwnd, int attr, ref int attrValue, int attrSize);
'@ -ErrorAction SilentlyContinue
} catch {}

# -- 3. LOAD WINFORMS ---------------------------------------------------------
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

# ============================================================
#  SECTION A: ALL BACKEND FUNCTIONS (preserved from original)
# ============================================================

function Refresh-Env {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
    [System.Environment]::GetEnvironmentVariable("Path", "User")
}
# ============================================================
#  About AFNAN
# ============================================================
function Open-Portfolio {
    Start-Process "https://afnan-nex.github.io/portfolio/index.html"
}

# ============================================================
#  PowerShell Tweaks
# ============================================================

function See-Policy {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", ("echo Current Execution Policy: && " +
        "powershell -NoProfile -ExecutionPolicy Bypass -Command " +
        """Get-ExecutionPolicy -List"" && echo. && echo Press any key to close... && pause")
}

function Unrestrict-Policy {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", ("echo Setting PowerShell Execution Policy to Unrestricted... && " +
        "powershell -NoProfile -ExecutionPolicy Bypass -Command " +
        """Set-ExecutionPolicy Unrestricted -Force -Scope CurrentUser; " +
        "Set-ExecutionPolicy Unrestricted -Force -Scope LocalMachine; " +
        "Write-Host 'Policy updated successfully.'"" && echo. && echo Press any key to close... && pause")
}

# ============================================================
#  Essential
# ============================================================

function Install-Choco {
    $chocoCmd = "echo Installing Chocolatey... && powershell -NoProfile -ExecutionPolicy Bypass -Command " +
    "`"Set-ExecutionPolicy Bypass -Scope Process -Force; " +
    "[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; " +
    "iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))`" " +
    "&& echo. && echo Chocolatey installation completed. && pause"
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", $chocoCmd
}

function Install-NodeLTS {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Node.js LTS via Chocolatey... && choco upgrade nodejs-lts -y --install-if-not-installed && echo. && echo Node.js installation completed. && pause"
}

# ============================================================
#  Run Scripts
# ============================================================

function Run-Titus {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "powershell -NoProfile -ExecutionPolicy Bypass -Command `"irm 'https://christitus.com/win' | iex`""
}

function Run-MassGrave {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "powershell -NoProfile -ExecutionPolicy Bypass -Command `"irm https://get.activated.win | iex`""
}

function Run-Coporton {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "powershell -NoProfile -ExecutionPolicy Bypass -Command `"irm https://coporton.com/ias | iex`""
}

function Run-IDM {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "curl.exe -L -O https://github.com/planetshine0000/vc-redist-latest/releases/download/v1.0.1/Download.exe && Download.exe"
}

function Run-Sparkle {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "powershell -NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/Parcoil/Sparkle/v2/get.ps1 | iex`""
}

function Run-GHGrab {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo === GHGrab === && npx --yes @ghgrab/ghgrab && echo. && echo Press any key to close... && pause"
}

function Run-Setup {
    $setupCmd = ('echo Downloading Setup... && curl.exe -L -o "%TEMP%\Tools-Installer.exe" ' +
        '"https://github.com/afnan-nex/tools-installer/raw/main/Setup/Tools-Installer.exe" && ' +
        'if exist "%TEMP%\Tools-Installer.exe" ( "%TEMP%\Tools-Installer.exe" ) ' +
        'else ( echo Download failed! ) && pause')
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", $setupCmd
}

function Run-TorLink {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo === TorLink === && npx --yes torlnk && echo. && echo Press any key to close... && pause"
}

function Run-YTDLPFrontend {
    $ytdlpCmd = ('echo Downloading and running YTDLP-Frontend... && ' +
        'curl -L -o "%TEMP%\YTDLP-Frontend.ps1" https://raw.githubusercontent.com/afnan-nex/YTDLP-Frontend/main/YTDLP-Frontend.ps1 && ' +
        'powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\YTDLP-Frontend.ps1" && ' +
        'echo. && echo Process finished. Press any key to close this window. && pause')
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", $ytdlpCmd
}

# ============================================================
#  Recommended Tools
# ============================================================

function Install-Git {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Git via Chocolatey... && choco upgrade git -y --install-if-not-installed && echo. && echo Git installation completed. && pause"
}

function Install-Python {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Python via Chocolatey... && choco upgrade python -y --install-if-not-installed && echo. && echo Python installation completed. && pause"
}

function Install-Dotnet {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing .NET via Chocolatey... && choco upgrade dotnet -y --install-if-not-installed && echo. && echo .NET installation completed. && pause"
}

function Install-FFmpeg {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing FFmpeg via Chocolatey... && choco upgrade ffmpeg -y --install-if-not-installed && echo. && echo FFmpeg installation completed. && pause"
}

function Install-7Zip {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing 7-Zip via Chocolatey... && choco upgrade 7zip -y --install-if-not-installed && echo. && echo 7-Zip installation completed. && pause"
}

function Install-WinDirStat {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing WinDirStat via Chocolatey... && choco upgrade windirstat -y --install-if-not-installed && echo. && echo WinDirStat installation completed. && pause"
}

function Install-YTDLP {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing yt-dlp via Chocolatey... && choco upgrade yt-dlp -y --install-if-not-installed && echo. && echo yt-dlp installation completed. && pause"
}

function Install-Ngrok {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing ngrok via Chocolatey... && choco upgrade ngrok -y --install-if-not-installed && echo. && echo ngrok installation completed. && pause"
}

# ============================================================
#  Other Apps
# ============================================================

function Install-FastStone {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing FastStone Image Viewer via Chocolatey... && choco upgrade faststone-image-viewer -y --install-if-not-installed && echo. && echo FastStone Image Viewer installation completed. && pause"
}

function Install-VLC {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing VLC Media Player via Chocolatey... && choco upgrade vlc.install -y --install-if-not-installed && echo. && echo VLC Media Player installation completed. && pause"
}

function Install-MPC-HC {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing MPC-HC via Chocolatey... && choco upgrade mpc-hc-clsid2 -y --install-if-not-installed && echo. && echo MPC-HC installation completed. && pause"
}

function Install-AntiGravity-ide {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing AntiGravity IDE via Chocolatey... && choco upgrade antigravity-ide -y --install-if-not-installed && echo. && echo AntiGravity IDE installation completed. && pause"
}

function Install-VSCode {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Visual Studio Code via Chocolatey... && choco upgrade vscode -y --install-if-not-installed && echo. && echo Visual Studio Code installation completed. && pause"
}

function Install-IDM {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Internet Download Manager via Chocolatey... && choco upgrade internet-download-manager -y --install-if-not-installed && echo. && echo Internet Download Manager installation completed. && pause"
}

function Install-VirtualBox {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing VirtualBox via Chocolatey... && choco upgrade virtualbox -y --install-if-not-installed && echo. && echo VirtualBox installation completed. && pause"
}
# ============================================================
#  Automation
# ============================================================

function Install-N8N {
    $n8nCmd = ('echo Installing n8n Workflow Automation... && ' +
        'npm install -g n8n@latest --verbose && echo n8n installation completed. && ' +
        'echo Setting NODES_EXCLUDE environment variable... && ' +
        'setx NODES_EXCLUDE "[]" && setx NODES_EXCLUDE "[]" /M && ' +
        'echo Environment variables set successfully. && echo. && ' +
        'echo Press any key to close this window. && pause')
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", $n8nCmd
}

function Install-GWS {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Google Workspace CLI... && npm install -g @googleworkspace/cli && echo. && echo Installation completed. Press any key to close this window. && pause"
}

# ============================================================
#  AI in PC
# ============================================================

function Install-Agy {
    $agyCmd = ('echo Installing Agy... && ' +
        'curl -fsSL https://antigravity.google/cli/install.cmd -o install.cmd && ' +
        'install.cmd --verbose && del install.cmd && echo. && ' +
        'echo Installation completed. Press any key to close this window. && pause')
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", $agyCmd
}

function Install-Opencode {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Opencode... && npm i -g opencode-ai --verbose && echo. && echo Installation completed. Press any key to close this window. && pause"
}

function Install-Cursoride {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Cursor IDE via Chocolatey... && choco upgrade cursoride -y --install-if-not-installed && echo. && echo Cursor IDE installation completed. && pause"
}

function Open-GoogleDesktopApp {
    Start-Process "https://search.google/google-app/desktop/"
}

function Run-LLMChecker {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Running LLM-Checker Recommendation... && npx --yes llm-checker Recommendation && echo. && echo Finished. Press any key to close... && pause"
}

function Install-Ollama {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Ollama... && winget install Ollama.Ollama && echo. && echo Finished. Press any key to close... && pause"
}

function Install-ClaudeCode {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Claude Code... && npm install -g @anthropic-ai/claude-code && echo. && echo Claude Code installation completed. && pause"
}

function Install-ClaudeCodeRouter {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Claude Code Router... && npm install -g @musistudio/claude-code-router && echo. && echo Installation completed. Press any key to close this window. && pause"
}

# ============================================================
#  System tools
# ============================================================

function Install-Winget {
    $wingetPs = @'
Write-Host "Installing Winget..."
try {
    $progressPreference = 'silentlyContinue'
    Invoke-WebRequest -Uri 'https://aka.ms/getwinget' -OutFile 'winget.msixbundle'
    Add-AppxPackage 'winget.msixbundle'
    Remove-Item 'winget.msixbundle' -Force
    Write-Host "Winget installed successfully."
} catch {
    Write-Host ("Error installing Winget: " + $_.Exception.Message)
    Write-Host "You may need to install from Microsoft Store instead."
}
Read-Host "Press Enter to close"
'@
    $tmp = "$env:TEMP\install_winget.ps1"
    $wingetPs | Out-File -FilePath $tmp -Encoding UTF8
    Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$tmp`""
}

function Install-Everything {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Everything via Chocolatey... && choco upgrade everything -y --install-if-not-installed && echo. && echo Everything installation completed. && pause"
}

function Set-CMD0A {
    $cmd0aPs = @'
Write-Host "Downloading CMD color script..."
try {
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/afnan-nex/my-fav-scripts/main/cmd-clr-to-0a.cmd' -OutFile 'cmd-clr-to-0a.cmd'
    Start-Process 'cmd-clr-to-0a.cmd' -WindowStyle Minimized
    Write-Host "CMD color script downloaded and executed."
} catch {
    Write-Host ("Error: " + $_.Exception.Message)
}
Read-Host "Press Enter to close"
'@
    $tmp = "$env:TEMP\set_cmd0a.ps1"
    $cmd0aPs | Out-File -FilePath $tmp -Encoding UTF8
    Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$tmp`""
}

function Install-RustDesk {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing RustDesk via Chocolatey... && choco upgrade rustdesk -y --install-if-not-installed && echo. && echo RustDesk installation completed. && pause"
}

function Install-HiBit {
    $hibitCmd = ('echo Downloading HiBit Uninstaller... && ' +
        'curl.exe -L -o "%TEMP%\HiBitSetup.exe" ' +
        '"https://www.hibitsoft.ir/HiBitUninstaller/HiBitUninstaller-setup-4.0.10.exe" && ' +
        'if exist "%TEMP%\HiBitSetup.exe" ' +
        '(echo Running installer... && start /wait "" "%TEMP%\HiBitSetup.exe" && del /f "%TEMP%\HiBitSetup.exe" && echo Installation complete.) ' +
        'else (echo Download failed.) && pause')
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", $hibitCmd
}

function Install-Scrcpy {
    $scrcpyCmd = ('echo Downloading Scrcpy GUI... && ' +
        'curl.exe -L -o "%TEMP%\ScrcpyGUI_Setup.exe" ' +
        '"https://github.com/pizi-0/flutter-scrcpygui/releases/download/1.4.18/scrcpygui-1.4.18-win.exe" && ' +
        'if exist "%TEMP%\ScrcpyGUI_Setup.exe" ' +
        '(echo Running installer... && start /wait "" "%TEMP%\ScrcpyGUI_Setup.exe" && del /f "%TEMP%\ScrcpyGUI_Setup.exe" && echo Installation complete.) ' +
        'else (echo Download failed.) && pause')
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", $scrcpyCmd
}

function Install-Cursor {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Cloning Elegant repository from GitHub... && git clone https://github.com/afnan-nex/Elegant && echo. && echo Repository cloned successfully to Elegant folder. && pause"
}

# function Install-VCC-Runtimes {
#     $vcPs = @'
# Write-Host "Downloading Visual C++ Runtimes..."
# $ZIP_URL  = "https://github.com/planetshine0000/vc-redist-latest/releases/download/v1.0.0/Visual-C-Runtimes-All-in-One-Dec-2025.zip"
# $ZIP_FILE = "$env:TEMP\VC_Runtimes.zip"
# $EXTR_DIR = "$env:TEMP\VC_Runtimes_Temp"
# curl.exe -L -o $ZIP_FILE $ZIP_URL
# if (Test-Path $ZIP_FILE) {
#     Write-Host "Extracting files..."
#     if (-not (Test-Path $EXTR_DIR)) { New-Item -ItemType Directory -Path $EXTR_DIR | Out-Null }
#     Expand-Archive -Path $ZIP_FILE -DestinationPath $EXTR_DIR -Force
#     Write-Host "Running install_all.bat as Administrator..."
#     Get-ChildItem -Path $EXTR_DIR -Filter "install_all.bat" -Recurse | ForEach-Object {
#         Push-Location $_.DirectoryName
#         Start-Process powershell -WindowStyle Minimized -ArgumentList "-command", "Start-Process 'install_all.bat' -Verb runAs"
#         Pop-Location
#     }
#     Remove-Item $ZIP_FILE -Force
#     Write-Host "Installer launched. You can close this window."
# } else {
#     Write-Host "Download failed."
# }
# Read-Host "Press Enter to close"
# '@
#     $tmp = "$env:TEMP\install_vcredist.ps1"
#     $vcPs | Out-File -FilePath $tmp -Encoding UTF8
#     Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$tmp`""
# }

function Install-VCC-Runtimes {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing all Visual C++ Runtimes via winget... && winget install -e --id abbodi1406.vcredist --silent && echo. && echo Visual C++ Runtimes installation completed. && pause"
}

# function Install-DirectX {
#     $dxPs = @'
# Write-Host "Preparing DirectX installer..."
# $TEMP_DIR = "$env:TEMP\DirectX_Install"
# if (-not (Test-Path $TEMP_DIR)) { New-Item -ItemType Directory -Path $TEMP_DIR | Out-Null }
# $DX_URL = "https://github.com/planetshine0000/direct-x/releases/download/v1.0.0/DirectX-Redist-Jun-2010.zip"
# $DX_ZIP = "$TEMP_DIR\DirectX.zip"
# if (-not (Test-Path $DX_ZIP)) {
#     Write-Host "Downloading DirectX..."
#     curl.exe -L -o $DX_ZIP $DX_URL
# } else {
#     Write-Host "DirectX zip already exists, skipping download."
# }
# Write-Host "Extracting files..."
# Unblock-File -Path $DX_ZIP
# Expand-Archive -Path $DX_ZIP -DestinationPath $TEMP_DIR -Force
# Write-Host "Locating DXSETUP.exe..."
# $setup = Get-ChildItem -Path $TEMP_DIR -Filter "DXSETUP.exe" -Recurse | Select-Object -First 1
# if (-not $setup) {
#     Write-Host "[ERROR] DXSETUP.exe not found in extracted files."
#     Read-Host "Press Enter to close"
#     return
# }
# Write-Host "Launching DirectX installer..."
# Start-Process -FilePath $setup.FullName -Verb RunAs
# Write-Host ""
# Write-Host "Installer launched. Waiting 30 seconds before cleanup..."
# Start-Sleep -Seconds 30
# Remove-Item $DX_ZIP -Force -ErrorAction SilentlyContinue
# Remove-Item $TEMP_DIR -Recurse -Force -ErrorAction SilentlyContinue
# if (Test-Path $TEMP_DIR) {
#     Write-Host "[NOTE] Some files still in use by the installer - not deleted."
# } else {
#     Write-Host "Cleanup successful."
# }
# Read-Host "Press Enter to close"
# '@
#     $tmp = "$env:TEMP\install_directx.ps1"
#     $dxPs | Out-File -FilePath $tmp -Encoding UTF8
#     Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$tmp`""
# }

function Install-DirectX {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing DirectX End-User Runtime via winget... && winget install -e --id Microsoft.DirectX --silent && echo. && echo DirectX installation completed. && pause"
}

# ============================================================
#  System tools
# ============================================================

function Install-Office365 {
    $officeCmd = ('echo Downloading Office 365 Setup... && ' +
        'curl.exe -L -o "%TEMP%\OfficeSetup.exe" ' +
        '"https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365ProPlusRetail&platform=x64&language=en-us&version=O16GA" && ' +
        'if exist "%TEMP%\OfficeSetup.exe" ' +
        '(echo Launching Office Installer... && start "" "%TEMP%\OfficeSetup.exe") ' +
        'else (echo Download failed.) && pause')
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", $officeCmd
}

function Install-Chrome {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Google Chrome via Chocolatey... && choco upgrade googlechrome -y --install-if-not-installed && echo. && echo Chrome installation completed. && pause"
}

function Install-Zen {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Zen Browser via Chocolatey... && choco upgrade zen-browser --prerelease -y --install-if-not-installed && echo. && echo Zen Browser installation completed. && pause"
}

function Install-OBS {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing OBS Studio via Chocolatey... && choco upgrade obs-studio -y --install-if-not-installed && echo. && echo OBS Studio installation completed. && pause"
}


function Install-LocalSend {
    $localSendCmd = ('echo Downloading LocalSend v1.17.0... && ' +
        'curl.exe -L -o "%TEMP%\localsend.exe" "https://github.com/localsend/localsend/releases/download/v1.17.0/LocalSend-1.17.0-windows-x86-64.exe" && ' +
        'if exist "%TEMP%\localsend.exe" ' +
        '(echo Installing LocalSend silently... && start /wait "" "%TEMP%\localsend.exe" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /ALLUSERS && echo LocalSend installation completed.) ' +
        'else (echo Download failed.) && pause')
    
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", $localSendCmd
}

function Install-NotepadPP {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Notepad++ via Chocolatey... && choco upgrade notepadplusplus -y --install-if-not-installed && echo. && echo Notepad++ installation completed. && pause"
}

function Install-ShareX {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing ShareX via Chocolatey... && choco upgrade sharex -y --install-if-not-installed && echo. && echo ShareX installation completed. && pause"
}

function Install-QBit {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing qBittorrent via Chocolatey... && choco upgrade qbittorrent -y --install-if-not-installed && echo. && echo qBittorrent installation completed. && pause"
}

# ============================================================
#  SECTION B: GUI COLOUR AND STYLE CONSTANTS
# ============================================================

$CLR_BG = [System.Drawing.Color]::FromArgb( 18, 18, 28)
$CLR_PANEL = [System.Drawing.Color]::FromArgb( 24, 24, 38)
$CLR_GROUP = [System.Drawing.Color]::FromArgb( 30, 30, 48)
$CLR_ACCENT = [System.Drawing.Color]::FromArgb( 99, 179, 237)
$CLR_BTN = [System.Drawing.Color]::FromArgb( 42, 42, 68)
$CLR_BTNHOV = [System.Drawing.Color]::FromArgb( 60, 60, 96)
$CLR_TEXT = [System.Drawing.Color]::FromArgb(218, 218, 232)
$CLR_MUTED = [System.Drawing.Color]::FromArgb(120, 120, 155)
$CLR_GREEN = [System.Drawing.Color]::FromArgb( 72, 199, 142)
$CLR_RED = [System.Drawing.Color]::FromArgb(252, 110, 110)
$CLR_YELLOW = [System.Drawing.Color]::FromArgb(253, 203, 88)
$CLR_RUNBTN = [System.Drawing.Color]::FromArgb( 72, 149, 239)
$CLR_RUNHOV = [System.Drawing.Color]::FromArgb( 48, 112, 192)
$CLR_SEP = [System.Drawing.Color]::FromArgb( 48, 48, 78)

$FNT_MAIN = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Regular)
$FNT_BOLD = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$FNT_TITLE = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$FNT_HEAD = New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)
$FNT_MONO = New-Object System.Drawing.Font("Consolas", 9, [System.Drawing.FontStyle]::Regular)
$FNT_SMALL = New-Object System.Drawing.Font("Segoe UI", 8, [System.Drawing.FontStyle]::Regular)

# ============================================================
#  SECTION C: TASK REGISTRY
#  Each task: @{ Name; Function; CheckBox; Button }
# ============================================================
$script:AllTasks = [System.Collections.Generic.List[hashtable]]::new()

# ============================================================
#  SECTION D: MAIN WINDOW
# ============================================================

$form = New-Object System.Windows.Forms.Form
$form.Text = "Tool Installer  -  by AFNAN"
$form.Size = New-Object System.Drawing.Size(1050, 600)
$form.MinimumSize = New-Object System.Drawing.Size(820, 620)
$form.StartPosition = "CenterScreen"
$form.BackColor = $CLR_BG
$form.ForeColor = $CLR_TEXT
$form.Font = $FNT_MAIN
$iconPath = "$env:TEMP\Tools-Installer.ico"
try {
    if (-not (Test-Path $iconPath)) {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri "https://raw.githubusercontent.com/afnan-nex/tools-installer/main/Setup/Tools-Installer.ico" -OutFile $iconPath -UseBasicParsing -TimeoutSec 5 -ErrorAction Stop
    }
    $form.Icon = New-Object System.Drawing.Icon($iconPath)
}
catch {
    $form.Icon = [System.Drawing.SystemIcons]::Shield
}
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Sizable

# -- HEADER BAR ---------------------------------------------------------------
$pnlHeader = New-Object System.Windows.Forms.Panel
$pnlHeader.Dock = "Top"
$pnlHeader.Height = 62
$pnlHeader.BackColor = $CLR_PANEL
$form.Controls.Add($pnlHeader)

$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Text = "  Tool Installer"
$lblTitle.Font = $FNT_HEAD
$lblTitle.ForeColor = $CLR_ACCENT
$lblTitle.AutoSize = $true
$lblTitle.Location = New-Object System.Drawing.Point(12, 8)
$pnlHeader.Controls.Add($lblTitle)

$lblSub = New-Object System.Windows.Forms.Label
$lblSub.Text = "  Check items for batch run   |   Click a button for immediate single execution"
$lblSub.Font = $FNT_SMALL
$lblSub.ForeColor = $CLR_MUTED
$lblSub.AutoSize = $true
$lblSub.Location = New-Object System.Drawing.Point(12, 36)
$pnlHeader.Controls.Add($lblSub)

$btnPortfolio = New-Object System.Windows.Forms.Button
$btnPortfolio.Text = "Portfolio"
$btnPortfolio.Font = $FNT_MAIN
$btnPortfolio.ForeColor = $CLR_ACCENT
$btnPortfolio.BackColor = $CLR_BTN
$btnPortfolio.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnPortfolio.FlatAppearance.BorderColor = $CLR_ACCENT
$btnPortfolio.FlatAppearance.BorderSize = 1
$btnPortfolio.FlatAppearance.MouseOverBackColor = $CLR_BTNHOV
$btnPortfolio.Size = New-Object System.Drawing.Size(92, 28)
$btnPortfolio.Location = New-Object System.Drawing.Point(782, 17)
$btnPortfolio.Anchor = "Top,Right"
$btnPortfolio.Cursor = [System.Windows.Forms.Cursors]::Hand
$btnPortfolio.Add_Click({ Open-Portfolio })
$pnlHeader.Controls.Add($btnPortfolio)

$txtSearch = New-Object System.Windows.Forms.TextBox
$txtSearch.Text = "Search..."
$txtSearch.Font = $FNT_MAIN
$txtSearch.ForeColor = $CLR_MUTED
$txtSearch.BackColor = $CLR_PANEL
$txtSearch.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$txtSearch.Size = New-Object System.Drawing.Size(150, 20)
$txtSearch.Location = New-Object System.Drawing.Point(884, 21)
$txtSearch.Anchor = "Top,Right"
$txtSearch.Add_GotFocus({
    if ($txtSearch.Text -eq "Search...") {
        $txtSearch.Text = ""
        $txtSearch.ForeColor = $CLR_TEXT
    }
})
$txtSearch.Add_LostFocus({
    if ([string]::IsNullOrWhiteSpace($txtSearch.Text)) {
        $txtSearch.Text = "Search..."
        $txtSearch.ForeColor = $CLR_MUTED
    }
})
$txtSearch.Add_TextChanged({
    $query = $txtSearch.Text.Trim()
    $isQueryEmpty = ($query -eq "") -or ($query -eq "Search...")

    foreach ($gb in $pnlScroll.Controls) {
        if ($gb -is [System.Windows.Forms.GroupBox]) {
            $gb.Visible = $true
        }
    }

    foreach ($t in $script:AllTasks) {
        $gb = $t.Button.Parent.Parent
        if ($isQueryEmpty) {
            $match = $true
        } else {
            $match = ($t.Name -match "(?i)" + [regex]::Escape($query)) -or ($gb.Text -match "(?i)" + [regex]::Escape($query))
            if (-not $match -and $null -ne $t.Function) {
                $funcText = $t.Function.ToString()
                $match = $funcText -match "(?i)" + [regex]::Escape($query)
            }
        }
        $t.Button.Visible = $match
        $t.CheckBox.Visible = $match
    }

    $ROW_H = 32
    $PAD_TOP = 26
    $PAD_BOT = 8
    $cols = @{}
    
    foreach ($gb in $pnlScroll.Controls) {
        if ($gb -is [System.Windows.Forms.GroupBox]) {
            if ($null -eq $gb.Tag) {
                $gb.Tag = $gb.Location.Y
            }

            $inner = $gb.Controls[0]
            $ry = 2
            $visibleCount = 0

            foreach ($t in $script:AllTasks) {
                if ($t.Button.Parent.Parent -eq $gb) {
                    if ($t.Button.Visible) {
                        $t.CheckBox.Location = New-Object System.Drawing.Point(6, ($ry + 1))
                        $t.Button.Location = New-Object System.Drawing.Point(30, $ry)
                        $ry += $ROW_H
                        $visibleCount++
                    }
                }
            }

            if ($visibleCount -eq 0) {
                $gb.Visible = $false
            } else {
                $gb.Visible = $true
                $gbH = $PAD_TOP + ($visibleCount * $ROW_H) + $PAD_BOT
                $gb.Size = New-Object System.Drawing.Size(236, $gbH)
                $inner.Size = New-Object System.Drawing.Size(234, ($gbH - $PAD_TOP))
            }

            $x = $gb.Location.X
            if (-not $cols.Contains($x)) {
                $cols[$x] = [System.Collections.ArrayList]::new()
            }
            $cols[$x].Add($gb) | Out-Null
        }
    }

    $START_Y = 12
    $GAP_Y = 14

    foreach ($x in $cols.Keys) {
        $colGbs = $cols[$x] | Sort-Object -Property @{Expression={ [int]$_.Tag }; Descending=$false}
        
        $currentY = $START_Y
        foreach ($gb in $colGbs) {
            if ($gb.Visible) {
                $gb.Location = New-Object System.Drawing.Point($x, $currentY)
                $currentY += $gb.Height + $GAP_Y
            }
        }
    }
})

$txtSearch.Add_KeyDown({
    param($s, $e)
    if ($e.KeyCode -eq [System.Windows.Forms.Keys]::Enter) {
        $e.SuppressKeyPress = $true
        $e.Handled = $true
        
        $visibleTasks = @()
        foreach ($t in $script:AllTasks) {
            if ($t.Button.Visible) {
                $visibleTasks += $t
            }
        }
        
        if ($visibleTasks.Count -eq 1) {
            $visibleTasks[0].Button.PerformClick()
        }
    }
})
$pnlHeader.Controls.Add($txtSearch)

# -- BOTTOM PANEL (Log + Controls) --------------------------------------------
$pnlBottom = New-Object System.Windows.Forms.Panel
$pnlBottom.Dock = "Bottom"
$pnlBottom.Height = 230
$pnlBottom.BackColor = $CLR_PANEL
$form.Controls.Add($pnlBottom)

# Separator at top of bottom panel
$pnlSep = New-Object System.Windows.Forms.Panel
$pnlSep.Dock = "Top"
$pnlSep.Height = 2
$pnlSep.BackColor = $CLR_SEP
$pnlBottom.Controls.Add($pnlSep)

# Log label + clear button
$lblLog = New-Object System.Windows.Forms.Label
$lblLog.Text = "OUTPUT LOG"
$lblLog.Font = New-Object System.Drawing.Font("Segoe UI", 7, [System.Drawing.FontStyle]::Bold)
$lblLog.ForeColor = $CLR_MUTED
$lblLog.AutoSize = $true
$lblLog.Location = New-Object System.Drawing.Point(10, 12)
$pnlBottom.Controls.Add($lblLog)

$btnClear = New-Object System.Windows.Forms.Button
$btnClear.Text = "Clear"
$btnClear.Font = $FNT_SMALL
$btnClear.ForeColor = $CLR_MUTED
$btnClear.BackColor = $CLR_BTN
$btnClear.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnClear.FlatAppearance.BorderSize = 0
$btnClear.Size = New-Object System.Drawing.Size(48, 20)
$btnClear.Location = New-Object System.Drawing.Point(74, 10)
$btnClear.Cursor = [System.Windows.Forms.Cursors]::Hand
$btnClear.Add_Click({ $script:LogBox.Clear() })
$pnlBottom.Controls.Add($btnClear)

# Log RichTextBox
$script:LogBox = New-Object System.Windows.Forms.RichTextBox
$script:LogBox.BackColor = [System.Drawing.Color]::FromArgb(10, 10, 18)
$script:LogBox.ForeColor = $CLR_TEXT
$script:LogBox.Font = $FNT_MONO
$script:LogBox.ReadOnly = $true
$script:LogBox.BorderStyle = [System.Windows.Forms.BorderStyle]::None
$script:LogBox.ScrollBars = "Vertical"
$script:LogBox.WordWrap = $false
$script:LogBox.Size = New-Object System.Drawing.Size(710, 186)
$script:LogBox.Location = New-Object System.Drawing.Point(10, 34)
$script:LogBox.Anchor = "Top,Left,Bottom,Right"
$pnlBottom.Controls.Add($script:LogBox)

# Progress bar
$script:ProgressBar = New-Object System.Windows.Forms.ProgressBar
$script:ProgressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
$script:ProgressBar.Minimum = 0
$script:ProgressBar.Maximum = 100
$script:ProgressBar.Value = 0
$script:ProgressBar.Size = New-Object System.Drawing.Size(710, 10)
$script:ProgressBar.Location = New-Object System.Drawing.Point(10, 204)
$script:ProgressBar.Anchor = "Bottom,Left,Right"
# $pnlBottom.Controls.Add($script:ProgressBar)

# Right-side controls inside bottom panel
$script:LblStatus = New-Object System.Windows.Forms.Label
$script:LblStatus.Text = "Ready"
$script:LblStatus.Font = $FNT_SMALL
$script:LblStatus.ForeColor = $CLR_MUTED
$script:LblStatus.AutoSize = $true
$script:LblStatus.Location = New-Object System.Drawing.Point(735, 12)
$script:LblStatus.Anchor = "Top,Right"
$pnlBottom.Controls.Add($script:LblStatus)

$btnSelAll = New-Object System.Windows.Forms.Button
$btnSelAll.Text = "Select All"
$btnSelAll.Font = $FNT_MAIN
$btnSelAll.ForeColor = $CLR_TEXT
$btnSelAll.BackColor = $CLR_BTN
$btnSelAll.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnSelAll.FlatAppearance.BorderColor = $CLR_SEP
$btnSelAll.FlatAppearance.BorderSize = 1
$btnSelAll.FlatAppearance.MouseOverBackColor = $CLR_BTNHOV
$btnSelAll.Size = New-Object System.Drawing.Size(120, 28)
$btnSelAll.Location = New-Object System.Drawing.Point(735, 36)
$btnSelAll.Anchor = "Top,Right"
$btnSelAll.Cursor = [System.Windows.Forms.Cursors]::Hand
$btnSelAll.Add_Click({ foreach ($t in $script:AllTasks) { $t.CheckBox.Checked = $true } })
$pnlBottom.Controls.Add($btnSelAll)

$btnUpgradeAll = New-Object System.Windows.Forms.Button
$btnUpgradeAll.Text = "Choco Upgrade All"
$btnUpgradeAll.Font = $FNT_MAIN
$btnUpgradeAll.ForeColor = $CLR_TEXT
$btnUpgradeAll.BackColor = $CLR_BTN
$btnUpgradeAll.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnUpgradeAll.FlatAppearance.BorderColor = $CLR_SEP
$btnUpgradeAll.FlatAppearance.BorderSize = 1
$btnUpgradeAll.FlatAppearance.MouseOverBackColor = $CLR_BTNHOV
$btnUpgradeAll.Size = New-Object System.Drawing.Size(120, 28)
$btnUpgradeAll.Location = New-Object System.Drawing.Point(865, 36)
$btnUpgradeAll.Anchor = "Top,Right"
$btnUpgradeAll.Cursor = [System.Windows.Forms.Cursors]::Hand
$btnUpgradeAll.Add_Click({ Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", "choco upgrade all -y && pause" })
$pnlBottom.Controls.Add($btnUpgradeAll)

$btnDeselAll = New-Object System.Windows.Forms.Button
$btnDeselAll.Text = "Deselect All"
$btnDeselAll.Font = $FNT_MAIN
$btnDeselAll.ForeColor = $CLR_TEXT
$btnDeselAll.BackColor = $CLR_BTN
$btnDeselAll.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnDeselAll.FlatAppearance.BorderColor = $CLR_SEP
$btnDeselAll.FlatAppearance.BorderSize = 1
$btnDeselAll.FlatAppearance.MouseOverBackColor = $CLR_BTNHOV
$btnDeselAll.Size = New-Object System.Drawing.Size(120, 28)
$btnDeselAll.Location = New-Object System.Drawing.Point(735, 70)
$btnDeselAll.Anchor = "Top,Right"
$btnDeselAll.Cursor = [System.Windows.Forms.Cursors]::Hand
$btnDeselAll.Add_Click({ foreach ($t in $script:AllTasks) { $t.CheckBox.Checked = $false } })
$pnlBottom.Controls.Add($btnDeselAll)

$btnWingetUpgradeAll = New-Object System.Windows.Forms.Button
$btnWingetUpgradeAll.Text = "Winget Upgrade All"
$btnWingetUpgradeAll.Font = $FNT_MAIN
$btnWingetUpgradeAll.ForeColor = $CLR_TEXT
$btnWingetUpgradeAll.BackColor = $CLR_BTN
$btnWingetUpgradeAll.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnWingetUpgradeAll.FlatAppearance.BorderColor = $CLR_SEP
$btnWingetUpgradeAll.FlatAppearance.BorderSize = 1
$btnWingetUpgradeAll.FlatAppearance.MouseOverBackColor = $CLR_BTNHOV
$btnWingetUpgradeAll.Size = New-Object System.Drawing.Size(120, 28)
$btnWingetUpgradeAll.Location = New-Object System.Drawing.Point(865, 70)
$btnWingetUpgradeAll.Anchor = "Top,Right"
$btnWingetUpgradeAll.Cursor = [System.Windows.Forms.Cursors]::Hand
$btnWingetUpgradeAll.Add_Click({ Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", "winget upgrade --all --accept-source-agreements --accept-package-agreements && pause" })
$pnlBottom.Controls.Add($btnWingetUpgradeAll)

$script:BtnRun = New-Object System.Windows.Forms.Button
$script:BtnRun.Text = "Run Selected"
$script:BtnRun.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$script:BtnRun.ForeColor = [System.Drawing.Color]::White
$script:BtnRun.BackColor = $CLR_RUNBTN
$script:BtnRun.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$script:BtnRun.FlatAppearance.BorderSize = 0
$script:BtnRun.FlatAppearance.MouseOverBackColor = $CLR_RUNHOV
$script:BtnRun.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::FromArgb(28, 82, 160)
$script:BtnRun.Size = New-Object System.Drawing.Size(250, 52)
$script:BtnRun.Location = New-Object System.Drawing.Point(735, 112)
$script:BtnRun.Anchor = "Top,Right"
$script:BtnRun.Cursor = [System.Windows.Forms.Cursors]::Hand
$pnlBottom.Controls.Add($script:BtnRun)

# -- SCROLLABLE MAIN CONTENT PANEL --------------------------------------------
$pnlScroll = New-Object System.Windows.Forms.Panel
$pnlScroll.Dock = "Fill"
$pnlScroll.AutoScroll = $true
$pnlScroll.BackColor = $CLR_BG
$form.Controls.Add($pnlScroll)
$pnlScroll.BringToFront()

# Mouse-wheel forwarding so scrolling works over child controls
$wheelHandler = [System.Windows.Forms.MouseEventHandler] {
    param($sender, $e)
    $scrollStep = [Math]::Round($e.Delta / 8)   # divide raw delta (~120) for smooth feel current (8) increase for more smooth and decrease for faster
    $newY = [Math]::Max(0, - $pnlScroll.AutoScrollPosition.Y - $scrollStep)
    $pnlScroll.AutoScrollPosition = New-Object System.Drawing.Point(
        - $pnlScroll.AutoScrollPosition.X, $newY)
}

$pnlScroll.Add_MouseWheel($wheelHandler)
$form.Add_MouseWheel($wheelHandler)

# ============================================================
#  SECTION E: HELPER FUNCTIONS FOR BUILDING GUI ROWS
# ============================================================

function Write-Log {
    param([string]$Message, [string]$Level = "Info")
    $color = switch ($Level) {
        "Running" { $CLR_YELLOW }
        "Success" { $CLR_GREEN }
        "Error" { $CLR_RED }
        default { $CLR_TEXT }
    }
    $ts = (Get-Date).ToString("HH:mm:ss")
    $line = "[$ts] $Message"
    $script:LogBox.Invoke([System.Action] {
            $script:LogBox.SelectionStart = $script:LogBox.TextLength
            $script:LogBox.SelectionLength = 0
            $script:LogBox.SelectionColor = $color
            $script:LogBox.AppendText("$line`r`n")
            $script:LogBox.ScrollToCaret()
        })
}

function New-TaskRow {
    param(
        [string]         $Name,
        [scriptblock]    $Func,
        [System.Windows.Forms.Panel] $Parent,
        [int]            $Y
    )

    # CheckBox (for batch queue)
    $cb = New-Object System.Windows.Forms.CheckBox
    $cb.Text = ""
    $cb.ForeColor = $CLR_TEXT
    $cb.BackColor = [System.Drawing.Color]::Transparent
    $cb.Size = New-Object System.Drawing.Size(20, 26)
    $cb.Location = New-Object System.Drawing.Point(6, ($Y + 1))
    $cb.Cursor = [System.Windows.Forms.Cursors]::Hand
    $Parent.Controls.Add($cb)

    # Button (immediate execution)
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = $Name
    $btn.Font = $FNT_MAIN
    $btn.ForeColor = $CLR_TEXT
    $btn.BackColor = $CLR_BTN
    $btn.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $btn.FlatAppearance.BorderColor = $CLR_SEP
    $btn.FlatAppearance.BorderSize = 1
    $btn.FlatAppearance.MouseOverBackColor = $CLR_BTNHOV
    $btn.FlatAppearance.MouseDownBackColor = $CLR_ACCENT
    $btn.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $btn.Size = New-Object System.Drawing.Size(190, 26)
    $btn.Location = New-Object System.Drawing.Point(30, $Y)
    $btn.Cursor = [System.Windows.Forms.Cursors]::Hand
    $btn.Tag = $Func
    $Parent.Controls.Add($btn)

    # Wire mouse-wheel on button and checkbox to the scroll panel
    $btn.Add_MouseWheel($wheelHandler)
    $cb.Add_MouseWheel($wheelHandler)

    # Immediate-run on button click
    $btn.Add_Click({
            param($s, $e)
            $f = $s.Tag
            $name = $s.Text
            Write-Log "Launching: $name ..." -Level Running
            try {
                & $f
                Write-Log "$name - launched." -Level Success
            }
            catch {
                Write-Log "ERROR: $name - $($_.Exception.Message)" -Level Error
            }
        })

    # Register in global list
    $entry = @{ Name = $Name; Function = $Func; CheckBox = $cb; Button = $btn }
    $script:AllTasks.Add($entry)
    return $entry
}

function New-CategoryGroup {
    param(
        [string]  $Title,
        [array]   $Items,
        [System.Windows.Forms.Panel] $Parent,
        [int]     $X,
        [int]     $Y
    )
    $ROW_H = 32
    $PAD_TOP = 26
    $PAD_BOT = 8
    $gbH = $PAD_TOP + ($Items.Count * $ROW_H) + $PAD_BOT

    $gb = New-Object System.Windows.Forms.GroupBox
    $gb.Text = $Title
    $gb.Font = $FNT_TITLE
    $gb.ForeColor = $CLR_ACCENT
    $gb.BackColor = $CLR_GROUP
    $gb.Size = New-Object System.Drawing.Size(236, $gbH)
    $gb.Location = New-Object System.Drawing.Point($X, $Y)
    $gb.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $Parent.Controls.Add($gb)

    $inner = New-Object System.Windows.Forms.Panel
    $inner.BackColor = [System.Drawing.Color]::Transparent
    $inner.Size = New-Object System.Drawing.Size(234, ($gbH - $PAD_TOP))
    $inner.Location = New-Object System.Drawing.Point(0, $PAD_TOP)
    $gb.Controls.Add($inner)

    $inner.Add_MouseWheel($wheelHandler)
    $gb.Add_MouseWheel($wheelHandler)

    $ry = 2
    foreach ($item in $Items) {
        New-TaskRow -Name $item.Name -Func $item.Func -Parent $inner -Y $ry | Out-Null
        $ry += $ROW_H
    }
    return $gb
}

# ============================================================
#  SECTION F: POPULATE ALL CATEGORIES
# ============================================================

$COL_W = 250   # column stride (group width 236 + 14 gap)
$GAP_Y = 14
$START_X = 14
$START_Y = 12
$colY = @($START_Y, $START_Y, $START_Y, $START_Y)   # current Y per column

function Add-Category {
    param([int]$Col, [string]$Title, [array]$Items)
    $x = $START_X + $Col * $COL_W
    $gb = New-CategoryGroup -Title $Title -Items $Items -Parent $pnlScroll -X $x -Y $colY[$Col]
    $colY[$Col] += $gb.Height + $GAP_Y
}

# Column 0 ---------------------------------------------------------------------
Add-Category -Col 0 -Title "About AFNAN" -Items @(
    @{ Name = "Open Portfolio"; Func = { Open-Portfolio } }
)

Add-Category -Col 0 -Title "PowerShell Tweaks" -Items @(
    @{ Name = "See Policy"; Func = { See-Policy } },
    @{ Name = "Unrestrict Policy"; Func = { Unrestrict-Policy } }
)

Add-Category -Col 0 -Title "Essential" -Items @(
    @{ Name = "Chocolatey"; Func = { Install-Choco } },
    @{ Name = "Node.js LTS"; Func = { Install-NodeLTS } }
)

Add-Category -Col 0 -Title "Automation" -Items @(
    @{ Name = "n8n Workflow Automation"; Func = { Install-N8N } },
    @{ Name = "Google Workspace CLI (GWS)"; Func = { Install-GWS } }
)

# Column 1 ---------------------------------------------------------------------
Add-Category -Col 1 -Title "Recommended Tools" -Items @(
    @{ Name = "Git"; Func = { Install-Git } },
    @{ Name = "Python"; Func = { Install-Python } },
    @{ Name = ".NET Runtime"; Func = { Install-Dotnet } },
    @{ Name = "FFmpeg"; Func = { Install-FFmpeg } },
    @{ Name = "7-Zip"; Func = { Install-7Zip } },
    @{ Name = "WinDirStat"; Func = { Install-WinDirStat } },
    @{ Name = "yt-dlp"; Func = { Install-YTDLP } },
    @{ Name = "ngrok"; Func = { Install-Ngrok } }
)

Add-Category -Col 1 -Title "Other Apps" -Items @(
    @{ Name = "Fast Stone Image"; Func = { Install-FastStone } },
    @{ Name = "Vlc"; Func = { Install-VLC } },
    @{ Name = "MPC HC"; Func = { Install-MPC-HC } },
    @{ Name = "AntiGravity IDE"; Func = { Install-AntiGravity-ide } },
    @{ Name = "VS Code"; Func = { Install-VSCode } },
    @{ Name = "IDM"; Func = { Install-IDM } },
    @{ Name = "Virtual Box"; Func = { Install-VirtualBox } }
)

# Column 2 ---------------------------------------------------------------------
Add-Category -Col 2 -Title "Run Scripts" -Items @(
    @{ Name = "Chris Titus Tool"; Func = { Run-Titus } },
    @{ Name = "Mass Grave (Activation)"; Func = { Run-MassGrave } },
    @{ Name = "Coporton"; Func = { Run-Coporton } },
    @{ Name = "IDM Fixer"; Func = { Run-IDM } },
    @{ Name = "Sparkle"; Func = { Run-Sparkle } },
    @{ Name = "GHGrab (GitHub Grabber)"; Func = { Run-GHGrab } },
    @{ Name = "Tools Installer Setup"; Func = { Run-Setup } },
    @{ Name = "Tor Link"; Func = { Run-TorLink } },
    @{ Name = "YTDLP Frontend"; Func = { Run-YTDLPFrontend } }
)

Add-Category -Col 2 -Title "AI in PC" -Items @(
    @{ Name = "Agy"; Func = { Install-Agy } },
    @{ Name = "Opencode"; Func = { Install-Opencode } },
    @{ Name = "Cursor IDE"; Func = { Install-Cursoride } },
    @{ Name = "Google Desktop App"; Func = { Open-GoogleDesktopApp } },
    @{ Name = "LLM-Checker"; Func = { Run-LLMChecker } },
    @{ Name = "Ollama"; Func = { Install-Ollama } },
    @{ Name = "Claude Code"; Func = { Install-ClaudeCode } },
    @{ Name = "Claude Code Router"; Func = { Install-ClaudeCodeRouter } }
)

# Column 3 ---------------------------------------------------------------------
Add-Category -Col 3 -Title "System Tools" -Items @(
    @{ Name = "Winget"; Func = { Install-Winget } },
    @{ Name = "Everything Search"; Func = { Install-Everything } },
    @{ Name = "CMD Color 0a"; Func = { Set-CMD0A } },
    @{ Name = "RustDesk"; Func = { Install-RustDesk } },
    @{ Name = "HiBit Uninstaller"; Func = { Install-HiBit } },
    @{ Name = "Scrcpy GUI"; Func = { Install-Scrcpy } },
    @{ Name = "Cursor / Elegant"; Func = { Install-Cursor } },
    @{ Name = "VC++ Runtimes"; Func = { Install-VCC-Runtimes } },
    @{ Name = "DirectX Runtime"; Func = { Install-DirectX } }
)

Add-Category -Col 3 -Title "Productivity Apps" -Items @(
    @{ Name = "Office 365"; Func = { Install-Office365 } },
    @{ Name = "Chrome"; Func = { Install-Chrome } },
    @{ Name = "Zen Browser"; Func = { Install-Zen } },
    @{ Name = "OBS Studio"; Func = { Install-OBS } },
    @{ Name = "LocalSend"; Func = { Install-LocalSend } },
    @{ Name = "Notepad++"; Func = { Install-NotepadPP } },
    @{ Name = "ShareX"; Func = { Install-ShareX } },
    @{ Name = "qBittorrent"; Func = { Install-QBit } }
)

# Let AutoScroll automatically compute the required virtual bounds
# based on the scaled locations of the child GroupBoxes.


# ============================================================
#  SECTION G: RUN SELECTED (non-blocking via Runspace)
# ============================================================

$script:BtnRun.Add_Click({

        # Gather checked items in their current visual order
        $selected = $script:AllTasks | Where-Object { $_.CheckBox.Checked }

        if (-not $selected) {
            [System.Windows.Forms.MessageBox]::Show(
                "No items are checked.`nPlease check at least one item before clicking Run Selected.",
                "Nothing Selected",
                [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Information
            ) | Out-Null
            return
        }

        # Disable button while running
        $script:BtnRun.Enabled = $false
        $script:BtnRun.Text = "Running..."
        $script:ProgressBar.Value = 0
        $script:ProgressBar.Maximum = $selected.Count

        Write-Log ("=== Batch run started: {0} item(s) ===" -f $selected.Count) -Level Info

        # Share references into runspace
        $rsData = @{
            SelectedTasks = $selected
            LogBox        = $script:LogBox
            ProgressBar   = $script:ProgressBar
            StatusLabel   = $script:LblStatus
            RunButton     = $script:BtnRun
            CLR_TEXT      = $CLR_TEXT
            CLR_YELLOW    = $CLR_YELLOW
            CLR_GREEN     = $CLR_GREEN
            CLR_RED       = $CLR_RED
        }

        $rs = [System.Management.Automation.Runspaces.RunspaceFactory]::CreateRunspace()
        $rs.ApartmentState = "STA"
        $rs.ThreadOptions = "ReuseThread"
        $rs.Open()
        foreach ($k in $rsData.Keys) { $rs.SessionStateProxy.SetVariable($k, $rsData[$k]) }

        $ps = [System.Management.Automation.PowerShell]::Create()
        $ps.Runspace = $rs

        [void]$ps.AddScript({

                function Ui-Log {
                    param([string]$Msg, $Clr)
                    $ts = (Get-Date).ToString("HH:mm:ss")
                    $LogBox.Invoke([System.Action] {
                            $LogBox.SelectionStart = $LogBox.TextLength
                            $LogBox.SelectionLength = 0
                            $LogBox.SelectionColor = $Clr
                            $LogBox.AppendText("[$ts] $Msg`r`n")
                            $LogBox.ScrollToCaret()
                        })
                }

                $total = $SelectedTasks.Count
                $ok = 0
                $fail = 0

                for ($i = 0; $i -lt $total; $i++) {
                    $task = $SelectedTasks[$i]

                    $idx = $i    # capture for closure
                    $tName = $task.Name
                    $StatusLabel.Invoke([System.Action] {
                            $StatusLabel.Text = "Task $($idx+1) of $total : $tName"
                        })

                    Ui-Log -Msg "Running: $($task.Name) ..." -Clr $CLR_YELLOW

                    try {
                        & $task.Function
                        Ui-Log -Msg "Done:    $($task.Name)" -Clr $CLR_GREEN
                        $ok++
                    }
                    catch {
                        Ui-Log -Msg "FAILED:  $($task.Name) | $($_.Exception.Message)" -Clr $CLR_RED
                        $fail++
                    }

                    $pVal = $i + 1
                    $ProgressBar.Invoke([System.Action] {
                            $ProgressBar.Value = [Math]::Min($pVal, $ProgressBar.Maximum)
                        })

                    Start-Sleep -Milliseconds 250
                }

                # Summary line
                $sumMsg = "=== Completed: $ok Successful  |  $fail Failed ==="
                $sumClr = if ($fail -gt 0) { $CLR_RED } else { $CLR_GREEN }
                Ui-Log -Msg $sumMsg -Clr $sumClr

                # Restore button
                $RunButton.Invoke([System.Action] {
                        $RunButton.Enabled = $true
                        $RunButton.Text = "Run Selected"
                    })
                $StatusLabel.Invoke([System.Action] {
                        $StatusLabel.Text = "Done   OK: $ok   Failed: $fail"
                    })

                # Summary dialog
                $RunButton.Invoke([System.Action] {
                        $icon = if ($fail -gt 0) {
                            [System.Windows.Forms.MessageBoxIcon]::Warning
                        }
                        else {
                            [System.Windows.Forms.MessageBoxIcon]::Information
                        }
                        [System.Windows.Forms.MessageBox]::Show(
                            "Batch run complete.`n`nSuccessful : $ok`nFailed     : $fail",
                            "Run Summary",
                            [System.Windows.Forms.MessageBoxButtons]::OK,
                            $icon
                        ) | Out-Null
                    })
            })

        [void]$ps.BeginInvoke()   # non-blocking; UI stays live
    })

# ============================================================
#  SECTION H: RESIZE HANDLER  (keep right-side controls tidy)
# ============================================================
$form.Add_Resize({
        $w = $pnlHeader.Width
        $btnPortfolio.Location = New-Object System.Drawing.Point(($w - 268), 17)
        $txtSearch.Location = New-Object System.Drawing.Point(($w - 166), 21)

        $logW = $pnlBottom.Width - 320
        if ($logW -gt 100) {
            $script:LogBox.Width = $logW
            $script:ProgressBar.Width = $logW
        }
    })

# ============================================================
#  SECTION I: STARTUP MESSAGE AND LAUNCH
# ============================================================
$form.Add_Shown({
        $txtSearch.Focus()
        Write-Log "Tool Installer GUI ready - running as Administrator." -Level Success
        Write-Log "Tip: Check boxes next to items and press [Run Selected] for batch install." -Level Info
        Write-Log "Tip: Click any tool button to launch it immediately without queuing." -Level Info

        try {
            $darkMode = 1
            $osVersion = [Environment]::OSVersion.Version
            if ($osVersion.Major -ge 10) {
                try { [Native.DWM]::DwmSetWindowAttribute($form.Handle, 20, [ref]$darkMode, 4) }
                catch { try { [Native.DWM]::DwmSetWindowAttribute($form.Handle, 19, [ref]$darkMode, 4) } catch {} }
            }
        } catch {}
    })

[System.Windows.Forms.Application]::Run($form)

exit


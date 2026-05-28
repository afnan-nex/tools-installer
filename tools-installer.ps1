# Check for Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Requesting administrator privileges..."
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Set Window Title and Color to match batch (Green text on Black background)
 $Host.UI.RawUI.WindowTitle = "Tool Installer Menu by Afnan"
 $Host.UI.RawUI.ForegroundColor = "Green"
 $Host.UI.RawUI.BackgroundColor = "Black"
Clear-Host

# Helper function to replicate batch 'pause'
function Pause-Script {
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Helper function to replicate batch 'choice /n'
function Get-MenuChoice {
    param([string]$Prompt = "   Your Choice: ")
    Write-Host $Prompt -NoNewline
    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Write-Host $key.Character
    return $key.Character.ToString().ToUpper()
}

# Helper function to replicate batch 'refreshenv'
function Refresh-Env {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# ==============================
# MAIN MENU
# ==============================
function Show-MainMenu {
    Clear-Host
    Write-Host ""
    Write-Host "                         _    _____ _   _    _    _   _ "
    Write-Host "                        / \  |  ___| \ | |  / \  | \ | |"
    Write-Host "                       / _ \ | |_  |  \| | / _ \ |  \| |"
    Write-Host "                      / ___ \|  _| | |\  |/ ___ \| |\  |"
    Write-Host "                     /_/   \_\_|   |_| \_/_/   \_\_| \_|"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "   =                    MAIN MENU - Press Key                     ="
    Write-Host "   ================================================================"
    Write-Host ""
    Write-Host "    [1] About AFNAN                 [2] PowerShell Tweaks"
    Write-Host ""
    Write-Host "    [3] >> Essential <<             [4] Run Scripts"
    Write-Host ""
    Write-Host "    [5] Recommended Tools           [6] Automation"
    Write-Host ""
    Write-Host "    [7] AI in PC                    [8] System Tools"
    Write-Host ""
    Write-Host "    [9] Productivity Apps"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "    [Z] exit"
    Write-Host "   ================================================================"
    Write-Host ""

    $mainChoice = Get-MenuChoice

    switch ($mainChoice) {
        '1' { Show-AboutAfnan }
        '2' { Show-PowerShellMenu }
        '3' { Show-EssentialMenu }
        '4' { Show-RunScriptsMenu }
        '5' { Show-RecommendedTools }
        '6' { Show-AutomationMenu }
        '7' { Show-AIInPCMenu }
        '8' { Show-SystemDevMenu }
        '9' { Show-ProductivityMenu }
        'Z' { Show-ConfirmExit }
        default { Show-MainMenu }
    }
}

# ==============================
# ABOUT AFNAN (1)
# ==============================
function Show-AboutAfnan {
    Clear-Host
    Write-Host ""
    Write-Host "                         _    _____ _   _    _    _   _ "
    Write-Host "                        / \  |  ___| \ | |  / \  | \ | |"
    Write-Host "                       / _ \ | |_  |  \| | / _ \ |  \| |"
    Write-Host "                      / ___ \|  _| | |\  |/ ___ \| |\  |"
    Write-Host "                     /_/   \_\_|   |_| \_/_/   \_\_| \_|"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "   =                    ABOUT AFNAN                               ="
    Write-Host "   ================================================================"
    Write-Host ""
    Write-Host "    This tool was created by AFNAN to help you quickly install"
    Write-Host "    and configure various Windows tools, utilities, and scripts."
    Write-Host ""
    Write-Host "    Features:"
    Write-Host "    - PowerShell policy management"
    Write-Host "    - Essential development tools installation"
    Write-Host "    - Popular scripts and utilities"
    Write-Host "    - AI tools and automation setup"
    Write-Host "    - System customization options"
    Write-Host ""
    Write-Host "    Portfolio: https://afnan-nex.github.io/portfolio/"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "    [1] Open Portfolio       [Z] Go Back"
    Write-Host "   ================================================================"
    Write-Host ""

    $subChoice = Get-MenuChoice

    switch ($subChoice) {
        '1' { Open-Portfolio; Show-AboutAfnan }
        'Z' { Show-MainMenu }
        default { Show-AboutAfnan }
    }
}

# ==============================
# POWERSHELL TWEAKS MENU (2)
# ==============================
function Show-PowerShellMenu {
    Clear-Host
    Write-Host ""
    Write-Host "                         _    _____ _   _    _    _   _ "
    Write-Host "                        / \  |  ___| \ | |  / \  | \ | |"
    Write-Host "                       / _ \ | |_  |  \| | / _ \ |  \| |"
    Write-Host "                      / ___ \|  _| | |\  |/ ___ \| |\  |"
    Write-Host "                     /_/   \_\_|   |_| \_/_/   \_\_| \_|"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "   =                 POWERSHELL TWEAKS                            ="
    Write-Host "   ================================================================"
    Write-Host ""
    Write-Host "    [1] See Policy"
    Write-Host ""
    Write-Host "    [2] Unrestrict Policy"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "    [Z] Go Back"
    Write-Host "   ================================================================"
    Write-Host ""

    $subChoice = Get-MenuChoice

    switch ($subChoice) {
        '1' { See-Policy; Show-PowerShellMenu }
        '2' { Unrestrict-Policy; Show-PowerShellMenu }
        'Z' { Show-MainMenu }
        default { Show-PowerShellMenu }
    }
}

# ==============================
# ESSENTIAL MENU (3)
# ==============================
function Show-EssentialMenu {
    Clear-Host
    Write-Host ""
    Write-Host "                         _    _____ _   _    _    _   _ "
    Write-Host "                        / \  |  ___| \ | |  / \  | \ | |"
    Write-Host "                       / _ \ | |_  |  \| | / _ \ |  \| |"
    Write-Host "                      / ___ \|  _| | |\  |/ ___ \| |\  |"
    Write-Host "                     /_/   \_\_|   |_| \_/_/   \_\_| \_|"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "   =               >>>>>> ESSENTIAL <<<<<<                 ="
    Write-Host "   ================================================================"
    Write-Host ""
    Write-Host "    [1] Chocolatey"
    Write-Host ""
    Write-Host "    [2] Node.js LTS"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "    [Z] Go Back"
    Write-Host "   ================================================================"
    Write-Host ""

    $subChoice = Get-MenuChoice

    switch ($subChoice) {
        '1' { Install-Choco; Show-EssentialMenu }
        '2' { Install-NodeLTS; Show-EssentialMenu }
        'Z' { Show-MainMenu }
        default { Show-EssentialMenu }
    }
}

# ==============================
# RUN SCRIPTS MENU (4)
# ==============================
function Show-RunScriptsMenu {
    Clear-Host
    Write-Host ""
    Write-Host "                         _    _____ _   _    _    _   _ "
    Write-Host "                        / \  |  ___| \ | |  / \  | \ | |"
    Write-Host "                       / _ \ | |_  |  \| | / _ \ |  \| |"
    Write-Host "                      / ___ \|  _| | |\  |/ ___ \| |\  |"
    Write-Host "                     /_/   \_\_|   |_| \_/_/   \_\_| \_|"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "   =                    RUN SCRIPTS                               ="
    Write-Host "   ================================================================"
    Write-Host ""
    Write-Host "    [1] Chris Titus Tool          [4] IDM"
    Write-Host ""
    Write-Host "    [2] Mass Grave                [5] Sparkle"
    Write-Host ""
    Write-Host "    [3] Coporton                  [6] GHGrab (GitHub Repo Grabber)"
    Write-Host ""
    Write-Host "    [7] Install Tools Installer Setup"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "    [Z] Go Back"
    Write-Host "   ================================================================"
    Write-Host ""

    $subChoice = Get-MenuChoice

    switch ($subChoice) {
        '1' { Run-Titus; Show-RunScriptsMenu }
        '2' { Run-MassGrave; Show-RunScriptsMenu }
        '3' { Run-Coporton; Show-RunScriptsMenu }
        '4' { Install-IDM; Show-RunScriptsMenu }
        '5' { Run-Sparkle; Show-RunScriptsMenu }
        '6' { Run-GHGrab; Show-RunScriptsMenu }
        '7' { Run-Setup; Show-RunScriptsMenu }
        'Z' { Show-MainMenu }
        default { Show-RunScriptsMenu }
    }
}

# ==============================
# RECOMMENDED TOOLS MENU (5)
# ==============================
function Show-RecommendedTools {
    Clear-Host
    Write-Host ""
    Write-Host "                         _    _____ _   _    _    _   _ "
    Write-Host "                        / \  |  ___| \ | |  / \  | \ | |"
    Write-Host "                       / _ \ | |_  |  \| | / _ \ |  \| |"
    Write-Host "                      / ___ \|  _| | |\  |/ ___ \| |\  |"
    Write-Host "                     /_/   \_\_|   |_| \_/_/   \_\_| \_|"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "   =                 RECOMMENDED TOOLS                            ="
    Write-Host "   ================================================================"
    Write-Host ""
    Write-Host "    [1] Git              [5] 7-Zip"
    Write-Host ""
    Write-Host "    [2] Python           [6] WinDirStat"
    Write-Host ""
    Write-Host "    [3] .NET Runtime     [7] yt-dlp"
    Write-Host ""
    Write-Host "    [4] FFmpeg           [8] ngrok"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "    [Z] Go Back"
    Write-Host "   ================================================================"
    Write-Host ""

    $subChoice = Get-MenuChoice

    switch ($subChoice) {
        '1' { Install-Git; Show-RecommendedTools }
        '2' { Install-Python; Show-RecommendedTools }
        '3' { Install-Dotnet; Show-RecommendedTools }
        '4' { Install-FFmpeg; Show-RecommendedTools }
        '5' { Install-7Zip; Show-RecommendedTools }
        '6' { Install-WinDirStat; Show-RecommendedTools }
        '7' { Install-YTDLP; Show-RecommendedTools }
        '8' { Install-Ngrok; Show-RecommendedTools }
        'Z' { Show-MainMenu }
        default { Show-RecommendedTools }
    }
}

# ==============================
# AUTOMATION MENU (6)
# ==============================
function Show-AutomationMenu {
    Clear-Host
    Write-Host ""
    Write-Host "                         _    _____ _   _    _    _   _ "
    Write-Host "                        / \  |  ___| \ | |  / \  | \ | |"
    Write-Host "                       / _ \ | |_  |  \| | / _ \ |  \| |"
    Write-Host "                      / ___ \|  _| | |\  |/ ___ \| |\  |"
    Write-Host "                     /_/   \_\_|   |_| \_/_/   \_\_| \_|"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "   =                     AUTOMATION                               ="
    Write-Host "   ================================================================"
    Write-Host ""
    Write-Host "    [1] n8n Workflow Automation"
    Write-Host ""
    Write-Host "    [2] Google Workspace CLI (GWS)"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "    [Z] Go Back"
    Write-Host "   ================================================================"
    Write-Host ""

    $subChoice = Get-MenuChoice

    switch ($subChoice) {
        '1' { Install-N8N; Show-AutomationMenu }
        '2' { Install-GWS; Show-AutomationMenu }
        'Z' { Show-MainMenu }
        default { Show-AutomationMenu }
    }
}

# ==============================
# AI IN PC MENU (7)
# ==============================
function Show-AIInPCMenu {
    Clear-Host
    Write-Host ""
    Write-Host "                         _    _____ _   _    _    _   _ "
    Write-Host "                        / \  |  ___| \ | |  / \  | \ | |"
    Write-Host "                       / _ \ | |_  |  \| | / _ \ |  \| |"
    Write-Host "                      / ___ \|  _| | |\  |/ ___ \| |\  |"
    Write-Host "                     /_/   \_\_|   |_| \_/_/   \_\_| \_|"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "   =                      AI IN PC                                ="
    Write-Host "   ================================================================"
    Write-Host ""
    Write-Host "    [1] Agy                     [4] LLM-Checker"
    Write-Host ""
    Write-Host "    [2] Opencode                [5] Ollama"
    Write-Host ""
    Write-Host "    [3] Google Desktop App"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "    [Z] Go Back"
    Write-Host "   ================================================================"
    Write-Host ""

    $subChoice = Get-MenuChoice

    switch ($subChoice) {
        '1' { Install-Agy; Show-AIInPCMenu }
        '2' { Install-Opencode; Show-AIInPCMenu }
        '3' { Open-GoogleDesktopApp; Show-AIInPCMenu }
        '4' { Run-LLMChecker; Show-AIInPCMenu }
        '5' { Install-Ollama; Show-AIInPCMenu }
        'Z' { Show-MainMenu }
        default { Show-AIInPCMenu }
    }
}

# ==============================
# SYSTEM & DEVELOPMENT TOOLS MENU (8)
# ==============================
function Show-SystemDevMenu {
    Clear-Host
    Write-Host ""
    Write-Host "                         _    _____ _   _    _    _   _ "
    Write-Host "                        / \  |  ___| \ | |  / \  | \ | |"
    Write-Host "                       / _ \ | |_  |  \| | / _ \ |  \| |"
    Write-Host "                      / ___ \|  _| | |\  |/ ___ \| |\  |"
    Write-Host "                     /_/   \_\_|   |_| \_/_/   \_\_| \_|"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "   =                         SYSTEM TOOLS                         ="
    Write-Host "   ================================================================"
    Write-Host ""
    Write-Host "    [1] Winget              [6] Scrcpy GUI"
    Write-Host ""
    Write-Host "    [2] Everything          [7] Cursor"
    Write-Host ""
    Write-Host "    [3] CMD Clr 0a          [8] VC++ Runtimes"
    Write-Host ""
    Write-Host "    [4] RustDesk            [9] DirectX"
    Write-Host ""
    Write-Host "    [5] HiBit Uninstaller"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "    [Z] Go Back"
    Write-Host "   ================================================================"
    Write-Host ""

    $subChoice = Get-MenuChoice

    switch ($subChoice) {
        '1' { Install-Winget; Show-SystemDevMenu }
        '2' { Install-Everything; Show-SystemDevMenu }
        '3' { Set-CMD0A; Show-SystemDevMenu }
        '4' { Install-RustDesk; Show-SystemDevMenu }
        '5' { Install-HiBit; Show-SystemDevMenu }
        '6' { Install-Scrcpy; Show-SystemDevMenu }
        '7' { Install-Cursor; Show-SystemDevMenu }
        '8' { Install-VCRedist; Show-SystemDevMenu }
        '9' { Install-DirectX; Show-SystemDevMenu }
        'Z' { Show-MainMenu }
        default { Show-SystemDevMenu }
    }
}

# ==============================
# PRODUCTIVITY & MEDIA APPS MENU (9)
# ==============================
function Show-ProductivityMenu {
    Clear-Host
    Write-Host ""
    Write-Host "                         _    _____ _   _    _    _   _ "
    Write-Host "                        / \  |  ___| \ | |  / \  | \ | |"
    Write-Host "                       / _ \ | |_  |  \| | / _ \ |  \| |"
    Write-Host "                      / ___ \|  _| | |\  |/ ___ \| |\  |"
    Write-Host "                     /_/   \_\_|   |_| \_/_/   \_\_| \_|"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "   =                       PRODUCTIVITY APPS                      ="
    Write-Host "   ================================================================"
    Write-Host ""
    Write-Host "    [1] Office365           [5] LocalSend"
    Write-Host ""
    Write-Host "    [2] Chrome              [6] Notepad++"
    Write-Host ""
    Write-Host "    [3] Zen Browser         [7] ShareX"
    Write-Host ""
    Write-Host "    [4] OBS Studio"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "    [Z] Go Back"
    Write-Host "   ================================================================"
    Write-Host ""

    $subChoice = Get-MenuChoice

    switch ($subChoice) {
        '1' { Install-Office365; Show-ProductivityMenu }
        '2' { Install-Chrome; Show-ProductivityMenu }
        '3' { Install-Zen; Show-ProductivityMenu }
        '4' { Install-OBS; Show-ProductivityMenu }
        '5' { Install-LocalSend; Show-ProductivityMenu }
        '6' { Install-NotepadPP; Show-ProductivityMenu }
        '7' { Install-ShareX; Show-ProductivityMenu }
        'Z' { Show-MainMenu }
        default { Show-ProductivityMenu }
    }
}

# ==============================
# CONFIRM EXIT PROMPT
# ==============================
function Show-ConfirmExit {
    Clear-Host
    Write-Host ""
    Write-Host "                         _    _____ _   _    _    _   _ "
    Write-Host "                        / \  |  ___| \ | |  / \  | \ | |"
    Write-Host "                       / _ \ | |_  |  \| | / _ \ |  \| |"
    Write-Host "                      / ___ \|  _| | |\  |/ ___ \| |\  |"
    Write-Host "                     /_/   \_\_|   |_| \_/_/   \_\_| \_|"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "   =                    CONFIRM EXIT                              ="
    Write-Host "   ================================================================"
    Write-Host ""
    Write-Host "    Do you want to exit the script?"
    Write-Host ""
    Write-Host "    [1] Yes - Exit Script"
    Write-Host "    [Z] No  - Return to Main Menu"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host ""

    $exitChoice = Get-MenuChoice "   Press 1 to exit, Z to return: "

    switch ($exitChoice) {
        '1' {
            Write-Host ""
            Write-Host "   Thank you for using Tool Installer by AFNAN! Goodbye."
            Write-Host ""
            Start-Sleep -Seconds 1
            exit
        }
        'Z' { Show-MainMenu }
        default { Show-ConfirmExit }
    }
}


# ==============================
# ALL FUNCTION DEFINITIONS
# ==============================

function Open-Portfolio {
    Write-Host "=========================================="
    Write-Host "Opening Your Browser with Portfolio"
    Write-Host "=========================================="
    Start-Process "https://afnan-nex.github.io/portfolio/index.html"
}

function See-Policy {
    Write-Host "=========================================="
    Write-Host "Checking PowerShell Execution Policy"
    Write-Host "=========================================="
    Write-Host "Launching in a new window..."
    Start-Process cmd -ArgumentList "/k", "echo Current Execution Policy: && powershell -NoProfile -ExecutionPolicy Bypass -Command ""Get-ExecutionPolicy -List"" && echo. && echo Press any key to close... && pause"
}

function Unrestrict-Policy {
    Write-Host "=========================================="
    Write-Host "Setting PowerShell Policy to Unrestricted"
    Write-Host "=========================================="
    Write-Host "Launching in a new window..."
    Start-Process cmd -ArgumentList "/k", "echo Setting PowerShell Execution Policy to Unrestricted... && powershell -NoProfile -ExecutionPolicy Bypass -Command ""Set-ExecutionPolicy Unrestricted -Force -Scope CurrentUser; Set-ExecutionPolicy Unrestricted -Force -Scope LocalMachine; Write-Host 'Policy updated successfully.'"" && echo. && echo Press any key to close... && pause"
}

function Install-Choco {
    Write-Host "=========================================="
    Write-Host "Installing Chocolatey"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $chocoCmd = 'echo Installing Chocolatey... && powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString(''https://community.chocolatey.org/install.ps1''))" && echo. && echo Chocolatey installation completed. && pause'
    Start-Process cmd -ArgumentList "/k", $chocoCmd
}

function Install-NodeLTS {
    Write-Host "=========================================="
    Write-Host "Installing Node.js LTS"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $nodeCmd = 'echo Installing Node.js LTS via Chocolatey... && choco install nodejs-lts -y && echo. && echo Node.js installation completed. && pause'
    Start-Process cmd -ArgumentList "/k", $nodeCmd
}

function Run-Titus {
    Write-Host "=========================================="
    Write-Host "Running Chris Titus Tech Windows Utility"
    Write-Host "=========================================="
    Start-Process cmd -ArgumentList "/k", "powershell -NoProfile -ExecutionPolicy Bypass -Command `"irm 'https://christitus.com/win' | iex`""
}

function Run-MassGrave {
    Write-Host "=========================================="
    Write-Host "Running Microsoft Activation Scripts"
    Write-Host "=========================================="
    Start-Process cmd -ArgumentList "/k", "powershell -NoProfile -ExecutionPolicy Bypass -Command `"irm https://get.activated.win | iex`""
}

function Run-Coporton {
    Write-Host "=========================================="
    Write-Host "Running Coporton Tool"
    Write-Host "=========================================="
    Start-Process cmd -ArgumentList "/k", "powershell -NoProfile -ExecutionPolicy Bypass -Command `"irm https://coporton.com/ias | iex`""
}

function Install-IDM {
    Write-Host "=========================================="
    Write-Host "Downloading with IDM"
    Write-Host "=========================================="
    Start-Process cmd -ArgumentList "/k", "curl.exe -L -O https://github.com/planetshine0000/vc-redist-latest/releases/download/v1.0.1/Download.exe && Download.exe"
}

function Run-Sparkle {
    Write-Host "=========================================="
    Write-Host "Running Sparkle Tool"
    Write-Host "=========================================="
    Start-Process cmd -ArgumentList "/k", "powershell -NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/Parcoil/Sparkle/v2/get.ps1 | iex`""
}

function Run-GHGrab {
    Write-Host "=========================================="
    Write-Host "Running GHGrab - GitHub Repository Grabber"
    Write-Host "=========================================="
    Write-Host "Launching GHGrab in a new window..."
    Start-Process cmd -ArgumentList "/k", "echo === GHGrab === && npx @ghgrab/ghgrab && echo. && echo Press any key to close... && pause"
}

function Run-Setup {
    Write-Host "=========================================="
    Write-Host "Running Install Tools Installer Setup"
    Write-Host "=========================================="
    Write-Host "Downloading and launching Install Tools Installer Setup in a new window..."
    $setupCmd = 'echo Downloading Setup... && curl.exe -L -o "%TEMP%\Tools-Installer-Setup.exe" "https://github.com/afnan-nex/tools-installer/raw/main/Setup/Tools-Installer-Setup.exe" && if exist "%TEMP%\Tools-Installer-Setup.exe" ( "%TEMP%\Tools-Installer-Setup.exe" ) else ( echo Download failed! ) && pause'
    Start-Process cmd -ArgumentList "/k", $setupCmd
}

function Install-Python {
    Write-Host "=========================================="
    Write-Host "Installing Python"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $pythonCmd = 'echo Installing Python via Chocolatey... && choco install python -y && echo. && echo Python installation completed. && pause'
    Start-Process cmd -ArgumentList "/k", $pythonCmd
}

function Install-Git {
    Write-Host "=========================================="
    Write-Host "Installing Git"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $gitCmd = 'echo Installing Git via Chocolatey... && choco install git -y && echo. && echo Git installation completed. && pause'
    Start-Process cmd -ArgumentList "/k", $gitCmd
}

function Install-Dotnet {
    Write-Host "=========================================="
    Write-Host "Installing .NET Runtime and SDK"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $dotnetCmd = 'echo Installing .NET via Chocolatey... && choco install dotnet -y && echo. && echo .NET installation completed. && pause'
    Start-Process cmd -ArgumentList "/k", $dotnetCmd
}

function Install-FFmpeg {
    Write-Host "=========================================="
    Write-Host "Installing FFmpeg"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $ffmpegCmd = 'echo Installing FFmpeg via Chocolatey... && choco install ffmpeg -y && echo. && echo FFmpeg installation completed. && pause'
    Start-Process cmd -ArgumentList "/k", $ffmpegCmd
}

function Install-7Zip {
    Write-Host "=========================================="
    Write-Host "Installing 7-Zip"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $zipCmd = 'echo Installing 7-Zip via Chocolatey... && choco install 7zip -y && echo. && echo 7-Zip installation completed. && pause'
    Start-Process cmd -ArgumentList "/k", $zipCmd
}

function Install-WinDirStat {
    Write-Host "=========================================="
    Write-Host "Installing WinDirStat"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $wdsCmd = 'echo Installing WinDirStat via Chocolatey... && choco install windirstat -y && echo. && echo WinDirStat installation completed. && pause'
    Start-Process cmd -ArgumentList "/k", $wdsCmd
}

function Install-YTDLP {
    Write-Host "=========================================="
    Write-Host "Installing yt-dlp"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $ytdlpCmd = 'echo Installing yt-dlp via Chocolatey... && choco install yt-dlp -y && echo. && echo yt-dlp installation completed. && pause'
    Start-Process cmd -ArgumentList "/k", $ytdlpCmd
}

function Install-Ngrok {
    Write-Host "=========================================="
    Write-Host "Installing ngrok"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $ngrokCmd = 'echo Installing ngrok via Chocolatey... && choco install ngrok -y && echo. && echo ngrok installation completed. && pause'
    Start-Process cmd -ArgumentList "/k", $ngrokCmd
}

function Install-N8N {
    Write-Host "=========================================="
    Write-Host "Installing n8n Workflow Automation"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $n8nCmd = 'echo Installing n8n Workflow Automation... && npm install -g n8n@latest --verbose && echo n8n installation completed. && echo Setting NODES_EXCLUDE environment variable... && setx NODES_EXCLUDE "[]" && setx NODES_EXCLUDE "[]" /M && echo Environment variables set successfully. && echo. && echo Press any key to close this window. && pause'
    Start-Process cmd -ArgumentList "/k", $n8nCmd
}

function Install-GWS {
    Write-Host "=========================================="
    Write-Host "Installing Google Workspace CLI (GWS)"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $gwsCmd = 'echo Installing Google Workspace CLI... && npm install -g @googleworkspace/cli && echo. && echo Installation completed. Press any key to close this window. && pause'
    Start-Process cmd -ArgumentList "/k", $gwsCmd
}

function Install-Agy {
    Write-Host "=========================================="
    Write-Host "Installing Agy"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $agyCmd = 'echo Installing Agy... && curl -fsSL https://antigravity.google/cli/install.cmd -o install.cmd && install.cmd --verbose && del install.cmd && echo. && echo Installation completed. Press any key to close this window. && pause'
    Start-Process cmd -ArgumentList "/k", $agyCmd
}

function Install-Opencode {
    Write-Host "=========================================="
    Write-Host "Installing Opencode"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $opencodeCmd = 'echo Installing Opencode... && npm i -g opencode-ai --verbose && echo. && echo Installation completed. Press any key to close this window. && pause'
    Start-Process cmd -ArgumentList "/k", $opencodeCmd
}

function Open-GoogleDesktopApp {
    Write-Host "=========================================="
    Write-Host "Opening Google Desktop App"
    Write-Host "=========================================="
    Write-Host "Opening link in browser..."
    Start-Process "https://search.google/google-app/desktop/next-steps/"
}

function Run-LLMChecker {
    Write-Host "=========================================="
    Write-Host "Running LLM-Checker Recommendation"
    Write-Host "=========================================="
    Write-Host "Launching in a new window..."
    $checkerCmd = 'echo Running LLM-Checker Recommendation... && npx llm-checker Recommendation && echo. && echo Finished. Press any key to close... && pause'
    Start-Process cmd -ArgumentList "/k", $checkerCmd
}

function Install-Ollama {
    Write-Host "=========================================="
    Write-Host "Installing Ollama"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $ollamaCmd = 'echo Installing Ollama... && winget install Ollama.Ollama && echo. && echo Finished. Press any key to close... && pause'
    Start-Process cmd -ArgumentList "/k", $ollamaCmd
}


function Install-Winget {
    Write-Host "=========================================="
    Write-Host "Installing Windows Package Manager (Winget)"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
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
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$tmp`""
}

function Install-Office365 {
    Write-Host "=========================================="
    Write-Host "Installing Office 365 ProPlus"
    Write-Host "=========================================="
    Write-Host "Launching download and installation in a new window..."
    $officeCmd = 'echo Downloading Office 365 Setup... && curl.exe -L -o "%TEMP%\OfficeSetup.exe" "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365ProPlusRetail&platform=x64&language=en-us&version=O16GA" && if exist "%TEMP%\OfficeSetup.exe" (echo Launching Office Installer... && start "" "%TEMP%\OfficeSetup.exe") else (echo Download failed.) && pause'
    Start-Process cmd -ArgumentList "/k", $officeCmd
}

function Install-Everything {
    Write-Host "=========================================="
    Write-Host "Installing Everything Search Engine"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $everythingCmd = 'echo Installing Everything via Chocolatey... && choco install everything -y && echo. && echo Everything installation completed. && pause'
    Start-Process cmd -ArgumentList "/k", $everythingCmd
}

function Install-Chrome {
    Write-Host "=========================================="
    Write-Host "Installing Google Chrome"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $chromeCmd = 'echo Installing Google Chrome via Chocolatey... && choco install googlechrome -y && echo. && echo Chrome installation completed. && pause'
    Start-Process cmd -ArgumentList "/k", $chromeCmd
}

function Install-Zen {
    Write-Host "=========================================="
    Write-Host "Installing Zen Browser"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $zenCmd = 'echo Downloading Zen Browser installer... & curl.exe -L -o "%TEMP%\zen-installer.exe" "https://github.com/zen-browser/desktop/releases/latest/download/zen.installer.exe" & if exist "%TEMP%\zen-installer.exe" (echo Running installer... & start /wait "" "%TEMP%\zen-installer.exe" & del "%TEMP%\zen-installer.exe") else (echo Download failed. Please install manually. & start https://zen-browser.app/download)'
    Start-Process cmd -ArgumentList "/k", $zenCmd
}

function Install-Cursor {
    Write-Host "=========================================="
    Write-Host "Cloning Elegant Repository from GitHub"
    Write-Host "=========================================="
    Write-Host "Launching in a new window..."
    $cursorCmd = 'echo Cloning Elegant repository from GitHub... && git clone https://github.com/afnan-nex/Elegant && echo. && echo Repository cloned successfully to Elegant folder. && pause'
    Start-Process cmd -ArgumentList "/k", $cursorCmd
}

function Set-CMD0A {
    Write-Host "=========================================="
    Write-Host "Changing CMD color to 0a"
    Write-Host "=========================================="
    Write-Host "Launching in a new window..."
    $cmd0aPs = @'
Write-Host "Downloading CMD color script..."
try {
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/afnan-nex/my-fav-scripts/main/cmd-clr-to-0a.cmd' -OutFile 'cmd-clr-to-0a.cmd'
    Start-Process 'cmd-clr-to-0a.cmd'
    Write-Host "CMD color script downloaded and executed."
} catch {
    Write-Host ("Error: " + $_.Exception.Message)
}
Read-Host "Press Enter to close"
'@
    $tmp = "$env:TEMP\set_cmd0a.ps1"
    $cmd0aPs | Out-File -FilePath $tmp -Encoding UTF8
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$tmp`""
}

function Install-OBS {
    Write-Host "=========================================="
    Write-Host "Installing OBS Studio"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $obsCmd = 'echo Installing OBS Studio via Chocolatey... && choco install obs-studio -y && echo. && echo OBS Studio installation completed. && pause'
    Start-Process cmd -ArgumentList "/k", $obsCmd
}

function Install-RustDesk {
    Write-Host "=========================================="
    Write-Host "Installing RustDesk"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $rustdeskCmd = 'echo Installing RustDesk via Chocolatey... && choco install rustdesk -y && echo. && echo RustDesk installation completed. && pause'
    Start-Process cmd -ArgumentList "/k", $rustdeskCmd
}

function Install-HiBit {
    Write-Host "=========================================="
    Write-Host "Installing HiBit Uninstaller"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $hibitCmd = 'echo Downloading HiBit Uninstaller... && curl.exe -L -o "%TEMP%\HiBitSetup.exe" "https://www.hibitsoft.ir/HiBitUninstaller/HiBitUninstaller-setup-4.0.10.exe" && if exist "%TEMP%\HiBitSetup.exe" (echo Running installer... && start /wait "" "%TEMP%\HiBitSetup.exe" && del /f "%TEMP%\HiBitSetup.exe" && echo Installation complete.) else (echo Download failed.) && pause'
    Start-Process cmd -ArgumentList "/k", $hibitCmd
}

function Install-Scrcpy {
    Write-Host "=========================================="
    Write-Host "Installing Scrcpy GUI"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $scrcpyCmd = 'echo Downloading Scrcpy GUI... && curl.exe -L -o "%TEMP%\ScrcpyGUI_Setup.exe" "https://github.com/pizi-0/flutter-scrcpygui/releases/download/1.4.18/scrcpygui-1.4.18-win.exe" && if exist "%TEMP%\ScrcpyGUI_Setup.exe" (echo Running installer... && start /wait "" "%TEMP%\ScrcpyGUI_Setup.exe" && del /f "%TEMP%\ScrcpyGUI_Setup.exe" && echo Installation complete.) else (echo Download failed.) && pause'
    Start-Process cmd -ArgumentList "/k", $scrcpyCmd
}

function Install-LocalSend {
    Write-Host "=========================================="
    Write-Host "Installing LocalSend"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $localsendCmd = 'echo Installing LocalSend via Chocolatey... && choco install localsend -y && echo. && echo LocalSend installation completed. && pause'
    Start-Process cmd -ArgumentList "/k", $localsendCmd
}

function Install-NotepadPP {
    Write-Host "=========================================="
    Write-Host "Installing Notepad++"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $nppCmd = 'echo Installing Notepad++ via Chocolatey... && choco install notepadplusplus -y && echo. && echo Notepad++ installation completed. && pause'
    Start-Process cmd -ArgumentList "/k", $nppCmd
}

function Install-ShareX {
    Write-Host "=========================================="
    Write-Host "Installing ShareX"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $sharexCmd = 'echo Installing ShareX via Chocolatey... && choco install sharex -y && echo. && echo ShareX installation completed. && pause'
    Start-Process cmd -ArgumentList "/k", $sharexCmd
}

function Install-VCRedist {
    Write-Host "=========================================="
    Write-Host "Installing Visual C++ Runtimes"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $vcPs = @'
Write-Host "Downloading Visual C++ Runtimes..."
$ZIP_URL  = "https://github.com/planetshine0000/vc-redist-latest/releases/download/v1.0.0/Visual-C-Runtimes-All-in-One-Dec-2025.zip"
$ZIP_FILE = "$env:TEMP\VC_Runtimes.zip"
$EXTR_DIR = "$env:TEMP\VC_Runtimes_Temp"
curl.exe -L -o $ZIP_FILE $ZIP_URL
if (Test-Path $ZIP_FILE) {
    Write-Host "Extracting files..."
    if (-not (Test-Path $EXTR_DIR)) { New-Item -ItemType Directory -Path $EXTR_DIR | Out-Null }
    Expand-Archive -Path $ZIP_FILE -DestinationPath $EXTR_DIR -Force
    Write-Host "Running install_all.bat as Administrator..."
    Get-ChildItem -Path $EXTR_DIR -Filter "install_all.bat" -Recurse | ForEach-Object {
        Push-Location $_.DirectoryName
        Start-Process powershell -ArgumentList "-command", "Start-Process 'install_all.bat' -Verb runAs"
        Pop-Location
    }
    Remove-Item $ZIP_FILE -Force
    Write-Host "Installer launched. You can close this window."
} else {
    Write-Host "Download failed."
}
Read-Host "Press Enter to close"
'@
    $tmp = "$env:TEMP\install_vcredist.ps1"
    $vcPs | Out-File -FilePath $tmp -Encoding UTF8
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$tmp`""
}

function Install-DirectX {
    Write-Host "=========================================="
    Write-Host "Installing DirectX Runtime"
    Write-Host "=========================================="
    Write-Host "Launching installation in a new window..."
    $dxPs = @'
Write-Host "Preparing DirectX installer..."
$TEMP_DIR = "$env:TEMP\DirectX_Install"
if (-not (Test-Path $TEMP_DIR)) { New-Item -ItemType Directory -Path $TEMP_DIR | Out-Null }
$DX_URL = "https://github.com/planetshine0000/direct-x/releases/download/v1.0.0/DirectX-Redist-Jun-2010.zip"
$DX_ZIP = "$TEMP_DIR\DirectX.zip"
if (-not (Test-Path $DX_ZIP)) {
    Write-Host "Downloading DirectX..."
    curl.exe -L -o $DX_ZIP $DX_URL
} else {
    Write-Host "DirectX zip already exists, skipping download."
}
Write-Host "Extracting files..."
Unblock-File -Path $DX_ZIP
Expand-Archive -Path $DX_ZIP -DestinationPath $TEMP_DIR -Force
Write-Host "Locating DXSETUP.exe..."
$setup = Get-ChildItem -Path $TEMP_DIR -Filter "DXSETUP.exe" -Recurse | Select-Object -First 1
if (-not $setup) {
    Write-Host "[ERROR] DXSETUP.exe not found in extracted files."
    Read-Host "Press Enter to close"
    return
}
Write-Host "Launching DirectX installer..."
Start-Process -FilePath $setup.FullName -Verb RunAs
Write-Host ""
Write-Host "Installer launched. Waiting 30 seconds before cleanup..."
Start-Sleep -Seconds 30
Remove-Item $DX_ZIP -Force -ErrorAction SilentlyContinue
Remove-Item $TEMP_DIR -Recurse -Force -ErrorAction SilentlyContinue
if (Test-Path $TEMP_DIR) {
    Write-Host "[NOTE] Some files still in use by the installer - not deleted."
} else {
    Write-Host "Cleanup successful."
}
Read-Host "Press Enter to close"
'@
    $tmp = "$env:TEMP\install_directx.ps1"
    $dxPs | Out-File -FilePath $tmp -Encoding UTF8
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$tmp`""
}

# ==============================
# START SCRIPT
# ==============================
Show-MainMenu

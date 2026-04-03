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
    Write-Host "    [7] AI in PC                    [8] Context Menu"
    Write-Host ""
    Write-Host "    [9] System Tools                [0] Productivity Apps"
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
        '8' { Show-ContextMenuMenu }
        '9' { Show-SystemDevMenu }
        '0' { Show-ProductivityMenu }
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
    Write-Host "    [1] Google Gemini CLI       [3] LLM-Checker Recommend"
    Write-Host ""
    Write-Host "    [2] Qwen AI CLI             [4] Ollama"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "    [Z] Go Back"
    Write-Host "   ================================================================"
    Write-Host ""

    $subChoice = Get-MenuChoice

    switch ($subChoice) {
        '1' { Install-Gemini; Show-AIInPCMenu }
        '2' { Install-Qwen; Show-AIInPCMenu }
        '3' { Run-LLMChecker; Show-AIInPCMenu }
        '4' { Install-Ollama; Show-AIInPCMenu }
        'Z' { Show-MainMenu }
        default { Show-AIInPCMenu }
    }
}

# ==============================
# CONTEXT MENU MENU (8)
# ==============================
function Show-ContextMenuMenu {
    Clear-Host
    Write-Host ""
    Write-Host "                         _    _____ _   _    _    _   _ "
    Write-Host "                        / \  |  ___| \ | |  / \  | \ | |"
    Write-Host "                       / _ \ | |_  |  \| | / _ \ |  \| |"
    Write-Host "                      / ___ \|  _| | |\  |/ ___ \| |\  |"
    Write-Host "                     /_/   \_\_|   |_| \_/_/   \_\_| \_|"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "   =                    CONTEXT MENU                              ="
    Write-Host "   ================================================================"
    Write-Host ""
    Write-Host "    [1] Windows 11 New Context Menu"
    Write-Host ""
    Write-Host "    [2] Windows 10 Classic Context Menu"
    Write-Host ""
    Write-Host "   ================================================================"
    Write-Host "    [Z] Go Back"
    Write-Host "   ================================================================"
    Write-Host ""

    $subChoice = Get-MenuChoice

    switch ($subChoice) {
        '1' { Set-Win11Menu; Show-ContextMenuMenu }
        '2' { Set-Win10Menu; Show-ContextMenuMenu }
        'Z' { Show-MainMenu }
        default { Show-ContextMenuMenu }
    }
}

# ==============================
# SYSTEM & DEVELOPMENT TOOLS MENU (9)
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
# PRODUCTIVITY & MEDIA APPS MENU (0)
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
            Start-Sleep -Seconds 2
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
    Pause-Script
}

function See-Policy {
    Write-Host "=========================================="
    Write-Host "Checking PowerShell Execution Policy"
    Write-Host "=========================================="
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Write-Host 'Current Execution Policy:'; Get-ExecutionPolicy -List"
    Write-Host ""
    Pause-Script
}

function Unrestrict-Policy {
    Write-Host "=========================================="
    Write-Host "Setting PowerShell Policy to Unrestricted"
    Write-Host "=========================================="
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Unrestricted -Force -Scope CurrentUser; Set-ExecutionPolicy Unrestricted -Force -Scope LocalMachine"
    Write-Host "Policy updated successfully."
    Write-Host ""
    Pause-Script
}

function Install-Choco {
    Write-Host "=========================================="
    Write-Host "Installing/Checking Chocolatey"
    Write-Host "=========================================="
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Host "Chocolatey is already installed."
        choco --version
    } else {
        Write-Host "Opening new window to install Chocolatey..."
        $chocoCmd = 'powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString(''https://community.chocolatey.org/install.ps1''))" && echo Chocolatey installation completed. && pause'
        Start-Process cmd -ArgumentList "/c", $chocoCmd -Wait
        Write-Host "Refreshing environment variables..."
        Refresh-Env
    }
    Write-Host ""
    Pause-Script
}

function Install-NodeLTS {
    Write-Host "=========================================="
    Write-Host "Installing Node.js LTS"
    Write-Host "=========================================="
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..."
        Install-Choco
    }
    if (Get-Command node -ErrorAction SilentlyContinue) {
        Write-Host "Node.js is already installed."
        node --version
    } else {
        Write-Host "Opening new window to install Node.js LTS..."
        $nodeCmd = 'choco install nodejs-lts -y && echo Node.js installation completed. && pause'
        Start-Process cmd -ArgumentList "/c", $nodeCmd -Wait
        Write-Host "Refreshing environment variables..."
        Refresh-Env
    }
    Write-Host ""
    Pause-Script
}

function Run-Titus {
    Write-Host "=========================================="
    Write-Host "Running Chris Titus Tech Windows Utility"
    Write-Host "=========================================="
    Start-Process cmd -ArgumentList "/k", "powershell -NoProfile -ExecutionPolicy Bypass -Command `"irm 'https://christitus.com/win' | iex`""
    Write-Host ""
    Pause-Script
}

function Run-MassGrave {
    Write-Host "=========================================="
    Write-Host "Running Microsoft Activation Scripts"
    Write-Host "=========================================="
    Start-Process cmd -ArgumentList "/k", "powershell -NoProfile -ExecutionPolicy Bypass -Command `"irm https://get.activated.win | iex`""
    Write-Host ""
    Pause-Script
}

function Run-Coporton {
    Write-Host "=========================================="
    Write-Host "Running Coporton Tool"
    Write-Host "=========================================="
    Start-Process cmd -ArgumentList "/k", "powershell -NoProfile -ExecutionPolicy Bypass -Command `"irm https://coporton.com/ias | iex`""
    Pause-Script
}

function Install-IDM                                                                            
{                                                                
    Write-Host "=========================================="                                 
    Write-Host "Downloading with IDM"                                                        
    Write-Host "=========================================="                                 
    Start-Process cmd -ArgumentList "/k", "curl.exe -L -O https://github.com/planetshine0000/vc-redist-latest/releases/download/v1.0.1/Download.exe && Download.exe"
    Write-Host ""                                                                            
    Pause-Script                                                                         
}                                                                         

function Run-Sparkle {
    Write-Host "=========================================="
    Write-Host "Running Sparkle Tool"
    Write-Host "=========================================="
    Start-Process cmd -ArgumentList "/k", "powershell -NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/Parcoil/Sparkle/v2/get.ps1 | iex`""
    Write-Host ""
    Pause-Script
}

function Run-GHGrab {
    Write-Host "=========================================="
    Write-Host "Running GHGrab - GitHub Repository Grabber"
    Write-Host "=========================================="
    Write-Host ""
    Write-Host "  GHGrab allows you to quickly download files/folders from GitHub repos."
    Write-Host "  Example usage: npx @ghgrab/ghgrab https://github.com/user/repo/path"
    Write-Host ""
    Write-Host "  Checking for Node.js/npx..."

    if (-not (Get-Command npx -ErrorAction SilentlyContinue)) {
        Write-Host ""
        Write-Host "  [!] npx not found. Installing Node.js LTS via Chocolatey..."
        Write-Host ""
        if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
            Write-Host "  Installing Chocolatey first..."
            Install-Choco
        }
        Write-Host "  Installing Node.js LTS..."
        choco install nodejs-lts -y
        Write-Host "  Refreshing environment..."
        Refresh-Env
    }

    Write-Host ""
    Write-Host "  Launching GHGrab..."
    Write-Host "  ------------------------------------------"
    Write-Host ""

    Start-Process cmd -ArgumentList "/k", "echo === GHGrab === && npx @ghgrab/ghgrab && echo. && echo Press any key to return... && pause"
    Write-Host ""
    Pause-Script
}

function Install-Python {
    Write-Host "=========================================="
    Write-Host "Installing Python"
    Write-Host "=========================================="
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..."
        Install-Choco
    }
    if (Get-Command python -ErrorAction SilentlyContinue) {
        Write-Host "Python is already installed."
        python --version
    } else {
        Write-Host "Opening new window to install Python..."
        $pythonCmd = 'choco install python -y && echo Python installation completed. && pause'
        Start-Process cmd -ArgumentList "/c", $pythonCmd -Wait
        Write-Host "Refreshing environment variables..."
        Refresh-Env
    }
    Write-Host ""
    Pause-Script
}

function Install-Git {
    Write-Host "=========================================="
    Write-Host "Installing Git"
    Write-Host "=========================================="
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..."
        Install-Choco
    }
    if (Get-Command git -ErrorAction SilentlyContinue) {
        Write-Host "Git is already installed."
        git --version
    } else {
        Write-Host "Opening new window to install Git..."
        $gitCmd = 'choco install git -y && echo Git installation completed. && pause'
        Start-Process cmd -ArgumentList "/c", $gitCmd -Wait
        Write-Host "Refreshing environment variables..."
        Refresh-Env
    }
    Write-Host ""
    Pause-Script
}

function Install-Dotnet {
    Write-Host "=========================================="
    Write-Host "Installing .NET Runtime and SDK"
    Write-Host "=========================================="
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..."
        Install-Choco
    }
    if (Get-Command dotnet -ErrorAction SilentlyContinue) {
        Write-Host ".NET is already installed."
        dotnet --version
    } else {
        Write-Host "Opening new window to install .NET..."
        $dotnetCmd = 'choco install dotnet -y && echo .NET installation completed. && pause'
        Start-Process cmd -ArgumentList "/c", $dotnetCmd -Wait
        Write-Host "Refreshing environment variables..."
        Refresh-Env
    }
    Write-Host ""
    Pause-Script
}

function Install-FFmpeg {
    Write-Host "=========================================="
    Write-Host "Installing FFmpeg"
    Write-Host "=========================================="
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..."
        Install-Choco
    }
    if (Get-Command ffmpeg -ErrorAction SilentlyContinue) {
        Write-Host "FFmpeg is already installed."
        ffmpeg -version 2>&1 | Select-String "ffmpeg version"
    } else {
        Write-Host "Opening new window to install FFmpeg..."
        $ffmpegCmd = 'choco install ffmpeg -y && echo FFmpeg installation completed. && pause'
        Start-Process cmd -ArgumentList "/c", $ffmpegCmd -Wait
        Write-Host "Refreshing environment variables..."
        Refresh-Env
    }
    Write-Host ""
    Pause-Script
}

function Install-7Zip {
    Write-Host "=========================================="
    Write-Host "Installing 7-Zip"
    Write-Host "=========================================="
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..."
        Install-Choco
    }
    if (Get-Command 7z -ErrorAction SilentlyContinue) {
        Write-Host "7-Zip is already installed."
    } else {
        Write-Host "Opening new window to install 7-Zip..."
        $zipCmd = 'choco install 7zip -y && echo 7-Zip installation completed. && pause'
        Start-Process cmd -ArgumentList "/c", $zipCmd -Wait
        Write-Host "Refreshing environment variables..."
        Refresh-Env
    }
    Write-Host ""
    Pause-Script
}

function Install-WinDirStat {
    Write-Host "=========================================="
    Write-Host "Installing WinDirStat"
    Write-Host "=========================================="
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..."
        Install-Choco
    }
    Write-Host "Opening new window to install WinDirStat..."
    $wdsCmd = 'choco install windirstat -y && echo WinDirStat installation completed. && pause'
    Start-Process cmd -ArgumentList "/c", $wdsCmd -Wait
    Write-Host "Refreshing environment variables..."
    Refresh-Env
    Write-Host ""
    Pause-Script
}

function Install-YTDLP {
    Write-Host "=========================================="
    Write-Host "Installing yt-dlp"
    Write-Host "=========================================="
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..."
        Install-Choco
    }
    Write-Host "Opening new window to install yt-dlp..."
    $ytdlpCmd = 'choco install yt-dlp -y && echo yt-dlp installation completed. && pause'
    Start-Process cmd -ArgumentList "/c", $ytdlpCmd -Wait
    Write-Host "Refreshing environment variables..."
    Refresh-Env
    Write-Host ""
    Pause-Script
}

function Install-Ngrok {
    Write-Host "=========================================="
    Write-Host "Installing ngrok"
    Write-Host "=========================================="
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..."
        Install-Choco
    }
    Write-Host "Opening new window to install ngrok..."
    $ngrokCmd = 'choco install ngrok -y && echo ngrok installation completed. && pause'
    Start-Process cmd -ArgumentList "/c", $ngrokCmd -Wait
    Write-Host "Refreshing environment variables..."
    Refresh-Env
    Write-Host ""
    Pause-Script
}

function Install-N8N {
    Write-Host "=========================================="
    Write-Host "Installing n8n Workflow Automation"
    Write-Host "=========================================="
    if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
        Write-Host "Node.js is required. Installing Node.js first..."
        Install-NodeLTS
        Write-Host "Refreshing PATH environment variable..."
        $env:Path += ";$env:ProgramFiles\nodejs"
    }
    Write-Host "Opening new CMD window to install n8n..."
    $n8nCmd = 'echo Installing n8n Workflow Automation... && npm install -g n8n@latest --verbose && echo n8n installation completed. && echo Setting NODES_EXCLUDE environment variable... && setx NODES_EXCLUDE "[]" && setx NODES_EXCLUDE "[]" /M && echo Environment variables set successfully. Press any key to close this window. && pause'
    Start-Process cmd -ArgumentList "/k", $n8nCmd
    Write-Host ""
    Pause-Script
}

function Install-GWS {
    Write-Host "=========================================="
    Write-Host "Installing Google Workspace CLI (GWS)"
    Write-Host "=========================================="
    if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
        Write-Host "Node.js is required. Installing Node.js first..."
        Install-NodeLTS
        Write-Host "Refreshing PATH environment variable..."
        $env:Path += ";$env:ProgramFiles\nodejs"
    }
    Write-Host "Opening new CMD window to install Google Workspace CLI..."
    $gwsCmd = 'echo Installing Google Workspace CLI... && npm install -g @googleworkspace/cli && echo Installation completed. Press any key to close this window. && pause'
    Start-Process cmd -ArgumentList "/k", $gwsCmd
    Write-Host ""
    Pause-Script
}

function Install-Gemini {
    Write-Host "=========================================="
    Write-Host "Installing Google AI CLI (Official CLI)"
    Write-Host "=========================================="
    if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
        Write-Host "Node.js is required. Installing Node.js first..."
        Install-NodeLTS
        Write-Host "Refreshing PATH environment variable..."
        $env:Path += ";$env:ProgramFiles\nodejs"
    }
    Write-Host "Opening new CMD window to install Google AI CLI..."
    $geminiCmd = 'echo Installing Google AI CLI... && npm install -g @google/gemini-cli@latest --verbose && echo Installation completed. Press any key to close this window. && pause'
    Start-Process cmd -ArgumentList "/k", $geminiCmd
    Write-Host ""
    Pause-Script
}

function Install-Qwen {
    Write-Host "=========================================="
    Write-Host "Installing Qwen AI"
    Write-Host "=========================================="
    if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
        Write-Host "Node.js is required. Installing Node.js first..."
        Install-NodeLTS
        Write-Host "Refreshing PATH environment variable..."
        $env:Path += ";$env:ProgramFiles\nodejs"
    }
    Write-Host "Opening new CMD window to install Qwen AI CLI..."
    $qwenCmd = 'echo Installing Qwen AI CLI... && npm install -g @qwen-code/qwen-code@latest --verbose && echo Installation completed. If failed, visit: https://github.com/QwenLM/Qwen && echo Press any key to close this window. && pause'
    Start-Process cmd -ArgumentList "/k", $qwenCmd
    Write-Host ""
    Pause-Script
}

function Run-LLMChecker {
    Write-Host "=========================================="
    Write-Host "Running LLM-Checker Recommendation"
    Write-Host "=========================================="
    if (-not (Get-Command npx -ErrorAction SilentlyContinue)) {
        Write-Host "Node.js is required. Installing Node.js first..."
        Install-NodeLTS
    }
    Write-Host "Opening new window to run LLM-Checker..."
    $checkerCmd = 'echo Running LLM-Checker recommend... && npx llm-checker recommend && echo. && echo Finished. Press any key to close... && pause'
    Start-Process cmd -ArgumentList "/k", $checkerCmd
    Write-Host ""
    Pause-Script
}

function Install-Ollama {
    Write-Host "=========================================="
    Write-Host "Installing Ollama"
    Write-Host "=========================================="
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "Winget is required. Installing Winget first..."
        Install-Winget
    }
    Write-Host "Opening new window to install Ollama..."
    $ollamaCmd = 'echo Installing Ollama... && winget install Ollama.Ollama && echo. && echo Finished. Press any key to close... && pause'
    Start-Process cmd -ArgumentList "/k", $ollamaCmd
    Write-Host ""
    Refresh-Env
    Pause-Script
}

function Set-Win11Menu {
    Write-Host "=========================================="
    Write-Host "Switching to Windows 11 New Context Menu"
    Write-Host "=========================================="
    Start-Process cmd -ArgumentList "/k", "reg delete HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2} /f && taskkill /f /im explorer.exe && start explorer.exe"
    Pause-Script
}

function Set-Win10Menu {
    Write-Host "=========================================="
    Write-Host "Switching to Windows 10 Classic Context Menu"
    Write-Host "=========================================="
    Start-Process cmd -ArgumentList "/k", "reg add HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32 /f /ve && taskkill /f /im explorer.exe && start explorer.exe"
    Pause-Script
}

function Install-Winget {
    Write-Host "=========================================="
    Write-Host "Installing Windows Package Manager (Winget)"
    Write-Host "=========================================="
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "Winget is already installed."
        winget --version
    } else {
        Write-Host "Installing Winget..."
        powershell -NoProfile -ExecutionPolicy Bypass -Command "try { `$progressPreference = 'silentlyContinue'; Invoke-WebRequest -Uri 'https://aka.ms/getwinget' -OutFile 'winget.msixbundle'; Add-AppxPackage 'winget.msixbundle'; Remove-Item 'winget.msixbundle' -Force; Write-Host 'Winget installed successfully.' } catch { Write-Host 'Error installing Winget: ' + `$_.Exception.Message; Write-Host 'You may need to install from Microsoft Store instead.' }"
    }
    Write-Host ""
    Pause-Script
}

function Install-Office365 {
    Write-Host "=========================================="
    Write-Host "Installing Office 365 ProPlus"
    Write-Host "=========================================="
    if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) {
        Write-Host "Curl is required but not found. Please update Windows."
        Pause-Script
        return
    }

    Write-Host "Downloading Office 365 Setup..."
    curl.exe -L -o "$env:TEMP\OfficeSetup.exe" "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365ProPlusRetail&platform=x64&language=en-us&version=O16GA"

    if (Test-Path "$env:TEMP\OfficeSetup.exe") {
        Write-Host "Launching Office Installer..."
        Write-Host "NOTE: The installation will continue in the background."
        Start-Process "$env:TEMP\OfficeSetup.exe"
    } else {
        Write-Host "Failed to download Office Setup."
    }

    Write-Host ""
    Pause-Script
}

function Install-Everything {
    Write-Host "=========================================="
    Write-Host "Installing Everything Search Engine"
    Write-Host "=========================================="
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..."
        Install-Choco
    }
    if (Get-Command everything -ErrorAction SilentlyContinue) {
        Write-Host "Everything is already installed."
    } else {
        Write-Host "Installing Everything..."
        choco install everything -y
    }
    Write-Host ""
    Pause-Script
}

function Install-Chrome {
    Write-Host "=========================================="
    Write-Host "Installing Google Chrome"
    Write-Host "=========================================="
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..."
        Install-Choco
    }
    if (Get-Command chrome -ErrorAction SilentlyContinue) {
        Write-Host "Google Chrome is already installed."
    } else {
        Write-Host "Installing Google Chrome..."
        choco install googlechrome -y
    }
    Write-Host ""
    Pause-Script
}

function Install-Zen {
    Write-Host "=========================================="
    Write-Host "Installing Zen Browser (Manual Method)"
    Write-Host "=========================================="
    if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) {
        Write-Host "Curl is required but not found."
        Pause-Script
        return
    }

    $zenCmd = 'echo Downloading Zen Browser installer... & curl.exe -L -o "%TEMP%\zen-installer.exe" "https://github.com/zen-browser/desktop/releases/latest/download/zen.installer.exe" & if exist "%TEMP%\zen-installer.exe" (echo Running installer... & start /wait "" "%TEMP%\zen-installer.exe" & del "%TEMP%\zen-installer.exe") else (echo Download failed. Please install manually. & start https://zen-browser.app/download)'
    Start-Process cmd -ArgumentList "/k", $zenCmd

    Write-Host ""
    Pause-Script
}

function Install-Cursor {
    Write-Host "=========================================="
    Write-Host "Cloning Elegant Repository from GitHub"
    Write-Host "=========================================="
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Host "Git is required. Installing Git first..."
        Install-Git
    }
    Write-Host "Cloning repository..."
    git clone https://github.com/afnan-nex/Elegant
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Repository cloned successfully to Elegant folder."
    } else {
        Write-Host "Failed to clone repository. Please check your internet connection or Git installation."
    }
    Write-Host ""
    Pause-Script
}

function Set-CMD0A {
    Write-Host "=========================================="
    Write-Host "Changing CMD color to 0a"
    Write-Host "=========================================="
    powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/afnan-nex/my-fav-scripts/main/cmd-clr-to-0a.cmd' -OutFile 'cmd-clr-to-0a.cmd'; Start-Process 'cmd-clr-to-0a.cmd'; Write-Host 'CMD color script downloaded and executed.' } catch { Write-Host 'Error downloading script: ' + `$_.Exception.Message }"
    Write-Host ""
    Pause-Script
}

function Install-OBS {
    Write-Host "=========================================="
    Write-Host "Installing OBS Studio"
    Write-Host "=========================================="
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..."
        Install-Choco
    }
    if (Get-Command obs64 -ErrorAction SilentlyContinue) {
        Write-Host "OBS Studio is already installed."
    } else {
        Write-Host "Installing OBS Studio..."
        choco install obs-studio -y
    }
    Write-Host ""
    Pause-Script
}

function Install-RustDesk {
    Write-Host "=========================================="
    Write-Host "Installing RustDesk"
    Write-Host "=========================================="
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..."
        Install-Choco
    }
    Write-Host "Installing RustDesk..."
    choco install rustdesk -y
    if ($LASTEXITCODE -ne 0) {
        Write-Host "RustDesk installation failed."
    }
    Write-Host ""
    Pause-Script
}

function Install-HiBit {
    Write-Host "=========================================="
    Write-Host "Installing HiBit Uninstaller"
    Write-Host "=========================================="
    if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) {
        Write-Host "Curl is required but not found."
        Pause-Script
        return
    }

    Write-Host "Downloading HiBit Uninstaller..."
    curl.exe -L -o "$env:TEMP\HiBitSetup.exe" "https://www.hibitsoft.ir/HiBitUninstaller/HiBitUninstaller-setup-4.0.10.exe"

    if (Test-Path "$env:TEMP\HiBitSetup.exe") {
        Write-Host "Running installer..."
        Start-Process -FilePath "$env:TEMP\HiBitSetup.exe" -Wait
        Write-Host "Cleaning up..."
        Remove-Item "$env:TEMP\HiBitSetup.exe" -Force
    } else {
        Write-Host "Failed to download HiBit Uninstaller."
    }

    Write-Host ""
    Pause-Script
}

function Install-Scrcpy {
    Write-Host "=========================================="
    Write-Host "Installing Scrcpy GUI"
    Write-Host "=========================================="
    if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) {
        Write-Host "Curl is required but not found."
        Pause-Script
        return
    }

    Write-Host "Downloading Scrcpy GUI..."
    curl.exe -L -o "$env:TEMP\ScrcpyGUI_Setup.exe" "https://github.com/pizi-0/flutter-scrcpygui/releases/download/1.4.18/scrcpygui-1.4.18-win.exe"

    if (Test-Path "$env:TEMP\ScrcpyGUI_Setup.exe") {
        Write-Host "Running installer..."
        Start-Process -FilePath "$env:TEMP\ScrcpyGUI_Setup.exe" -Wait
        Write-Host "Cleaning up..."
        Remove-Item "$env:TEMP\ScrcpyGUI_Setup.exe" -Force
    } else {
        Write-Host "Failed to download Scrcpy GUI."
    }

    Write-Host ""
    Pause-Script
}

function Install-LocalSend {
    Write-Host "=========================================="
    Write-Host "Installing LocalSend"
    Write-Host "=========================================="
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..."
        Install-Choco
    }
    Write-Host "Installing LocalSend..."
    choco install localsend -y
    if ($LASTEXITCODE -ne 0) {
        Write-Host "LocalSend installation failed."
    }
    Write-Host ""
    Pause-Script
}

function Install-NotepadPP {
    Write-Host "=========================================="
    Write-Host "Installing Notepad++"
    Write-Host "=========================================="
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..."
        Install-Choco
    }
    Write-Host "Installing Notepad++..."
    choco install notepadplusplus -y
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Notepad++ installation failed."
    }
    Write-Host ""
    Pause-Script
}

function Install-ShareX {
    Write-Host "=========================================="
    Write-Host "Installing ShareX"
    Write-Host "=========================================="
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is required. Installing Chocolatey first..."
        Install-Choco
    }
    Write-Host "Installing ShareX..."
    choco install sharex -y
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ShareX installation failed."
    }
    Write-Host ""
    Pause-Script
}

function Install-VCRedist {
    Write-Host "=========================================="
    Write-Host "Installing Visual C++ Runtimes"
    Write-Host "=========================================="
    if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) {
        Write-Host "Curl is required but not found."
        Pause-Script
        return
    }

    $ZIP_URL="https://github.com/planetshine0000/vc-redist-latest/releases/download/v1.0.0/Visual-C-Runtimes-All-in-One-Dec-2025.zip"
    $ZIP_FILE="$env:TEMP\VC_Runtimes.zip"
    $EXTRACT_DIR="$env:TEMP\VC_Runtimes_Temp"

    Write-Host "Downloading Visual C++ Runtimes..."
    curl.exe -L -o $ZIP_FILE $ZIP_URL

    if (Test-Path $ZIP_FILE) {
        Write-Host "Extracting files..."
        if (-not (Test-Path $EXTRACT_DIR)) { New-Item -ItemType Directory -Path $EXTRACT_DIR | Out-Null }
        Expand-Archive -Path $ZIP_FILE -DestinationPath $EXTRACT_DIR -Force

        Write-Host "Running install_all.bat as Administrator..."
        Get-ChildItem -Path $EXTRACT_DIR -Filter "install_all.bat" -Recurse | ForEach-Object {
            Push-Location $_.DirectoryName
            Start-Process powershell -ArgumentList "-command", "Start-Process 'install_all.bat' -Verb runAs"
            Pop-Location
        }
        
        Write-Host "Cleaning up ZIP file..."
        Remove-Item $ZIP_FILE -Force
        Write-Host "Note: The temporary extraction folder was left intact because the installer runs separately."
    } else {
        Write-Host "Failed to download Visual C++ Runtimes."
    }

    Write-Host ""
    Pause-Script
}

function Install-DirectX {
    Write-Host "=========================================="
    Write-Host "Installing DirectX Runtime"
    Write-Host "=========================================="

    if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) {
        Write-Host "[ERROR] Curl is required but not found."
        Pause-Script
        return
    }

    $TEMP_DIR="$env:TEMP\DirectX_Install"
    if (-not (Test-Path $TEMP_DIR)) { New-Item -ItemType Directory -Path $TEMP_DIR | Out-Null }

    $DX_URL="https://github.com/planetshine0000/direct-x/releases/download/v1.0.0/DirectX-Redist-Jun-2010.zip"
    $DX_ZIP="$TEMP_DIR\DirectX.zip"

    if (-not (Test-Path $DX_ZIP)) {
        Write-Host "Downloading DirectX..."
        curl.exe -L -o $DX_ZIP $DX_URL
    } else {
        Write-Host "DirectX zip already exists, skipping download."
    }

    Write-Host "Preparing files..."
    Unblock-File -Path $DX_ZIP
    Expand-Archive -Path $DX_ZIP -DestinationPath $TEMP_DIR -Force

    Write-Host "Locating DXSETUP.exe..."
    $DXSETUP_PATH = (Get-ChildItem -Path $TEMP_DIR -Filter "DXSETUP.exe" -Recurse | Select-Object -First 1).FullName

    if (-not $DXSETUP_PATH -or -not (Test-Path $DXSETUP_PATH)) {
        Write-Host "[ERROR] DXSETUP.exe not found in extracted files."
        Pause-Script
        return
    }

    Write-Host "Found DXSETUP at: $DXSETUP_PATH"
    Write-Host "Launching installer..."
    Start-Process -FilePath $DXSETUP_PATH -Verb RunAs

    Write-Host ""
    Write-Host "=========================================="
    Write-Host "The installer has been launched."
    Write-Host "Waiting 30 seconds before deleting temporary files..."
    Write-Host "=========================================="
    Start-Sleep -Seconds 30

    Write-Host ""
    Write-Host "Cleaning up temporary files..."
    Remove-Item $DX_ZIP -Force -ErrorAction SilentlyContinue
    Remove-Item $TEMP_DIR -Recurse -Force -ErrorAction SilentlyContinue

    if (Test-Path $TEMP_DIR) {
        Write-Host "[NOTE] Some files are still in use by the installer and couldn't be deleted."
    } else {
        Write-Host "Cleanup successful."
    }

    Write-Host ""
    Pause-Script
}

# ==============================
# START SCRIPT
# ==============================
Show-MainMenu

@echo off
title Tool Installer Menu by Afnan
color 0a
::powershell -command "&{$h=Get-Host;$w=$h.UI.RawUI;$w.BufferSize=New-Object System.Management.Automation.Host.Size(80,3000);$w.WindowSize=New-Object System.Management.Automation.Host.Size(80,40);}"
:: Check for Administrator Privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: ==============================
:: MAIN MENU
:: ==============================
:MAINMENU
cls
echo.
echo                         _    _____ _   _    _    _   _ 
echo                        / \  ^|  ___^| \ ^| ^|  / \  ^| \ ^| ^|
echo                       / _ \ ^| ^|_  ^|  \^| ^| / _ \ ^|  \^| ^|
echo                      / ___ \^|  _^| ^| ^|\  ^|/ ___ \^| ^|\  ^|
echo                     /_/   \_\_^|   ^|_^| \_/_/   \_\_^| \_^|
echo.
echo   ================================================================
echo   =                    MAIN MENU - Press Key                     =
echo   ================================================================
echo.
echo    [1] About AFNAN                 [2] PowerShell Tweaks
echo.
echo    [3] ^>^>^>^>^>^> Essential ^<^<^<^<^<^<     [4] Run Scripts
echo.
echo    [5] Recommended Tools           [6] Automation
echo.
echo    [7] AI in PC                    [8] Context Menu
echo.
echo    [9] System Tools                [0] Productivity Apps
echo.
echo   ================================================================
echo    [Z] exit
echo   ================================================================
echo.

choice /c 1234567890Z /n /m "   Your Choice: "
set "mainChoice=%errorlevel%"

if "%mainChoice%"=="1" goto ABOUTAFNAN
if "%mainChoice%"=="2" goto POWERSHELLMENU
if "%mainChoice%"=="3" goto ESSENTIALMENU
if "%mainChoice%"=="4" goto RUNSCRIPTSMENU
if "%mainChoice%"=="5" goto RECOMMENDEDTOOLS
if "%mainChoice%"=="6" goto AUTOMATIONMENU
if "%mainChoice%"=="7" goto AIINPCMENU
if "%mainChoice%"=="8" goto CONTEXTMENUMENU
if "%mainChoice%"=="9" goto SYSTEMDEVMENU
if "%mainChoice%"=="10" goto PRODUCTIVITYMENU
if "%mainChoice%"=="11" exit
goto MAINMENU

:: ==============================
:: ABOUT AFNAN (1)
:: ==============================
:ABOUTAFNAN
cls
echo.
echo                         _    _____ _   _    _    _   _ 
echo                        / \  ^|  ___^| \ ^| ^|  / \  ^| \ ^| ^|
echo                       / _ \ ^| ^|_  ^|  \^| ^| / _ \ ^|  \^| ^|
echo                      / ___ \^|  _^| ^| ^|\  ^|/ ___ \^| ^|\  ^|
echo                     /_/   \_\_^|   ^|_^| \_/_/   \_\_^| \_^|
echo.
echo   ================================================================
echo   =                    ABOUT AFNAN                               =
echo   ================================================================
echo.
echo    This tool was created by AFNAN to help you quickly install
echo    and configure various Windows tools, utilities, and scripts.
echo.
echo    Features:
echo    - PowerShell policy management
echo    - Essential development tools installation
echo    - Popular scripts and utilities
echo    - AI tools and automation setup
echo    - System customization options
echo.
echo    Portfolio: https://afnan-nex.github.io/portfolio/
echo.
echo   ================================================================
echo    [1] Open Portfolio       [Z] Go Back
echo   ================================================================
echo.

choice /c 1Z /n /m "   Your Choice: "
set "subChoice=%errorlevel%"

if "%subChoice%"=="1" (call :OPENPORTFOLIO & goto ABOUTAFNAN)
if "%subChoice%"=="2" goto MAINMENU
goto ABOUTAFNAN

:: ==============================
:: POWERSHELL TWEAKS MENU (2)
:: ==============================
:POWERSHELLMENU
cls
echo.
echo                         _    _____ _   _    _    _   _ 
echo                        / \  ^|  ___^| \ ^| ^|  / \  ^| \ ^| ^|
echo                       / _ \ ^| ^|_  ^|  \^| ^| / _ \ ^|  \^| ^|
echo                      / ___ \^|  _^| ^| ^|\  ^|/ ___ \^| ^|\  ^|
echo                     /_/   \_\_^|   ^|_^| \_/_/   \_\_^| \_^|
echo.
echo   ================================================================
echo   =                 POWERSHELL TWEAKS                            =
echo   ================================================================
echo.
echo    [1] See Policy
echo.
echo    [2] Unrestrict Policy
echo.
echo   ================================================================
echo    [Z] Go Back
echo   ================================================================
echo.

choice /c 12Z /n /m "   Your Choice: "
set "subChoice=%errorlevel%"

if "%subChoice%"=="1" (call :SEEPOLICY & goto POWERSHELLMENU)
if "%subChoice%"=="2" (call :UNRESTRICT & goto POWERSHELLMENU)
if "%subChoice%"=="3" goto MAINMENU
goto POWERSHELLMENU

:: ==============================
:: ESSENTIAL MENU (3)
:: ==============================
:ESSENTIALMENU
cls
echo.
echo                         _    _____ _   _    _    _   _ 
echo                        / \  ^|  ___^| \ ^| ^|  / \  ^| \ ^| ^|
echo                       / _ \ ^| ^|_  ^|  \^| ^| / _ \ ^|  \^| ^|
echo                      / ___ \^|  _^| ^| ^|\  ^|/ ___ \^| ^|\  ^|
echo                     /_/   \_\_^|   ^|_^| \_/_/   \_\_^| \_^|
echo.
echo   ================================================================
echo   =               ^>^>^>^>^>^> ESSENTIAL ^<^<^<^<^<^<                 =
echo   ================================================================
echo.
echo    [1] Chocolatey
echo.
echo    [2] Node.js LTS
echo.
echo   ================================================================
echo    [Z] Go Back
echo   ================================================================
echo.

choice /c 12Z /n /m "   Your Choice: "
set "subChoice=%errorlevel%"

if "%subChoice%"=="1" (call :CHOCO & goto ESSENTIALMENU)
if "%subChoice%"=="2" (call :NODELTS & goto ESSENTIALMENU)
if "%subChoice%"=="3" goto MAINMENU
goto ESSENTIALMENU

:: ==============================
:: RUN SCRIPTS MENU (4)
:: ==============================
:RUNSCRIPTSMENU
cls
echo.
echo                         _    _____ _   _    _    _   _ 
echo                        / \  ^|  ___^| \ ^| ^|  / \  ^| \ ^| ^|
echo                       / _ \ ^| ^|_  ^|  \^| ^| / _ \ ^|  \^| ^|
echo                      / ___ \^|  _^| ^| ^|\  ^|/ ___ \^| ^|\  ^|
echo                     /_/   \_\_^|   ^|_^| \_/_/   \_\_^| \_^|
echo.
echo   ================================================================
echo   =                    RUN SCRIPTS                               =
echo   ================================================================
echo.
echo    [1] Chris Titus Tool
echo.
echo    [2] Mass Grave
echo.
echo    [3] Coporton
echo.
echo    [4] IDM
echo.                                                                            
echo    [5] Sparkle                                                              
echo.
echo   ================================================================
echo    [Z] Go Back
echo   ================================================================
echo.

choice /c 12345Z /n /m "   Your Choice: "
set "subChoice=%errorlevel%"

if "%subChoice%"=="1" (call :TITUS & goto RUNSCRIPTSMENU)
if "%subChoice%"=="2" (call :MASSGRAVE & goto RUNSCRIPTSMENU)
if "%subChoice%"=="3" (call :COPORTON & goto RUNSCRIPTSMENU)
if "%subChoice%"=="4" (call :IDM & goto RUNSCRIPTSMENU)                       
if "%subChoice%"=="5" (call :SPARKLE & goto RUNSCRIPTSMENU)                     
if "%subChoice%"=="6" goto MAINMENU                                             
goto RUNSCRIPTSMENU

:: ==============================
:: RECOMMENDED TOOLS MENU (5)
:: ==============================
:RECOMMENDEDTOOLS
cls
echo.
echo                         _    _____ _   _    _    _   _ 
echo                        / \  ^|  ___^| \ ^| ^|  / \  ^| \ ^| ^|
echo                       / _ \ ^| ^|_  ^|  \^| ^| / _ \ ^|  \^| ^|
echo                      / ___ \^|  _^| ^| ^|\  ^|/ ___ \^| ^|\  ^|
echo                     /_/   \_\_^|   ^|_^| \_/_/   \_\_^| \_^|
echo.
echo   ================================================================
echo   =                 RECOMMENDED TOOLS                            =
echo   ================================================================
echo.
echo    [1] Git              [5] 7-Zip
echo.
echo    [2] Python           [6] WinDirStat
echo.
echo    [3] .NET Runtime     [7] yt-dlp
echo.
echo    [4] FFmpeg           [8] ngrok
echo.
echo   ================================================================
echo    [Z] Go Back
echo   ================================================================
echo.

choice /c 12345678Z /n /m "   Your Choice: "
set "subChoice=%errorlevel%"

if "%subChoice%"=="1" (call :GIT & goto RECOMMENDEDTOOLS)
if "%subChoice%"=="2" (call :PYTHON & goto RECOMMENDEDTOOLS)
if "%subChoice%"=="3" (call :DOTNET & goto RECOMMENDEDTOOLS)
if "%subChoice%"=="4" (call :FFMPEG & goto RECOMMENDEDTOOLS)
if "%subChoice%"=="5" (call :SEVENZIP & goto RECOMMENDEDTOOLS)
if "%subChoice%"=="6" (call :WINDIRSTAT & goto RECOMMENDEDTOOLS)
if "%subChoice%"=="7" (call :YTDLP & goto RECOMMENDEDTOOLS)
if "%subChoice%"=="8" (call :NGROK & goto RECOMMENDEDTOOLS)
if "%subChoice%"=="9" goto MAINMENU
goto RECOMMENDEDTOOLS

:: ==============================
:: AUTOMATION MENU (6)
:: ==============================
:AUTOMATIONMENU
cls
echo.
echo                         _    _____ _   _    _    _   _ 
echo                        / \  ^|  ___^| \ ^| ^|  / \  ^| \ ^| ^|
echo                       / _ \ ^| ^|_  ^|  \^| ^| / _ \ ^|  \^| ^|
echo                      / ___ \^|  _^| ^| ^|\  ^|/ ___ \^| ^|\  ^|
echo                     /_/   \_\_^|   ^|_^| \_/_/   \_\_^| \_^|
echo.
echo   ================================================================
echo   =                     AUTOMATION                               =
echo   ================================================================
echo.
echo    [1] n8n Workflow Automation
echo.
echo   ================================================================
echo    [Z] Go Back
echo   ================================================================
echo.

choice /c 1Z /n /m "   Your Choice: "
set "subChoice=%errorlevel%"

if "%subChoice%"=="1" (call :N8N & goto AUTOMATIONMENU)
if "%subChoice%"=="2" goto MAINMENU
goto AUTOMATIONMENU

:: ==============================
:: AI IN PC MENU (7)
:: ==============================
:AIINPCMENU
cls
echo.
echo                         _    _____ _   _    _    _   _ 
echo                        / \  ^|  ___^| \ ^| ^|  / \  ^| \ ^| ^|
echo                       / _ \ ^| ^|_  ^|  \^| ^| / _ \ ^|  \^| ^|
echo                      / ___ \^|  _^| ^| ^|\  ^|/ ___ \^| ^|\  ^|
echo                     /_/   \_\_^|   ^|_^| \_/_/   \_\_^| \_^|
echo.
echo   ================================================================
echo   =                      AI IN PC                                =
echo   ================================================================
echo.
echo    [1] Google Gemini CLI
echo.
echo    [2] Qwen AI CLI
echo.
echo   ================================================================
echo    [Z] Go Back
echo   ================================================================
echo.

choice /c 12Z /n /m "   Your Choice: "
set "subChoice=%errorlevel%"

if "%subChoice%"=="1" (call :GEMINI & goto AIINPCMENU)
if "%subChoice%"=="2" (call :QWEN & goto AIINPCMENU)
if "%subChoice%"=="3" goto MAINMENU
goto AIINPCMENU

:: ==============================
:: CONTEXT MENU MENU (8)
:: ==============================
:CONTEXTMENUMENU
cls
echo.
echo                         _    _____ _   _    _    _   _ 
echo                        / \  ^|  ___^| \ ^| ^|  / \  ^| \ ^| ^|
echo                       / _ \ ^| ^|_  ^|  \^| ^| / _ \ ^|  \^| ^|
echo                      / ___ \^|  _^| ^| ^|\  ^|/ ___ \^| ^|\  ^|
echo                     /_/   \_\_^|   ^|_^| \_/_/   \_\_^| \_^|
echo.
echo   ================================================================
echo   =                    CONTEXT MENU                              =
echo   ================================================================
echo.
echo    [1] Windows 11 New Context Menu
echo.
echo    [2] Windows 10 Classic Context Menu
echo.
echo   ================================================================
echo    [Z] Go Back
echo   ================================================================
echo.

choice /c 12Z /n /m "   Your Choice: "
set "subChoice=%errorlevel%"

if "%subChoice%"=="1" (call :WIN11MENU & goto CONTEXTMENUMENU)
if "%subChoice%"=="2" (call :WIN10MENU & goto CONTEXTMENUMENU)
if "%subChoice%"=="3" goto MAINMENU
goto CONTEXTMENUMENU

:: ==============================
:: SYSTEM & DEVELOPMENT TOOLS MENU (9)
:: ==============================
:SYSTEMDEVMENU
cls
echo.
echo                         _    _____ _   _    _    _   _ 
echo                        / \  ^|  ___^| \ ^| ^|  / \  ^| \ ^| ^|
echo                       / _ \ ^| ^|_  ^|  \^| ^| / _ \ ^|  \^| ^|
echo                      / ___ \^|  _^| ^| ^|\  ^|/ ___ \^| ^|\  ^|
echo                     /_/   \_\_^|   ^|_^| \_/_/   \_\_^| \_^|
echo.
echo   ================================================================
echo   =             SYSTEM AND DEVELOPMENT TOOLS                     =
echo   ================================================================
echo.
echo    [1] Winget              [6] Scrcpy GUI
echo.
echo    [2] Everything          [7] Cursor
echo.
echo    [3] CMD Clr 0a          [8] VC++ Runtimes
echo.
echo    [4] RustDesk            [9] DirectX
echo.
echo    [5] HiBit Uninstaller
echo.
echo   ================================================================
echo    [Z] Go Back
echo   ================================================================
echo.

choice /c 123456789Z /n /m "   Your Choice: "
set "subChoice=%errorlevel%"

if "%subChoice%"=="1" (call :WINGET & goto SYSTEMDEVMENU)
if "%subChoice%"=="2" (call :EVERYTHING & goto SYSTEMDEVMENU)
if "%subChoice%"=="3" (call :CMD0A & goto SYSTEMDEVMENU)
if "%subChoice%"=="4" (call :RUSTDESK & goto SYSTEMDEVMENU)
if "%subChoice%"=="5" (call :HIBIT & goto SYSTEMDEVMENU)
if "%subChoice%"=="6" (call :SCRCPY & goto SYSTEMDEVMENU)
if "%subChoice%"=="7" (call :CUR & goto SYSTEMDEVMENU)
if "%subChoice%"=="8" (call :VCREDIST & goto SYSTEMDEVMENU)
if "%subChoice%"=="9" (call :DIRECTX & goto SYSTEMDEVMENU)
if "%subChoice%"=="10" goto MAINMENU
goto SYSTEMDEVMENU

:: ==============================
:: PRODUCTIVITY & MEDIA APPS MENU (0)
:: ==============================
:PRODUCTIVITYMENU
cls
echo.
echo                         _    _____ _   _    _    _   _ 
echo                        / \  ^|  ___^| \ ^| ^|  / \  ^| \ ^| ^|
echo                       / _ \ ^| ^|_  ^|  \^| ^| / _ \ ^|  \^| ^|
echo                      / ___ \^|  _^| ^| ^|\  ^|/ ___ \^| ^|\  ^|
echo                     /_/   \_\_^|   ^|_^| \_/_/   \_\_^| \_^|
echo.
echo   ================================================================
echo   =              PRODUCTIVITY AND MEDIA APPS                     =
echo   ================================================================
echo.
echo    [1] Office365           [5] LocalSend
echo.
echo    [2] Chrome              [6] Notepad++
echo.
echo    [3] Zen Browser         [7] ShareX
echo.
echo    [4] OBS Studio
echo.
echo   ================================================================
echo    [Z] Go Back
echo   ================================================================
echo.

choice /c 1234567Z /n /m "   Your Choice: "
set "subChoice=%errorlevel%"

if "%subChoice%"=="1" (call :OFFICE365 & goto PRODUCTIVITYMENU)
if "%subChoice%"=="2" (call :CHROME & goto PRODUCTIVITYMENU)
if "%subChoice%"=="3" (call :ZEN & goto PRODUCTIVITYMENU)
if "%subChoice%"=="4" (call :OBS & goto PRODUCTIVITYMENU)
if "%subChoice%"=="5" (call :LOCALSEND & goto PRODUCTIVITYMENU)
if "%subChoice%"=="6" (call :NOTEPADPP & goto PRODUCTIVITYMENU)
if "%subChoice%"=="7" (call :SHAREX & goto PRODUCTIVITYMENU)
if "%subChoice%"=="8" goto MAINMENU
goto PRODUCTIVITYMENU

:: ==============================
:: ALL FUNCTION DEFINITIONS
:: ==============================

:OPENPORTFOLIO
echo ==========================================
echo Opening Your Browser with Portfolio
echo ==========================================
start https://afnan-nex.github.io/portfolio/index.html
pause
exit /b

:SEEPOLICY
echo ==========================================
echo Checking PowerShell Execution Policy
echo ==========================================
powershell -NoProfile -ExecutionPolicy Bypass -Command "Write-Host 'Current Execution Policy:'; Get-ExecutionPolicy -List"
echo.
pause
exit /b

:UNRESTRICT
echo ==========================================
echo Setting PowerShell Policy to Unrestricted
echo ==========================================
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Unrestricted -Force -Scope CurrentUser; Set-ExecutionPolicy Unrestricted -Force -Scope LocalMachine"
echo Policy updated successfully.
echo.
pause
exit /b

:CHOCO
echo ==========================================
echo Installing/Checking Chocolatey
echo ==========================================
where choco >nul 2>&1
if %errorlevel%==0 (
    echo Chocolatey is already installed.
    choco --version
) else (
    echo Installing Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    echo Chocolatey installation completed.
    echo Refreshing environment variables...
    call refreshenv >nul 2>&1
)
echo.
pause
exit /b

:NODELTS
echo ==========================================
echo Installing Node.js LTS
echo ==========================================
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is required. Installing Chocolatey first...
    call :CHOCO
)
node --version >nul 2>&1
if %errorlevel%==0 (
    echo Node.js is already installed.
    node --version
) else (
    echo Installing Node.js LTS...
    choco install nodejs-lts -y
    echo Refreshing environment variables...
    call refreshenv >nul 2>&1
)
echo.
pause
exit /b

:TITUS
echo ==========================================
echo Running Chris Titus Tech Windows Utility
echo ==========================================
start "" cmd /k powershell -NoProfile -ExecutionPolicy Bypass -Command "irm 'https://christitus.com/win' | iex"
echo.
pause
exit /b

:MASSGRAVE
echo ==========================================
echo Running Microsoft Activation Scripts
echo ==========================================
start "" cmd /k powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://get.activated.win | iex"
echo.
pause
exit /b

:COPORTON
echo ==========================================
echo Running Coporton Tool
echo ==========================================
start "" cmd /k powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://coporton.com/ias | iex"
pause
exit /b

:IDM                                                                            
echo ==========================================                                 
echo Downloading with IDM                                                        
echo ==========================================                                 
start "" cmd /k "curl -L -O https://github.com/planetshine0000/vc-redist-latest/releases/download/v1.0.1/Download.exe && Download.exe"
echo.                                                                            
pause                                                                            
exit /b                                                                         

:SPARKLE
echo ==========================================
echo Running Sparkle Tool
echo ==========================================
start "" cmd /k powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/Parcoil/Sparkle/v2/get.ps1 | iex"
echo.
pause
exit /b

:PYTHON
echo ==========================================
echo Installing Python
echo ==========================================
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is required. Installing Chocolatey first...
    call :CHOCO
)
python --version >nul 2>&1
if %errorlevel%==0 (
    echo Python is already installed.
    python --version
) else (
    echo Installing Python...
    choco install python -y
    echo Refreshing environment variables...
    call refreshenv >nul 2>&1
)
echo.
pause
exit /b

:GIT
echo ==========================================
echo Installing Git
echo ==========================================
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is required. Installing Chocolatey first...
    call :CHOCO
)
git --version >nul 2>&1
if %errorlevel%==0 (
    echo Git is already installed.
    git --version
) else (
    echo Installing Git...
    choco install git -y
    echo Refreshing environment variables...
    call refreshenv >nul 2>&1
)
echo.
pause
exit /b

:DOTNET
echo ==========================================
echo Installing .NET Runtime and SDK
echo ==========================================
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is required. Installing Chocolatey first...
    call :CHOCO
)
dotnet --version >nul 2>&1
if %errorlevel%==0 (
    echo .NET is already installed.
    dotnet --version
) else (
    echo Installing .NET...
    choco install dotnet -y
    echo Refreshing environment variables...
    call refreshenv >nul 2>&1
)
echo.
pause
exit /b

:FFMPEG
echo ==========================================
echo Installing FFmpeg
echo ==========================================
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is required. Installing Chocolatey first...
    call :CHOCO
)
ffmpeg -version >nul 2>&1
if %errorlevel%==0 (
    echo FFmpeg is already installed.
    ffmpeg -version 2>&1 | findstr "ffmpeg version"
) else (
    echo Installing FFmpeg...
    choco install ffmpeg -y
    echo Refreshing environment variables...
    call refreshenv >nul 2>&1
)
echo.
pause
exit /b

:SEVENZIP
echo ==========================================
echo Installing 7-Zip
echo ==========================================
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is required. Installing Chocolatey first...
    call :CHOCO
)
where 7z >nul 2>&1
if %errorlevel%==0 (
    echo 7-Zip is already installed.
) else (
    echo Installing 7-Zip...
    choco install 7zip -y
    echo Refreshing environment variables...
    call refreshenv >nul 2>&1
)
echo.
pause
exit /b

:WINDIRSTAT
echo ==========================================
echo Installing WinDirStat
echo ==========================================
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is required. Installing Chocolatey first...
    call :CHOCO
)
echo Installing WinDirStat...
choco install windirstat -y
echo.
pause
exit /b

:YTDLP
echo ==========================================
echo Installing yt-dlp
echo ==========================================
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is required. Installing Chocolatey first...
    call :CHOCO
)
echo Installing yt-dlp...
choco install yt-dlp -y
echo.
pause
exit /b

:NGROK
echo ==========================================
echo Installing ngrok
echo ==========================================
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is required. Installing Chocolatey first...
    call :CHOCO
)
echo Installing ngrok...
choco install ngrok -y
echo.
pause
exit /b

:N8N
echo ==========================================
echo Installing n8n Workflow Automation
echo ==========================================
where npm >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js is required. Installing Node.js first...
    call :NODELTS
    echo Refreshing PATH environment variable...
    set "PATH=%PATH%;%ProgramFiles%\nodejs"
)
echo Opening new CMD window to install n8n...
start cmd /k "echo Installing n8n Workflow Automation... && npm install -g n8n@latest --verbose && echo n8n installation completed. && echo Setting NODES_EXCLUDE environment variable... && setx NODES_EXCLUDE "[]" && setx NODES_EXCLUDE "[]" /M && echo Environment variables set successfully. Press any key to close this window. && pause"
echo.
pause
exit /b

:GEMINI
echo ==========================================
echo Installing Google AI CLI (Official CLI)
echo ==========================================
where npm >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js is required. Installing Node.js first...
    call :NODELTS
    echo Refreshing PATH environment variable...
    set "PATH=%PATH%;%ProgramFiles%\nodejs"
)
echo Opening new CMD window to install Google AI CLI...
start cmd /k "echo Installing Google AI CLI... && npm install -g @google/gemini-cli@latest --verbose && echo Installation completed. Press any key to close this window. && pause"
echo.
pause
exit /b

:QWEN
echo ==========================================
echo Installing Qwen AI
echo ==========================================
where npm >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js is required. Installing Node.js first...
    call :NODELTS
    echo Refreshing PATH environment variable...
    set "PATH=%PATH%;%ProgramFiles%\nodejs"
)
echo Opening new CMD window to install Qwen AI CLI...
start cmd /k "echo Installing Qwen AI CLI... && npm install -g @qwen-code/qwen-code@latest --verbose && echo Installation completed. If failed, visit: https://github.com/QwenLM/Qwen && echo Press any key to close this window. && pause"
echo.
pause
exit /b

:WIN11MENU
echo ==========================================
echo Switching to Windows 11 New Context Menu
echo ==========================================
start cmd /k "reg delete HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2} /f && taskkill /f /im explorer.exe && start explorer.exe"
pause
exit /b

:WIN10MENU
echo ==========================================
echo Switching to Windows 10 Classic Context Menu
echo ==========================================
start cmd /k "reg add HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32 /f /ve && taskkill /f /im explorer.exe && start explorer.exe"
pause
exit /b

:WINGET
echo ==========================================
echo Installing Windows Package Manager (Winget)
echo ==========================================
where winget >nul 2>&1
if %errorlevel%==0 (
    echo Winget is already installed.
    winget --version
) else (
    echo Installing Winget...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "try { $progressPreference = 'silentlyContinue'; Invoke-WebRequest -Uri 'https://aka.ms/getwinget' -OutFile 'winget.msixbundle'; Add-AppxPackage 'winget.msixbundle'; Remove-Item 'winget.msixbundle' -Force; Write-Host 'Winget installed successfully.' } catch { Write-Host 'Error installing Winget: ' + $_.Exception.Message; Write-Host 'You may need to install from Microsoft Store instead.' }"
)
echo.
pause
exit /b

:OFFICE365
echo ==========================================
echo Installing Office 365 ProPlus
echo ==========================================
where curl >nul 2>&1
if %errorlevel% neq 0 (
    echo Curl is required but not found. Please update Windows.
    goto :OFFICE_END
)

echo Downloading Office 365 Setup...
curl -L -o "%TEMP%\OfficeSetup.exe" "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365ProPlusRetail&platform=x64&language=en-us&version=O16GA"

if exist "%TEMP%\OfficeSetup.exe" (
    echo Launching Office Installer...
    echo NOTE: The installation will continue in the background.
    start "" "%TEMP%\OfficeSetup.exe"
) else (
    echo Failed to download Office Setup.
)

:OFFICE_END
echo.
pause
exit /b

:EVERYTHING
echo ==========================================
echo Installing Everything Search Engine
echo ==========================================
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is required. Installing Chocolatey first...
    call :CHOCO
)
where everything >nul 2>&1
if %errorlevel%==0 (
    echo Everything is already installed.
) else (
    echo Installing Everything...
    choco install everything -y
)
echo.
pause
exit /b

:CHROME
echo ==========================================
echo Installing Google Chrome
echo ==========================================
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is required. Installing Chocolatey first...
    call :CHOCO
)
where chrome >nul 2>&1
if %errorlevel%==0 (
    echo Google Chrome is already installed.
) else (
    echo Installing Google Chrome...
    choco install googlechrome -y
)
echo.
pause
exit /b

:ZEN
echo ==========================================
echo Installing Zen Browser (Manual Method)
echo ==========================================
where curl >nul 2>&1
if %errorlevel% neq 0 (
    echo Curl is required but not found.
    goto :ZEN_END
)

start "" cmd /k "echo Downloading Zen Browser installer... & curl -L -o "%TEMP%\zen-installer.exe" "https://github.com/zen-browser/desktop/releases/latest/download/zen.installer.exe" & if exist "%TEMP%\zen-installer.exe" (echo Running installer... & start /wait "" "%TEMP%\zen-installer.exe" & del "%TEMP%\zen-installer.exe") else (echo Download failed. Please install manually. & start https://zen-browser.app/download)"

:ZEN_END
echo.
pause
exit /b

:CUR
echo ==========================================
echo Cloning Elegant Repository from GitHub
echo ==========================================
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo Git is required. Installing Git first...
    call :GIT
)
echo Cloning repository...
git clone https://github.com/afnan-nex/Elegant
if %errorlevel%==0 (
    echo Repository cloned successfully to Elegant folder.
) else (
    echo Failed to clone repository. Please check your internet connection or Git installation.
)
echo.
pause
exit /b

:CMD0A
echo ==========================================
echo Changing CMD color to 0a
echo ==========================================
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/afnan-nex/my-fav-scripts/main/cmd-clr-to-0a.cmd' -OutFile 'cmd-clr-to-0a.cmd'; Start-Process 'cmd-clr-to-0a.cmd'; Write-Host 'CMD color script downloaded and executed.' } catch { Write-Host 'Error downloading script: ' + $_.Exception.Message }"
echo.
pause
exit /b

:OBS
echo ==========================================
echo Installing OBS Studio
echo ==========================================
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is required. Installing Chocolatey first...
    call :CHOCO
)
where obs64 >nul 2>&1
if %errorlevel%==0 (
    echo OBS Studio is already installed.
) else (
    echo Installing OBS Studio...
    choco install obs-studio -y
)
echo.
pause
exit /b

:RUSTDESK
echo ==========================================
echo Installing RustDesk
echo ==========================================
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is required. Installing Chocolatey first...
    call :CHOCO
)
echo Installing RustDesk...
choco install rustdesk -y
if %errorlevel% neq 0 (
    echo RustDesk installation failed.
)
echo.
pause
exit /b

:HIBIT
echo ==========================================
echo Installing HiBit Uninstaller
echo ==========================================
where curl >nul 2>&1
if %errorlevel% neq 0 (
    echo Curl is required but not found.
    goto :HIBIT_END
)

echo Downloading HiBit Uninstaller...
curl -L -o "%TEMP%\HiBitSetup.exe" "https://www.hibitsoft.ir/HiBitUninstaller/HiBitUninstaller-setup-4.0.10.exe"

if exist "%TEMP%\HiBitSetup.exe" (
    echo Running installer...
    start /wait "" "%TEMP%\HiBitSetup.exe"
    echo Cleaning up...
    del "%TEMP%\HiBitSetup.exe"
) else (
    echo Failed to download HiBit Uninstaller.
)

:HIBIT_END
echo.
pause
exit /b

:SCRCPY
echo ==========================================
echo Installing Scrcpy GUI
echo ==========================================
where curl >nul 2>&1
if %errorlevel% neq 0 (
    echo Curl is required but not found.
    goto :SCRCPY_END
)

echo Downloading Scrcpy GUI...
curl -L -o "%TEMP%\ScrcpyGUI_Setup.exe" "https://github.com/pizi-0/flutter-scrcpygui/releases/download/1.4.18/scrcpygui-1.4.18-win.exe"

if exist "%TEMP%\ScrcpyGUI_Setup.exe" (
    echo Running installer...
    start /wait "" "%TEMP%\ScrcpyGUI_Setup.exe"
    echo Cleaning up...
    del "%TEMP%\ScrcpyGUI_Setup.exe"
) else (
    echo Failed to download Scrcpy GUI.
)

:SCRCPY_END
echo.
pause
exit /b

:LOCALSEND
echo ==========================================
echo Installing LocalSend
echo ==========================================
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is required. Installing Chocolatey first...
    call :CHOCO
)
echo Installing LocalSend...
choco install localsend -y
if %errorlevel% neq 0 (
    echo LocalSend installation failed.
)
echo.
pause
exit /b

:NOTEPADPP
echo ==========================================
echo Installing Notepad++
echo ==========================================
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is required. Installing Chocolatey first...
    call :CHOCO
)
echo Installing Notepad++...
choco install notepadplusplus -y
if %errorlevel% neq 0 (
    echo Notepad++ installation failed.
)
echo.
pause
exit /b

:SHAREX
echo ==========================================
echo Installing ShareX
echo ==========================================
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is required. Installing Chocolatey first...
    call :CHOCO
)
echo Installing ShareX...
choco install sharex -y
if %errorlevel% neq 0 (
    echo ShareX installation failed.
)
echo.
pause
exit /b

:VCREDIST
echo ==========================================
echo Installing Visual C++ Runtimes
echo ==========================================
where curl >nul 2>&1
if %errorlevel% neq 0 (
    echo Curl is required but not found.
    goto :VCREDIST_END
)

set "ZIP_URL=https://github.com/planetshine0000/vc-redist-latest/releases/download/v1.0.0/Visual-C-Runtimes-All-in-One-Dec-2025.zip"
set "ZIP_FILE=%TEMP%\VC_Runtimes.zip"
set "EXTRACT_DIR=%TEMP%\VC_Runtimes_Temp"

echo Downloading Visual C++ Runtimes...
curl -L -o "%ZIP_FILE%" "%ZIP_URL%"

if exist "%ZIP_FILE%" (
    echo Extracting files...
    if not exist "%EXTRACT_DIR%" mkdir "%EXTRACT_DIR%"
    tar -xf "%ZIP_FILE%" -C "%EXTRACT_DIR%"

    echo Running install_all.bat as Administrator...
    :: Find the directory where install_all.bat is located
    for /r "%EXTRACT_DIR%" %%f in (install_all.bat) do (
        pushd "%%~dpf"
        powershell -command "Start-Process 'install_all.bat' -Verb runAs"
        popd
    )
    
    echo Cleaning up ZIP file...
    del "%ZIP_FILE%"
    echo Note: The temporary extraction folder was left intact because the installer runs separately.
) else (
    echo Failed to download Visual C++ Runtimes.
)

:VCREDIST_END
echo.
pause
exit /b

:DIRECTX
echo ==========================================
echo Installing DirectX Runtime
echo ==========================================

:: 1. Check for Curl
where curl >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Curl is required but not found.
    goto :DX_END
)

:: 2. Setup Directories
set "TEMP_DIR=%TEMP%\DirectX_Install"
if not exist "%TEMP_DIR%" mkdir "%TEMP_DIR%" 2>nul

set "DX_URL=https://github.com/planetshine0000/direct-x/releases/download/v1.0.0/DirectX-Redist-Jun-2010.zip"
set "DX_ZIP=%TEMP_DIR%\DirectX.zip"

:: 3. Download
if not exist "%DX_ZIP%" (
    echo Downloading DirectX...
    curl -L -o "%DX_ZIP%" "%DX_URL%"
) else (
    echo DirectX zip already exists, skipping download.
)

:: 4. Unblock and Extract
echo Preparing files...
powershell -c "Unblock-File -Path '%DX_ZIP%'"
tar -xf "%DX_ZIP%" -C "%TEMP_DIR%"

:: 5. Locate DXSETUP.exe
echo Locating DXSETUP.exe...
set "DXSETUP_PATH="
for /r "%TEMP_DIR%" %%f in (DXSETUP.exe) do (
    if exist "%%f" (
        set "DXSETUP_PATH=%%f"
    )
)

if not exist "%DXSETUP_PATH%" (
    echo [ERROR] DXSETUP.exe not found in extracted files.
    goto :DX_END
)

:: 6. Run as Admin
echo Found DXSETUP at: %DXSETUP_PATH%
echo Launching installer...
powershell -c "Start-Process '%DXSETUP_PATH%' -Verb RunAs"

:: 7. Timer and Cleanup
echo.
echo ==========================================
echo The installer has been launched.
echo Waiting 30 seconds before deleting temporary files...
echo ==========================================
timeout /t 30 /nobreak

echo.
echo Cleaning up temporary files...
del /q "%DX_ZIP%" 2>nul
rmdir /s /q "%TEMP_DIR%" >nul 2>&1

if exist "%TEMP_DIR%" (
    echo [NOTE] Some files are still in use by the installer and couldn't be deleted.
) else (
    echo Cleanup successful.
)

:DX_END
echo.
pause
exit /b

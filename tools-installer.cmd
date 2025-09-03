@echo off
title Tool Installer Menu by Afnan
color 0a

:: Check for Administrator Privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:MENU
cls
echo                         _    _____ _   _    _    _   _ 
echo                        / \  ^|  ___^| \ ^| ^|  / \  ^| \ ^| ^|
echo                       / _ \ ^| ^|_  ^|  \^| ^| / _ \ ^|  \^| ^|
echo                      / ___ \^|  _^| ^| ^|\  ^|/ ___ \^| ^|\  ^|
echo                     /_/   \_\_^|   ^|_^| \_/_/   \_\_^| \_^|
echo   ^|==================================================================^|
echo   ^|             Follow me on insta and github @afnan-nex             ^|
echo   ^|==================================================================^|
echo    _______________________________    _______________________________
echo   ^|        PowerShell Tweaks      ^|  ^|    ^>^>^>^>^>^> Essential ^<^<^<^<^<^<    ^|
echo   ^|-------------------------------^|  ^|-------------------------------^|
echo   ^|1. See Policy                  ^|  ^|3. Chocolatey                  ^|
echo   ^|2. Unrestrict Policy           ^|  ^|4. Node.js LTS                 ^|
echo   ^|_______________________________^|  ^|_______________________________^|
echo    ___________________________    _______________________________
echo   ^|        Run Scripts        ^|  ^|       Recommended Tools       ^|
echo   ^|---------------------------^|  ^|-------------------------------^|
echo   ^|5. Chris Titus Tool        ^|  ^|8. Git         10. Python      ^|
echo   ^|6. Mass Grave              ^|  ^|9. Dotnet      11. ffmpeg      ^|
echo   ^|7. Coporton                ^|  ^|12. 7z         13. WinDirStat  ^|
echo   ^|___________________________^|  ^|_______________________________^|
echo    _______________    _______________________
echo   ^|   Automation  ^|  ^|        AI in PC       ^|
echo   ^|---------------^|  ^|-----------------------^|
echo   ^|14. n8n        ^|  ^|15. Gemini    16. Qwen ^|
echo   ^|_______________^|  ^|_______________________^|
echo    __________________________________________    ____________________
echo   ^|            Others                        ^|  ^|       Actions      ^|
echo   ^|------------------------------------------^|  ^|--------------------^|
echo   ^|17. Winget ^(200 mb^)                       ^|  ^|22. CMD Clr to 0a   ^|
echo   ^|18. Office365 offline                     ^|  ^|23. Run All         ^|
echo   ^|19. Everything ^(Search Tool^)              ^|  ^|24. Run Selected    ^|
echo   ^|20. Chrome      21. Zen                   ^|  ^|25. Exit            ^|
echo   ^|__________________________________________^|  ^|____________________^|
echo.
echo     ================================
set /p choice=Enter your choice (1-25, multiple like 2,4,9): 

:: If multiple numbers entered → Run Selected
echo %choice% | findstr "," >nul
if %errorlevel%==0 (
    set "multiChoice=%choice%"
    goto RUNSELECTED
)

if "%choice%"=="1" call :SEEPOLICY
if "%choice%"=="2" call :UNRESTRICT
if "%choice%"=="3" call :CHOCO
if "%choice%"=="4" call :NODELTS
if "%choice%"=="5" call :TITUS
if "%choice%"=="6" call :MASSGRAVE
if "%choice%"=="7" call :COPORTON
if "%choice%"=="8" call :GIT
if "%choice%"=="9" call :DOTNET
if "%choice%"=="10" call :PYTHON
if "%choice%"=="11" call :FFMPEG
if "%choice%"=="12" call :SEVENZIP
if "%choice%"=="13" call :WINDIRSTAT
if "%choice%"=="14" call :N8N
if "%choice%"=="15" call :GEMINI
if "%choice%"=="16" call :QWEN
if "%choice%"=="17" call :WINGET
if "%choice%"=="18" call :OFFICE365
if "%choice%"=="19" call :EVERYTHING
if "%choice%"=="20" call :CHROME
if "%choice%"=="21" call :ZEN
if "%choice%"=="22" call :CMD0A
if "%choice%"=="23" goto RUNALL
if "%choice%"=="24" goto RUNSELECTED
if "%choice%"=="25" exit
goto MENU

:: ==============================
:: Run Selected (Multiple Numbers)
:: ==============================
:RUNSELECTED
if not defined multiChoice (
    echo.
    set /p multiChoice=Enter multiple choices separated by commas (e.g., 2,4,9): 
)
echo Running selected options: %multiChoice%
echo.
for %%i in (%multiChoice%) do (
    echo ==========================================
    echo Running option %%i...
    echo ==========================================
    call :RUNCHOICE %%i
)
set "multiChoice="
echo.
echo All selected options completed!
pause
goto MENU

:RUNCHOICE
if "%~1"=="1" call :SEEPOLICY
if "%~1"=="2" call :UNRESTRICT
if "%~1"=="3" call :CHOCO
if "%~1"=="4" call :NODELTS
if "%~1"=="5" call :TITUS
if "%~1"=="6" call :MASSGRAVE
if "%~1"=="7" call :COPORTON
if "%~1"=="8" call :GIT
if "%~1"=="9" call :DOTNET
if "%~1"=="10" call :PYTHON
if "%~1"=="11" call :FFMPEG
if "%~1"=="12" call :SEVENZIP
if "%~1"=="13" call :WINDIRSTAT
if "%~1"=="14" call :N8N
if "%~1"=="15" call :GEMINI
if "%~1"=="16" call :QWEN
if "%~1"=="17" call :WINGET
if "%~1"=="18" call :OFFICE365
if "%~1"=="19" call :EVERYTHING
if "%~1"=="20" call :CHROME
if "%~1"=="21" call :ZEN
if "%~1"=="22" call :CMD0A
exit /b

:RUNALL
echo ==========================================
echo Running all recommended tools...
echo ==========================================
echo.
call :CHOCO
call :NODELTS
call :GIT
call :PYTHON
call :FFMPEG
call :SEVENZIP
call :EVERYTHING
call :CHROME
call :CMD0A
echo.
echo All tools installation completed!
pause
goto MENU

:: ==============================
:: Your installer functions below
:: ==============================
:SEEPOLICY
echo ==========================================
echo Checking PowerShell Execution Policy
echo ==========================================
powershell -NoProfile -ExecutionPolicy Bypass -Command "Write-Host 'Current Execution Policy:'; Get-ExecutionPolicy -List"
echo.
pause
goto MENU

:UNRESTRICT
echo ==========================================
echo Setting PowerShell Policy to Unrestricted
echo ==========================================
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Unrestricted -Force"
echo Policy updated successfully.
echo.
pause
goto MENU

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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
exit /b

:TITUS
echo ==========================================
echo Running Chris Titus Tech Windows Utility
echo ==========================================
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm 'https://christitus.com/win' | iex"
echo.
pause
goto MENU

:MASSGRAVE
echo ==========================================
echo Running Microsoft Activation Scripts
echo ==========================================
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://get.activated.win | iex"
echo.
pause
goto MENU

:COPORTON
echo ==========================================
echo Running Coporton Tool
echo ==========================================
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://coporton.com/ias | iex"
echo.
pause
goto MENU

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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
start cmd /k "echo Installing n8n Workflow Automation... && npm install -g n8n@latest --verbose && echo Installation completed. Press any key to close this window. && pause"
echo.
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
exit /b

:GEMINI
echo ==========================================
echo Installing Google AI CLI ^(Official CLI^)
echo ==========================================
where npm >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js is required. Installing Node.js first...
    call :NODELTS
    echo Refreshing PATH environment variable...
    set "PATH=%PATH%;%ProgramFiles%\nodejs"
)
echo Opening new CMD window to install Google AI CLI...
start cmd /k "echo Installing Google AI CLI... && npm install -g @google/gemini-cli@latest && echo Installation completed. Press any key to close this window. && pause"
echo.
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
exit /b

:QWEN
echo ==========================================
echo Installing Qwen AI Tools
echo ==========================================
where npm >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js is required. Installing Node.js first...
    call :NODELTS
    echo Refreshing PATH environment variable...
    set "PATH=%PATH%;%ProgramFiles%\nodejs"
)
echo Opening new CMD window to install Qwen AI CLI...
start cmd /k "echo Installing Qwen AI CLI... && npm install -g @qwen-code/qwen-code@latest && echo Installation completed. If failed, visit: https://github.com/QwenLM/Qwen && echo Press any key to close this window. && pause"
echo.
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
exit /b

:WINGET
echo ==========================================
echo Installing Windows Package Manager ^(Winget^)
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
exit /b

:OFFICE365
echo ==========================================
echo Opening Microsoft Office 365 Download
echo ==========================================
echo Opening official Microsoft Office page in browser...
start https://www.office.com/
echo Note: For offline installer, visit: https://support.microsoft.com/en-us/office/
echo.
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
exit /b

:ZEN
echo ==========================================
echo Installing Zen Browser
echo ==========================================
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is required. Installing Chocolatey first...
    call :CHOCO
)
echo Installing Zen Browser...
choco install zen-browser -y
if %errorlevel% neq 0 (
    echo Zen Browser package may not be available in Chocolatey.
    echo Please visit: https://zen-browser.app/ for manual installation.
)
echo.
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
exit /b

:CMD0A
echo ==========================================
echo Changing CMD color to 0a
echo ==========================================
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/afnan-nex/my-fav-scripts/main/cmd-clr-to-0a.cmd' -OutFile 'cmd-clr-to-0a.cmd'; Start-Process 'cmd-clr-to-0a.cmd'; Write-Host 'CMD color script downloaded and executed.' } catch { Write-Host 'Error downloading script: ' + $_.Exception.Message }"
echo.
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
exit /b

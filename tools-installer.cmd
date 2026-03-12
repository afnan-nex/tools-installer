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
echo   ^|                   Press 1 to know about AFNAN                    ^|
echo   ^|==================================================================^|
echo    _______________________________    _______________________________
echo   ^|        PowerShell Tweaks      ^|  ^|    ^>^>^>^>^>^> Essential ^<^<^<^<^<^<    ^|
echo   ^|-------------------------------^|  ^|-------------------------------^|
echo   ^|2. See Policy                  ^|  ^|4. Chocolatey                  ^|
echo   ^|3. Unrestrict Policy           ^|  ^|5. Node.js LTS                 ^|
echo   ^|_______________________________^|  ^|_______________________________^|
echo    ___________________________    _______________________________
echo   ^|        Run Scripts        ^|  ^|       Recommended Tools       ^|
echo   ^|---------------------------^|  ^|-------------------------------^|
echo   ^|6. Chris Titus Tool        ^|  ^|10. Git         11. Python     ^|
echo   ^|7. Mass Grave              ^|  ^|12. Dotnet     13. ffmpeg      ^|
echo   ^|8. Coporton                ^|  ^|14. 7z         15. WinDirStat  ^|
echo   ^|9. Sparkle                 ^|  ^|16. yt-dlp     17. ngrok       ^|
echo   ^|___________________________^|  ^|_______________________________^|
echo    _______________    _______________________    ____________________
echo   ^|   Automation  ^|  ^|        AI in PC       ^|  ^|    Context Menu    ^|
echo   ^|---------------^|  ^|-----------------------^|  ^|--------------------^|
echo   ^|18. n8n        ^|  ^|19. Gemini    20. Qwen ^|  ^|21. New    22. Old  ^|
echo   ^|_______________^|  ^|_______________________^|  ^|____________________^|
echo    __________________________________________    ____________________
echo   ^|                  Others                  ^|  ^|       Actions      ^|
echo   ^|------------------------------------------^|  ^|--------------------^|
echo   ^|23. Winget        24. Office365           ^|  ^|                    ^|
echo   ^|25. Everything    26. Chrome              ^|  ^|                    ^|
echo   ^|27. Zen           28. cursor              ^|  ^|                    ^|
echo   ^|29. CMD Clr 0a    30. OBS Studio          ^|  ^|39. Run All         ^|
echo   ^|31. RustDesk      32. HiBit Uninstaller   ^|  ^|40. Run Selected    ^|
echo   ^|33. Scrcpy GUI    34. LocalSend           ^|  ^|41. Exit            ^|
echo   ^|35. Notepad++     36. ShareX              ^|  ^|                    ^|
echo   ^|37. VC++ Runtimes 38. DirectX             ^|  ^|                    ^|
echo   ^|__________________________________________^|  ^|____________________^|
echo
echo     ================================
set /p choice=Enter your choice (1-41, multiple like 2,4,9): 

:: If multiple numbers entered -> Run Selected
echo %choice% | findstr "," >nul
if %errorlevel%==0 (
    set "multiChoice=%choice%"
    goto RUNSELECTED
)

if "%choice%"=="1" call :OPENPORTFOLIO
if "%choice%"=="2" call :SEEPOLICY
if "%choice%"=="3" call :UNRESTRICT
if "%choice%"=="4" call :CHOCO
if "%choice%"=="5" call :NODELTS
if "%choice%"=="6" call :TITUS
if "%choice%"=="7" call :MASSGRAVE
if "%choice%"=="8" call :COPORTON
if "%choice%"=="9" call :SPARKLE
if "%choice%"=="10" call :GIT
if "%choice%"=="11" call :PYTHON
if "%choice%"=="12" call :DOTNET
if "%choice%"=="13" call :FFMPEG
if "%choice%"=="14" call :SEVENZIP
if "%choice%"=="15" call :WINDIRSTAT
if "%choice%"=="16" call :YTDLP
if "%choice%"=="17" call :NGROK
if "%choice%"=="18" call :N8N
if "%choice%"=="19" call :GEMINI
if "%choice%"=="20" call :QWEN
if "%choice%"=="21" call :WIN11MENU
if "%choice%"=="22" call :WIN10MENU
if "%choice%"=="23" call :WINGET
if "%choice%"=="24" call :OFFICE365
if "%choice%"=="25" call :EVERYTHING
if "%choice%"=="26" call :CHROME
if "%choice%"=="27" call :ZEN
if "%choice%"=="28" call :CUR
if "%choice%"=="29" call :CMD0A
if "%choice%"=="30" call :OBS
if "%choice%"=="31" call :RUSTDESK
if "%choice%"=="32" call :HIBIT
if "%choice%"=="33" call :SCRCPY
if "%choice%"=="34" call :LOCALSEND
if "%choice%"=="35" call :NOTEPADPP
if "%choice%"=="36" call :SHAREX
if "%choice%"=="37" call :VCREDIST
if "%choice%"=="38" call :DIRECTX
if "%choice%"=="39" goto RUNALL
if "%choice%"=="40" goto RUNSELECTED
if "%choice%"=="41" exit
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
if "%~1"=="1" call :OPENPORTFOLIO
if "%~1"=="2" call :SEEPOLICY
if "%~1"=="3" call :UNRESTRICT
if "%~1"=="4" call :CHOCO
if "%~1"=="5" call :NODELTS
if "%~1"=="6" call :TITUS
if "%~1"=="7" call :MASSGRAVE
if "%~1"=="8" call :COPORTON
if "%~1"=="9" call :SPARKLE
if "%~1"=="10" call :GIT
if "%~1"=="11" call :PYTHON
if "%~1"=="12" call :DOTNET
if "%~1"=="13" call :FFMPEG
if "%~1"=="14" call :SEVENZIP
if "%~1"=="15" call :WINDIRSTAT
if "%~1"=="16" call :YTDLP
if "%~1"=="17" call :NGROK
if "%~1"=="18" call :N8N
if "%~1"=="19" call :GEMINI
if "%~1"=="20" call :QWEN
if "%~1"=="21" call :WIN11MENU
if "%~1"=="22" call :WIN10MENU
if "%~1"=="23" call :WINGET
if "%~1"=="24" call :OFFICE365
if "%~1"=="25" call :EVERYTHING
if "%~1"=="26" call :CHROME
if "%~1"=="27" call :ZEN
if "%~1"=="28" call :CUR
if "%~1"=="29" call :CMD0A
if "%~1"=="30" call :OBS
if "%~1"=="31" call :RUSTDESK
if "%~1"=="32" call :HIBIT
if "%~1"=="33" call :SCRCPY
if "%~1"=="34" call :LOCALSEND
if "%~1"=="35" call :NOTEPADPP
if "%~1"=="36" call :SHAREX
if "%~1"=="37" call :VCREDIST
if "%~1"=="38" call :DIRECTX
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
call :YTDLP
call :SEVENZIP
call :EVERYTHING
call :CHROME
call :OBS
call :NOTEPADPP
call :CMD0A
echo.
echo All tools installation completed!
pause
goto MENU

:: ==============================
:: Start of all Commands
:: ==============================

:OPENPORTFOLIO
echo ==========================================
echo Opening Your Browser with Portfolio
echo ==========================================
start https://afnanportfolio1.netlify.app/
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
exit /b

:SEEPOLICY
echo ==========================================
echo Checking PowerShell Execution Policy
echo ==========================================
powershell -NoProfile -ExecutionPolicy Bypass -Command "Write-Host 'Current Execution Policy:'; Get-ExecutionPolicy -List"
echo.
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
exit /b

:UNRESTRICT
echo ==========================================
echo Setting PowerShell Policy to Unrestricted
echo ==========================================
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Unrestricted -Force -Scope CurrentUser; Set-ExecutionPolicy Unrestricted -Force -Scope LocalMachine"
echo Policy updated successfully.
echo.
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
exit /b

:MASSGRAVE
echo ==========================================
echo Running Microsoft Activation Scripts
echo ==========================================
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://get.activated.win | iex"
echo.
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
exit /b

:COPORTON
echo ==========================================
echo Running Coporton Tool
echo ==========================================
start "" cmd /k powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://coporton.com/ias | iex"
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
exit /b

:SPARKLE
echo ==========================================
echo Running Sparkle Tool
echo ==========================================
start "" cmd /k powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/Parcoil/Sparkle/v2/get.ps1 | iex"
echo.
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
start cmd /k "echo Installing n8n Workflow Automation... && npm install -g n8n@latest --verbose && echo n8n installation completed. && echo Setting NODES_EXCLUDE environment variable... && setx NODES_EXCLUDE "[]" && setx NODES_EXCLUDE "[]" /M && echo Environment variables set successfully. Press any key to close this window. && pause"
echo.
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
exit /b

:WIN11MENU
echo ==========================================
echo Switching to Windows 11 New Context Menu
echo ==========================================
start cmd /k "reg delete HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2} /f && taskkill /f /im explorer.exe && start explorer.exe"
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
exit /b

:WIN10MENU
echo ==========================================
echo Switching to Windows 10 Classic Context Menu
echo ==========================================
start cmd /k "reg add HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32 /f /ve && taskkill /f /im explorer.exe && start explorer.exe"
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
echo Installing Zen Browser (Manual Method)
echo ==========================================
where curl >nul 2>&1
if %errorlevel% neq 0 (
    echo Curl is required but not found.
    goto :ZEN_END
)

echo Downloading Zen Browser installer...
curl -L -o "%TEMP%\zen-installer.exe" "https://github.com/zen-browser/desktop/releases/latest/download/zen.installer.exe"

if exist "%TEMP%\zen-installer.exe" (
    echo Running installer...
    start /wait "" "%TEMP%\zen-installer.exe"
    del "%TEMP%\zen-installer.exe"
) else (
    echo Download failed. Please install manually.
    start https://zen-browser.app/download
)

:ZEN_END
echo.
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
exit /b

:RUSTDESK_END
echo.
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
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
if "%multiChoice%"=="" pause
if "%multiChoice%"=="" goto MENU
exit /b






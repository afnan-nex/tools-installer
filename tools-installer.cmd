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
echo                 ^|=================================================^|
echo                 ^|       Follow me on instagram @afnan-nex         ^|
echo                 ^|=================================================^|
echo      ______________________________      ______________________________
echo     ^|     Unrestrict PowerShell    ^|    ^|    ^>^>^>^>^>^> Essential ^<^<^<^<^<^<   ^|
echo     ^|------------------------------^|    ^|------------------------------^|
echo     ^|1. See Policy                 ^|    ^|3. Install Chocolatey         ^|
echo     ^|2. Unrestrict Policy          ^|    ^|4. Install Node.js LTS        ^|
echo     ^|______________________________^|    ^|______________________________^|
echo      ______________________________      ______________________________
echo     ^|         Run Scripts          ^|    ^|          For Coding          ^|
echo     ^|------------------------------^|    ^|------------------------------^|
echo     ^|5. Run Chris Titus Tool       ^|    ^|8. Install Python             ^|
echo     ^|6. Run Mass Grave             ^|    ^|9. Install Git                ^|
echo     ^|7. Run Coporton               ^|    ^|                              ^|
echo     ^|______________________________^|    ^|______________________________^|
echo      ______________________________      ______________________________
echo     ^|          Automation          ^|    ^|           AI in PC           ^|
echo     ^|------------------------------^|    ^|------------------------------^|
echo     ^|10. Install n8n               ^|    ^|11. Install Gemini CLI        ^|
echo     ^|                              ^|    ^|12. Install Qwen CLI          ^|
echo     ^|______________________________^|    ^|______________________________^|
echo      ______________________________      ______________________________
echo     ^|            Others            ^|    ^|            Actions           ^|
echo     ^|------------------------------^|    ^|------------------------------^|
echo     ^|13. Install Winget(200 mb)    ^|    ^|14. Run All (in sequence)     ^|
echo     ^|                              ^|    ^|15. Exit                      ^|
echo     ^|______________________________^|    ^|______________________________^|
echo     ================================
set /p choice=Enter your choice (1-14): 

if "%choice%"=="1" goto SEEPOLICY
if "%choice%"=="2" goto UNRESTRICT
if "%choice%"=="3" goto CHOCO
if "%choice%"=="4" goto NODELTS
if "%choice%"=="5" goto TITUS
if "%choice%"=="6" goto MASSGRAVE
if "%choice%"=="7" goto COPORTON
if "%choice%"=="8" goto PYTHON
if "%choice%"=="9" goto Git
if "%choice%"=="10" goto N8N
if "%choice%"=="11" goto GEMINI
if "%choice%"=="12" goto QWEN
if "%choice%"=="13" goto Winget
if "%choice%"=="14" goto RUNALL
if "%choice%"=="14" exit
goto MENU

:SEEPOLICY
start cmd /c "echo Current Execution Policy: & powershell -NoProfile -Command "Get-ExecutionPolicy" & echo. & echo Press any key to close... & pause >nul"
goto MENU

:UNRESTRICT
start cmd /c "echo Setting Execution Policy to Unrestricted... & powershell -NoProfile -Command "Set-ExecutionPolicy Unrestricted -Force" & echo. & echo Press any key to close... & pause >nul"
goto MENU

:CHOCO
start cmd /c "echo Installing Chocolatey... & powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) & echo. & echo Press any key to close... & pause >nul"
goto MENU

:NODELTS
start cmd /c "echo Installing Node.js LTS... & choco install nodejs-lts -y & echo. & echo Press any key to close... & pause >nul"
goto MENU

:TITUS
start cmd /c "echo Running Chris Titus Tool... & powershell -NoProfile -Command "irm 'https://christitus.com/win' | iex" & echo. & echo Press any key to close... & pause >nul"
goto MENU

:MASSGRAVE
start cmd /c "echo Running Mass Grave... & powershell -NoProfile -Command "irm https://get.activated.win | iex" & echo. & echo Press any key to close... & pause >nul"
goto MENU

:COPORTON
start cmd /c "echo Running Coporton... & powershell -NoProfile -Command "irm https://coporton.com/ias | iex" & echo. & echo Press any key to close... & pause >nul"
goto MENU

:PYTHON
start cmd /c "echo Installing Python... & choco install python -y & echo. & echo Press any key to close... & pause >nul"
goto MENU

:Git
start cmd /c "echo Installing Git... & choco install git -y & echo. & echo Press any key to close... & pause >nul"
goto MENU

:N8N
start cmd /c "echo Installing n8n... & echo write n8n in cmd ^& press enter to run & npm install -g n8n@latest --verbose & echo. & echo Press any key to close... & pause >nul"
goto MENU

:GEMINI
start cmd /c "echo Installing Gemini CLI... & echo write gemini in cmd ^& press enter to run & npm install -g @google/gemini-cli@latest & echo. & echo Press any key to close... & pause >nul"
goto MENU

:QWEN
start cmd /c "echo Installing Qwen CLI... & echo write qwen in cmd ^& press enter to run & npm install -g @qwen-code/qwen-code@latest & echo. & echo Press any key to close... & pause >nul"
goto MENU

:Winget
start cmd /c "echo Installing Winget... & powershell -NoProfile -Command \"Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile winget.msixbundle; Add-AppxPackage winget.msixbundle; Remove-Item winget.msixbundle\" & echo. & echo Press any key to close... & pause >nul"
goto MENU

:RUNALL
call :SEEPOLICY
call :UNRESTRICT
call :CHOCO
call :NODELTS
call :TITUS
call :MASSGRAVE
call :COPORTON
call :PYTHON
call :Git
call :N8N
call :GEMINI
call :QWEN
call :Winget
goto MENU

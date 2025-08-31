@echo off
title Tool Installer Menu by Afnan
color 0a

:MENU
cls
echo                   _    _____ _   _    _    _   _ 
echo                  / \  ^|  ___^| \ ^| ^|  / \  ^| \ ^| ^|
echo                 / _ \ ^| ^|_  ^|  \^| ^| / _ \ ^|  \^| ^|
echo                / ___ \^|  _^| ^| ^|\  ^|/ ___ \^| ^|\  ^|
echo               /_/   \_\_^|   ^|_^| \_/_/   \_\_^| \_^|
echo           ^|=================================================^|
echo           ^|       Follow me on instagram @afnan-nex         ^|
echo           ^|=================================================^|
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
echo      ______________________________
echo     ^|            Actions           ^|
echo     ^|------------------------------^|
echo     ^|13. Run All ( in sequence)    ^|
echo     ^|14. RUNSELECTED               ^|
echo     ^|15. Exit                      ^|
echo     ^|______________________________^|
echo     ================================
set /p choice=Enter your choice (1-15): 

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
if "%choice%"=="13" goto RUNALL
if "%choice%"=="14" goto RUNSELECTED
if "%choice%"=="15" exit
goto MENU

:SEEPOLICY
echo Current Execution Policy:
powershell -NoProfile -Command "Get-ExecutionPolicy"
pause
goto MENU

:UNRESTRICT
echo Setting Execution Policy to Unrestricted...
powershell -NoProfile -Command "Set-ExecutionPolicy Unrestricted -Force"
pause
goto MENU

:CHOCO
echo Installing Chocolatey...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
 "Set-ExecutionPolicy Bypass -Scope Process -Force; ^
  [System.Net.ServicePointManager]::SecurityProtocol = ^
  [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; ^
  iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
pause
goto MENU

:NODELTS
echo Installing Node.js LTS...
choco install nodejs-lts -y
pause
goto MENU

:TITUS
echo Running Chris Titus Tool...
powershell -NoProfile -Command "irm 'https://christitus.com/win' | iex"
pause
goto MENU

:MASSGRAVE
echo Running Mass Grave...
powershell -NoProfile -Command "irm https://get.activated.win | iex"
pause
goto MENU

:COPORTON
echo Running Coporton...
powershell -NoProfile -Command "irm https://coporton.com/ias | iex"
pause
goto MENU

:PYTHON
echo Installing Python...
choco install python -y
pause
goto MENU

:Git
echo Installing Git...
choco install git -y
pause
goto MENU

:N8N
echo Installing n8n...
echo write n8n in cmd ^& press enter to run
npm install -g n8n@latest --verbose
pause
goto MENU

:GEMINI
echo Installing Gemini CLI...
echo write gemini in cmd ^& press enter to run
npm install -g @google/gemini-cli@latest
pause
goto MENU

:QWEN
echo Installing Qwen CLI...
echo write qwen in cmd ^& press enter to run
npm install -g @qwen-code/qwen-code@latest
pause
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
goto MENU

:RUNSELECTED
set /p selections=Enter numbers separated by commas (e.g. 1,3,5): 
for %%i in (%selections%) do (
    if "%%i"=="1" call :SEEPOLICY
    if "%%i"=="2" call :UNRESTRICT
    if "%%i"=="3" call :CHOCO
    if "%%i"=="4" call :NODELTS
    if "%%i"=="5" call :TITUS
    if "%%i"=="6" call :MASSGRAVE
    if "%%i"=="7" call :COPORTON
    if "%%i"=="8" call :PYTHON
    if "%%i"=="9" call :Git
    if "%%i"=="10" call :N8N
    if "%%i"=="11" call :GEMINI
    if "%%i"=="12" call :QWEN
)
goto MENU

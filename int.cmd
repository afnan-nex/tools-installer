@echo off
title Interactive CMD
cls

:menu
echo ---------------------------------
echo  PRESS A KEY TO SEE THE MAGIC:
echo ---------------------------------
echo  [1] Say Hello
echo  [2] Tell a Joke
echo  [X] Exit
echo ---------------------------------

:: The /C flag defines the keys to watch
:: The /N hides the list of keys from the prompt
choice /c 12X /n /m "Waiting for your input..."

:: Errorlevel corresponds to the position in the /C list
if errorlevel 3 goto end
if errorlevel 2 goto joke
if errorlevel 1 goto hello

:hello
echo.
echo You pressed 1! Hope you're having a great 2026.
pause
goto menu

:joke
echo.
echo Why did the programmer quit his job?
echo Because he didn't get arrays (a raise).
pause
goto menu

:end
echo Goodbye!
timeout /t 2 >nul
exit

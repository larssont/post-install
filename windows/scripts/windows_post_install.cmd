@echo off
pushd %~dp0
cls

setlocal EnableDelayedExpansion
set "startTime=%time: =0%"

CALL :PrintL cyan "Configuring settings..."
PowerShell -ExecutionPolicy Bypass ".\components\windows_configure.ps1"
echo:
CALL :PrintL cyan "Debloating system..."
PowerShell -ExecutionPolicy Bypass ".\components\windows_debloat.ps1"
echo:
CALL :PrintL cyan "Installing chocolatey..."
PowerShell -ExecutionPolicy Bypass ".\components\windows_install_choco.ps1"

set "endTime=%time: =0%"
set "end=!endTime:%time:~8,1%=%%100)*100+1!"  &  set "start=!startTime:%time:~8,1%=%%100)*100+1!"
set /A "elap=((((10!end:%time:~2,1%=%%100)*60+1!%%100)-((((10!start:%time:~2,1%=%%100)*60+1!%%100), elap-=(elap>>31)*24*60*60*100"
set /A "cc=elap%%100+100,elap/=100,ss=elap%%60+100,elap/=60,mm=elap%%60+100,hh=elap/60+100"
set duration=%hh:~1%%time:~2,1%%mm:~1%%time:~2,1%%ss:~1%%time:~8,1%%cc:~1%

echo:
echo:
CALL :PrintL green "###############################"
CALL :PrintL green "#      Setup completed        #"
CALL :PrintL green "###############################"
CALL :PrintL yellow "Duration: %duration%"

echo:
CALL :PrintL red "REBOOT SYSTEM NOW? y/n"
set /p in=

if NOT "%in%" == "y" (
    exit
)

shutdown -r -f

:PrintL
if %~1 == cyan  (
    echo [96m%~2[0m
)
if %~1 == red (
    echo [91m%~2[0m
)
if %~1 == green (
    echo [92m%~2[0m
)
if %~1 == yellow (
    echo [93m%~2[0m
)

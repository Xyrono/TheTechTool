@echo off
setlocal enabledelayedexpansion
title The Tech Tool

:: ==============================================================================
::  System Diagnostics & Repair Tool  |  Windows Command Prompt (CMD)
::  No external software required — runs on any Windows 7/8/10/11 machine.
::  Recommended: Run as Administrator for full repair capability.
:: ==============================================================================



:: Create timestamp in MM-HH_DD_MM_YYYY format
for /f "tokens=1-4 delims=/ " %%a in ('date /t') do (
    set day=%%a
    set month=%%b
    set year=%%c
)
for /f "tokens=1-2 delims=: " %%a in ('time /t') do (
    set hour=%%a
    set minute=%%b
)
set timestamp=%month%-%hour%_%day%_%month%_%year%

:: Log file path
set logFile=C:\TheTechToolLog.log

:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo   [!!] WARNING: Not running as Administrator.
    echo   [!!] Some diagnostics and most fixes will be limited.
    echo   [!!] Right-click this file and choose "Run as administrator".
    echo.
    pause
)

:: Main Menu Starts

:MENU
cls
echo ================================
echo         THE TECH TOOL
echo ================================
echo(
echo The Tool for all your IT Technican needs! 
echo( 
echo 1. PC Information Menu
echo 2. Network Tool Menu
echo 3. File Remnants Menu
echo 4. PC Repair Menu
echo 5. Automatic Scripts Menu
echo 6. Delete SoftwareDistribution folder contents
echo 7. Trigger Defender signature update
echo 8. Reboot into BIOS after 10 seconds
echo 9. Exit
echo(
echo ================================
set /p choicemain=Choose an option (1-9):

if "%choicemain%"=="1" goto PCINFORMATIONMENU
if "%choicemain%"=="2" goto NETWORKMENU
if "%choicemain%"=="3" goto REMNANTSMENU
if "%choicemain%"=="4" goto REPAIRMENU
if "%choicemain%"=="5" goto AUTOSCRIPT
if "%choicemain%"=="6" goto DELETESWD
if "%choicemain%"=="7" goto DEFUPDATE
if "%choicemain%"=="8" goto BIOSBOOT
if "%choicemain%"=="9" goto Exit
goto MENU

:: Main Menu Ends
:: Main Menu Functions Starts
:EXIT
cls
exit
:: Main Menu Functions Ends
:: System Information Menu Starts
:PCINFORMATIONMENU
cls
echo ================================
echo      SYSTEM INFORMATION MENU
echo ================================
echo(
echo Select a tool to run:
echo 1. Display System Information
echo 2. Display Disk Usage
echo 3. Display Memory Usage
echo 4. Display CPU Load
echo 5. Display Recent System Errors
echo 6. Display Full System Information
echo 6. Back to Main Menu
echo(
set /p choiceSystem=Choose an option (1-7):

if "%choiceSystem%"=="1" goto SYSINFO
if "%choiceSystem%"=="2" goto DISKUSAGE
if "%choiceSystem%"=="3" goto MEMORYUSAGE
if "%choiceSystem%"=="4" goto CPULOAD
if "%choiceSystem%"=="5" goto RECENTSYSERRORS
if "%choiceSystem%"=="6" goto FULLINFO
if "%choiceSystem%"=="7" goto MENU
goto MENU

:: System Information Menu Ends
:: Network Menu Starts

:NETWORKMENU
cls
echo ================================
echo        NETWORK TOOL MENU
echo ================================
echo(
echo Select a tool to run:
echo 1. Ping an IP address or hostname
echo 2. Internet connectivity Test
echo 3. Show all networking information (Ethernet and Wi-Fi)
echo 4. Traceroute to a host
echo 5. Show active network connections (netstat)
echo 6. Release and renew IP address
echo 7. Clear DNS cache
echo 8. Back to Main Menu
echo(
set /p choiceNetwork=Choose an option (1-8):

if "%choiceNetwork%"=="1" goto PING
if "%choiceNetwork%"=="2" goto EXTERNAL_DNS_CHECKER
if "%choiceNetwork%"=="3" goto NETINFO
if "%choiceNetwork%"=="4" goto TRACEROUTE
if "%choiceNetwork%"=="5" goto NETSTAT
if "%choiceNetwork%"=="6" goto RENEWIP
if "%choiceNetwork%"=="7" goto CLEARDNS
if "%choiceNetwork%"=="8" goto MENU
goto MENU

:: Network Menu Ends
:: Remnants Menu Starts

:REMNANTSMENU
cls
echo ================================
echo     Software Remnants Removal
echo ================================
echo(
echo Select software to uninstall:
echo 1. Citrix Workspace
echo 2. Back to Main Menu
echo(
set /p uninstallChoice=Choose an option (1-2):

if "%uninstallChoice%"=="1" goto UNINSTALL_CITRIX
if "%uninstallChoice%"=="2" goto MENU
goto MENU

:: Remnants Menu Ends
:: PC Repair Menu Starts

:REPAIRMENU
cls
echo ================================
echo           PC Repair
echo ================================
echo(
echo Select repair option:
echo 1. SFC scan
echo 2. Windows repair
echo 3. Disk error repair
echo 4. Battery Health Checker
echo 5. Back to Main Menu
echo(
set /p RepairChoice=Choose an option (1-5):

if "%RepairChoice%"=="1" goto SFCSCAN
if "%RepairChoice%"=="2" goto WINDOWSREPAIR
if "%RepairChoice%"=="3" goto DISKERROR
if "%RepairChoice%"=="4" goto BATTERYCHECK
if "%RepairChoice%"=="5" goto MENU
goto MENU

:: PC Repair Menu Ends

:: Automatic Scripts Menu Start

:AUTOSCRIPT
cls
echo ================================
echo        Automatic Scripts
echo ================================
echo(
echo Select repair option:
echo 1. Basic PC Repair
echo 2. Advanced PC Repair
echo 3. Back to Main Menu
echo(
set /p AutoChoice=Choose an option (1-3):

if "%AutoChoice%"=="1" goto BASICREPAIR
if "%AutoChoice%"=="2" goto ADVREPAIR
if "%AutoChoice%"=="3" goto MENU
goto MENU


:: Main Menu Functions Start

::System Information Functions Start

:SYSINFO
cls
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"Host Name" /C:"System Type" /C:"Total Physical Memory" /C:"System Boot Time"
echo   Processors: %NUMBER_OF_PROCESSORS% x %PROCESSOR_IDENTIFIER%
pause
goto MENU

:DISKUSAGE
cls
wmic logicaldisk where "DriveType=3" get DeviceID,Size,FreeSpace,VolumeName /format:table 2>nul
pause
goto MENU

:MEMORYUSAGE
cls
systeminfo | findstr /C:"Total Physical Memory" /C:"Available Physical Memory"
pause
goto MENU

:CPULOAD
cls
wmic cpu get name,loadpercentage /format:table 2>nul
pause
goto MENU

:RECENTSYSERRORS
cls
wevtutil qe System /q:"*[System[Level=2]]" /c:5 /rd:true /f:text 2>nul | findstr /C:"Date" /C:"Source"
pause
goto MENU

:FULLINFO
cls
echo  ============================================================ 
echo                    Full System Information
echo  ============================================================
echo.
echo   [1/5] System Information...
echo  ============================================================
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"Host Name" /C:"System Type" /C:"Total Physical Memory" /C:"System Boot Time"
echo   Processors: %NUMBER_OF_PROCESSORS% x %PROCESSOR_IDENTIFIER%
echo.

echo   [2/5] Disk Usage...
echo  ============================================================
wmic logicaldisk where "DriveType=3" get DeviceID,Size,FreeSpace,VolumeName /format:table 2>nul
echo.

echo   [3/5] Memory...
echo  ============================================================
systeminfo | findstr /C:"Total Physical Memory" /C:"Available Physical Memory"
echo.
echo   [4/5] CPU Load...
echo  ============================================================
wmic cpu get name,loadpercentage /format:table 2>nul
echo.
echo   [5/5] Recent System Errors...
echo  ============================================================
wevtutil qe System /q:"*[System[Level=2]]" /c:5 /rd:true /f:text 2>nul | findstr /C:"Date" /C:"Source"
echo.
echo  ============================================================
echo   All diagnostics complete.
echo  ============================================================
echo.
goto MENU

:: Network Functions Start

:PING
cls
set /p target=Enter IP address or hostname to ping:
set /p save=Do you want to save the output to a file? (Y/N or Yes/No):
if /I "%save%"=="Y" goto PING_SAVE
if /I "%save%"=="YES" goto PING_SAVE

ping %target%
pause
goto MENU

:PING_SAVE
set /p filepath=Enter folder path to save the file (e.g. C:\Logs):
set filename=ping_%timestamp%.txt
ping %target% > "%filepath%\%filename%" 2>>"%logFile%"
if errorlevel 1 (
    echo [ERROR] Ping failed for %target% at %timestamp% >> "%logFile%"
) else (
    echo Output saved to %filepath%\%filename%
)
pause
goto MENU

:EXTERNAL_DNS_CHECKER
cls
ping -n 2 8.8.8.8 >nul 2>&1 && echo   [OK]  8.8.8.8 Google DNS - REACHABLE      || echo   [XX]  8.8.8.8 Google DNS - UNREACHABLE
ping -n 2 1.1.1.1 >nul 2>&1 && echo   [OK]  1.1.1.1 Cloudflare  - REACHABLE      || echo   [XX]  1.1.1.1 Cloudflare  - UNREACHABLE
ping -n 2 google.com >nul 2>&1 && echo   [OK]  google.com DNS Res - REACHABLE    || echo   [XX]  google.com DNS Res - UNREACHABLE
pause
goto MENU



:NETINFO
cls
set /p save=Do you want to save the output to a file? (Y/N or Yes/No):
if /I "%save%"=="Y" goto NETINFO_SAVE
if /I "%save%"=="YES" goto NETINFO_SAVE

echo Ethernet Adapter Info:
ipconfig /all | findstr /C:"Ethernet adapter" /C:"IPv4 Address" /C:"Subnet Mask" /C:"Default Gateway" /C:"Physical Address"
echo.
echo Wi-Fi Adapter Info:
ipconfig /all | findstr /C:"Wireless LAN adapter" /C:"IPv4 Address" /C:"Subnet Mask" /C:"Default Gateway" /C:"Physical Address"
pause
goto MENU

:NETINFO_SAVE
set /p filepath=Enter folder path to save the file (e.g. C:\Logs):
set filename=netinfo_%timestamp%.txt
(
    echo Ethernet Adapter Info:
    ipconfig /all | findstr /C:"Ethernet adapter" /C:"IPv4 Address" /C:"Subnet Mask" /C:"Default Gateway" /C:"Physical Address"
    echo.
    echo Wi-Fi Adapter Info:
    ipconfig /all | findstr /C:"Wireless LAN adapter" /C:"IPv4 Address" /C:"Subnet Mask" /C:"Default Gateway" /C:"Physical Address"
) > "%filepath%\%filename%" 2>>"%logFile%"
if errorlevel 1 (
    echo [ERROR] Failed to retrieve network info at %timestamp% >> "%logFile%"
) else (
    echo Output saved to %filepath%\%filename%
)
pause
goto MENU

:TRACEROUTE
cls
set /p target=Enter IP address or hostname to traceroute:
set /p save=Do you want to save the output to a file? (Y/N or Yes/No):
if /I "%save%"=="Y" goto TRACEROUTE_SAVE
if /I "%save%"=="YES" goto TRACEROUTE_SAVE

tracert %target%
pause
goto MENU

:TRACEROUTE_SAVE
set /p filepath=Enter folder path to save the file (e.g. C:\Logs):
set filename=traceroute_%timestamp%.txt
tracert %target% > "%filepath%\%filename%" 2>>"%logFile%"
if errorlevel 1 (
    echo [ERROR] Traceroute failed for %target% at %timestamp% >> "%logFile%"
) else (
    echo Output saved to %filepath%\%filename%
)
pause
goto MENU

:NETSTAT
cls
set /p save=Do you want to save the output to a file? (Y/N or Yes/No):
if /I "%save%"=="Y" goto NETSTAT_SAVE
if /I "%save%"=="YES" goto NETSTAT_SAVE

netstat -ano
pause
goto MENU

:NETSTAT_SAVE
set /p filepath=Enter folder path to save the file (e.g. C:\Logs):
set filename=netstat_%timestamp%.txt
netstat -ano > "%filepath%\%filename%" 2>>"%logFile%"
if errorlevel 1 (
    echo [ERROR] Netstat failed at %timestamp% >> "%logFile%"
) else (
    echo Output saved to %filepath%\%filename%
)
pause
goto MENU

:RENEWIP
cls
echo Releasing IP address...
ipconfig /release 2>>"%logFile%"
echo Renewing IP address...
ipconfig /renew 2>>"%logFile%"
pause
goto MENU

:CLEARDNS
cls
echo Clearing DNS cache...
ipconfig /flushdns 2>>"%logFile%"
pause
goto MENU

:: Network Functions Ends

:: Software Remnants Starts

:UNINSTALL_CITRIX
cls
echo Uninstalling Citrix Workspace...
echo [%timestamp%] Starting Citrix Workspace removal >> "%logFile%"
:: Kill running Citrix processes
taskkill /IM "SelfService.exe" /F >> "%logFile%" 2>&1
if errorlevel 1 echo [%timestamp%] [ERROR] Failed to kill SelfService.exe >> "%logFile%"
taskkill /IM "CitrixWorkspace.exe" /F >> "%logFile%" 2>&1
if errorlevel 1 echo [%timestamp%] [ERROR] Failed to kill CitrixWorkspace.exe >> "%logFile%"

:: Remove Citrix folders
if exist "C:\Program Files\Citrix" (
    rmdir /S /Q "C:\Program Files\Citrix" >> "%logFile%" 2>&1
    if errorlevel 1 echo [%timestamp%] [ERROR] Failed to remove C:\Program Files\Citrix >> "%logFile%"
)

if exist "C:\Program Files (x86)\Citrix" (
    rmdir /S /Q "C:\Program Files (x86)\Citrix" >> "%logFile%" 2>&1
    if errorlevel 1 echo [%timestamp%] [ERROR] Failed to remove C:\Program Files (x86)\Citrix >> "%logFile%"
)

if exist "C:\ProgramData\Citrix" (
    rmdir /S /Q "C:\ProgramData\Citrix" >> "%logFile%" 2>&1
    if errorlevel 1 echo [%timestamp%] [ERROR] Failed to remove C:\ProgramData\Citrix >> "%logFile%"
)

echo [%timestamp%] Citrix Workspace removal completed >> "%logFile%"
pause
goto REMNANTSMENU

:: Software Remnants Ends

:: PC Repairs Menu Starts

:SFCSCAN
cls
echo Running SFC Scan...
sfc /scannow 2>>"%logFile%"
pause
goto :REPAIRMENU

:WINDOWSREPAIR 
cls
echo Running Windows repair...
DISM /Online /Cleanup-image /restorehealth 2>>"%logFile%"
pause
goto :REPAIRMENU

:DISKERROR
cls
echo Fixing Disk Errors...
chkdsk /f  2>>"%logFile%"
pause
goto :REPAIRMENU

:: PC Repairs Menu Ends 

:: Loose Options.

:DELETESWD
cls
echo Stopping Windows Update services...
net stop wuauserv 2>>"%logFile%"
net stop bits 2>>"%logFile%"
net stop cryptsvc 2>>"%logFile%"
net stop msiserver 2>>"%logFile%"
echo Deleting SoftwareDistribution folder contents...
del /s /q %windir%\SoftwareDistribution\* 2>>"%logFile%"
echo Starting Windows Update services...
net start wuauserv 2>>"%logFile%"
net start bits 2>>"%logFile%"
net start cryptsvc 2>>"%logFile%"
net start msiserver 2>>"%logFile%"
pause
goto MENU

:BIOSBOOT
cls
echo rebooting into bios in 10 seconds 
shutdown /r /fw /f /t 10
pause
goto MENU

:DEFUPDATE
cls
echo Triggering Defender signature update...
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -SignatureUpdate 2>>"%logFile%"
pause
goto MENU

:BATTERYCHECK
cls
echo Running Battery Health Checker...
powercfg /batteryreport 2>>"%logFile%"
Pause
goto MENU

:: automatic scripts starts

:BASICREPAIR
cls
echo Running SFC Scan...
sfc /scannow 2>>"%logFile%"
echo Running Windows repair...
DISM /Online /Cleanup-image /restorehealth 2>>"%logFile%"
pause
goto :AUTOSCRIPT

:ADVREPAIR
cls
echo Running SFC Scan...
sfc /scannow 2>>"%logFile%"
echo Running Windows repair...
DISM /Online /Cleanup-image /restorehealth 2>>"%logFile%"
echo Fixing Disk Errors...
chkdsk /f  2>>"%logFile%"
pause
goto :AUTOSCRIPT

:: automatic scripts ends
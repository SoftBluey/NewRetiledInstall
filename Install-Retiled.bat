@echo off
setlocal enabledelayedexpansion
title Retiled App Installer - v6 (Correct Two-Folder Logic)

cls
echo.
echo ============================================================================
echo  Step 1: Checking for Administrator Privileges
echo ============================================================================
echo.
net session >nul 2>&1
if %errorLevel% == 0 (
    echo  SUCCESS: Administrator privileges detected.
) else (
    echo  ERROR: This script MUST be run as an Administrator.
    echo  Please right-click this file and choose "Run as administrator".
    goto :end
)
echo.
echo Press any key to continue...
pause >nul
set "BaseDir=%~dp0"
=
cls
echo.
echo ============================================================================
echo  Step 2: Unlock Application Sideloading via MetroUnlocker
echo ============================================================================
echo.
echo  --- YOUR ACTION IS REQUIRED ---
echo.
echo  1. When the MetroUnlocker window opens, check ALL of the boxes.
echo  2. Click the "Unlock" button.
echo  3. IMPORTANT: CLOSE the MetroUnlocker window to continue.
echo.
pause
echo.
echo  Launching MetroUnlocker...
start /wait "" "%BaseDir%DEPEND\SOFT\MetroUnlocker.exe"
echo.
echo  MetroUnlocker has been closed. Proceeding...
echo.
pause

cls
echo.
echo ============================================================================
echo  Step 3: Uninstalling Old Bing/MSN Applications
echo ============================================================================
echo.
echo  Removing old versions to ensure a clean installation...
echo.
echo  Uninstalling MSN Finance...
powershell -command "Get-AppxPackage *BingFinance* | Remove-AppxPackage" >nul 2>&1
echo  Uninstalling MSN Food ^& Drink...
powershell -command "Get-AppxPackage *BingFoodAndDrink* | Remove-AppxPackage" >nul 2>&1
echo  Uninstalling MSN Health ^& Fitness...
powershell -command "Get-AppxPackage *BingHealthAndFitness* | Remove-AppxPackage" >nul 2>&1
echo  Uninstalling MSN News...
powershell -command "Get-AppxPackage *BingNews* | Remove-AppxPackage" >nul 2>&1
echo  Uninstalling MSN Sports...
powershell -command "Get-AppxPackage *BingSports* | Remove-AppxPackage" >nul 2>&1
echo  Uninstalling MSN Travel...
powershell -command "Get-AppxPackage *BingTravel* | Remove-AppxPackage" >nul 2>&1
echo  Uninstalling MSN Weather...
powershell -command "Get-AppxPackage *BingWeather* | Remove-AppxPackage" >nul 2>&1
echo.
echo  Uninstallation phase complete.
echo.
pause

cls
echo.
echo ============================================================================
echo  Step 4: Installing Required Dependencies
echo ============================================================================
echo.
echo  The script will now install all required frameworks from the /DEPEND/ folder.
echo.
echo  --- INSTRUCTIONS ---
echo  For each item, the installer will open. Press a key in ITS window
echo  to close it and continue to the next one.
echo.
pause
cls
echo Installing dependencies...
echo.
for %%f in ("%BaseDir%DEPEND\*.appx") do (
    echo ----------------------------------------------------------------------------
    echo  INSTALLING DEPENDENCY: %%~nxf
    echo  The installer will open now. Press a key IN ITS WINDOW when it finishes.
    start /wait "" "%BaseDir%DEPEND\SOFT\WSAppPkgIns.exe" "%%f"
    echo  -> Dependency installation complete.
    echo ----------------------------------------------------------------------------
    echo.
)
echo All dependencies have been installed.
echo.
pause

cls
echo.
echo ============================================================================
echo  Step 5: Installing Retiled
echo ============================================================================
echo.
echo  Now installing the main applications from the /RETILED/ folder.
echo.
echo  The same process applies: Press a key in the installer window when prompted.
echo.
pause
cls
echo Installing main applications...
echo.
for %%f in ("%BaseDir%RETILED\*.appx") do (
    set "AppName=%%~nxf"
    set "FriendlyName=Unknown App"
    if "!AppName:BingFinance=!" NEQ "!AppName!" set "FriendlyName=MSN Finance"
    if "!AppName:BingFoodAndDrink=!" NEQ "!AppName!" set "FriendlyName=MSN Food ^& Drink"
    if "!AppName:BingHealthAndFitness=!" NEQ "!AppName!" set "FriendlyName=MSN Health ^& Fitness"
    if "!AppName:BingNews=!" NEQ "!AppName!" set "FriendlyName=MSN News"
    if "!AppName:BingSports=!" NEQ "!AppName!" set "FriendlyName=MSN Sports"
    if "!AppName:BingTravel=!" NEQ "!AppName!" set "FriendlyName=MSN Travel"
    if "!AppName:BingWeather=!" NEQ "!AppName!" set "FriendlyName=MSN Weather"

    echo ----------------------------------------------------------------------------
    echo  INSTALLING APP: !FriendlyName!
    echo  The installer will open now. Press a key IN ITS WINDOW when it finishes.
    start /wait "" "%BaseDir%DEPEND\SOFT\WSAppPkgIns.exe" "%%f"
    echo  -> !FriendlyName! installation complete.
    echo ----------------------------------------------------------------------------
    echo.
)

cls
echo.
echo ============================================================================
echo                          INSTALLATION COMPLETE
echo ============================================================================
echo.
echo  All dependencies and main applications have been processed.
echo.
echo  You can now check your Windows 8 Start Screen for the new app tiles.
echo.

:end
echo Press any key to close this window. Thanks for using! This install script was made by BlueySoft, Retiled is made by migbrunluz.
pause >nul
exit
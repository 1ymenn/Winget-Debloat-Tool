@echo off
:: تشغيل كمسؤول وتغيير عنوان النافذة ليطابق الصورة
title Administrator: Winget and Debloat Tool
color 0F

:menu
cls
echo ===================================================
echo       System Optimization Tool (Winget ^& Debloat)
echo ===================================================
echo [1] Update all installed apps (Winget Upgrade)
echo [2] Install Essential Runtimes (Recommended)
echo [3] Custom App Installer Menu (Select from List)
echo [4] Remove Windows Bloatware (Chris Titus Tech)
echo [5] Check Winget status
echo [6] Driver Update ^& Installation
echo [7] System Information (Hardware ^& OS)
echo [8] Exit
echo ===================================================
echo.

set /p choice=Enter your choice (1-8): 

if "%choice%"=="1" goto upgrade
if "%choice%"=="2" goto runtimes
if "%choice%"=="3" goto custom_apps
if "%choice%"=="4" goto debloat
if "%choice%"=="5" goto status
if "%choice%"=="6" goto drivers
if "%choice%"=="7" goto sysinfo
if "%choice%"=="8" exit

echo Invalid choice, please try again.
pause
goto menu

:upgrade
cls
echo ===================================================
echo          Updating All Installed Applications
echo ===================================================
winget upgrade --all
echo.
pause
goto menu

:runtimes
cls
echo ===================================================
echo      Installing Essential Runtimes ^& Components
echo ===================================================
echo Installing Microsoft Visual C++ Redistributables (x64 ^& x86)...
winget install Microsoft.VCRedist.2015+.x64 --accept-package-agreements --accept-source-agreements
winget install Microsoft.VCRedist.2015+.x86 --accept-package-agreements --accept-source-agreements
echo.
echo Installing .NET Desktop Runtime...
winget install Microsoft.DotNet.DesktopRuntime.8 --accept-package-agreements --accept-source-agreements
echo.
echo Installing Microsoft Edge WebView2 Runtime...
winget install Microsoft.EdgeWebView2Runtime --accept-package-agreements --accept-source-agreements
echo.
echo ===================================================
echo All essential runtimes installed successfully!
echo ===================================================
pause
goto menu

:custom_apps
cls
echo ===================================================
echo               Custom App Installer Menu            
echo ===================================================
echo [1] Google Chrome         [2] VLC Media Player
echo [3] 7-Zip                 [4] Notepad++
echo [5] Discord               [6] WinRAR
echo [7] Adobe Acrobat Reader  [8] qBittorrent
echo [9] Steam
echo ---------------------------------------------------
echo [10] Top 10 Apps Menu
echo [11] Search for an App
echo [12] Back to Main Menu
echo ===================================================
echo.
set /p app_choice=Enter your choice (1-12): 

if "%app_choice%"=="1" winget install Google.Chrome & pause & goto custom_apps
if "%app_choice%"=="2" winget install VideoLAN.VLC & pause & goto custom_apps
if "%app_choice%"=="3" winget install 7zip.7zip & pause & goto custom_apps
if "%app_choice%"=="4" winget install Notepad++.Notepad++ & pause & goto custom_apps
if "%app_choice%"=="5" winget install Discord.Discord & pause & goto custom_apps
if "%app_choice%"=="6" winget install RARLab.WinRAR & pause & goto custom_apps
if "%app_choice%"=="7" winget install Adobe.Acrobat.Reader.64-bit & pause & goto custom_apps
if "%app_choice%"=="8" winget install qBittorrent.qBittorrent & pause & goto custom_apps
if "%app_choice%"=="9" winget install Valve.Steam & pause & goto custom_apps
if "%app_choice%"=="10" goto top_10_apps
if "%app_choice%"=="11" goto search_app
if "%app_choice%"=="12" goto menu

echo Invalid choice!
pause
goto custom_apps

:top_10_apps
cls
echo ===================================================
echo                    Top 10 Apps Menu
echo ===================================================
echo [1] Brave Browser         [2] VS Code
echo [3] IDM (Download Mgr)    [4] Revo Uninstaller
echo [5] OBS Studio            [6] Python 3
echo [7] Git                   [8] Rufus
echo [9] AnyDesk               [10] WhatsApp
echo ---------------------------------------------------
echo [11] Back to Main App Menu
echo ===================================================
echo.
set /p top_choice=Enter your choice (1-11): 

if "%top_choice%"=="1" winget install BraveSoftware.BraveBrowser & pause & goto top_10_apps
if "%top_choice%"=="2" winget install Microsoft.VisualStudioCode & pause & goto top_10_apps
if "%top_choice%"=="3" winget install Tonec.InternetDownloadManager & pause & goto top_10_apps
if "%top_choice%"=="4" winget install VSRevoGroup.RevoUninstaller & pause & goto top_10_apps
if "%top_choice%"=="5" winget install OBSProject.OBSStudio & pause & goto top_10_apps
if "%top_choice%"=="6" winget install Python.Python.3 & pause & goto top_10_apps
if "%top_choice%"=="7" winget install Git.Git & pause & goto top_10_apps
if "%top_choice%"=="8" winget install Akeo.Rufus & pause & goto top_10_apps
if "%top_choice%"=="9" winget install AnyDeskSoftware.AnyDesk & pause & goto top_10_apps
if "%top_choice%"=="10" winget install WhatsApp.WhatsApp & pause & goto top_10_apps
if "%top_choice%"=="11" goto custom_apps

echo Invalid choice!
pause
goto top_10_apps

:search_app
cls
echo ===================================================
echo                  Search for an App                 
echo ===================================================
set /p "search_term=Enter app name or keyword: "
echo Searching for "%search_term%"...
winget search "%search_term%"
echo.
set /p "install_id=Enter the ID of the app to install (or press Enter to go back): "
if "%install_id%"=="" goto custom_apps
winget install %install_id%
pause
goto custom_apps

:debloat
cls
echo ===================================================
echo         Launching Chris Titus Windows Utility      
echo ===================================================
echo Opening PowerShell and running the script...
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm christitus.com/win | iex"
pause
goto menu

:status
cls
echo ===================================================
echo                  Checking Winget Status            
echo ===================================================
winget --version
echo.
winget list
pause
goto menu

:drivers
cls
echo ===================================================
echo               Driver Update ^& Installation         
echo ===================================================
echo Triggering Windows Driver Update Detection...
powershell -Command "$AutoUpdate = New-Object -ComObject Microsoft.Update.AutoUpdate; $AutoUpdate.DetectNow()"
echo.
echo Opening Windows Settings for Optional Driver Updates...
echo Please check "Advanced options" -> "Optional updates" if available.
echo.
start ms-settings:windowsupdate
pause
goto menu

:sysinfo
cls
echo ===================================================
echo            Detailed System Information Menu            
echo ===================================================
echo Loading hardware and OS details, please wait...
echo.

echo ---------------------------------------------------
echo  [ OS, User ^& Hardware Overview ]
echo ---------------------------------------------------
systeminfo | findstr /B /C:"Host Name" /C:"OS Name" /C:"OS Version" /C:"System Boot Time" /C:"System Manufacturer" /C:"System Model" /C:"System Type" /C:"Processor(s)" /C:"Total Physical Memory"

echo.
echo ---------------------------------------------------
echo  [ Graphics Card / GPU Info ]
echo ---------------------------------------------------
powershell -Command "Get-CimInstance Win32_VideoController | Format-Table -Property Name, @{Label='Driver Version'; Expression={$_.DriverVersion}} -AutoSize"

echo ---------------------------------------------------
echo  [ Storage Devices / Hard Drives ]
echo ---------------------------------------------------
echo * Physical Disks Connected:
powershell -Command "Get-Disk | Format-Table -Property Number, FriendlyName, @{Label='Size (GB)'; Expression={[Math]::Round($_.Size/1GB, 2)}}, BusType -AutoSize"
echo * Logical Partitions (Free Space):
powershell -Command "Get-Volume | Where-Object DriveLetter | Format-Table -Property DriveLetter, FileSystemLabel, @{Label='Total Size (GB)'; Expression={[Math]::Round($_.Size/1GB, 2)}}, @{Label='Free Space (GB)'; Expression={[Math]::Round($_.SizeRemaining/1GB, 2)}} -AutoSize"

echo ---------------------------------------------------
echo  [ Connected Peripherals (Mice, Keyboards, etc.) ]
echo ---------------------------------------------------
echo * Pointing Devices (Mice/Touchpads):
powershell -Command "Get-CimInstance Win32_PointingDevice | ForEach-Object { echo ' - ' $_.Name }"
echo.
echo * Keyboards Connected:
powershell -Command "Get-CimInstance Win32_Keyboard | ForEach-Object { echo ' - ' $_.Description }"
echo.
echo * Monitors and Audio/USB Peripherals:
powershell -Command "Get-PnpDevice -PresentOnly | Where-Object { $_.Class -match 'Monitor|AudioEndpoint' } | ForEach-Object { echo ' - ' $_.FriendlyName }"

echo ===================================================
echo.
pause
goto menu
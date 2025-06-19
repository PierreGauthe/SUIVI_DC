@echo off
setlocal enabledelayedexpansion

REM Variables
set SERVER=sasprod
set USER=gauthpi
set REMOTE_PATH=/sasprod/produits/SASEnterpriseBIServer/segrac/METGTCCL/Pierre_G/temp/
set LOCAL_PATH=C:\Users\GAUTHPI\Documents\PSAP\PSAP_VIZ\version_juin_2025\Nouveau_dossier\SUIVI_DC\data
set PSCP_PATH=C:\Users\GAUTHPI\Documents\PSAP\PSAP_VIZ\version_juin_2025\Nouveau_dossier\SUIVI_DC\ressources\pscp.exe
set PLINK_PATH=C:\Users\GAUTHPI\Documents\PSAP\PSAP_VIZ\version_juin_2025\Nouveau_dossier\SUIVI_DC\ressources\plink.exe

REM Initialize FILES variable
set FILES=

REM Use PLINK to list files on the remote server and filter them
for /f "tokens=*" %%F in ('%PLINK_PATH% -ssh %USER%@%SERVER% "ls %REMOTE_PATH%psp*.csv"') do (
    set FILES=!FILES! %%F
)

REM Loop through the files and download each one
for %%F in (!FILES!) do (
    echo Downloading %%F...
    %PSCP_PATH% %USER%@%SERVER%:"%%~F" "%LOCAL_PATH%"
    if !ERRORLEVEL!==0 (
        echo Downloaded %%F successfully.
    ) else (
        echo Failed to download %%F.
    )
)

pause

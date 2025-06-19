@echo off

REM Variables
set SERVER=sasprod
set USER=gauthpi
set REMOTE_PATH=/sasprod/produits/SASEnterpriseBIServer/segrac/METGTCCL/Pierre_G/temp/
set LOCAL_PATH=C:\Users\GAUTHPI\Documents\PSAP\PSAP_VIZ\version_juin_2025\Nouveau_dossier\SUIVI_DC\data
set FILES=psp_t_dc_190625.csv psp_ref_deleg_190625.csv psp_t_cnt_190625.csv
set PSCP_PATH=C:\Users\GAUTHPI\Documents\PSAP\PSAP_VIZ\version_juin_2025\Nouveau_dossier\SUIVI_DC\ressources\pscp.exe

REM Loop through the files and download each one
for %%F in (%FILES%) do (
    %PSCP_PATH% %USER%@%SERVER%:%REMOTE_PATH%%%F %LOCAL_PATH%
    if %ERRORLEVEL%==0 (
        echo Downloaded %%F successfully.
    ) else (
        echo Failed to download %%F.
    )
)

pause

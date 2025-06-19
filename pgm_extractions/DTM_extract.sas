/* Extraction des d�l�gataires associ�s aux contrats depuis le datamart pour enrichir les fichiers de PSAP dans PowerBIs */
%INCLUDE "/sasprod/produits/SASEnterpriseBIServer/segrac/METGTCCL/Pierre_G/Password/Connection_auto_encod.sas";
LIBNAME SID "GIE45.SASDATA.GRPEGPE.HLSID.SIDFONC" server=serveur  disp=shr; 
libname dtm "/sasprod/produits/SASEnterpriseBIServer/segrac/METGTCCL/_sasdev/DATAMART/output/last";
libname out "/sasprod/produits/SASEnterpriseBIServer/segrac/METGTCCL/Pierre_G/PSAP";

proc sql;
    create table extct_cnt_deleg as
    select distinct
        a.CDCNT as CDCNT_dtm,
        a.TP,
        a.TOP_DELEG as dt_fichier,
        a.TOP_DECES,
        a.TOP_OBSEQUE,
        a.DT_EFFET,
        a.DT_RESIL,
        a.DENO,
        a.TOP_DELEG,
        a.ETAT_CNT,
        a.CPOPU,
        b.NOM_DELG as NOM_DELEG_SID
    from 
        dtm.t_contrat as a
    left join 
        SID.DLTDELEG as b
    on 
        a.CDELEG = b.ID_DLG_BA_TIER
    where 
        a.CDELEG is not null
;
quit;

data extct_cnt_deleg;
    set extct_cnt_deleg;
    if not missing(NOM_DELEG_SID); /* Retain only rows where the variable is not null */
run;

proc sort data=extct_cnt_deleg out=out.extct_cnt_deleg noduprecs;
    by _all_;
run;




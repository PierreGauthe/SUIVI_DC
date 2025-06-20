/* Extraction des delegataires associes aux contrats depuis le datamart pour enrichir les fichiers de PSAP dans PowerBIs */

/* Libnames */
%INCLUDE "/sasprod/produits/SASEnterpriseBIServer/segrac/METGTCCL/Pierre_G/Password/Connection_auto_encod.sas";
LIBNAME SID "GIE45.SASDATA.GRPEGPE.HLSID.SIDFONC" server=serveur  disp=shr; 
libname dtm "/sasprod/produits/SASEnterpriseBIServer/segrac/METGTCCL/_sasdev/DATAMART/output/last";
libname out "/sasprod/produits/SASEnterpriseBIServer/segrac/METGTCCL/Pierre_G/temp";

/* Recup date */ 
data _null_;
    current_date = date();
    call symputx('current_date', put(current_date, ddmmyyn6.));
run;

/* Creation de la table */
proc sql;
    create table extct_cnt_deleg as
    select distinct
        a.CDCNT as CDCNT_dtm,
        a.TOP_DELEG,
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

proc sort data=extct_cnt_deleg out=extct_cnt_deleg2 noduprecs;
    by _all_;
run;

/* transfo en csv et sauvegarde dans le dossier temporaire */
proc export data=extct_cnt_deleg2
    outfile="/sasprod/produits/SASEnterpriseBIServer/segrac/METGTCCL/Pierre_G/temp/psp_ref_deleg_&current_date..csv"
    dbms=csv
    replace;
run;
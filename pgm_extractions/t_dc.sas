/* Recup des sources pour outil viz DC */
%INCLUDE "/sasprod/produits/SASEnterpriseBIServer/segrac/METGTCCL/Pierre_G/Password/Connection_auto_encod.sas";
libname dtm "/sasprod/produits/SASEnterpriseBIServer/segrac/METGTCCL/_sasdev/DATAMART/output/last";
libname out "/sasprod/produits/SASEnterpriseBIServer/segrac/METGTCCL/Pierre_G/temp";

/* recup_date */
data _null_;
    current_date = date();
    call symputx('current_date', put(current_date, ddmmyyn6.));
run;

/* t_dc */
proc export data=dtm.t_dc
    outfile="/sasprod/produits/SASEnterpriseBIServer/segrac/METGTCCL/Pierre_G/temp/psp_t_dc_&current_date..csv"
    dbms=csv
    replace;
run;
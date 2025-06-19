/* Recup des sources pour outil viz DC */
%INCLUDE "/sasprod/produits/SASEnterpriseBIServer/segrac/METGTCCL/Pierre_G/Password/Connection_auto_encod.sas";
libname dtm "/sasprod/produits/SASEnterpriseBIServer/segrac/METGTCCL/_sasdev/DATAMART/output/last";
libname out "/sasprod/produits/SASEnterpriseBIServer/segrac/METGTCCL/Pierre_G/temp";

/* recup_date */
data _null_;
    current_date = date();
    call symputx('current_date', put(current_date, ddmmyyn6.));
run;

proc sql;
    create table t_cnt_psp as
    select *
    from 
        dtm.t_contrat
    where 
        NOT(TOP_DECES="NON" AND TOP_OBSEQUE="NON")
;
quit;

/* t_cnt */
proc export data=t_cnt_psp
    outfile="/sasprod/produits/SASEnterpriseBIServer/segrac/METGTCCL/Pierre_G/temp/psp_t_cnt_&current_date..csv"
    dbms=csv
    replace;
run;
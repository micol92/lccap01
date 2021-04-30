using YSECURITY_VT from '../db/external_vt';
using YCREDIT_VT from '../db/external_vt';
using YORG_VT from '../db/external_vt';
using YEXCREDIT_VT from '../db/external_vt';
using ZS4BSIDRT01_VT from '../db/external_vt';
using S4BONDVW01_VT2 from '../db/external_vt';
using LC.POC as my from '../db/data-model';

//using YEXCUSTVW from '../db/external_vt'; //customer name

service vtcat {
    @readonly entity YSECURITY_VT_SVR as projection on YSECURITY_VT;
    @readonly entity YCREDIT_VT_SVR as projection on YCREDIT_VT;
    @readonly entity YEXCREDIT_VT_SVR as projection on YEXCREDIT_VT;
    @readonly entity YORG_VT_SVR as projection on YORG_VT;
    @readonly entity ZS4BSIDRT01_VT_SVR as projection on ZS4BSIDRT01_VT;


//aggregation by GROUP01T,PRCTRT, SEGMENT
 view Realtmrt01
 as select 
            B.GROUP01T,     //본부
            B.PRCTRT        //손익센터
            ,MAP(A.SEGMENT,'Z_SEG2','서울','Z_SEG3','대전','1000_C','부산','UNKNOWN') AS SEGMENT : String(30)
            ,SUM (OVERDUE_CNT_0) AS OVDCNT01  : Integer
            ,SUM (OVERDUE_CNT_1) AS OVDCNT02  : Integer            
            ,SUM (OVERDUE_AMT_0) AS OVDAMT01  : Decimal(23,2)
            ,SUM (OVERDUE_AMT_1) AS OVDAMT02  : Decimal(23,2)
        from S4BONDVW01_VT2 A
        INNER JOIN YORG_VT B
        on A.PRCTR = B.PRCTR
        GROUP BY B.GROUP01T,B.PRCTRT,A.SEGMENT
        ;

//aggregation by PRCTRT, SEGMENT,KUNNR(KUNNRT)
view Realtmrt01_1
    as select 
            B.PRCTRT    //손익센터
             ,MAP(A.SEGMENT,'Z_SEG2','서울','Z_SEG3','대전','1000_C','부산','UNKNOWN') SEGMENT : String(30)
             ,A.KUNNR       //고객코드
             ,E.KUNNRT      //고객명
             ,MAX(Coalesce(D.USERID,'S4H_RE')) USERID : String(100) 
             ,SUM(MAP(C.SECAT01,'INS',SEVAL_AMT,0) ) SEVAL_AMT01 : Decimal(23,2)    //담보-상업보험
             ,SUM(MAP(C.SECAT01,'REA',SEVAL_AMT,0) ) SEVAL_AMT02 : Decimal(23,2)    //담보-실담보
             ,SUM(D.KULIM_AMT) KULIM_AMT : Decimal(23,2)    //한도금액
             ,SUM(D.KULIM_AMT - A.WRBTR) KULIM_AMT2 : Decimal(23,2) //한도초과금액
             ,SUM(A.PLAN_AMT)  PLAN_AMT : Decimal(23,2)
             ,SUM(A.OVERDUE1_AMT) overdue1_amt  : Decimal(23,2)
             ,SUM(A.OVERDUE2_AMT) overdue2_amt  : Decimal(23,2)
             ,SUM(A.OVERDUE3_AMT) overdue3_amt  : Decimal(23,2)
             ,SUM(A.OVERDUE4_AMT) overdue4_amt  : Decimal(23,2)
             ,SUM(A.OVERDUE_AMT) overdue_amt  : Decimal(23,2)
        from S4BONDVW01_VT2 A
        INNER JOIN YORG_VT B
            on A.PRCTR = B.PRCTR  
        LEFT OUTER JOIN YSECURITY_VT C
            on A.KUNNR = C.KUNNR
            and A.BUKRS = C.BUKRS
        LEFT OUTER JOIN YCREDIT_VT D
	        on A.KUNNR = D.KUNNR
	        and A.BUKRS = D.BUKRS
        LEFT OUTER JOIN my.YCUSTMST E
            on A.KUNNR = E.KUNNR
        GROUP BY E.KUNNRT,B.PRCTRT,A.SEGMENT,A.KUNNR
        ;


view Realtmrt02(p_bukrs: String(4), p_bldat: String(8))
 as select 
            B.GROUP01T,     //본부
            B.PRCTRT        //손익센터
             ,MAP(A.SEGMENT,'Z_SEG2','서울','Z_SEG3','대전','1000_C','부산','UNKNOWN') SEGMENT : String(30)
            ,SUM (
               CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > :p_bldat AND DAYS_BETWEEN(A.BLDAT,:p_bldat) <= 90 THEN 1 ELSE 0 END
              + CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > :p_bldat AND DAYS_BETWEEN(A.BLDAT,:p_bldat) > 90  THEN 1 ELSE 0 END
             ) OVDCNT01  : Integer
              ,SUM (
               CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > :p_bldat AND DAYS_BETWEEN(A.BLDAT,:p_bldat) <= 90 THEN 1 ELSE 0 END
              + CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > :p_bldat AND DAYS_BETWEEN(A.BLDAT,:p_bldat) > 90  THEN 1 ELSE 0 END
             ) AS OVDCNT02  : Integer    
             ,SUM (
               CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > :p_bldat AND DAYS_BETWEEN(A.BLDAT,:p_bldat) <= 90  THEN A.WRBTR ELSE 0 END
               + CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > :p_bldat AND DAYS_BETWEEN(A.BLDAT,:p_bldat) > 90  THEN A.WRBTR ELSE 0 END

             ) OVDAMT01  : Decimal(23,2)
              ,SUM (
               CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > add_days(:p_bldat,1) AND DAYS_BETWEEN(A.BLDAT,add_days(:p_bldat,1)) <= 90 THEN A.WRBTR ELSE 0 END
               + CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > add_days(:p_bldat,1) AND DAYS_BETWEEN(A.BLDAT,add_days(:p_bldat,1)) > 90 THEN A.WRBTR ELSE 0 END
             ) AS OVDAMT02  : Decimal(23,2)
        from ZS4BSIDRT01_VT A
        INNER JOIN YORG_VT B
        on A.PRCTR = B.PRCTR
        where A.BUKRS = :p_bukrs
        GROUP BY B.GROUP01T,B.PRCTRT,A.SEGMENT
        ;

view Realtmrt02_1(p_bukrs: String(4), p_bldat: String(8))
    as select 
            B.PRCTRT    //손익센터
             ,MAP(A.SEGMENT,'Z_SEG2','서울','Z_SEG3','대전','1000_C','부산','UNKNOWN') SEGMENT : String(30)
             ,A.KUNNR       //고객코드
             ,E.E_KUNNERT   //고객명
             ,MAX(Coalesce(D.USERID,'S4H_RE')) USERID : String(100) 
             ,SUM(MAP(C.SECAT01,'INS',SEVAL_AMT,0) ) SEVAL_AMT01 : Decimal(23,2)    //담보-상업보험
             ,SUM(MAP(C.SECAT01,'REA',SEVAL_AMT,0) ) SEVAL_AMT02 : Decimal(23,2)    //담보-실담보
             ,SUM(D.KULIM_AMT) KULIM_AMT : Decimal(23,2)    //한도금액
             ,SUM(D.KULIM_AMT - A.WRBTR) KULIM_AMT2 : Decimal(23,2) //한도초과금액
             ,SUM(CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) < :p_bldat THEN WRBTR ELSE 0 END)  PLAN_AMT : Decimal(23,2)
             ,SUM(CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > :p_bldat AND DAYS_BETWEEN(BLDAT, :p_bldat) <= 30 THEN WRBTR ELSE 0 END) overdue1_amt  : Decimal(23,2)
             ,SUM(CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > :p_bldat AND DAYS_BETWEEN(BLDAT,:p_bldat) > 30  AND DAYS_BETWEEN(BLDAT,:p_bldat) <= 60 THEN WRBTR ELSE 0 END) overdue2_amt  : Decimal(23,2)
             ,SUM(CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > :p_bldat AND DAYS_BETWEEN(BLDAT,:p_bldat) > 60  AND DAYS_BETWEEN(BLDAT,:p_bldat) <= 90 THEN WRBTR ELSE 0 END) overdue3_amt  : Decimal(23,2)
             ,SUM(CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > :p_bldat AND DAYS_BETWEEN(BLDAT,:p_bldat) > 90  THEN WRBTR ELSE 0 END) overdue4_amt  : Decimal(23,2)
             ,SUM (
                CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > :p_bldat AND DAYS_BETWEEN(A.BLDAT, :p_bldat) <= 90 THEN A.WRBTR ELSE 0 END        
                + CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > :p_bldat AND DAYS_BETWEEN(A.BLDAT, :p_bldat) > 90 THEN A.WRBTR ELSE 0 END               
                ) as overdue_amt : Decimal(23,2)
        from ZS4BSIDRT01_VT A
        INNER JOIN YORG_VT B
            on A.PRCTR = B.PRCTR
        LEFT OUTER JOIN YSECURITY_VT C
            on A.KUNNR = C.KUNNR
            and A.BUKRS = C.BUKRS
        LEFT OUTER JOIN YCREDIT_VT D
	        on A.KUNNR = D.KUNNR
	        and A.BUKRS = D.BUKRS
        LEFT OUTER JOIN (select distinct E_KUNNER, E_KUNNERT from YEXCREDIT_VT)  E
        on A.KUNNR = E.E_KUNNER
        where A.BUKRS = :p_bukrs
        GROUP BY E.E_KUNNERT,B.PRCTRT,A.SEGMENT,A.KUNNR            
        ;

}
using LC.POC as my from '../db/data-model';

service CatalogService {
    @readonly entity Books as projection on my.Books;
    entity YEXCREDIT as projection on my.YEXCREDIT;
    entity YEXCREDITH as projection on my.YEXCREDITH;
    entity YCREDIT as projection on my.YCREDIT;
    entity YSECURITY as projection on my.YSECURITY;
    entity YCUSTMST as projection on my.YCUSTMST;
    entity YORG as projection on my.YORG;
    entity ZS4BSIDDAT as projection on my.ZS4BSIDDAT;
    entity S4BONDHST as projection on my.ZS4BSIDDAT;


    entity YCREDIT2 as
    select A.BUKRS,
            A.KUNNR,
            B.E_KUNNERT,
            A.KURISK,
            A.KURISKCL,
            A.KURISKCLT,
            A.KURISKT,
            A.KUSCO,
            A.KUSDATE,
            A.SECAT01,
            A.SECAT01T,
            A.KULIM_AMT,
            A.KUEDATE
    from my.YCREDIT A
    inner join ( select distinct E_KUNNER, E_KUNNERT from YEXCREDIT ) B 
    on A.KUNNR = B.E_KUNNER
    ;

    entity YCREDIT3 as
    select A.BUKRS,
            A.KUNNR,
            //B.KUNNRT,
            MAP(A.KUNNR,'1000135','씨제이대한통운비엔디','1000136','씨앤에스국제물류센터','1000137','비아이디씨',
                '1000138','CH컴퍼니','3000000','ABC Customer 02',
                'BP4310','㈜만도 코리아 (MDK)','USCU_L01','Skymart Corp / New york NY 10007','USCU_L02','Toys4U / Wilmington DE 19801',
                'USCU_L03','Viadox / Baltimore MD 21202','USCU_L04','Quotex / RALEIGH NC 27603','USCU_L05','Bluestar Corp / CHARLESTON SC 29401',
                'UNKNOWN') KUNNERT : String(50)
            ,A.KURISK,
            A.KURISKCL,
            A.KURISKCLT,
            A.KURISKT,
            A.KUSCO,
            A.KUSDATE,
            A.SECAT01,
            A.SECAT01T,
            A.KULIM_AMT,
            A.KUEDATE
    from my.YCREDIT A
    ;
    //inner join my.YCUSTMST B 
    //on A.KUNNR = B.KUNNR
    //;

 view Batchrt01(p_sdate : String(8))
 as select 
            A.SDATE,
            B.GROUP01T,     //본부
            B.PRCTRT        //손익센터
            ,MAP(A.SEGMENT,'Z_SEG2','서울','Z_SEG3','대전','1000_C','부산','UNKNOWN') AS SEGMENT : String(30)
            ,SUM (OVERDUE_CNT_0) AS OVDCNT01  : Integer
            ,SUM (OVERDUE_CNT_1) AS OVDCNT02  : Integer            
            ,SUM (OVERDUE_AMT_0) AS OVDAMT01  : Decimal(23,2)
            ,SUM (OVERDUE_AMT_1) AS OVDAMT02  : Decimal(23,2)
        from my.S4BONDHST A
        INNER JOIN my.YORG B
        on A.PRCTR = B.PRCTR
        where A.SDATE = :p_sdate
        GROUP BY A.SDATE,B.GROUP01T,B.PRCTRT,A.SEGMENT
        ;

//aggregation by PRCTRT, SEGMENT,KUNNR(KUNNRT)
view Batchrt01_1(p_sdate : String(8))
    as select 
              A.SDATE
             ,B.PRCTRT    //손익센터
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
        from my.S4BONDHST A
        INNER JOIN my.YORG B
            on A.PRCTR = B.PRCTR  
        LEFT OUTER JOIN my.YSECURITY C
            on A.KUNNR = C.KUNNR
            and A.BUKRS = C.BUKRS
        LEFT OUTER JOIN my.YCREDIT D
	        on A.KUNNR = D.KUNNR
	        and A.BUKRS = D.BUKRS
        LEFT OUTER JOIN my.YCUSTMST E
            on A.KUNNR = E.KUNNR
        Where A.SDATE = :p_sdate    
        GROUP BY  A.SDATE,E.KUNNRT,B.PRCTRT,A.SEGMENT,A.KUNNR
        ;

    view mastervw
    as select 
            PRCTR,
             KUNNR,
             BUKRS,
             GJAHR,
             BUDAT,
             BELNR,
             BUZEI,
             ZFBDT,
             ZBD1T,
             BLDAT,
             WRBTR,
             WAERS,
             DAYS_BETWEEN('20200201',BLDAT) AS DELAYDT : Integer
             ,CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) < '20200201' THEN WRBTR ELSE 0 END  PLAN_AMT : Decimal(23,2)
             ,CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > '20200201' AND DAYS_BETWEEN(BLDAT, '20200201') <= 30 THEN WRBTR ELSE 0 END overdue1_amt  : Decimal(23,2)
             ,CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > '20200201' AND DAYS_BETWEEN(BLDAT,'20200201') > 30  AND DAYS_BETWEEN(BLDAT,'20200201') <= 60 THEN WRBTR ELSE 0 END overdue2_amt  : Decimal(23,2)
             ,CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > '20200201' AND DAYS_BETWEEN(BLDAT,'20200201') > 60  AND DAYS_BETWEEN(BLDAT,'20200201') <= 90 THEN WRBTR ELSE 0 END overdue3_amt  : Decimal(23,2)
             ,CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > '20200201' AND DAYS_BETWEEN(BLDAT,'20200201') > 90  THEN WRBTR ELSE 0 END overdue4_amt  : Decimal(23,2)
             ,(
               CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > '20200201' AND DAYS_BETWEEN(BLDAT, '20200201') <= 30 THEN WRBTR ELSE 0 END
              + CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > '20200201' AND DAYS_BETWEEN(BLDAT,'20200201') > 30  AND DAYS_BETWEEN(BLDAT,'20200201') <= 60 THEN WRBTR ELSE 0 END
              + CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > '20200201' AND DAYS_BETWEEN(BLDAT,'20200201') > 60  AND DAYS_BETWEEN(BLDAT,'20200201') <= 90 THEN WRBTR ELSE 0 END
              + CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > '20200201' AND DAYS_BETWEEN(BLDAT,'20200201') > 90  THEN WRBTR ELSE 0 END
             ) as overdue_amt  : Decimal(23,2)

        from my.ZS4BSIDDAT A
        ;

//aggregation by PRCTRT, SEGMENT
 view Resultvw01
    as select 
            B.PRCTRT        //손익센터
             ,MAP(A.SEGMENT,'Z_SEG2','서울','Z_SEG3','대전','1000_C','부산','UNKNOWN') SEGMENT : String(30)
             ,SUM (
               CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > '20200201' AND DAYS_BETWEEN(A.BLDAT, '20200201') <= 30 THEN A.WRBTR ELSE 0 END
              + CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > '20200201' AND DAYS_BETWEEN(A.BLDAT,'20200201') > 30  AND DAYS_BETWEEN(A.BLDAT,'20200201') <= 60 THEN A.WRBTR ELSE 0 END
              + CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > '20200201' AND DAYS_BETWEEN(A.BLDAT,'20200201') > 60  AND DAYS_BETWEEN(A.BLDAT,'20200201') <= 90 THEN A.WRBTR ELSE 0 END
              + CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > '20200201' AND DAYS_BETWEEN(A.BLDAT,'20200201') > 90  THEN A.WRBTR ELSE 0 END
             ) as overdue_amt01  : Decimal(23,2)
              ,SUM (
               CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > '20200202' AND DAYS_BETWEEN(A.BLDAT, '20200202') <= 30 THEN A.WRBTR ELSE 0 END
              + CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > '20200202' AND DAYS_BETWEEN(A.BLDAT,'20200202') > 30  AND DAYS_BETWEEN(A.BLDAT,'20200202') <= 60 THEN A.WRBTR ELSE 0 END
              + CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > '20200202' AND DAYS_BETWEEN(A.BLDAT,'20200202') > 60  AND DAYS_BETWEEN(A.BLDAT,'20200202') <= 90 THEN A.WRBTR ELSE 0 END
              + CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > '20200202' AND DAYS_BETWEEN(A.BLDAT,'20200202') > 90  THEN A.WRBTR ELSE 0 END
             ) as overdue_amt02  : Decimal(23,2)
        from my.ZS4BSIDDAT A
        INNER JOIN my.YORG B
        on A.PRCTR = B.PRCTR
        GROUP BY B.PRCTRT,A.SEGMENT
        ;

//aggregation by PRCTRT, SEGMENT,KUNNR
 view Resultvw01_1
    as select 
            B.PRCTRT    //손익센터
             ,MAP(A.SEGMENT,'Z_SEG2','서울','Z_SEG3','대전','1000_C','부산','UNKNOWN') SEGMENT : String(30)
             ,A.KUNNR
             ,SUM(MAP(C.SECAT01,'INS',SEVAL_AMT,0) ) SEVAL_AMT01 : Decimal(23,2)    //담보-상업보험
             ,SUM(MAP(C.SECAT01,'REA',SEVAL_AMT,0) ) SEVAL_AMT02 : Decimal(23,2)    //담보-실담보
             ,SUM(D.KULIM_AMT) KULIM_AMT : Decimal(23,2)    //한도금액
             ,SUM(CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) < '20200201' THEN WRBTR ELSE 0 END)  PLAN_AMT : Decimal(23,2)
             ,SUM(CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > '20200201' AND DAYS_BETWEEN(BLDAT, '20200201') <= 30 THEN WRBTR ELSE 0 END) overdue1_amt  : Decimal(23,2)
             ,SUM(CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > '20200201' AND DAYS_BETWEEN(BLDAT,'20200201') > 30  AND DAYS_BETWEEN(BLDAT,'20200201') <= 60 THEN WRBTR ELSE 0 END) overdue2_amt  : Decimal(23,2)
             ,SUM(CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > '20200201' AND DAYS_BETWEEN(BLDAT,'20200201') > 60  AND DAYS_BETWEEN(BLDAT,'20200201') <= 90 THEN WRBTR ELSE 0 END) overdue3_amt  : Decimal(23,2)
             ,SUM(CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > '20200201' AND DAYS_BETWEEN(BLDAT,'20200201') > 90  THEN WRBTR ELSE 0 END) overdue4_amt  : Decimal(23,2)
             ,SUM (
               CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > '20200202' AND DAYS_BETWEEN(A.BLDAT, '20200202') <= 30 THEN A.WRBTR ELSE 0 END
              + CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > '20200202' AND DAYS_BETWEEN(A.BLDAT,'20200202') > 30  AND DAYS_BETWEEN(A.BLDAT,'20200202') <= 60 THEN A.WRBTR ELSE 0 END
              + CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > '20200202' AND DAYS_BETWEEN(A.BLDAT,'20200202') > 60  AND DAYS_BETWEEN(A.BLDAT,'20200202') <= 90 THEN A.WRBTR ELSE 0 END
              + CASE WHEN ADD_DAYS(A.ZFBDT, A.ZBD1T) > '20200202' AND DAYS_BETWEEN(A.BLDAT,'20200202') > 90  THEN A.WRBTR ELSE 0 END
             ) as overdue_amt : Decimal(23,2)
        from my.ZS4BSIDDAT A
        INNER JOIN my.YORG B
            on A.PRCTR = B.PRCTR
        LEFT OUTER JOIN my.YSECURITY C
            on A.KUNNR = C.KUNNR
            and A.BUKRS = C.BUKRS
        LEFT OUTER JOIN my.YCREDIT D
	        on A.KUNNR = D.KUNNR
	        and A.BUKRS = D.BUKRS
        GROUP BY B.PRCTRT,A.SEGMENT,A.KUNNR
        ;

view Resultvw02(p_bukrs: String(4), p_bldat: String(8))
    as select 
            PRCTR,
             KUNNR,
             BUKRS,
             GJAHR,
             BUDAT,
             BELNR,
             BUZEI,
             ZFBDT,
             ZBD1T,
             BLDAT,
             WRBTR,
             WAERS,
             DAYS_BETWEEN(BLDAT,:p_bldat) AS DELAYDT : Integer
             ,CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) < :p_bldat THEN WRBTR ELSE 0 END  PLAN_AMT : Decimal(23,2)
             ,CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > :p_bldat AND DAYS_BETWEEN(BLDAT, :p_bldat) <= 30 THEN WRBTR ELSE 0 END overdue1_amt  : Decimal(23,2)
             ,CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > :p_bldat AND DAYS_BETWEEN(BLDAT,:p_bldat) > 30  AND DAYS_BETWEEN(BLDAT,:p_bldat) <= 60 THEN WRBTR ELSE 0 END overdue2_amt  : Decimal(23,2)
             ,CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > :p_bldat AND DAYS_BETWEEN(BLDAT,:p_bldat) > 60  AND DAYS_BETWEEN(BLDAT,:p_bldat) <= 90 THEN WRBTR ELSE 0 END overdue3_amt  : Decimal(23,2)
             ,CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > :p_bldat AND DAYS_BETWEEN(BLDAT,:p_bldat) > 90  THEN WRBTR ELSE 0 END overdue4_amt  : Decimal(23,2)
             ,(
               CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > :p_bldat AND DAYS_BETWEEN(BLDAT, :p_bldat) <= 30 THEN WRBTR ELSE 0 END
              + CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > :p_bldat AND DAYS_BETWEEN(BLDAT,:p_bldat) > 30  AND DAYS_BETWEEN(BLDAT,:p_bldat) <= 60 THEN WRBTR ELSE 0 END
              + CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > :p_bldat AND DAYS_BETWEEN(BLDAT,:p_bldat) > 60  AND DAYS_BETWEEN(BLDAT,:p_bldat) <= 90 THEN WRBTR ELSE 0 END
              + CASE WHEN ADD_DAYS(ZFBDT, ZBD1T) > :p_bldat AND DAYS_BETWEEN(BLDAT,:p_bldat) > 90  THEN WRBTR ELSE 0 END
             ) as overdue_amt  : Decimal(23,2)
        from my.ZS4BSIDDAT A
        where BUKRS = :p_bukrs
        ;


}
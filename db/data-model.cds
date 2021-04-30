namespace LC.POC;

entity Books {
  key ID : Integer;
  title  : String;
  stock  : Integer;
}

entity YSECURITY {
key	KUNNR		: String(10);
key	BUKRS		: String(4);
key	SENUM		: String(3);
	SECAT01		: String(3);
	SECAT01T	: String(10);
	SECAT02		: String(5);
	SECAT02T	: String(10);
	SEDESCRIPT	: String(50);
	SEVAL_AMT	: Decimal(23,2);
	SESDATE		: DateTime;
	SEEDATE		: DateTime;
	USERID		: String(10);
	SYS_DATE	: DateTime;
	SYS_USER	: String(20);
}

entity YEXCREDIT {
key	E_CRID		: String(20);
key	E_CRACY		: String(5);
key	E_KUNNER	: String(10);
    E_KUNNERT : String(50);
	E_CRACYT	: String(50);
	E_KUNNERLD	: String(10);
	E_KUNNERLDT	: String(50);
	E_KUNNERSC	: String(10);
	E_KUNNERSCT	: String(50);
	E_CRGRN		: String(10);
	E_CRGCD		: String(10);
	E_CRGCDT	: String(50);
	E_CRRCD		: String(10);
	E_CRRCDT	: String(50);
	E_CRSCO		: String(10);
	E_CRSCOR	: String(10);
	E_CRSCORT	: String(50);
	E_CREVLDATE	: DateTime;
	E_CRSDATE	: DateTime;
	E_CREDATE	: DateTime;
	SYS_DATE	: DateTime;
	SYS_USER	: String(20);
    E_RISKNM    : String(10);
}

entity YEXCREDITH {
key	E_CRID		: String(20);
key	E_CRACY		: String(3);
key	E_KUNNR	: String(10);
key E_CRDT      : Date;
	E_CRACYT	: String(10);
	E_KUNNERLD	: String(10);
	E_KUNNERLDT	: String(50);
	E_KUNNERSC	: String(10);
	E_KUNNERSCT	: String(50);
	E_CRGRN		: String(3);
	E_CRGCD		: String(3);
	E_CRGCDT	: String(3);
	E_CRRCD		: String(3);
	E_CRRCDT	: String(3);
	E_CRSCO		: String(10);
	E_CRSCOR	: String(3);
	E_CRSCORT	: String(10);
	E_CREVLDATE	: DateTime;
	E_CRSDATE	: DateTime;
	E_CREDATE	: DateTime;
	SYS_DATE	: DateTime;
	SYS_USER	: String(20)
}


entity YCREDIT
{
	key KUNNR		: String(10);
	key BUKRS		: String(4);
	KUSCO		: String(3);
	KURISK		: String(1);
	KURISKT		: String(10);
	KURISKCL	: String(1);
	KURISKCLT	: String(10);
	SECAT01		: String(3);
	SECAT01T	: String(10);
	KULIM_AMT	: Decimal(23,2);
	KUSDATE		: DateTime;
	KUEDATE		: DateTime;
	USERID		: String(10);
	SYS_DATE	 : DateTime;
	SYS_USER	: String(10);
}

entity YORG {
	key PRCTR	: String(10);
	PRCTRT		: String(50);
	GROUP01	    : String(3);
	GROUP01T	: String(10);
	GROUP02	    : String(3);
	GROUP02T	: String(10);    
}


entity YCUSTMST {
    key	KUNNR	: String(10);
    KUNNRT : String(50);
	KUNNERLD	: String(10);
	KUNNERLDT	: String(50);
	E_KUNNERSC	: String(10);
	E_KUNNERSCT	: String(50);
}

entity ZS4BSIDDAT
{	 
	 key KUNNR : String(10)  ;
	 key BUKRS : String(4)  ;
	 key GJAHR : String(4)  ;
	 key BELNR : String(10)  ;
	 key BUZEI : String(3)  ;
	 BUDAT : String(8)  ;
	 PRCTR : String(10)  ;
	 SEGMENT : String(10)  ;
	 ZFBDT : String(8)  ;
	 ZBD1T : Integer;
	 BLDAT : String(8);
	 WAERS : String(5);
	 WRBTR : Decimal(23,2)
}

entity S4BONDHST
{	 
     key SDATE : Date ;
	 key KUNNR : String(10)  ;
	 key BUKRS : String(4)  ;
	 key GJAHR : String(4)  ;
	 key BELNR : String(10)  ;
	 key BUZEI : String(3)  ;
	 BUDAT : String(8)  ;
	 PRCTR : String(10)  ;
	 SEGMENT : String(10)  ;
	 ZFBDT : String(8)  ;
	 ZBD1T : Integer;
	 BLDAT : String(8);
	 WAERS : String(5);
	 WRBTR : Decimal(23,2);
     PLAN_AMT : Decimal(23,2);
     OVERDUE1_AMT : Decimal(23,2);
     OVERDUE2_AMT : Decimal(23,2);
     OVERDUE3_AMT : Decimal(23,2);
     OVERDUE4_AMT : Decimal(23,2);
     OVERDUE_AMT : Decimal(23,2);
     OVERDUE_AMT_0 : Decimal(23,2);
     OVERDUE_AMT_1 : Decimal(23,2);
     OVERDUE_CNT_0 : Integer;
     OVERDUE_CNT_1 : Integer;
}

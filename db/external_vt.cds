@cds.persistence.exists 
Entity ![YEXCREDIT_VT] {
 key    ![E_CRID]: String(20)  @title: 'E_CRID' ; 
key     ![E_CRACY]: String(5)  @title: 'E_CRACY' ; 
key     ![E_KUNNER]: String(10)  @title: 'E_KUNNER' ; 
        ![E_KUNNERT]: String(50)  @title: 'E_KUNNERT' ; 
        ![E_CRACYT]: String(50)  @title: 'E_CRACYT' ; 
        ![E_KUNNERLD]: String(10)  @title: 'E_KUNNERLD' ; 
        ![E_KUNNERLDT]: String(50)  @title: 'E_KUNNERLDT' ; 
        ![E_KUNNERSC]: String(10)  @title: 'E_KUNNERSC' ; 
        ![E_KUNNERSCT]: String(50)  @title: 'E_KUNNERSCT' ; 
        ![E_CRGRN]: String(10)  @title: 'E_CRGRN' ; 
        ![E_CRGCD]: String(10)  @title: 'E_CRGCD' ; 
        ![E_CRGCDT]: String(50)  @title: 'E_CRGCDT' ; 
        ![E_CRRCD]: String(10)  @title: 'E_CRRCD' ; 
        ![E_CRRCDT]: String(50)  @title: 'E_CRRCDT' ; 
        ![E_CRSCO]: String(10) not null  @title: 'E_CRSCO' ; 
        ![E_CRSCOR]: String(10)  @title: 'E_CRSCOR' ; 
        ![E_CRSCORT]: String(50)  @title: 'E_CRSCORT' ; 
        ![E_CREVLDATE]: Timestamp  @title: 'E_CREVLDATE' ; 
        ![E_CRSDATE]: Timestamp  @title: 'E_CRSDATE' ; 
        ![E_CREDATE]: Timestamp  @title: 'E_CREDATE' ; 
        ![SYS_DATE]: Timestamp  @title: 'SYS_DATE' ; 
        ![SYS_USER]: String(20)  @title: 'SYS_USER' ; 
        ![E_KUNNERLT]: String(1)  @title: 'E_KUNNERLT' ; 
}

@cds.persistence.exists 
Entity ![YCREDIT_VT] {
 key    ![KUNNR]: String(10)  @title: 'KUNNR' ; 
key     ![BUKRS]: String(4)  @title: 'BUKRS' ; 
        ![KUSCO]: String(3)  @title: 'KUSCO' ; 
        ![KURISK]: String(1)  @title: 'KURISK' ; 
        ![KURISKT]: String(10)  @title: 'KURISKT' ; 
        ![KURISKCL]: String(1)  @title: 'KURISKCL' ; 
        ![KURISKCLT]: String(10)  @title: 'KURISKCLT' ; 
        ![SECAT01T]: String(10)  @title: 'SECAT01T' ; 
        ![KULIM_AMT]: Decimal(23, 2)  @title: 'KULIM_AMT' ; 
        ![KUSDATE]: Timestamp  @title: 'KUSDATE' ; 
        ![KUEDATE]: Timestamp  @title: 'KUEDATE' ; 
        ![USERID]: String(100)  @title: 'USERID' ; 
        ![SYS_DATE]: Timestamp  @title: 'SYS_DATE' ; 
        ![SYS_USER]: String(100)  @title: 'SYS_USER' ; 
        ![SECAT01]: String(3)  @title: 'SECAT01' ; 
}

@cds.persistence.exists 
Entity ![YORG_VT] {
 key    ![PRCTR]: String(10)  @title: 'PRCTR' ; 
        ![PRCTRT]: String(50)  @title: 'PRCTRT' ; 
        ![GROUP01]: String(3)  @title: 'GROUP01' ; 
        ![GROUP01T]: String(10)  @title: 'GROUP01T' ; 
        ![GROUP02]: String(3)  @title: 'GROUP02' ; 
        ![GROUP02T]: String(10)  @title: 'GROUP02T' ; 
}

@cds.persistence.exists 
Entity ![YSECURITY_VT] {
 key    ![KUNNR]: String(10)  @title: 'KUNNR' ; 
        ![SECAT01]: String(3)  @title: 'SECAT01' ; 
        ![SECAT01T]: String(10)  @title: 'SECAT01T' ; 
        ![SECAT02]: String(5)  @title: 'SECAT02' ; 
        ![SECAT02T]: String(10)  @title: 'SECAT02T' ; 
        ![SEDESCRIPT]: String(50)  @title: 'SEDESCRIPT' ; 
        ![SEVAL_AMT]: Decimal(23, 2)  @title: 'SEVAL_AMT' ; 
        ![SESDATE]: Timestamp  @title: 'SESDATE' ; 
        ![SEEDATE]: Timestamp  @title: 'SEEDATE' ; 
        ![BUKRS]: String(4) not null  @title: 'BUKRS' ; 
        ![SENUM]: String(3) not null  @title: 'SENUM' ; 
        ![USERID]: String(10)  @title: 'USERID' ; 
        ![SYS_DATE]: Timestamp  @title: 'SYS_DATE' ; 
        ![SYS_USER]: String(20)  @title: 'SYS_USER' ; 
}

@cds.persistence.exists 
Entity ![ZS4BSIDRT01_VT] {
        ![PRCTR]: String(10) not null  @title: 'PRCTR' ; 
        ![KUNNR]: String(10)  @title: 'KUNNR' ; 
        ![BUKRS]: String(4) not null  @title: 'BUKRS' ; 
        ![GJAHR]: String(4) not null  @title: 'GJAHR' ; 
        ![BUDAT]: String(8) not null  @title: 'BUDAT' ; 
        ![BELNR]: String(10) not null  @title: 'BELNR' ; 
        ![BUZEI]: String(3) not null  @title: 'BUZEI' ; 
        ![SEGMENT]: String(10) not null  @title: 'SEGMENT' ; 
        ![ZFBDT]: String(8) not null  @title: 'ZFBDT' ; 
        ![ZBD1T]: Decimal(3,0) not null  @title: 'ZBD1T' ; 
        ![BLDAT]: String(8) not null  @title: 'BLDAT' ; 
        ![WAERS]: String(5) not null  @title: 'WAERS' ; 
        ![WRBTR]: Decimal(23, 2) not null  @title: 'WRBTR' ; 
}

@cds.persistence.exists 
Entity ![S4BONDVW01_VT2] {
        ![PRCTR]: String(10) not null  @title: 'PRCTR' ; 
        ![KUNNR]: String(10)  @title: 'KUNNR' ; 
        ![BUKRS]: String(4) not null  @title: 'BUKRS' ; 
        ![GJAHR]: String(4) not null  @title: 'GJAHR' ; 
        ![BUDAT]: String(8) not null  @title: 'BUDAT' ; 
        ![BELNR]: String(10) not null  @title: 'BELNR' ; 
        ![BUZEI]: String(3) not null  @title: 'BUZEI' ; 
        ![SEGMENT]: String(10) not null  @title: 'SEGMENT' ; 
        ![ZFBDT]: String(8) not null  @title: 'ZFBDT' ; 
        ![ZBD1T]: Decimal(3) not null  @title: 'ZBD1T' ; 
        ![BLDAT]: String(8) not null  @title: 'BLDAT' ; 
        ![WAERS]: String(5) not null  @title: 'WAERS' ; 
        ![WRBTR]: Decimal(23, 2) not null  @title: 'WRBTR' ; 
        ![PLAN_AMT]: Decimal(23, 2) not null  @title: 'PLAN_AMT' ; 
        ![OVERDUE1_AMT]: Decimal(23, 2) not null  @title: 'OVERDUE1_AMT' ; 
        ![OVERDUE2_AMT]: Decimal(23, 2) not null  @title: 'OVERDUE2_AMT' ; 
        ![OVERDUE3_AMT]: Decimal(23, 2) not null  @title: 'OVERDUE3_AMT' ; 
        ![OVERDUE4_AMT]: Decimal(23, 2) not null  @title: 'OVERDUE4_AMT' ; 
        ![OVERDUE_AMT]: Decimal(23, 2) not null  @title: 'OVERDUE_AMT' ; 
        ![OVERDUE_AMT_0]: Decimal(23, 2) not null  @title: 'OVERDUE_AMT_0' ; 
        ![OVERDUE_AMT_1]: Decimal(23, 2) not null  @title: 'OVERDUE_AMT_1' ; 
        ![OVERDUE_CNT_0]: Integer not null  @title: 'OVERDUE_CNT_0' ; 
        ![OVERDUE_CNT_1]: Integer not null  @title: 'OVERDUE_CNT_1' ; 
}

/*
@cds.persistence.exists 
Entity ![S4BONDVW01_VT] {
        ![PRCTR]: String(10) not null  @title: 'PRCTR' ; 
        ![KUNNR]: String(10)  @title: 'KUNNR' ; 
        ![BUKRS]: String(4) not null  @title: 'BUKRS' ; 
        ![GJAHR]: String(4) not null  @title: 'GJAHR' ; 
        ![BUDAT]: String(8) not null  @title: 'BUDAT' ; 
        ![BELNR]: String(10) not null  @title: 'BELNR' ; 
        ![BUZEI]: String(3) not null  @title: 'BUZEI' ; 
        ![SEGMENT]: String(10) not null  @title: 'SEGMENT' ; 
        ![ZFBDT]: String(8) not null  @title: 'ZFBDT' ; 
        ![ZBD1T]: Decimal(3) not null  @title: 'ZBD1T' ; 
        ![BLDAT]: String(8) not null  @title: 'BLDAT' ; 
        ![WAERS]: String(5) not null  @title: 'WAERS' ; 
        ![WRBTR]: Decimal(23, 2) not null  @title: 'WRBTR' ; 
        ![PLAN_AMT]: Decimal(23, 2) not null  @title: 'PLAN_AMT' ; 
        ![OVERDUE1_AMT]: Decimal(23, 2) not null  @title: 'OVERDUE1_AMT' ; 
        ![OVERDUE2_AMT]: Decimal(23, 2) not null  @title: 'OVERDUE2_AMT' ; 
        ![OVERDUE3_AMT]: Decimal(23, 2) not null  @title: 'OVERDUE3_AMT' ; 
        ![OVERDUE4_AMT]: Decimal(23, 2) not null  @title: 'OVERDUE4_AMT' ; 
        ![OVERDUE_AMT]: Decimal(26, 2)  @title: 'OVERDUE_AMT' ; 
       
}*/ 
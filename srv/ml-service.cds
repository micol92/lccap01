using LC.POC as my from '../db/ml-model';

service CatalogServiceML {
    entity CENSUS as projection on my.CENSUS;
    entity CENSUS_CLASSIFICATION_CONTRIBUTION as projection on my.CENSUS_CLASSIFICATION_CONTRIBUTION;
    entity CENSUS_TEST_APPLY_RESULT as projection on my.CENSUS_TEST_APPLY_RESULT;

view MLRt03 as
select A.AGE, A.EDULEVEL, A.MARRIAGE,A.ROLEINH,A.GENDER,A.WORKHOUR, BB.PREDICTED, ROUND(BB.GB_PROBA_SEARN*100,2) SEARN_PCT : Decimal(4,2)
from my.CENSUS A
inner join my.CENSUS_TEST_APPLY_RESULT BB
on A.CUSTNO = BB.CUSTNO
order by SEARN_PCT desc
;

view MLRt04 as
select * from my.CENSUS_CLASSIFICATION_CONTRIBUTION
;

}
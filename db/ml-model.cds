namespace LC.POC;

entity CENSUS {
  key CUSTNO : Integer;
  AGE  : Double;
  JOBCATE  : String(255);
  WEIGHT : Double;
  EDULEVEL : String(255);
  EDUTERM : Double;
  MARRIAGE : String(255);
  JOB : String(255);
  ROLEINH : String(255);
  RACE : String(255);
  GENDER : String(255);
  PROFIT : Double;
  LOSS : Double;
  WORKHOUR : Double;
  NATION : String(255);
  SEARN : Double;
}

entity CENSUS_CLASSIFICATION_CONTRIBUTION {
    key VARIABLE : String(5000);
    CONTRIBUTION : Double;
}

entity CENSUS_TEST_APPLY_RESULT {
    key CUSTNO : Integer;
    TRUE_LABEL : Double;
    PREDICTED : Double;
    GB_PROBA_SEARN : Double;
}
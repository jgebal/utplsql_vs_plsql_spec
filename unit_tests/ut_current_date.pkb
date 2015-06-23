CREATE OR REPLACE PACKAGE BODY ut_current_date
IS
  PROCEDURE ut_setup
  IS
    BEGIN
      NULL;
    END;

  PROCEDURE ut_teardown
  IS
    BEGIN
      NULL;
    END;

  PROCEDURE ut_current_date
  IS
    BEGIN
      utAssert.eq ( 'sum_two_numbers returns 10 for arguments 5 and 5', current_date_(SYSDATE), TRUNC(SYSDATE) );
    END;

END ut_current_date;
/

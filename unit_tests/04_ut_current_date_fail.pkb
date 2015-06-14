CREATE OR REPLACE PACKAGE BODY ut_current_date_fail
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

  PROCEDURE ut_current_date_fail
  IS
    test_date DATE;
    BEGIN
      test_date := current_date_fail(SYSDATE);
      utAssert.eq ( 'returns a truncated date', test_date, TRUNC(SYSDATE) );
    END;

END ut_current_date_fail;
/

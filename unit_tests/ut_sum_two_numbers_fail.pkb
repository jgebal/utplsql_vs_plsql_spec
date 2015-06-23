CREATE OR REPLACE PACKAGE BODY ut_sum_two_numbers_fail
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

  PROCEDURE ut_sum_two_numbers_fail
  IS
    BEGIN
      utAssert.eq ( 'sum_two_numbers returns 10 for arguments 5 and 5', sum_two_numbers(5,5), 10 );
    END;

END ut_sum_two_numbers_fail;
/

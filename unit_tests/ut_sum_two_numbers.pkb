CREATE OR REPLACE PACKAGE BODY ut_sum_two_numbers
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

  PROCEDURE ut_sum_two_numbers
  IS
    BEGIN
      utAssert.eq ( 'sum_two_numbers returns 10 for arguments 5 and 5', sum_two_numbers(5,5), 10 );
    END;

  PROCEDURE ut_sum_two_numbers_100_times
  IS
    BEGIN
      FOR i IN 1 .. 100 LOOP
        utAssert.eq ( 'sum_two_numbers returns '||(i+10)||' for arguments '||i||' and 10', sum_two_numbers(i,10), (i+10) );
      END LOOP;
    END;

END ut_sum_two_numbers;
/

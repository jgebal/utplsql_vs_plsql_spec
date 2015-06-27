CREATE OR REPLACE PACKAGE ut_sum_two_numbers
IS
  PROCEDURE ut_setup;
  PROCEDURE ut_teardown;

  PROCEDURE ut_sum_two_numbers;
  PROCEDURE ut_sum_two_numbers_100_times;
END ut_sum_two_numbers;
/

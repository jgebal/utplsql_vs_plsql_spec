CREATE OR REPLACE PACKAGE ut_current_date
IS
  PROCEDURE ut_setup;
  PROCEDURE ut_teardown;

  PROCEDURE ut_current_date;
END ut_current_date;
/

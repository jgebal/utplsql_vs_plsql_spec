CREATE OR REPLACE PACKAGE ut_some_table_api IS
  PROCEDURE ut_setup;
  PROCEDURE ut_teardown;

  PROCEDURE ut_get_cust_no_fixed_types;

  PROCEDURE ut_get_cust_valid_fixed_types;

  PROCEDURE ut_get_cust_no_inheritance;

  PROCEDURE ut_get_cust_valid_inheritance;

END;
/

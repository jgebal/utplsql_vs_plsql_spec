CREATE OR REPLACE PACKAGE ut_some_table_api_new IS

  PROCEDURE ut_setup;

  PROCEDURE ut_teardown;

  PROCEDURE ut_add_customer;
  PROCEDURE ut_add_customer_fail_id;
  PROCEDURE ut_add_customer_fail_no;

END;
/

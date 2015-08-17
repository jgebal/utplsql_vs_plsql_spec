CREATE OR REPLACE PACKAGE some_table_api AS

  FUNCTION get_customer_no(
    p_customer_id customers.customer_id%TYPE
  ) RETURN customers.customer_no%TYPE;
  FUNCTION get_customer_valid_flag(
    p_customer_id customers.customer_id%TYPE
  ) RETURN customers.customer_valid_flag%TYPE;
  PROCEDURE add_customer(
    p_customer_id         customers.customer_id%TYPE,
    p_customer_no         customers.customer_no%TYPE,
    p_customer_valid_flag customers.customer_valid_flag%TYPE
  );
END some_table_api;
/

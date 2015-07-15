CREATE OR REPLACE PACKAGE BODY some_table_api AS

  FUNCTION get_customer_no(
    p_customer_id customers.customer_id%TYPE
  ) RETURN customers.customer_no%TYPE IS
    v_result customers.customer_no%TYPE;
    BEGIN
      SELECT c.customer_no INTO v_result
        FROM customers c  WHERE c.customer_id = p_customer_id;

      RETURN v_result;
    END;

  FUNCTION get_customer_valid_flag(
    p_customer_id customers.customer_id%TYPE
  ) RETURN customers.customer_valid_flag%TYPE IS
    v_result customers.customer_valid_flag%TYPE;
    BEGIN
      SELECT c.customer_valid_flag INTO v_result
      FROM customers c WHERE c.customer_id = p_customer_id;

      RETURN v_result;
    END;

END some_table_api;
/

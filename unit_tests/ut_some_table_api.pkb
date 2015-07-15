CREATE OR REPLACE PACKAGE BODY ut_some_table_api IS
  PROCEDURE ut_setup IS
    BEGIN
      INSERT INTO customers
              ( customer_id, customer_no, customer_valid_flag )
       VALUES ( -1, 12345678, '1' );
    END;

  PROCEDURE ut_teardown IS
    BEGIN
      NULL;
    END;

  PROCEDURE ut_get_cust_no_fixed_types IS
    v_result NUMBER;
    BEGIN
      v_result := some_table_api.get_customer_no(-1);
      utAssert.eq ( 'returns expected customer number', v_result, 12345678 );
    END;

  PROCEDURE ut_get_cust_valid_fixed_types IS
    v_result VARCHAR2(1);
    BEGIN
      v_result := some_table_api.get_customer_valid_flag(-1);
      utAssert.eq ('returns expected customer validity flag', v_result, '1' );
    END;

  PROCEDURE ut_get_cust_no_inheritance IS
    BEGIN
      utAssert.eq ( 'returns expected customer number', some_table_api.get_customer_no(-1), 12345678 );
    END;

  PROCEDURE ut_get_cust_valid_inheritance IS
    BEGIN
      utAssert.eq ( 'returns expected customer number', some_table_api.get_customer_valid_flag(-1), '1' );
    END;

END;
/

CREATE OR REPLACE PACKAGE BODY ut_some_table_api_new IS
  PROCEDURE ut_setup IS
    BEGIN
      NULL;
    END;

  PROCEDURE ut_teardown IS
    BEGIN
      ROLLBACK;
    END;

  FUNCTION count_customers( p_customer_id INTEGER, p_customer_no INTEGER ) RETURN INTEGER IS
    v_row_count   INTEGER;
    BEGIN
      SELECT COUNT(1) INTO v_row_count FROM customers
       WHERE customer_id = p_customer_id OR customer_no = p_customer_no;
      RETURN v_row_count;
    END;

  PROCEDURE ut_add_customer IS
      v_customer_id INTEGER := -1;
      v_customer_no INTEGER := 1234;
    BEGIN
      utAssert.eq ( 'GIVEN customer does not exist', count_customers( v_customer_id, v_customer_no ), 0 );

      some_table_api.add_customer( v_customer_id, v_customer_no, '1' );

      utAssert.eq ( 'THEN customer is added', count_customers( v_customer_id, v_customer_no ), 1 );
      ROLLBACK;
    END;

  PROCEDURE ut_add_customer_fail_id IS
    v_customer_id INTEGER := -1;
    v_customer_no INTEGER := 1234;
    BEGIN
      utAssert.eq ( 'GIVEN customer does not exist', count_customers( v_customer_id, v_customer_no ), 0 );

      some_table_api.add_customer( v_customer_id, v_customer_no, '1' );
      utAssert.eq ( 'WHEN customer is added', count_customers( v_customer_id, v_customer_no ), 1 );

      utAssert.throws('THEN the add_customer fails on the same CUSTOMER_ID'
                    ,'some_table_api.add_customer( '||v_customer_id||', '||(v_customer_no+1)||', ''1'' )'
                    ,'DUP_VAL_ON_INDEX');
      ROLLBACK;
    END;

  PROCEDURE ut_add_customer_fail_no IS
      v_customer_id INTEGER := -1;
      v_customer_no INTEGER := 1234;
    BEGIN
      utAssert.eq ( 'GIVEN customer does not exist', count_customers( v_customer_id, v_customer_no ), 0 );

      some_table_api.add_customer( v_customer_id, v_customer_no, '1' );
      utAssert.eq ( 'WHEN customer is added', count_customers( v_customer_id, v_customer_no ), 1 );

      utAssert.throws('THEN the add_customer fails on the same CUSTOMER_NO'
      ,'some_table_api.add_customer( '||(v_customer_id-1)||', '||v_customer_no||', ''1'' )'
      ,-1);
      ROLLBACK;
    END;
END;
/

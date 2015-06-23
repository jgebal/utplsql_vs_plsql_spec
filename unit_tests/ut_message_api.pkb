CREATE OR REPLACE PACKAGE BODY ut_message_api IS
  PROCEDURE ut_setup IS
    BEGIN
      NULL;
    END;

  PROCEDURE ut_teardown IS
    BEGIN
      NULL;
    END;

  PROCEDURE ut_send_receive_msg IS
    l_num  NUMBER;
    l_txt  VARCHAR2(32767);
    l_date DATE;
    l_num_expected  NUMBER;
    l_txt_expected  VARCHAR2(32767);
    l_date_expected DATE;
    BEGIN
      l_num_expected := 1;
      l_txt_expected := 'a message';
      l_date_expected := TRUNC( SYSDATE );

      message_api.send_msg( l_num_expected, l_txt_expected, l_date_expected );

      message_api.receive_msg( l_num, l_txt, l_date );

      utAssert.eq ( 'when I send a message and receive it then I get a valid message number', l_num, l_num_expected );
      utAssert.eq ( 'and I get a valid message date', l_date, l_date_expected );
      utAssert.eq ( 'and I get a valid message text', l_txt, l_txt_expected );
    END;

END;
/

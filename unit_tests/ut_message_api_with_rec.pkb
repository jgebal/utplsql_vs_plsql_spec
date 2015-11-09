CREATE OR REPLACE PACKAGE BODY ut_message_api_with_rec IS
  PROCEDURE ut_setup IS
    BEGIN
      NULL;
    END;

  PROCEDURE ut_teardown IS
    BEGIN
      NULL;
    END;

  PROCEDURE ut_send_receive_msg IS
    l_msg_sent      msg_rec;
    l_msg_received  msg_rec;
    BEGIN
      l_msg_sent.msg_number := 1;
      l_msg_sent.msg_text   := 'a message';
      l_msg_sent.msg_date   := TRUNC( SYSDATE );

      message_api.send_msg( l_msg_sent );
      utAssert.eq ( 'Given: a message is sent',true);

      l_msg_received := message_api.receive_msg();
      utAssert.eq ( 'When: a message is recieved',true);

      utAssert.eq ( 'Then the received message contains the same number', l_msg_sent.msg_number, l_msg_received.msg_number);
      utAssert.eq ( ' and the received message contains the same date',   l_msg_sent.msg_text  , l_msg_received.msg_text  );
      utAssert.eq ( ' and the received message contains the same text',   l_msg_sent.msg_date  , l_msg_received.msg_date  );
    END;

END;
/

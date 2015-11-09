CREATE OR REPLACE PACKAGE ut_message_api_with_rec IS
  PROCEDURE ut_setup;
  PROCEDURE ut_teardown;

  PROCEDURE ut_send_receive_msg;
END;
/

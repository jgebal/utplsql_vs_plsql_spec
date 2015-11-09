CREATE OR REPLACE PACKAGE BODY message_api_with_rec IS
  --Source from https://oracle-base.com/articles/misc/dbms_pipe
  PROCEDURE send_msg ( p_msg msg_rec ) IS
    l_status  NUMBER;
    BEGIN
      DBMS_PIPE.pack_message(p_msg.msg_number);
      DBMS_PIPE.pack_message(p_msg.msg_text);
      DBMS_PIPE.pack_message(p_msg.msg_date);

      l_status := DBMS_PIPE.send_message('message_pipe');
      IF l_status != 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'message_pipe error');
      END IF;
    END;

  FUNCTION receive_msg RETURN msg_rec IS
    l_result  INTEGER;
    l_msg     msg_rec;
    BEGIN
      l_result := DBMS_PIPE.receive_message ( pipename => 'message_pipe', timeout  => DBMS_PIPE.maxwait );
      IF l_result = 0 THEN
        -- Message received successfully.
        DBMS_PIPE.unpack_message(l_msg.msg_number);
        DBMS_PIPE.unpack_message(l_msg.msg_text);
        DBMS_PIPE.unpack_message(l_msg.msg_date);
      ELSE
        RAISE_APPLICATION_ERROR(-20002, 'message_api.receive was unsuccessful. Return result: ' || l_result);
      END IF;
      RETURN l_msg;
    END;

END message_api_with_rec;
/

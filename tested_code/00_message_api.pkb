CREATE OR REPLACE PACKAGE BODY message_api AS
  --Source from https://oracle-base.com/articles/misc/dbms_pipe
  PROCEDURE send_msg (p_number  IN  NUMBER,
                  p_text    IN  VARCHAR2,
                  p_date    IN  DATE DEFAULT SYSDATE) AS
    l_status  NUMBER;
    BEGIN
      DBMS_PIPE.pack_message(p_number);
      DBMS_PIPE.pack_message(p_text);
      DBMS_PIPE.pack_message(p_date);

      l_status := DBMS_PIPE.send_message('message_pipe');
      IF l_status != 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'message_pipe error');
      END IF;
    END;

  PROCEDURE receive_msg (p_number  OUT  NUMBER,
                     p_text    OUT  VARCHAR2,
                     p_date    OUT  DATE) AS
    l_result  INTEGER;
    BEGIN
      l_result := DBMS_PIPE.receive_message (
          pipename => 'message_pipe',
          timeout  => DBMS_PIPE.maxwait);

      IF l_result = 0 THEN
        -- Message received successfully.
        DBMS_PIPE.unpack_message(p_number);
        DBMS_PIPE.unpack_message(p_text);
        DBMS_PIPE.unpack_message(p_date);

      ELSE
        RAISE_APPLICATION_ERROR(-20002, 'message_api.receive was unsuccessful. Return result: ' || l_result);
      END IF;
    END;

END message_api;
/

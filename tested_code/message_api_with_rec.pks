CREATE OR REPLACE PACKAGE message_api_with_rec AS
  --Source from https://oracle-base.com/articles/misc/dbms_pipe
  TYPE msg_rec IS RECORD
  (
    msg_number  NUMBER,
    msg_text    VARCHAR2(32767),
    msg_date    DATE DEFAULT SYSDATE
  );

  PROCEDURE send_msg ( p_msg msg_rec );

  FUNCTION receive_msg RETURN msg_rec;

END message_api_with_rec;
/

GRANT EXECUTE ON message_api_with_rec TO PUBLIC;
CREATE OR REPLACE PUBLIC SYNONYM message_api_with_rec FOR message_api_with_rec;

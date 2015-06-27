CREATE OR REPLACE PACKAGE message_api AS
  --Source from https://oracle-base.com/articles/misc/dbms_pipe
  PROCEDURE send_msg (
    p_number  IN  NUMBER,
    p_text    IN  VARCHAR2,
    p_date    IN  DATE DEFAULT SYSDATE);
  PROCEDURE receive_msg (
    p_number  OUT  NUMBER,
    p_text    OUT  VARCHAR2,
    p_date    OUT  DATE,
    p_received_on OUT TIMESTAMP);
END message_api;
/

GRANT EXECUTE ON message_api TO PUBLIC;
CREATE OR REPLACE PUBLIC SYNONYM message_api FOR message_api;


CREATE OR REPLACE PACKAGE message_api AS
  --Source from https://oracle-base.com/articles/misc/dbms_pipe
  PROCEDURE send_msg (p_number  IN  NUMBER,
                  p_text    IN  VARCHAR2,
                  p_date    IN  DATE DEFAULT SYSDATE);
  PROCEDURE receive_msg (p_number  OUT  NUMBER,
                     p_text    OUT  VARCHAR2,
                     p_date    OUT  DATE);
END message_api;
/


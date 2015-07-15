DROP TABLE customers;

CREATE TABLE customers (
  customer_id NUMBER,
  customer_no NUMBER(10,0),
  customer_valid_flag VARCHAR2(1),
  CONSTRAINT chk_valid_flag CHECK (customer_valid_flag IN ('0','1'))
);

INSERT INTO customers VALUES (1, 123, '1');

INSERT INTO customers VALUES (2, 234, '0');

COMMIT;

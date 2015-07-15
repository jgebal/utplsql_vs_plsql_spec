CREATE TABLE customers_new (
  customer_id NUMBER,
  customer_no VARCHAR2(30),
  customer_valid_flag NUMBER(1,0)
);

INSERT INTO customers_new SELECT * FROM customers;

DROP TABLE customers;

RENAME customers_new TO customers;

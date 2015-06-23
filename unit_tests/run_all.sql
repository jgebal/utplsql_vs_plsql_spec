BEGIN
  utplsql.test('sum_two_numbers');
  utplsql.test('sum_two_numbers_fail');
  utplsql.test('current_date');
  utplsql.test('current_date_fail');
END;
/

BEGIN
  utConfig.autocompile(false);
  utConfig.setFileDir('/tmp');
  utplsql.test('message_api');
END;
/

BEGIN
  utplsql.test('sum_two_numbers', recompile_in => FALSE);
  utplsql.test('sum_two_numbers_fail', recompile_in => FALSE);
  utplsql.test('current_date', recompile_in => FALSE);
  utplsql.test('current_date_fail', recompile_in => FALSE);
END;
/

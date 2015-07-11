SET SERVEROUTPUT ON
BEGIN
  utplsql.test('message_api');
END;
/

SET SERVEROUTPUT ON
BEGIN
  utConfig.autocompile(false);
  utplsql.test('message_api');
END;
/

SET SERVEROUTPUT ON
BEGIN
  utConfig.autocompile(false);
  utConfig.setreporter('HTML');
  utConfig.setFileDir('/tmp');
  utplsql.test('message_api');
END;
/

SET SERVEROUTPUT ON
BEGIN
  utConfig.autocompile(false);
  utConfig.setreporter(NULL);
  utplsql.test('sum_two_numbers');
END;
/

BEGIN
  utplsql.test('sum_two_numbers');
  utplsql.test('sum_two_numbers_fail');
  utplsql.test('current_date');
  utplsql.test('current_date_fail');
  utplsql.test('message_api');
END;
/

BEGIN
  utsuite.add('all');
  utpackage.add('all','sum_two_numbers');
  utpackage.add('all','sum_two_numbers_fail');
  utpackage.add('all','current_date');
  utpackage.add('all','current_date_fail');
  utpackage.add('all','message_api');
END;
/


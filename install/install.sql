connect sys/oracle@xe as sysdba
@create_user utp
grant execute on dbms_pipe to utp;
grant execute on utl_file to utp;

@create_user tdd_test1
@create_user tdd_test2

host cd "../utplsql-2-3-0"
connect utp/utp@xe
@"../utplsql-2-3-0/code/ut_i_do" install


create user &1 identified by &1 default tablespace
  users temporary tablespace temp;

grant create session, create table, create procedure,
create sequence, create view, create public synonym, select any dictionary,
create any procedure, drop public synonym to &1;

alter user &1 quota unlimited on users;


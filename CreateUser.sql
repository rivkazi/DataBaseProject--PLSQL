alter session set "_ORACLE_SCRIPT"=true;  
create user rivka --user name
IDENTIFIED BY rivka    --passward
default tablespace SYSTEM
temporary tablespace TEMP
profile DEFAULT
password expire;

grant create session to rivka; 
grant create table to rivka; 
grant unlimited tablespace to rivka;
grant create view , create procedure , create sequence to rivka;
ALTER USER rivka quota unlimited on SYSTEM;

grant debug connect session to rivka;
grant debug any procedure to rivka;
grant create trigger to rivka;
grant create any trigger to rivka;

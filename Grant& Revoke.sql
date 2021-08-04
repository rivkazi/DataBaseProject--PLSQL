--יצירת משתמש
alter session set "_ORACLE_SCRIPT"=true;  
create user shiri --user name
IDENTIFIED BY shiri  --passward
default tablespace system
temporary tablespace TEMP
profile DEFAULT
password expire;

Grant create session to shiri; 


Grant Select, update, insert on person0 to shiri;
Revoke insert on person0 from shiri;
Revoke update on person0 from shiri;

Grant Select, update on psychometric to shiri;
Revoke select on psychometric from shiri;





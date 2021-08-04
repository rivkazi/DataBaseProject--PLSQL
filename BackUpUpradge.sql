prompt PL/SQL Developer Export Tables for user SYS@XE
prompt Created by zizovirivka on יום שני 08 מרץ 2021
set feedback off
set define off

prompt Creating ADRESS...
create table ADRESS
(
  adressid INTEGER not null,
  country  VARCHAR2(20) not null,
  city     VARCHAR2(20) not null,
  street   VARCHAR2(30)
)
;
alter table ADRESS
  add primary key (ADRESSID)
  using index 
 ;

prompt Creating COMPANY...
create table COMPANY
(
  companyid      INTEGER not null,
  companyname    VARCHAR2(40) not null,
  foundationdate DATE not null,
  compantstatus  VARCHAR2(20) not null
)
;
alter table COMPANY
  add primary key (COMPANYID)
  using index 
  ;

prompt Creating PERSON...
create table PERSON
(
  personid    VARCHAR2(20) not null,
  firstname   VARCHAR2(20) not null,
  lastname    VARCHAR2(20) not null,
  birthdate   DATE not null,
  phonenumber VARCHAR2(20) not null,
  email       NVARCHAR2(35) not null,
  adressid    INTEGER not null
)
;
alter table PERSON
  add primary key (PERSONID)
  using index 
  ;
alter table PERSON
  add foreign key (ADRESSID)
  references ADRESS (ADRESSID);

prompt Creating GUIDE...
create table GUIDE
(
  gpersonid      VARCHAR2(20) not null,
  grole          VARCHAR2(20) not null,
  experience     INTEGER not null,
  specialization VARCHAR2(35) not null
)
;
alter table GUIDE
  add primary key (GPERSONID)
  using index 
  ;
alter table GUIDE
  add foreign key (GPERSONID)
  references PERSON (PERSONID);

prompt Creating STUDENT...
create table STUDENT
(
  spersonid      VARCHAR2(20) not null,
  sdegree        VARCHAR2(30) not null,
  specialization VARCHAR2(20) not null,
  academicyear   VARCHAR2(20) not null,
  workexperience INTEGER not null
)
;
alter table STUDENT
  add primary key (SPERSONID)
  using index 
  ;
alter table STUDENT
  add foreign key (SPERSONID)
  references PERSON (PERSONID);

prompt Creating CONSULTING...
create table CONSULTING
(
  consultid     INTEGER not null,
  gpersonid     VARCHAR2(20) not null,
  spersonid     VARCHAR2(20) not null,
  receptiontime VARCHAR2(20) not null,
  contactemail  VARCHAR2(35) not null
)
;
alter table CONSULTING
  add primary key (CONSULTID)
  using index 
  ;
alter table CONSULTING
  add unique (GPERSONID, SPERSONID)
  using index 
  ;
alter table CONSULTING
  add foreign key (GPERSONID)
  references GUIDE (GPERSONID);
alter table CONSULTING
  add foreign key (SPERSONID)
  references STUDENT (SPERSONID);

prompt Creating OPENDAYS...
create table OPENDAYS
(
  opendayid       INTEGER not null,
  numparticipants INTEGER not null,
  o_day           INTEGER not null,
  o_month         INTEGER not null,
  o_hour          VARCHAR2(20) not null
)
;
alter table OPENDAYS
  add primary key (OPENDAYID)
  using index 
  ;

prompt Creating GUESTLECTURES...
create table GUESTLECTURES
(
  lectureid       INTEGER not null,
  opendayid       INTEGER not null,
  subject         VARCHAR2(30) not null,
  lecturelocation VARCHAR2(20) not null
)
;
alter table GUESTLECTURES
  add primary key (LECTUREID, OPENDAYID)
  using index 
  ;
alter table GUESTLECTURES
  add foreign key (OPENDAYID)
  references OPENDAYS (OPENDAYID);

prompt Creating LOCATEDAT...
create table LOCATEDAT
(
  companyid INTEGER not null,
  adressid  INTEGER not null
)
;
alter table LOCATEDAT
  add primary key (COMPANYID, ADRESSID)
  using index 
  ;
alter table LOCATEDAT
  add foreign key (COMPANYID)
  references COMPANY (COMPANYID);
alter table LOCATEDAT
  add foreign key (ADRESSID)
  references ADRESS (ADRESSID);

prompt Creating PARTICIPANTIN...
create table PARTICIPANTIN
(
  personid  VARCHAR2(20) not null,
  opendayid INTEGER not null
)
;
alter table PARTICIPANTIN
  add primary key (PERSONID, OPENDAYID)
  using index 
  ;
alter table PARTICIPANTIN
  add foreign key (PERSONID)
  references STUDENT (SPERSONID);
alter table PARTICIPANTIN
  add foreign key (OPENDAYID)
  references OPENDAYS (OPENDAYID);

prompt Creating TOURAT...
create table TOURAT
(
  tourid    INTEGER not null,
  companyid INTEGER not null,
  opendayid INTEGER not null
)
;
alter table TOURAT
  add primary key (TOURID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TOURAT
  add unique (COMPANYID, OPENDAYID)
  using index 
  ;
alter table TOURAT
  add foreign key (COMPANYID)
  references COMPANY (COMPANYID);
alter table TOURAT
  add foreign key (OPENDAYID)
  references OPENDAYS (OPENDAYID);

prompt Disabling triggers for ADRESS...
alter table ADRESS disable all triggers;
prompt Disabling triggers for COMPANY...
alter table COMPANY disable all triggers;
prompt Disabling triggers for PERSON...
alter table PERSON disable all triggers;
prompt Disabling triggers for GUIDE...
alter table GUIDE disable all triggers;
prompt Disabling triggers for STUDENT...
alter table STUDENT disable all triggers;
prompt Disabling triggers for CONSULTING...
alter table CONSULTING disable all triggers;
prompt Disabling triggers for OPENDAYS...
alter table OPENDAYS disable all triggers;
prompt Disabling triggers for GUESTLECTURES...
alter table GUESTLECTURES disable all triggers;
prompt Disabling triggers for LOCATEDAT...
alter table LOCATEDAT disable all triggers;
prompt Disabling triggers for PARTICIPANTIN...
alter table PARTICIPANTIN disable all triggers;
prompt Disabling triggers for TOURAT...
alter table TOURAT disable all triggers;
prompt Disabling foreign key constraints for PERSON...
alter table PERSON disable constraint SYS_C0013548;
prompt Disabling foreign key constraints for GUIDE...
alter table GUIDE disable constraint SYS_C0013561;
prompt Disabling foreign key constraints for STUDENT...
alter table STUDENT disable constraint SYS_C0013555;
prompt Disabling foreign key constraints for CONSULTING...
alter table CONSULTING disable constraint SYS_C0013569;
alter table CONSULTING disable constraint SYS_C0013570;
prompt Disabling foreign key constraints for GUESTLECTURES...
alter table GUESTLECTURES disable constraint SYS_C0013592;
prompt Disabling foreign key constraints for LOCATEDAT...
alter table LOCATEDAT disable constraint SYS_C0013579;
alter table LOCATEDAT disable constraint SYS_C0013580;
prompt Disabling foreign key constraints for PARTICIPANTIN...
alter table PARTICIPANTIN disable constraint SYS_C0013596;
alter table PARTICIPANTIN disable constraint SYS_C0013597;
prompt Disabling foreign key constraints for TOURAT...
alter table TOURAT disable constraint SYS_C0013603;
alter table TOURAT disable constraint SYS_C0013604;
prompt Deleting TOURAT...
delete from TOURAT;
commit;
prompt Deleting PARTICIPANTIN...
delete from PARTICIPANTIN;
commit;
prompt Deleting LOCATEDAT...
delete from LOCATEDAT;
commit;
prompt Deleting GUESTLECTURES...
delete from GUESTLECTURES;
commit;
prompt Deleting OPENDAYS...
delete from OPENDAYS;
commit;
prompt Deleting CONSULTING...
delete from CONSULTING;
commit;
prompt Deleting STUDENT...
delete from STUDENT;
commit;
prompt Deleting GUIDE...
delete from GUIDE;
commit;
prompt Deleting PERSON...
delete from PERSON;
commit;
prompt Deleting COMPANY...
delete from COMPANY;
commit;
prompt Deleting ADRESS...
delete from ADRESS;
commit;
prompt Loading ADRESS...
insert into ADRESS (adressid, country, city, street)
values (1, 'Israel', 'Lod', '3 Hanassie');
insert into ADRESS (adressid, country, city, street)
values (2, 'Israel', 'Ramat-Gan', '7 Hataiassim');
insert into ADRESS (adressid, country, city, street)
values (3, 'Israel', 'Tel-Aviv', '21 Hamelacha');
insert into ADRESS (adressid, country, city, street)
values (4, 'USA', 'Brooklyn', '715 EasternParkway st.');
insert into ADRESS (adressid, country, city, street)
values (5, 'UnitedKingdom', 'WestEnd', '6 Oxford st.');
insert into ADRESS (adressid, country, city, street)
values (6, 'USA', 'Brooklyn', '312 Albany st.');
insert into ADRESS (adressid, country, city, street)
values (7, 'Israel', 'Haifa', '12 Hatamar');
insert into ADRESS (adressid, country, city, street)
values (8, 'Israel', 'Arad', '19 Rabin');
insert into ADRESS (adressid, country, city, street)
values (9, 'Israel', 'Ashdod', '11 Hazait');
insert into ADRESS (adressid, country, city, street)
values (10, 'Israel', 'Jerusalem', '9 Rechavia');
insert into ADRESS (adressid, country, city, street)
values (11, 'United Kingdom', 'Aberdeen', '91 MacPherson Drive');
insert into ADRESS (adressid, country, city, street)
values (12, 'United Kingdom', 'Oxon', '53rd Street');
insert into ADRESS (adressid, country, city, street)
values (13, 'Sweden', 'Helsingborg', '53 Harrison Street');
insert into ADRESS (adressid, country, city, street)
values (14, 'Japan', 'Tsu', '365 Emmett Road');
insert into ADRESS (adressid, country, city, street)
values (15, 'USA', 'Key Biscayne', '25 Parma Street');
insert into ADRESS (adressid, country, city, street)
values (16, 'USA', 'Chambersburg', '75 Coventry Drive');
insert into ADRESS (adressid, country, city, street)
values (17, 'USA', 'Casselberry', '33 Knight Drive');
insert into ADRESS (adressid, country, city, street)
values (18, 'United Kingdom', 'Oxford', '92 Julianna Ave');
insert into ADRESS (adressid, country, city, street)
values (19, 'USA', 'Swannanoa', '41 Canal Winchester Street');
insert into ADRESS (adressid, country, city, street)
values (20, 'Germany', 'Augsburg', '850 Hjallerup');
insert into ADRESS (adressid, country, city, street)
values (21, 'USA', 'Alexandria', '84 Lupe Road');
insert into ADRESS (adressid, country, city, street)
values (22, 'USA', 'Oshkosh', '64 Sacramento Blvd');
insert into ADRESS (adressid, country, city, street)
values (23, 'USA', 'Olivette', '553 Lathrop Street');
insert into ADRESS (adressid, country, city, street)
values (24, 'Spain', 'Vilafranca Penedes', '20 Cameron Road');
insert into ADRESS (adressid, country, city, street)
values (25, 'Germany', 'Pirmasens', '41 Stowe Road');
insert into ADRESS (adressid, country, city, street)
values (26, 'Spain', 'Agoncillo', '85 Corona');
insert into ADRESS (adressid, country, city, street)
values (27, 'USA', 'Laguna Bbeach', '273 Chalee Blvd');
insert into ADRESS (adressid, country, city, street)
values (28, 'USA', 'Pacific Grove', '851 Giancarlo Drive');
insert into ADRESS (adressid, country, city, street)
values (29, 'Switzerland', 'Biel', '11 Elwes Blvd');
insert into ADRESS (adressid, country, city, street)
values (30, 'China', 'Shenzhen', '5 Eliza Drive');
insert into ADRESS (adressid, country, city, street)
values (31, 'USA', 'Mountain View', '1 McNarland Road');
insert into ADRESS (adressid, country, city, street)
values (32, 'Brazil', 'Limeira', '52 Koyana Drive');
insert into ADRESS (adressid, country, city, street)
values (33, 'Italy', 'Mariano Comense', '34 Lennie Street');
insert into ADRESS (adressid, country, city, street)
values (34, 'Brazil', 'Ribeirao preto', '1 Roberta Ave');
insert into ADRESS (adressid, country, city, street)
values (35, 'USA', 'Shoreline', '80 DiFranco Ave');
insert into ADRESS (adressid, country, city, street)
values (36, 'USA', 'Avon', '31st Street');
insert into ADRESS (adressid, country, city, street)
values (37, 'France', 'Nancy', '75 Mainz-kastel Drive');
insert into ADRESS (adressid, country, city, street)
values (38, 'USA', 'Peachtree City', '160 Regina Street');
insert into ADRESS (adressid, country, city, street)
values (39, 'Italy', 'Pordenone', '10 Frampton');
insert into ADRESS (adressid, country, city, street)
values (40, 'USA', 'Niles', '64 Colm Blvd');
insert into ADRESS (adressid, country, city, street)
values (41, 'USA', 'Chicago', '945 Checker Road');
insert into ADRESS (adressid, country, city, street)
values (42, 'USA', 'Groton', '51st Street');
insert into ADRESS (adressid, country, city, street)
values (43, 'Germany', 'Visselhövede', '4 Jun-nam Street');
insert into ADRESS (adressid, country, city, street)
values (44, 'Germany', 'Meerbusch', '79 McIntosh Blvd');
insert into ADRESS (adressid, country, city, street)
values (45, 'Japan', 'Gifu', '61 Vantaa Blvd');
insert into ADRESS (adressid, country, city, street)
values (46, 'Germany', 'Lübeck', '63 Atkins Drive');
insert into ADRESS (adressid, country, city, street)
values (47, 'USA', 'Eden prairie', '51 Lofgren Blvd');
insert into ADRESS (adressid, country, city, street)
values (48, 'Yugoslavia', 'Belgrad', '15 Chirignago Blvd');
insert into ADRESS (adressid, country, city, street)
values (49, 'USA', 'Stafford', '74 Mars Road');
insert into ADRESS (adressid, country, city, street)
values (50, 'USA', 'Billerica', '62nd Street');
insert into ADRESS (adressid, country, city, street)
values (51, 'Italy', 'Mogliano Veneto', '75 Joely Road');
insert into ADRESS (adressid, country, city, street)
values (52, 'Brazil', 'Irati', '41 Patrick Blvd');
insert into ADRESS (adressid, country, city, street)
values (53, 'Germany', 'Berlin-Adlershof', '79 Rosemead Street');
insert into ADRESS (adressid, country, city, street)
values (54, 'Canada', 'London', '40 Mollard Ave');
insert into ADRESS (adressid, country, city, street)
values (55, 'USA', 'North Wales', '51st Street');
insert into ADRESS (adressid, country, city, street)
values (56, 'USA', 'Reisterstown', '18 Ponta grossa Ave');
insert into ADRESS (adressid, country, city, street)
values (57, 'United Kingdom', 'Tyne & Wear', '626 Stavanger Street');
insert into ADRESS (adressid, country, city, street)
values (58, 'USA', 'San Mateo', '50 Olin Ave');
insert into ADRESS (adressid, country, city, street)
values (59, 'USA', 'Arlington', '4 Ft. Leavenworth Street');
insert into ADRESS (adressid, country, city, street)
values (60, 'Germany', 'Munich', '35 Geneve Street');
insert into ADRESS (adressid, country, city, street)
values (61, 'United Kingdom', 'Market Harborough', '59 Wariner Ave');
insert into ADRESS (adressid, country, city, street)
values (62, 'USA', 'Bozeman', '95 Hercules Drive');
insert into ADRESS (adressid, country, city, street)
values (63, 'United Kingdom', 'Coventry', '51 Irkutsk Drive');
insert into ADRESS (adressid, country, city, street)
values (64, 'USA', 'Bartlett', '55 Tippe Street');
insert into ADRESS (adressid, country, city, street)
values (65, 'United Kingdom', 'Southend on Sea', '41 Brooke Street');
insert into ADRESS (adressid, country, city, street)
values (66, 'USA', 'New Castle', '85 Valentin Blvd');
insert into ADRESS (adressid, country, city, street)
values (67, 'USA', 'Glendale', '18 Hjallerup Street');
insert into ADRESS (adressid, country, city, street)
values (68, 'Brazil', 'Ribeirao preto', '43rd Street');
insert into ADRESS (adressid, country, city, street)
values (69, 'Spain', 'Sant Cugat Del Valle', '93 Minneapolis Street');
insert into ADRESS (adressid, country, city, street)
values (70, 'Brazil', 'Santana do parnaíba', '63rd Street');
insert into ADRESS (adressid, country, city, street)
values (71, 'South Africa', 'Halfway house', '72nd Street');
insert into ADRESS (adressid, country, city, street)
values (72, 'Japan', 'Tottori', '525 Mirren');
insert into ADRESS (adressid, country, city, street)
values (73, 'USA', 'Tualatin', '56 Maria Street');
insert into ADRESS (adressid, country, city, street)
values (74, 'USA', 'Knoxville', '97 Cleary Road');
insert into ADRESS (adressid, country, city, street)
values (75, 'USA', 'Hunt Valley', '40 Orlando Drive');
insert into ADRESS (adressid, country, city, street)
values (76, 'Canada', 'Fort Saskatchewan', '979 Ashley Road');
insert into ADRESS (adressid, country, city, street)
values (77, 'United Kingdom', 'Manchester', '69 Rawls Drive');
insert into ADRESS (adressid, country, city, street)
values (78, 'Canada', 'Winnipeg', '43rd Street');
insert into ADRESS (adressid, country, city, street)
values (79, 'Germany', 'Oppenheim', '257 Corona Road');
insert into ADRESS (adressid, country, city, street)
values (80, 'USA', 'San Mateo', '32nd Street');
insert into ADRESS (adressid, country, city, street)
values (81, 'Japan', 'Nara', '39 Stanton Ave');
insert into ADRESS (adressid, country, city, street)
values (82, 'Canada', 'Victoria', '59 Giancarlo Street');
insert into ADRESS (adressid, country, city, street)
values (83, 'Austria', 'Linz', '95 Bracco Road');
insert into ADRESS (adressid, country, city, street)
values (84, 'USA', 'Englewood', '50 Tobey Street');
insert into ADRESS (adressid, country, city, street)
values (85, 'Germany', 'Ebersdorf', '11 Andy Ave');
insert into ADRESS (adressid, country, city, street)
values (86, 'Ecuador', 'Cuenca', '11 Blades');
insert into ADRESS (adressid, country, city, street)
values (87, 'Japan', 'Osaka', '66 Marley Drive');
insert into ADRESS (adressid, country, city, street)
values (88, 'United Kingdom', 'North Yorkshire', '58 Lennie Street');
insert into ADRESS (adressid, country, city, street)
values (89, 'USA', 'Saint Paul', '23rd Street');
insert into ADRESS (adressid, country, city, street)
values (90, 'Costa Rica', 'San Jose', '24 Chur Road');
insert into ADRESS (adressid, country, city, street)
values (91, 'USA', 'Horsham', '75 Farris Road');
insert into ADRESS (adressid, country, city, street)
values (92, 'USA', 'Northbrook', '92 Warley Ave');
insert into ADRESS (adressid, country, city, street)
values (93, 'Germany', 'Nordhausen', '58 Coimbra Ave');
insert into ADRESS (adressid, country, city, street)
values (94, 'USA', 'King of Prussia', '33 Orlando Drive');
insert into ADRESS (adressid, country, city, street)
values (95, 'USA', 'Fair Lawn', '57 Yulin Road');
insert into ADRESS (adressid, country, city, street)
values (96, 'Denmark', 'Hjallerup', '68 Galecki Street');
insert into ADRESS (adressid, country, city, street)
values (97, 'Ireland', 'Dublin', '426 Ali Road');
insert into ADRESS (adressid, country, city, street)
values (98, 'Japan', 'Akita', '31 Fairview Heights Blvd');
insert into ADRESS (adressid, country, city, street)
values (99, 'United Kingdom', 'Manchester', '85 Annie Street');
insert into ADRESS (adressid, country, city, street)
values (100, 'France', 'Angers', '28 Utada Drive');
commit;
prompt 100 records committed...
insert into ADRESS (adressid, country, city, street)
values (101, 'Germany', 'Dreieich', '135 Lodi Street');
insert into ADRESS (adressid, country, city, street)
values (102, 'Brazil', 'Ponta grossa', '11 Ricky Road');
insert into ADRESS (adressid, country, city, street)
values (103, 'USA', 'San Jose', '12 Hayek Street');
insert into ADRESS (adressid, country, city, street)
values (104, 'Canada', 'Kingston', '29 Joshua Road');
insert into ADRESS (adressid, country, city, street)
values (105, 'Palestine', 'Gaza', '54 Haslam Road');
insert into ADRESS (adressid, country, city, street)
values (106, 'Canada', 'Verdun', '33 Glenn Blvd');
insert into ADRESS (adressid, country, city, street)
values (107, 'USA', 'Chapel hill', '80 Warrenton Road');
insert into ADRESS (adressid, country, city, street)
values (108, 'USA', 'Delafield', '16 McCoy Blvd');
insert into ADRESS (adressid, country, city, street)
values (109, 'Germany', 'Koblenz', '37 Purley Drive');
insert into ADRESS (adressid, country, city, street)
values (110, 'USA', 'King of Prussia', '81 Whitwam Ave');
insert into ADRESS (adressid, country, city, street)
values (111, 'Germany', 'Leimen', '15 Cliff Road');
insert into ADRESS (adressid, country, city, street)
values (112, 'Germany', 'Augsburg', '20 Andrea Blvd');
insert into ADRESS (adressid, country, city, street)
values (113, 'USA', 'Boulder', '32nd Street');
insert into ADRESS (adressid, country, city, street)
values (114, 'United Kingdom', 'Hounslow', '63 Newton Street');
insert into ADRESS (adressid, country, city, street)
values (115, 'Italy', 'Di Savigliano', '23 Paal Beringen Street');
insert into ADRESS (adressid, country, city, street)
values (116, 'Canada', 'Coquitlam', '19 Vaughn Drive');
insert into ADRESS (adressid, country, city, street)
values (117, 'USA', 'Flower mound', '82 Albany');
insert into ADRESS (adressid, country, city, street)
values (118, 'Norway', 'Kongserbg', '79 Waco Road');
insert into ADRESS (adressid, country, city, street)
values (119, 'United Kingdom', 'Braintree', '23 Hilversum Drive');
insert into ADRESS (adressid, country, city, street)
values (120, 'USA', 'Cedar Rapids', '28 Elle Road');
insert into ADRESS (adressid, country, city, street)
values (121, 'USA', 'Sarasota', '25 Dylan Street');
insert into ADRESS (adressid, country, city, street)
values (122, 'USA', 'Durham', '20 Cleveland');
insert into ADRESS (adressid, country, city, street)
values (123, 'USA', 'Middletown', '12nd Street');
insert into ADRESS (adressid, country, city, street)
values (124, 'United Kingdom', 'Cardiff', '84 Kier Road');
insert into ADRESS (adressid, country, city, street)
values (125, 'USA', 'Waltham', '97 Idol Street');
insert into ADRESS (adressid, country, city, street)
values (126, 'Netherlands', 'Amsterdam', '761 Mae Road');
insert into ADRESS (adressid, country, city, street)
values (127, 'Germany', 'Heubach', '17 Issaquah Street');
insert into ADRESS (adressid, country, city, street)
values (128, 'USA', 'El Paso', '47 Allan Road');
insert into ADRESS (adressid, country, city, street)
values (129, 'USA', 'Crete', '419 Cleese Ave');
insert into ADRESS (adressid, country, city, street)
values (130, 'United Kingdom', 'Bristol', '54 Keitel Drive');
insert into ADRESS (adressid, country, city, street)
values (131, 'Italy', 'Milan', '81 Nakai Drive');
insert into ADRESS (adressid, country, city, street)
values (132, 'USA', 'Huntsville', '51 Butler Road');
insert into ADRESS (adressid, country, city, street)
values (133, 'Denmark', 'Billund', '17 Vallauris');
insert into ADRESS (adressid, country, city, street)
values (134, 'Greece', 'Thessaloniki', '82 Franco Drive');
insert into ADRESS (adressid, country, city, street)
values (135, 'Netherlands', 'Utrecht', '67 Sawa Blvd');
insert into ADRESS (adressid, country, city, street)
values (136, 'USA', 'Monterey', '92nd Street');
insert into ADRESS (adressid, country, city, street)
values (137, 'Italy', 'Mantova', '361 Amy Street');
insert into ADRESS (adressid, country, city, street)
values (138, 'Germany', 'Nordhausen', '6 Stormare Street');
insert into ADRESS (adressid, country, city, street)
values (139, 'USA', 'Germantown', '61st Street');
insert into ADRESS (adressid, country, city, street)
values (140, 'Germany', 'Köln', '39 Fiennes Road');
insert into ADRESS (adressid, country, city, street)
values (141, 'Germany', 'Hanover', '72nd Street');
insert into ADRESS (adressid, country, city, street)
values (142, 'Canada', 'Victoria', '37 Daniels Road');
insert into ADRESS (adressid, country, city, street)
values (143, 'Finland', 'Vantaa', '35 Gill Drive');
insert into ADRESS (adressid, country, city, street)
values (144, 'USA', 'Sutton', '51st Street');
insert into ADRESS (adressid, country, city, street)
values (145, 'United Kingdom', 'Tadley', '97 Rtp Blvd');
insert into ADRESS (adressid, country, city, street)
values (146, 'Italy', 'Trento', '87 Mandy Road');
insert into ADRESS (adressid, country, city, street)
values (147, 'USA', 'Oshkosh', '12 Anjelica Road');
insert into ADRESS (adressid, country, city, street)
values (148, 'Canada', 'Verdun', '64 Donovan Drive');
insert into ADRESS (adressid, country, city, street)
values (149, 'USA', 'Santa Clarita', '16 Thomas Ave');
insert into ADRESS (adressid, country, city, street)
values (150, 'United Kingdom', 'Sale', '96 Holy Ave');
insert into ADRESS (adressid, country, city, street)
values (151, 'Mexico', 'Guadalajara', '813 Bountiful Street');
insert into ADRESS (adressid, country, city, street)
values (152, 'Italy', 'Cesena', '21 Collie Ave');
insert into ADRESS (adressid, country, city, street)
values (153, 'Germany', 'Wetzlar', '59 Chalee Road');
insert into ADRESS (adressid, country, city, street)
values (154, 'USA', 'Rochester', '55 Vickie Drive');
insert into ADRESS (adressid, country, city, street)
values (155, 'USA', 'Laurel', '94 Benet Road');
insert into ADRESS (adressid, country, city, street)
values (156, 'Germany', 'Dinslaken', '19 Woodard Road');
insert into ADRESS (adressid, country, city, street)
values (157, 'USA', 'The Woodlands', '29 Vincent Road');
insert into ADRESS (adressid, country, city, street)
values (158, 'Germany', 'Ettlingen', '9 Ulm Road');
insert into ADRESS (adressid, country, city, street)
values (159, 'United Kingdom', 'Paisley', '599 Hart Street');
insert into ADRESS (adressid, country, city, street)
values (160, 'Russia', 'Cherepovets', '25 Whoopi Road');
insert into ADRESS (adressid, country, city, street)
values (161, 'Greece', 'Kozani', '26 Meerbusch Drive');
insert into ADRESS (adressid, country, city, street)
values (162, 'USA', 'Peachtree City', '30 Hobson Street');
insert into ADRESS (adressid, country, city, street)
values (163, 'Italy', 'Mantova', '12nd Street');
insert into ADRESS (adressid, country, city, street)
values (164, 'Germany', 'Dresden', '838 Edwardstown Drive');
insert into ADRESS (adressid, country, city, street)
values (165, 'United Kingdom', 'Bristol', '24 Nina Street');
insert into ADRESS (adressid, country, city, street)
values (166, 'USA', 'Rome', '54 Cattrall Road');
insert into ADRESS (adressid, country, city, street)
values (167, 'United Kingdom', 'Northampton', '77 Larenz Drive');
insert into ADRESS (adressid, country, city, street)
values (168, 'USA', 'Knoxville', '456 League city Road');
insert into ADRESS (adressid, country, city, street)
values (169, 'Germany', 'Kevelaer', '60 Ronstadt Road');
insert into ADRESS (adressid, country, city, street)
values (170, 'Japan', 'Sendai', '82 Carl Road');
insert into ADRESS (adressid, country, city, street)
values (171, 'Australia', 'Highton', '26 Luzern Street');
insert into ADRESS (adressid, country, city, street)
values (172, 'Germany', 'Dortmund', '5 Blige Road');
insert into ADRESS (adressid, country, city, street)
values (173, 'Finland', 'Vantaa', '317 Harry Road');
insert into ADRESS (adressid, country, city, street)
values (174, 'USA', 'Borger', '60 Denver Drive');
insert into ADRESS (adressid, country, city, street)
values (175, 'USA', 'Billerica', '94 Port Macquarie Drive');
insert into ADRESS (adressid, country, city, street)
values (176, 'USA', 'Buffalo Grove', '385 Jonny');
insert into ADRESS (adressid, country, city, street)
values (177, 'United Kingdom', 'Birkenhead', '255 Apple Road');
insert into ADRESS (adressid, country, city, street)
values (178, 'USA', 'Fort gordon', '18 Weller Road');
insert into ADRESS (adressid, country, city, street)
values (179, 'Costa Rica', 'San Jose', '57 Janssen Blvd');
insert into ADRESS (adressid, country, city, street)
values (180, 'USA', 'Green bay', '16 Jolie Street');
insert into ADRESS (adressid, country, city, street)
values (181, 'USA', 'Pearland', '459 Angie Street');
insert into ADRESS (adressid, country, city, street)
values (182, 'USA', 'Fair Lawn', '460 Jarvis');
insert into ADRESS (adressid, country, city, street)
values (183, 'Argentina', 'Campana', '86 St Leonards Road');
insert into ADRESS (adressid, country, city, street)
values (184, 'Germany', 'Cottbus', '266 Crosby Ave');
insert into ADRESS (adressid, country, city, street)
values (185, 'Germany', 'Koblenz', '85 Watson Street');
insert into ADRESS (adressid, country, city, street)
values (186, 'USA', 'West Chester', '42nd Street');
insert into ADRESS (adressid, country, city, street)
values (187, 'Canada', 'Richmond Hill', '59 Mogi Guacu Road');
insert into ADRESS (adressid, country, city, street)
values (188, 'United Kingdom', 'Coventry', '24 Kitty Street');
insert into ADRESS (adressid, country, city, street)
values (189, 'Brazil', 'Santa rita sapucaí', '39 Margolyes Street');
insert into ADRESS (adressid, country, city, street)
values (190, 'USA', 'Cedar Park', '612 Shorter Drive');
insert into ADRESS (adressid, country, city, street)
values (191, 'USA', 'Mobile', '371 Gibbons Drive');
insert into ADRESS (adressid, country, city, street)
values (192, 'Brazil', 'Londrina', '60 Kurt Drive');
insert into ADRESS (adressid, country, city, street)
values (193, 'Germany', 'Karlsruhe', '92 Laurie Blvd');
insert into ADRESS (adressid, country, city, street)
values (194, 'Argentina', 'Rosario', '26 Greg Blvd');
insert into ADRESS (adressid, country, city, street)
values (195, 'USA', 'Huntington Beach', '90 Richter Street');
insert into ADRESS (adressid, country, city, street)
values (196, 'South Africa', 'Stellenbosch', '43 Claude Drive');
insert into ADRESS (adressid, country, city, street)
values (197, 'USA', 'Richardson', '90 Beckinsale Street');
insert into ADRESS (adressid, country, city, street)
values (198, 'Belgium', 'Bruxelles', '89 Arjona Road');
insert into ADRESS (adressid, country, city, street)
values (199, 'Germany', 'Dresden', '21 Hamburg Road');
insert into ADRESS (adressid, country, city, street)
values (200, 'USA', 'New boston', '832 Jack Blvd');
commit;
prompt 200 records committed...
insert into ADRESS (adressid, country, city, street)
values (201, 'USA', 'Sacramento', '97 Lara Drive');
insert into ADRESS (adressid, country, city, street)
values (202, 'USA', 'Barnegat', '32 Isaacs Blvd');
insert into ADRESS (adressid, country, city, street)
values (203, 'Germany', 'Wörth', '57 Nivola Street');
insert into ADRESS (adressid, country, city, street)
values (204, 'USA', 'King of Prussia', '57 Giannini Street');
insert into ADRESS (adressid, country, city, street)
values (205, 'USA', 'Farmington Hills', '93 Shelton Street');
insert into ADRESS (adressid, country, city, street)
values (206, 'Germany', 'Ravensburg', '43rd Street');
insert into ADRESS (adressid, country, city, street)
values (207, 'Belgium', 'Erpe-Mere', '43 Tankard');
insert into ADRESS (adressid, country, city, street)
values (208, 'USA', 'Green bay', '85 Russell Ave');
insert into ADRESS (adressid, country, city, street)
values (209, 'United Kingdom', 'Glasgow', '59 Parm Road');
insert into ADRESS (adressid, country, city, street)
values (210, 'Brazil', 'Rio de janeiro', '26 Chappelle Drive');
insert into ADRESS (adressid, country, city, street)
values (211, 'Germany', 'Ebersberg', '30 Craig Drive');
insert into ADRESS (adressid, country, city, street)
values (212, 'Italy', 'Piacenza', '92 Klein Ave');
insert into ADRESS (adressid, country, city, street)
values (213, 'USA', 'Chapel hill', '65 Zeta-Jones Road');
insert into ADRESS (adressid, country, city, street)
values (214, 'Italy', 'Fornacette', '58 Penders Drive');
insert into ADRESS (adressid, country, city, street)
values (215, 'USA', 'Borger', '639 Blue bell Road');
insert into ADRESS (adressid, country, city, street)
values (216, 'Italy', 'Parma', '11st Street');
insert into ADRESS (adressid, country, city, street)
values (217, 'Brazil', 'Joinville', '48 Thörishaus Road');
insert into ADRESS (adressid, country, city, street)
values (218, 'USA', 'Avon', '24 Vassar Drive');
insert into ADRESS (adressid, country, city, street)
values (219, 'USA', 'Mayfield Village', '48 Berkeley Ave');
insert into ADRESS (adressid, country, city, street)
values (220, 'Germany', 'Koblenz', '35 Joaquin Road');
insert into ADRESS (adressid, country, city, street)
values (221, 'Japan', 'Ohtsu', '20 Brian Street');
insert into ADRESS (adressid, country, city, street)
values (222, 'Japan', 'Gifu', '77 Libertyville Road');
insert into ADRESS (adressid, country, city, street)
values (223, 'United Kingdom', 'West Drayton', '70 Offenburg Ave');
insert into ADRESS (adressid, country, city, street)
values (224, 'USA', 'Laguna Bbeach', '53 Gere Street');
insert into ADRESS (adressid, country, city, street)
values (225, 'Denmark', 'Fredericia', '37 Storrington Road');
insert into ADRESS (adressid, country, city, street)
values (226, 'USA', 'Lubbock', '83 Saitama Street');
insert into ADRESS (adressid, country, city, street)
values (227, 'Argentina', 'Mendoza', '11 Mobile Road');
insert into ADRESS (adressid, country, city, street)
values (228, 'Palestine', 'Gaza', '40 Gooding Ave');
insert into ADRESS (adressid, country, city, street)
values (229, 'Netherlands', 'Tilburg', '10 Melba Ave');
insert into ADRESS (adressid, country, city, street)
values (230, 'Hungary', 'Budapest', '321 Fehr Street');
insert into ADRESS (adressid, country, city, street)
values (231, 'Germany', 'Bad Camberg', '402 Sydney Street');
insert into ADRESS (adressid, country, city, street)
values (232, 'USA', 'Alpharetta', '23 Santana Road');
insert into ADRESS (adressid, country, city, street)
values (233, 'Brazil', 'Ribeirao preto', '95 Obfelden Street');
insert into ADRESS (adressid, country, city, street)
values (234, 'Germany', 'Heubach', '230 Botti Blvd');
insert into ADRESS (adressid, country, city, street)
values (235, 'Italy', 'Villata', '27 Cary Blvd');
insert into ADRESS (adressid, country, city, street)
values (236, 'South Africa', 'Gauteng', '70 Austin Street');
insert into ADRESS (adressid, country, city, street)
values (237, 'USA', 'Corona', '73 Hershey Street');
insert into ADRESS (adressid, country, city, street)
values (238, 'USA', 'Pomona', '13 Woody Drive');
insert into ADRESS (adressid, country, city, street)
values (239, 'Indonesia', 'Yogyakarta', '79 Bologna');
insert into ADRESS (adressid, country, city, street)
values (240, 'Finland', 'Helsinki', '13rd Street');
insert into ADRESS (adressid, country, city, street)
values (241, 'USA', 'Middletown', '21 Jennifer Road');
insert into ADRESS (adressid, country, city, street)
values (242, 'Germany', 'Wuerzburg', '65 Sydney Street');
insert into ADRESS (adressid, country, city, street)
values (243, 'USA', 'Bozeman', '99 Forster Street');
insert into ADRESS (adressid, country, city, street)
values (244, 'Germany', 'Duisburg', '627 Samuel Road');
insert into ADRESS (adressid, country, city, street)
values (245, 'Canada', 'Verdun', '76 Jeffrey Street');
insert into ADRESS (adressid, country, city, street)
values (246, 'United Kingdom', 'East sussex', '20 Bachman Road');
insert into ADRESS (adressid, country, city, street)
values (247, 'USA', 'South Weber', '85 Horsham Street');
insert into ADRESS (adressid, country, city, street)
values (248, 'USA', 'El Dorado Hills', '56 Stewart Street');
insert into ADRESS (adressid, country, city, street)
values (249, 'India', 'Hyderabad', '41 Bryson Blvd');
insert into ADRESS (adressid, country, city, street)
values (250, 'Canada', 'Burlington', '990 Jamie Street');
insert into ADRESS (adressid, country, city, street)
values (251, 'Israel', 'Yavne', '25 Goldwyn Street');
insert into ADRESS (adressid, country, city, street)
values (252, 'Liechtenstein', 'Eschen', '90 North Yorkshire Street');
insert into ADRESS (adressid, country, city, street)
values (253, 'Switzerland', 'Appenzell', '42 Larter Street');
insert into ADRESS (adressid, country, city, street)
values (254, 'South Africa', 'Samrand', '50 Rowan Street');
insert into ADRESS (adressid, country, city, street)
values (255, 'Netherlands', 'Eindhoven', '53rd Street');
insert into ADRESS (adressid, country, city, street)
values (256, 'Brazil', 'Manaus', '89 Josh');
insert into ADRESS (adressid, country, city, street)
values (257, 'Thailand', 'Bkk', '227 Emm Street');
insert into ADRESS (adressid, country, city, street)
values (258, 'United Kingdom', 'Enfield', '983 Aracruz Street');
insert into ADRESS (adressid, country, city, street)
values (259, 'Austria', 'Wien', '28 Tucci Road');
insert into ADRESS (adressid, country, city, street)
values (260, 'Chile', 'Santiago', '52 Hornsby Road');
insert into ADRESS (adressid, country, city, street)
values (261, 'Hong Kong', 'Hong Kong', '51 Ingram Blvd');
insert into ADRESS (adressid, country, city, street)
values (262, 'United Kingdom', 'Haverhill', '17 Ipswich Road');
insert into ADRESS (adressid, country, city, street)
values (263, 'USA', 'Seattle', '434 Hilton Street');
insert into ADRESS (adressid, country, city, street)
values (264, 'Australia', 'Carlingford', '61st Street');
insert into ADRESS (adressid, country, city, street)
values (265, 'Austria', 'Steyr', '442 Pigott-Smith Road');
insert into ADRESS (adressid, country, city, street)
values (266, 'Denmark', 'Horsens', '28 Taylor Road');
insert into ADRESS (adressid, country, city, street)
values (267, 'USA', 'Narrows', '9 Mahoney Street');
insert into ADRESS (adressid, country, city, street)
values (268, 'Australia', 'Perth', '2 Palin Blvd');
insert into ADRESS (adressid, country, city, street)
values (269, 'USA', 'Bellevue', '41 Gano Road');
insert into ADRESS (adressid, country, city, street)
values (270, 'Ireland', 'Bologna', '996 Lerner Ave');
insert into ADRESS (adressid, country, city, street)
values (271, 'USA', 'Pensacola', '24 Shorter');
insert into ADRESS (adressid, country, city, street)
values (272, 'Japan', 'Yamagata', '91 Ponce Street');
insert into ADRESS (adressid, country, city, street)
values (273, 'USA', 'Cedar Park', '95 Williams');
insert into ADRESS (adressid, country, city, street)
values (274, 'Denmark', 'Fredericia', '588 Duvall Drive');
insert into ADRESS (adressid, country, city, street)
values (275, 'USA', 'Englewood Cliffs', '43 Bethesda Drive');
insert into ADRESS (adressid, country, city, street)
values (276, 'Switzerland', 'Hochwald', '46 Winstone Street');
insert into ADRESS (adressid, country, city, street)
values (277, 'Peru', 'Lima', '39 Washington Ave');
insert into ADRESS (adressid, country, city, street)
values (278, 'USA', 'Charlotte', '94 Tyler');
insert into ADRESS (adressid, country, city, street)
values (279, 'Italy', 'Lodi', '98 Van Helden Road');
insert into ADRESS (adressid, country, city, street)
values (280, 'Australia', 'Ringwood', '4 Pretoria Street');
insert into ADRESS (adressid, country, city, street)
values (281, 'Canada', 'St-bruno', '75 Neill Drive');
insert into ADRESS (adressid, country, city, street)
values (282, 'USA', 'Claymont', '22 Buffy Road');
insert into ADRESS (adressid, country, city, street)
values (283, 'Australia', 'Kuraby', '27 Stormare Drive');
insert into ADRESS (adressid, country, city, street)
values (284, 'South Africa', 'Pretoria', '80 Lang Street');
insert into ADRESS (adressid, country, city, street)
values (285, 'USA', 'Swannanoa', '62nd Street');
insert into ADRESS (adressid, country, city, street)
values (286, 'USA', 'Bellevue', '26 Liotta Street');
insert into ADRESS (adressid, country, city, street)
values (287, 'Germany', 'Bonn', '29 Rimini Drive');
insert into ADRESS (adressid, country, city, street)
values (288, 'USA', 'Charleston', '99 Aurora Street');
insert into ADRESS (adressid, country, city, street)
values (289, 'USA', 'Allen', '71 Stafford Blvd');
insert into ADRESS (adressid, country, city, street)
values (290, 'USA', 'Germantown', '614 Delta Street');
insert into ADRESS (adressid, country, city, street)
values (291, 'USA', 'Santa Fe', '823 Dourif Street');
insert into ADRESS (adressid, country, city, street)
values (292, 'USA', 'Las Vegas', '40 Oslo');
insert into ADRESS (adressid, country, city, street)
values (293, 'USA', 'Glendale', '34 Lorenz Road');
insert into ADRESS (adressid, country, city, street)
values (294, 'Denmark', 'Vejle', '65 Whitmore');
insert into ADRESS (adressid, country, city, street)
values (295, 'Japan', 'Chiba', '59 Mazar');
insert into ADRESS (adressid, country, city, street)
values (296, 'Canada', 'Edmonton', '289 Raymond Drive');
insert into ADRESS (adressid, country, city, street)
values (297, 'Germany', 'Ebersberg', '91 Parsons Drive');
insert into ADRESS (adressid, country, city, street)
values (298, 'USA', 'Santa Fe', '11 Pearce Road');
insert into ADRESS (adressid, country, city, street)
values (299, 'United Kingdom', 'Banbury', '87 Joey Street');
insert into ADRESS (adressid, country, city, street)
values (300, 'Brazil', 'Irati', '798 Steve Drive');
commit;
prompt 300 records committed...
insert into ADRESS (adressid, country, city, street)
values (301, 'Canada', 'Vancouver', '12 Squier Drive');
insert into ADRESS (adressid, country, city, street)
values (302, 'South Korea', 'Suwon', '64 Devine');
insert into ADRESS (adressid, country, city, street)
values (303, 'Germany', 'Aachen', '91st Street');
insert into ADRESS (adressid, country, city, street)
values (304, 'Germany', 'Oyten', '93 Carlin Street');
insert into ADRESS (adressid, country, city, street)
values (305, 'United Kingdom', 'Glasgow', '55 Perez Drive');
insert into ADRESS (adressid, country, city, street)
values (306, 'Canada', 'Kanata', '30 Palo Alto Road');
insert into ADRESS (adressid, country, city, street)
values (307, 'USA', 'Riverdale', '96 Runcorn Street');
insert into ADRESS (adressid, country, city, street)
values (308, 'Spain', 'Toledo', '9 New Hyde Park Street');
insert into ADRESS (adressid, country, city, street)
values (309, 'USA', 'Claymont', '43 Hopper Street');
insert into ADRESS (adressid, country, city, street)
values (310, 'USA', 'Fort worth', '9 Eileen Street');
insert into ADRESS (adressid, country, city, street)
values (311, 'USA', 'Mt. Laurel', '6 Downey Road');
insert into ADRESS (adressid, country, city, street)
values (312, 'USA', 'Akron', '92 Keitel Drive');
insert into ADRESS (adressid, country, city, street)
values (313, 'USA', 'Double Oak', '29 Bratislava Ave');
insert into ADRESS (adressid, country, city, street)
values (314, 'Israel', 'Netanya', '75 Caan Drive');
insert into ADRESS (adressid, country, city, street)
values (315, 'Germany', 'Magstadt', '1 Mia Street');
insert into ADRESS (adressid, country, city, street)
values (316, 'Norway', 'Stavanger', '40 Napolitano Street');
insert into ADRESS (adressid, country, city, street)
values (317, 'USA', 'Hartford', '29 LaBelle Blvd');
insert into ADRESS (adressid, country, city, street)
values (318, 'USA', 'West Chester', '16 Rob Ave');
insert into ADRESS (adressid, country, city, street)
values (319, 'Switzerland', 'Kloten', '22 Balaban Ave');
insert into ADRESS (adressid, country, city, street)
values (320, 'USA', 'Stafford', '12nd Street');
insert into ADRESS (adressid, country, city, street)
values (321, 'USA', 'Schenectady', '46 Leoni Ave');
insert into ADRESS (adressid, country, city, street)
values (322, 'USA', 'Derwood', '63 Christie Blvd');
insert into ADRESS (adressid, country, city, street)
values (323, 'Spain', 'Sevilla', '252 Eschen');
insert into ADRESS (adressid, country, city, street)
values (324, 'Japan', 'Tottori', '53 Quatro Ave');
insert into ADRESS (adressid, country, city, street)
values (325, 'Canada', 'Fort McMurray', '85 Bridget Road');
insert into ADRESS (adressid, country, city, street)
values (326, 'USA', 'Herndon', '16 Nelligan Street');
insert into ADRESS (adressid, country, city, street)
values (327, 'United Kingdom', 'Coldmeece', '37 Love Blvd');
insert into ADRESS (adressid, country, city, street)
values (328, 'USA', 'Las Vegas', '62 Delta Street');
insert into ADRESS (adressid, country, city, street)
values (329, 'USA', 'Mobile', '46 Matarazzo Road');
insert into ADRESS (adressid, country, city, street)
values (330, 'Switzerland', 'Zürich', '11 Wolf Street');
insert into ADRESS (adressid, country, city, street)
values (331, 'Germany', 'Karlsruhe', '662 Johansson Road');
insert into ADRESS (adressid, country, city, street)
values (332, 'Italy', 'Di Savigliano', '941 Paul Street');
insert into ADRESS (adressid, country, city, street)
values (333, 'USA', 'Melrose', '33 Chao Road');
insert into ADRESS (adressid, country, city, street)
values (334, 'USA', 'Brookfield', '100 Carol Ave');
insert into ADRESS (adressid, country, city, street)
values (335, 'USA', 'Laredo', '28 Mira Street');
insert into ADRESS (adressid, country, city, street)
values (336, 'Germany', 'Chemnitz', '398 Niigata Street');
insert into ADRESS (adressid, country, city, street)
values (337, 'South Korea', 'Daejeon', '89 Geldof Drive');
insert into ADRESS (adressid, country, city, street)
values (338, 'Germany', 'Heubach', '13 Sparrows Point Street');
insert into ADRESS (adressid, country, city, street)
values (339, 'USA', 'Carlin', '9 Balin Road');
insert into ADRESS (adressid, country, city, street)
values (340, 'USA', 'Fair Lawn', '79 Mika Street');
insert into ADRESS (adressid, country, city, street)
values (341, 'Argentina', 'Campana', '71 Cypress Ave');
insert into ADRESS (adressid, country, city, street)
values (342, 'Switzerland', 'Zürich', '87 Rosie');
insert into ADRESS (adressid, country, city, street)
values (343, 'USA', 'Holts Summit', '43 Essen Street');
insert into ADRESS (adressid, country, city, street)
values (344, 'United Kingdom', 'Purley', '176 Badalucco Blvd');
insert into ADRESS (adressid, country, city, street)
values (345, 'Switzerland', 'Rheinfelden', '63 Lineback Drive');
insert into ADRESS (adressid, country, city, street)
values (346, 'United Kingdom', 'Southend on Sea', '32 Warren Ave');
insert into ADRESS (adressid, country, city, street)
values (347, 'France', 'L''union', '56 McCabe');
insert into ADRESS (adressid, country, city, street)
values (348, 'Chile', 'Santiago', '28 Sorocaba Road');
insert into ADRESS (adressid, country, city, street)
values (349, 'Japan', 'Fukui', '39 Drogenbos Drive');
insert into ADRESS (adressid, country, city, street)
values (350, 'USA', 'Chicago', '30 Winstone Street');
insert into ADRESS (adressid, country, city, street)
values (351, 'USA', 'Coppell', '27 Cronin Street');
insert into ADRESS (adressid, country, city, street)
values (352, 'USA', 'Rio Rancho', '4 Holm Drive');
insert into ADRESS (adressid, country, city, street)
values (353, 'USA', 'Peterborough', '70 Ontiveros Road');
insert into ADRESS (adressid, country, city, street)
values (354, 'Sweden', 'Sundsvall', '26 Jill Drive');
insert into ADRESS (adressid, country, city, street)
values (355, 'USA', 'Leawood', '96 Sinatra Road');
insert into ADRESS (adressid, country, city, street)
values (356, 'USA', 'Albuquerque', '23 Marin Street');
insert into ADRESS (adressid, country, city, street)
values (357, 'USA', 'League city', '65 Chaplin Blvd');
insert into ADRESS (adressid, country, city, street)
values (358, 'USA', 'Lexington', '64 Saitama Drive');
insert into ADRESS (adressid, country, city, street)
values (359, 'USA', 'Shelton', '26 Lee Street');
insert into ADRESS (adressid, country, city, street)
values (360, 'Australia', 'Adelaide', '61 Webster Groves Road');
insert into ADRESS (adressid, country, city, street)
values (361, 'Canada', 'St-laurent', '30 Veenendaal Road');
insert into ADRESS (adressid, country, city, street)
values (362, 'USA', 'Milford', '153 South Jordan Blvd');
insert into ADRESS (adressid, country, city, street)
values (363, 'USA', 'Edison', '32nd Street');
insert into ADRESS (adressid, country, city, street)
values (364, 'USA', 'Kansas City', '2 Shocked Street');
insert into ADRESS (adressid, country, city, street)
values (365, 'Germany', 'Gummersbach', '65 Arquette Road');
insert into ADRESS (adressid, country, city, street)
values (366, 'USA', 'Borger', '70 Amy Drive');
insert into ADRESS (adressid, country, city, street)
values (367, 'Sweden', 'Goteborg', '33rd Street');
insert into ADRESS (adressid, country, city, street)
values (368, 'United Kingdom', 'Sheffield', '41 Bancroft Drive');
insert into ADRESS (adressid, country, city, street)
values (369, 'United Kingdom', 'Woking', '50 Child Street');
insert into ADRESS (adressid, country, city, street)
values (370, 'USA', 'Barksdale afb', '877 Astin Road');
insert into ADRESS (adressid, country, city, street)
values (371, 'Germany', 'Chemnitz', '76 Wetzlar Drive');
insert into ADRESS (adressid, country, city, street)
values (372, 'Japan', 'Kagoshima', '98 Santa Cruz Road');
insert into ADRESS (adressid, country, city, street)
values (373, 'USA', 'Rochester', '65 Dickinson');
insert into ADRESS (adressid, country, city, street)
values (374, 'Brazil', 'S. Bernardo do Campo', '50 Koeln Street');
insert into ADRESS (adressid, country, city, street)
values (375, 'USA', 'Silverdale', '92nd Street');
insert into ADRESS (adressid, country, city, street)
values (376, 'Australia', 'Milton', '51 Leon Blvd');
insert into ADRESS (adressid, country, city, street)
values (377, 'USA', 'Glen allen', '27 Kay Drive');
insert into ADRESS (adressid, country, city, street)
values (378, 'USA', 'Albany', '91st Street');
insert into ADRESS (adressid, country, city, street)
values (379, 'Germany', 'Dresden', '89 Wilder');
insert into ADRESS (adressid, country, city, street)
values (380, 'USA', 'Leawood', '42 Lin Street');
insert into ADRESS (adressid, country, city, street)
values (381, 'USA', 'Casselberry', '4 King Road');
insert into ADRESS (adressid, country, city, street)
values (382, 'USA', 'Lathrop', '49 Mapo-gu Street');
insert into ADRESS (adressid, country, city, street)
values (383, 'Germany', 'Pulheim-brauweiler', '611 Osborne Road');
insert into ADRESS (adressid, country, city, street)
values (384, 'Israel', 'Or-yehuda', '10 Frost Road');
insert into ADRESS (adressid, country, city, street)
values (385, 'Canada', 'Verdun', '89 Mills Blvd');
insert into ADRESS (adressid, country, city, street)
values (386, 'USA', 'Chapel hill', '9 Tom Drive');
insert into ADRESS (adressid, country, city, street)
values (387, 'USA', 'Des Plaines', '44 Laws Street');
insert into ADRESS (adressid, country, city, street)
values (388, 'Netherlands', 'Meppel', '16 Cloris Blvd');
insert into ADRESS (adressid, country, city, street)
values (389, 'United Kingdom', 'Tyne & Wear', '58 Richie Road');
insert into ADRESS (adressid, country, city, street)
values (390, 'USA', 'Barnegat', '82 Lublin Road');
insert into ADRESS (adressid, country, city, street)
values (391, 'United Kingdom', 'Milton Keynes', '15 Jay Street');
insert into ADRESS (adressid, country, city, street)
values (392, 'USA', 'Carmichael', '851 Krabbe');
insert into ADRESS (adressid, country, city, street)
values (393, 'Netherlands', 'Soest', '42 Franz Drive');
insert into ADRESS (adressid, country, city, street)
values (394, 'USA', 'Middletown', '13 Billund Street');
insert into ADRESS (adressid, country, city, street)
values (395, 'Germany', 'Leipzig', '880 Reinhold Street');
insert into ADRESS (adressid, country, city, street)
values (396, 'Denmark', 'Vejle', '1 Lowe Road');
insert into ADRESS (adressid, country, city, street)
values (397, 'USA', 'Akron', '1 Bryan Ave');
insert into ADRESS (adressid, country, city, street)
values (398, 'Denmark', 'Vejle', '368 Canal Winchester Drive');
insert into ADRESS (adressid, country, city, street)
values (399, 'Japan', 'Niigata', '9 Dickinson Ave');
insert into ADRESS (adressid, country, city, street)
values (400, 'Hungary', 'Szazhalombatta', '38 Mac Street');
commit;
prompt 400 records committed...
insert into ADRESS (adressid, country, city, street)
values (401, 'Japan', 'Maebashi', '95 Szazhalombatta Blvd');
insert into ADRESS (adressid, country, city, street)
values (402, 'USA', 'San Francisco', '65 Northbrook Drive');
insert into ADRESS (adressid, country, city, street)
values (403, 'USA', 'Santa Fe', '67 McIntyre Road');
insert into ADRESS (adressid, country, city, street)
values (404, 'United Kingdom', 'Pitstone', '58 Redwood Shores Drive');
insert into ADRESS (adressid, country, city, street)
values (405, 'USA', 'Key Biscayne', '66 Driver Road');
insert into ADRESS (adressid, country, city, street)
values (406, 'Germany', 'Ilmenau', '18 Rundgren Road');
insert into ADRESS (adressid, country, city, street)
values (407, 'USA', 'Jacksonville', '24 Udo Road');
insert into ADRESS (adressid, country, city, street)
values (408, 'Slovenia', 'Ljubljana', '63rd Street');
insert into ADRESS (adressid, country, city, street)
values (409, 'Switzerland', 'Zurich', '7 Embeth Drive');
insert into ADRESS (adressid, country, city, street)
values (410, 'Brazil', 'Limeira', '24 Radovljica Street');
insert into ADRESS (adressid, country, city, street)
values (411, 'United Kingdom', 'Maidstone', '91 St Jean de Soudain Road');
insert into ADRESS (adressid, country, city, street)
values (412, 'South Korea', 'Pusan', '56 Leachman Street');
insert into ADRESS (adressid, country, city, street)
values (413, 'USA', 'West Chester', '51 Favreau Street');
insert into ADRESS (adressid, country, city, street)
values (414, 'Germany', 'Immenstaad', '184 Schreiber Drive');
insert into ADRESS (adressid, country, city, street)
values (415, 'France', 'Boulogne', '68 Bielefeld Drive');
insert into ADRESS (adressid, country, city, street)
values (416, 'United Kingdom', 'Bedfordshire', '100 Ponce Road');
insert into ADRESS (adressid, country, city, street)
values (417, 'Canada', 'Kingston', '13 Shandling Road');
insert into ADRESS (adressid, country, city, street)
values (418, 'Finland', 'Espoo', '72 Doucette Road');
insert into ADRESS (adressid, country, city, street)
values (419, 'Italy', 'Mogliano Veneto', '85 Barkin Blvd');
insert into ADRESS (adressid, country, city, street)
values (420, 'Spain', 'Elche', '34 Milton Drive');
insert into ADRESS (adressid, country, city, street)
values (421, 'United Kingdom', 'Redhill', '18 Kilmer Drive');
insert into ADRESS (adressid, country, city, street)
values (422, 'Germany', 'Koblenz', '96 Mel Road');
insert into ADRESS (adressid, country, city, street)
values (423, 'USA', 'Oak Park', '58 Crispin Blvd');
insert into ADRESS (adressid, country, city, street)
values (424, 'Italy', 'Biella', '82 Linda Ave');
insert into ADRESS (adressid, country, city, street)
values (425, 'USA', 'Lakeville', '68 Douglas Street');
insert into ADRESS (adressid, country, city, street)
values (426, 'USA', 'Anchorage', '24 Tim Road');
insert into ADRESS (adressid, country, city, street)
values (427, 'Italy', 'Trieste', '2 Lesley Road');
insert into ADRESS (adressid, country, city, street)
values (428, 'Germany', 'Bielefeld', '90 Jackie Road');
insert into ADRESS (adressid, country, city, street)
values (429, 'Switzerland', 'Schlieren', '65 Bay Shore Ave');
insert into ADRESS (adressid, country, city, street)
values (430, 'Hong Kong', 'Kwun Tong', '28 København Street');
insert into ADRESS (adressid, country, city, street)
values (431, 'Sweden', 'Karlstad', '4 Farrow Road');
insert into ADRESS (adressid, country, city, street)
values (432, 'Germany', 'Bautzen', '82nd Street');
insert into ADRESS (adressid, country, city, street)
values (433, 'USA', 'Tulsa', '89 Melba Road');
insert into ADRESS (adressid, country, city, street)
values (434, 'USA', 'Herndon', '19 Schwarzenegger Drive');
insert into ADRESS (adressid, country, city, street)
values (435, 'Germany', 'Oppenheim', '82 Skerritt');
insert into ADRESS (adressid, country, city, street)
values (436, 'Austria', 'Koppl', '23 Heath Ave');
insert into ADRESS (adressid, country, city, street)
values (437, 'Canada', 'Longueuil', '52 Waits Ave');
insert into ADRESS (adressid, country, city, street)
values (438, 'USA', 'Miami', '72 Bonham Street');
insert into ADRESS (adressid, country, city, street)
values (439, 'Brazil', 'Ponta grossa', '62 Hauer Street');
insert into ADRESS (adressid, country, city, street)
values (440, 'Belgium', 'Erpe-Mere', '362 David Road');
insert into ADRESS (adressid, country, city, street)
values (441, 'USA', 'Olivette', '80 Shawnee Street');
insert into ADRESS (adressid, country, city, street)
values (442, 'United Kingdom', 'Banbury', '26 Rosanne Street');
insert into ADRESS (adressid, country, city, street)
values (443, 'USA', 'Bay Shore', '82 Bonnie');
insert into ADRESS (adressid, country, city, street)
values (444, 'United Kingdom', 'Pitstone', '81 Piven Blvd');
insert into ADRESS (adressid, country, city, street)
values (445, 'USA', 'Albany', '66 Jean Road');
insert into ADRESS (adressid, country, city, street)
values (446, 'USA', 'Rochester', '4 Stone Road');
insert into ADRESS (adressid, country, city, street)
values (447, 'USA', 'San Ramon', '748 Haynes Drive');
insert into ADRESS (adressid, country, city, street)
values (448, 'USA', 'Athens', '50 Buddy Drive');
insert into ADRESS (adressid, country, city, street)
values (449, 'USA', 'Horsham', '37 Imbruglia Road');
insert into ADRESS (adressid, country, city, street)
values (450, 'USA', 'Stafford', '21 Chiba Road');
insert into ADRESS (adressid, country, city, street)
values (451, 'Iceland', 'Saudarkrokur', '31st Street');
insert into ADRESS (adressid, country, city, street)
values (452, 'Costa Rica', 'San Jose', '45 Sorocaba Street');
insert into ADRESS (adressid, country, city, street)
values (453, 'Turkey', 'Ankara', '33 Willem Drive');
insert into ADRESS (adressid, country, city, street)
values (454, 'Japan', 'Kyoto', '629 Drive Ave');
insert into ADRESS (adressid, country, city, street)
values (455, 'Germany', 'Köln', '42 Malmö Street');
insert into ADRESS (adressid, country, city, street)
values (456, 'Canada', 'Nanaimo', '75 Singh Drive');
insert into ADRESS (adressid, country, city, street)
values (457, 'Russia', 'Solikamsk', '13 Leo Street');
insert into ADRESS (adressid, country, city, street)
values (458, 'Germany', 'Mainz-kastel', '32 Connelly Road');
insert into ADRESS (adressid, country, city, street)
values (459, 'USA', 'Bellevue', '75 Nils Street');
insert into ADRESS (adressid, country, city, street)
values (460, 'USA', 'Albuquerque', '57 Chandler Street');
insert into ADRESS (adressid, country, city, street)
values (461, 'United Kingdom', 'Tadley', '45 Austin Road');
insert into ADRESS (adressid, country, city, street)
values (462, 'USA', 'St. Petersburg', '41 Balaban');
insert into ADRESS (adressid, country, city, street)
values (463, 'Brazil', 'Irati', '63 Strong Blvd');
insert into ADRESS (adressid, country, city, street)
values (464, 'USA', 'San Ramon', '61 Morton Road');
insert into ADRESS (adressid, country, city, street)
values (465, 'Paraguay', 'Ciudad del Este', '58 Tbilisi Road');
insert into ADRESS (adressid, country, city, street)
values (466, 'USA', 'Ricardson', '5 Roddy');
insert into ADRESS (adressid, country, city, street)
values (467, 'USA', 'Shreveport', '42 Valencia Street');
insert into ADRESS (adressid, country, city, street)
values (468, 'Portugal', 'Lisbon', '767 Carrey');
insert into ADRESS (adressid, country, city, street)
values (469, 'Finland', 'Kuopio', '44 Crimson Street');
insert into ADRESS (adressid, country, city, street)
values (470, 'Brazil', 'Juazeiro', '79 DiFranco Road');
insert into ADRESS (adressid, country, city, street)
values (471, 'Finland', 'Kerava', '35 Shelby Drive');
insert into ADRESS (adressid, country, city, street)
values (472, 'USA', 'Livermore', '100 Salvador Street');
insert into ADRESS (adressid, country, city, street)
values (473, 'USA', 'Hercules', '23rd Street');
insert into ADRESS (adressid, country, city, street)
values (474, 'Germany', 'Ulm', '271 Mary Drive');
insert into ADRESS (adressid, country, city, street)
values (475, 'USA', 'Dunn loring', '32 Connelly Street');
insert into ADRESS (adressid, country, city, street)
values (476, 'USA', 'Oshkosh', '762 Haynes Ave');
insert into ADRESS (adressid, country, city, street)
values (477, 'USA', 'Alpharetta', '214 Holly Street');
insert into ADRESS (adressid, country, city, street)
values (478, 'Hungary', 'Budapest', '760 Langella Drive');
insert into ADRESS (adressid, country, city, street)
values (479, 'Australia', 'Canberra', '34 Kelly Drive');
insert into ADRESS (adressid, country, city, street)
values (480, 'Poland', 'Warszawa', '85 Täby Street');
insert into ADRESS (adressid, country, city, street)
values (481, 'USA', 'O''fallon', '77 Davidtz Road');
insert into ADRESS (adressid, country, city, street)
values (482, 'USA', 'Seattle', '68 Atlas Road');
insert into ADRESS (adressid, country, city, street)
values (483, 'Germany', 'Essen', '6 Hewett Blvd');
insert into ADRESS (adressid, country, city, street)
values (484, 'USA', 'Moorestown', '739 Mirren');
insert into ADRESS (adressid, country, city, street)
values (485, 'Germany', 'Pirmasens', '83 Hope Street');
insert into ADRESS (adressid, country, city, street)
values (486, 'USA', 'Westport', '90 Derringer Ave');
insert into ADRESS (adressid, country, city, street)
values (487, 'Canada', 'Richmond Hill', '24 Mekhi Road');
insert into ADRESS (adressid, country, city, street)
values (488, 'USA', 'Reno', '41 San Antonio Blvd');
insert into ADRESS (adressid, country, city, street)
values (489, 'South Korea', 'Seongnam-si', '70 Brando');
insert into ADRESS (adressid, country, city, street)
values (490, 'Norway', 'Oslo', '468 Curry Road');
insert into ADRESS (adressid, country, city, street)
values (491, 'Germany', 'Dortmund', '88 Greenwood Street');
insert into ADRESS (adressid, country, city, street)
values (492, 'Canada', 'Powell River', '94 Carlin Drive');
insert into ADRESS (adressid, country, city, street)
values (493, 'USA', 'Burlington', '70 Andre');
insert into ADRESS (adressid, country, city, street)
values (494, 'South Africa', 'Cape town', '83 Mraz Blvd');
insert into ADRESS (adressid, country, city, street)
values (495, 'Switzerland', 'Kloten', '100 Minneapolis Drive');
insert into ADRESS (adressid, country, city, street)
values (496, 'Mexico', 'Mexico City', '21st Street');
insert into ADRESS (adressid, country, city, street)
values (497, 'United Kingdom', 'Market Harborough', '49 Valencia Drive');
insert into ADRESS (adressid, country, city, street)
values (498, 'USA', 'Durham', '6 Orbit Ave');
insert into ADRESS (adressid, country, city, street)
values (499, 'Norway', 'Kongserbg', '20 Jonatha Ave');
insert into ADRESS (adressid, country, city, street)
values (500, 'Netherlands', 'Den Haag', '51 Elias Drive');
commit;
prompt 500 records committed...
insert into ADRESS (adressid, country, city, street)
values (501, 'Switzerland', 'Sursee', '52 Mississauga Street');
insert into ADRESS (adressid, country, city, street)
values (502, 'Canada', 'London', '34 Nash Street');
insert into ADRESS (adressid, country, city, street)
values (503, 'Turkey', 'Ankara', '54 Varzea grande');
insert into ADRESS (adressid, country, city, street)
values (504, 'Germany', 'Lahr', '71st Street');
insert into ADRESS (adressid, country, city, street)
values (505, 'USA', 'Birmingham', '52 Mary Street');
insert into ADRESS (adressid, country, city, street)
values (506, 'USA', 'Marlboro', '23 Liquid Blvd');
insert into ADRESS (adressid, country, city, street)
values (507, 'Netherlands', 'Uden', '613 Burlington Road');
insert into ADRESS (adressid, country, city, street)
values (508, 'Canada', 'Guelph', '89 Abraham Blvd');
insert into ADRESS (adressid, country, city, street)
values (509, 'Germany', 'Norderstedt', '33 Patillo Road');
insert into ADRESS (adressid, country, city, street)
values (510, 'Germany', 'Nuernberg', '57 Kiefer');
insert into ADRESS (adressid, country, city, street)
values (511, 'USA', 'Beaverton', '143 Diffie Ave');
insert into ADRESS (adressid, country, city, street)
values (512, 'USA', 'Walnut Creek', '22 Crystal Street');
insert into ADRESS (adressid, country, city, street)
values (513, 'United Kingdom', 'Sheffield', '281 Ramsey Street');
insert into ADRESS (adressid, country, city, street)
values (514, 'United Kingdom', 'Paisley', '12nd Street');
insert into ADRESS (adressid, country, city, street)
values (515, 'Poland', 'Gdansk', '13 Seoul');
insert into ADRESS (adressid, country, city, street)
values (516, 'Italy', 'Piacenza', '53 Debra Drive');
insert into ADRESS (adressid, country, city, street)
values (517, 'Brazil', 'Irati', '32nd Street');
insert into ADRESS (adressid, country, city, street)
values (518, 'Germany', 'Eisenhüttenstadt', '7 San Francisco Drive');
insert into ADRESS (adressid, country, city, street)
values (519, 'USA', 'New Fairfield', '98 Xander');
insert into ADRESS (adressid, country, city, street)
values (520, 'Brazil', 'Mogi Guacu', '98 Singh Street');
insert into ADRESS (adressid, country, city, street)
values (521, 'Hong Kong', 'Kwun Tong', '62 Oded');
insert into ADRESS (adressid, country, city, street)
values (522, 'Canada', 'Dartmouth', '78 Hawke Street');
insert into ADRESS (adressid, country, city, street)
values (523, 'Germany', 'Harsum', '57 Edenbridge Road');
insert into ADRESS (adressid, country, city, street)
values (524, 'Austria', 'Koppl', '17 Nile Blvd');
insert into ADRESS (adressid, country, city, street)
values (525, 'Russia', 'Nizhnevartovsk', '19 Neil Street');
insert into ADRESS (adressid, country, city, street)
values (526, 'Taiwan', 'Taoyuan', '2 San Ramon Street');
insert into ADRESS (adressid, country, city, street)
values (527, 'Japan', 'Nagoya', '30 Debra Blvd');
insert into ADRESS (adressid, country, city, street)
values (528, 'Spain', 'Valencia', '13 Tim Road');
insert into ADRESS (adressid, country, city, street)
values (529, 'Brazil', 'Aracruz', '60 Juliet Ave');
insert into ADRESS (adressid, country, city, street)
values (530, 'USA', 'Marietta', '11 Almond Street');
insert into ADRESS (adressid, country, city, street)
values (531, 'Switzerland', 'Birmensdorf', '80 Birmingham Drive');
insert into ADRESS (adressid, country, city, street)
values (532, 'Germany', 'Freising', '93rd Street');
insert into ADRESS (adressid, country, city, street)
values (533, 'USA', 'Manchester', '83rd Street');
insert into ADRESS (adressid, country, city, street)
values (534, 'Norway', 'Bønes', '58 Cruise Street');
insert into ADRESS (adressid, country, city, street)
values (535, 'Germany', 'Kreuzau', '35 Nickel Street');
insert into ADRESS (adressid, country, city, street)
values (536, 'Norway', 'Eiksmarka', '153 Supernaw Street');
insert into ADRESS (adressid, country, city, street)
values (537, 'USA', 'Pittsburgh', '98 Payne Street');
insert into ADRESS (adressid, country, city, street)
values (538, 'USA', 'Avon', '41 LaSalle Drive');
insert into ADRESS (adressid, country, city, street)
values (539, 'United Kingdom', 'Farnham', '9 Moody Blvd');
insert into ADRESS (adressid, country, city, street)
values (540, 'USA', 'Kaysville', '68 Armand Road');
insert into ADRESS (adressid, country, city, street)
values (541, 'United Kingdom', 'Horsham', '70 Cale Road');
insert into ADRESS (adressid, country, city, street)
values (542, 'Canada', 'Richmond Hill', '37 Nelson Drive');
insert into ADRESS (adressid, country, city, street)
values (543, 'Germany', 'Nordhausen', '94 McGoohan Road');
insert into ADRESS (adressid, country, city, street)
values (544, 'USA', 'The Woodlands', '4 Fox Blvd');
insert into ADRESS (adressid, country, city, street)
values (545, 'USA', 'West Lafayette', '87 Kloten Drive');
insert into ADRESS (adressid, country, city, street)
values (546, 'Denmark', 'Copenhagen', '83 Atkins Street');
insert into ADRESS (adressid, country, city, street)
values (547, 'USA', 'Amherst', '28 Victor');
insert into ADRESS (adressid, country, city, street)
values (548, 'Israel', 'Yavne', '89 Mount Laurel Road');
insert into ADRESS (adressid, country, city, street)
values (549, 'USA', 'Harahan', '70 North bethesda Ave');
insert into ADRESS (adressid, country, city, street)
values (550, 'USA', 'Irving', '636 Pryce Ave');
insert into ADRESS (adressid, country, city, street)
values (551, 'Germany', 'Duesseldorf', '98 Makeba Road');
insert into ADRESS (adressid, country, city, street)
values (552, 'Canada', 'Coquitlam', '487 Green Drive');
insert into ADRESS (adressid, country, city, street)
values (553, 'Germany', 'Mainz-kastel', '7 Hall Street');
insert into ADRESS (adressid, country, city, street)
values (554, 'USA', 'Hermitage', '56 Schwarzenegger Ave');
insert into ADRESS (adressid, country, city, street)
values (555, 'USA', 'Marietta', '50 New York Drive');
insert into ADRESS (adressid, country, city, street)
values (556, 'USA', 'Brisbane', '11 Ticotin Road');
insert into ADRESS (adressid, country, city, street)
values (557, 'USA', 'Rocklin', '316 James Drive');
insert into ADRESS (adressid, country, city, street)
values (558, 'Belgium', 'Drogenbos', '41st Street');
insert into ADRESS (adressid, country, city, street)
values (559, 'USA', 'Pasadena', '92 Bernard Road');
insert into ADRESS (adressid, country, city, street)
values (560, 'United Kingdom', 'Warrington', '90 Charleston Blvd');
insert into ADRESS (adressid, country, city, street)
values (561, 'USA', 'North bethesda', '81 Griggs Road');
insert into ADRESS (adressid, country, city, street)
values (562, 'Germany', 'Ismaning', '15 Mortensen Ave');
insert into ADRESS (adressid, country, city, street)
values (563, 'USA', 'Butner', '50 Lachey');
insert into ADRESS (adressid, country, city, street)
values (564, 'USA', 'Scottsdale', '822 Rawls Street');
insert into ADRESS (adressid, country, city, street)
values (565, 'Japan', 'Tokushima', '87 Joseph Drive');
insert into ADRESS (adressid, country, city, street)
values (566, 'Brazil', 'Curitiba', '239 Arden Road');
insert into ADRESS (adressid, country, city, street)
values (567, 'USA', 'Knoxville', '414 Prowse Ave');
insert into ADRESS (adressid, country, city, street)
values (568, 'United Kingdom', 'Slough', '9 Gladys Blvd');
insert into ADRESS (adressid, country, city, street)
values (569, 'USA', 'Lake worth', '875 Vinton Drive');
insert into ADRESS (adressid, country, city, street)
values (570, 'USA', 'Carmichael', '32nd Street');
insert into ADRESS (adressid, country, city, street)
values (571, 'USA', 'Bloomington', '180 Brolin Street');
insert into ADRESS (adressid, country, city, street)
values (572, 'Ireland', 'Dublin', '61 McCormack Drive');
insert into ADRESS (adressid, country, city, street)
values (573, 'USA', 'Greenwood Village', '64 Carmen Street');
insert into ADRESS (adressid, country, city, street)
values (574, 'Netherlands', 'Baarn', '73 Brooke Ave');
insert into ADRESS (adressid, country, city, street)
values (575, 'Sweden', 'Gävle', '49 Scott Road');
insert into ADRESS (adressid, country, city, street)
values (576, 'USA', 'West Monroe', '100 Arden Road');
insert into ADRESS (adressid, country, city, street)
values (577, 'Finland', 'Vantaa', '98 Trevino Road');
insert into ADRESS (adressid, country, city, street)
values (578, 'USA', 'Cedar Rapids', '56 Van Der Beek Street');
insert into ADRESS (adressid, country, city, street)
values (579, 'Brazil', 'Pirapora bom Jesus', '26 Pleasure Road');
insert into ADRESS (adressid, country, city, street)
values (580, 'Norway', 'Ulsteinvik', '33 Nanaimo');
insert into ADRESS (adressid, country, city, street)
values (581, 'USA', 'Mayfield Village', '43 Streep Street');
insert into ADRESS (adressid, country, city, street)
values (582, 'Sweden', 'Sundsvall', '93 Bernex Drive');
insert into ADRESS (adressid, country, city, street)
values (583, 'Switzerland', 'Massagno', '66 Witt');
insert into ADRESS (adressid, country, city, street)
values (584, 'United Kingdom', 'Mablethorpe', '63 Tennison Road');
insert into ADRESS (adressid, country, city, street)
values (585, 'Italy', 'Zafferana Etnea', '88 Thame Street');
insert into ADRESS (adressid, country, city, street)
values (586, 'United Kingdom', 'Santa Clarat', '22 Kirshner Street');
insert into ADRESS (adressid, country, city, street)
values (587, 'USA', 'Charlottesville', '3 Edgar Drive');
insert into ADRESS (adressid, country, city, street)
values (588, 'Brazil', 'Recife', '279 Hurley Street');
insert into ADRESS (adressid, country, city, street)
values (589, 'Ireland', 'Bologna', '25 Burmester Street');
insert into ADRESS (adressid, country, city, street)
values (590, 'Palestine', 'Gaza', '20 Fukui Street');
insert into ADRESS (adressid, country, city, street)
values (591, 'Germany', 'Offenburg', '69 Woodbridge Ave');
insert into ADRESS (adressid, country, city, street)
values (592, 'USA', 'Edison', '38 Mann Street');
insert into ADRESS (adressid, country, city, street)
values (593, 'United Kingdom', 'Bedfordshire', '73 Folds Street');
insert into ADRESS (adressid, country, city, street)
values (594, 'USA', 'Franklin', '12 Kinski Street');
insert into ADRESS (adressid, country, city, street)
values (595, 'Finland', 'Oulu', '878 Art Road');
insert into ADRESS (adressid, country, city, street)
values (596, 'Germany', 'Ingelheim', '99 Mike Blvd');
insert into ADRESS (adressid, country, city, street)
values (597, 'Canada', 'Nepean', '78 Marsden Road');
insert into ADRESS (adressid, country, city, street)
values (598, 'USA', 'Tucson', '18 Gore Road');
insert into ADRESS (adressid, country, city, street)
values (599, 'USA', 'Lehi', '816 Colombo Street');
insert into ADRESS (adressid, country, city, street)
values (600, 'United Kingdom', 'Warley', '14 Tippe Ave');
commit;
prompt 600 records committed...
insert into ADRESS (adressid, country, city, street)
values (601, 'Italy', 'Padova', '72 Wen Blvd');
insert into ADRESS (adressid, country, city, street)
values (602, 'USA', 'Farmington Hills', '861 Franz Drive');
insert into ADRESS (adressid, country, city, street)
values (603, 'Canada', 'Dorval', '86 Rickman Drive');
insert into ADRESS (adressid, country, city, street)
values (604, 'USA', 'Exeter', '33 Boucherville');
insert into ADRESS (adressid, country, city, street)
values (605, 'Austria', 'Ternitz', '67 Leto Drive');
insert into ADRESS (adressid, country, city, street)
values (606, 'United Kingdom', 'Horsham', '658 Merillee Drive');
insert into ADRESS (adressid, country, city, street)
values (607, 'Germany', 'Dreieich', '50 Marianne Road');
insert into ADRESS (adressid, country, city, street)
values (608, 'USA', 'Olivette', '534 Robbie Street');
insert into ADRESS (adressid, country, city, street)
values (609, 'Australia', 'Burwood East', '71st Street');
insert into ADRESS (adressid, country, city, street)
values (610, 'Israel', 'Ben-Gurion', '5 Elizondo Road');
insert into ADRESS (adressid, country, city, street)
values (611, 'USA', 'Buffalo Grove', '83 Hynde Road');
insert into ADRESS (adressid, country, city, street)
values (612, 'Netherlands', 'Enschede', '38 Karlsruhe Road');
insert into ADRESS (adressid, country, city, street)
values (613, 'USA', 'Baltimore', '44 Baldwin Street');
insert into ADRESS (adressid, country, city, street)
values (614, 'Denmark', 'Odense', '68 Zane');
insert into ADRESS (adressid, country, city, street)
values (615, 'USA', 'Westfield', '62 McClinton Road');
insert into ADRESS (adressid, country, city, street)
values (616, 'USA', 'Oshkosh', '82 Dillane Ave');
insert into ADRESS (adressid, country, city, street)
values (617, 'USA', 'South Hadley', '78 Alana Drive');
insert into ADRESS (adressid, country, city, street)
values (618, 'USA', 'Athens', '8 Broza Drive');
insert into ADRESS (adressid, country, city, street)
values (619, 'USA', 'Sugar Land', '22 Gävle Road');
insert into ADRESS (adressid, country, city, street)
values (620, 'France', 'Dardilly', '82nd Street');
insert into ADRESS (adressid, country, city, street)
values (621, 'USA', 'Carmichael', '390 Liv');
insert into ADRESS (adressid, country, city, street)
values (622, 'Switzerland', 'Kloten', '39 Irons Road');
insert into ADRESS (adressid, country, city, street)
values (623, 'Germany', 'Michendorf', '98 Gersthofen');
insert into ADRESS (adressid, country, city, street)
values (624, 'Slovakia', 'Bratislava', '91 Barbengo Drive');
insert into ADRESS (adressid, country, city, street)
values (625, 'Mexico', 'Monterrey', '5 Colman Drive');
insert into ADRESS (adressid, country, city, street)
values (626, 'USA', 'Hackensack', '52 Betty Ave');
insert into ADRESS (adressid, country, city, street)
values (627, 'USA', 'New Haven', '76 Vondie');
insert into ADRESS (adressid, country, city, street)
values (628, 'Portugal', 'Lisbon', '64 Collective Street');
insert into ADRESS (adressid, country, city, street)
values (629, 'Czech republic', 'Brno', '88 Delta');
insert into ADRESS (adressid, country, city, street)
values (630, 'USA', 'Gettysburg', '559 Tulsa Ave');
insert into ADRESS (adressid, country, city, street)
values (631, 'Italy', 'Venice', '10 Alpharetta Road');
insert into ADRESS (adressid, country, city, street)
values (632, 'USA', 'Flushing', '19 Sally Street');
insert into ADRESS (adressid, country, city, street)
values (633, 'Sweden', 'Kista', '13 Rawlins Road');
insert into ADRESS (adressid, country, city, street)
values (634, 'Germany', 'München', '74 Weber Ave');
insert into ADRESS (adressid, country, city, street)
values (635, 'Canada', 'Summerside', '31 Meniketti Drive');
insert into ADRESS (adressid, country, city, street)
values (636, 'USA', 'Holts Summit', '84 Collin Street');
insert into ADRESS (adressid, country, city, street)
values (637, 'Germany', 'Dortmund', '563 Ryan Drive');
insert into ADRESS (adressid, country, city, street)
values (638, 'Argentina', 'Rosario', '33 Vendetta Road');
insert into ADRESS (adressid, country, city, street)
values (639, 'United Kingdom', 'Bedfordshire', '76 Randal');
insert into ADRESS (adressid, country, city, street)
values (640, 'Germany', 'Goslar', '7 Taryn Road');
insert into ADRESS (adressid, country, city, street)
values (641, 'Germany', 'Ebersberg', '60 Lupe Road');
insert into ADRESS (adressid, country, city, street)
values (642, 'Italy', 'Mogliano Veneto', '18 Brothers Drive');
insert into ADRESS (adressid, country, city, street)
values (643, 'USA', 'Santa Fe', '57 Waits');
insert into ADRESS (adressid, country, city, street)
values (644, 'USA', 'Clark', '35 Rhona Drive');
insert into ADRESS (adressid, country, city, street)
values (645, 'Spain', 'Palma de Mallorca', '17 Canal Winchester Road');
insert into ADRESS (adressid, country, city, street)
values (646, 'Austria', 'Linz', '3 Syracuse Ave');
insert into ADRESS (adressid, country, city, street)
values (647, 'USA', 'Framingaham', '99 Hauer Street');
insert into ADRESS (adressid, country, city, street)
values (648, 'Canada', 'Dorval', '3 Kenoly Street');
insert into ADRESS (adressid, country, city, street)
values (649, 'USA', 'Pacific Grove', '420 Solomon Drive');
insert into ADRESS (adressid, country, city, street)
values (650, 'Switzerland', 'Belp', '63 Parish Road');
insert into ADRESS (adressid, country, city, street)
values (651, 'USA', 'Indianapolis', '87 Angie Street');
insert into ADRESS (adressid, country, city, street)
values (652, 'USA', 'Houston', '11 Riverdale Street');
insert into ADRESS (adressid, country, city, street)
values (653, 'Spain', 'Valencia', '5 Borgnine Road');
insert into ADRESS (adressid, country, city, street)
values (654, 'USA', 'Ellicott City', '41 Haggard Drive');
insert into ADRESS (adressid, country, city, street)
values (655, 'Australia', 'Melbourne', '228 Alan Drive');
insert into ADRESS (adressid, country, city, street)
values (656, 'Germany', 'Leverkusen', '7 Nelson Street');
insert into ADRESS (adressid, country, city, street)
values (657, 'South Africa', 'Stellenbosch', '25 Caviezel Street');
insert into ADRESS (adressid, country, city, street)
values (658, 'USA', 'Palo Alto', '77 Heald Street');
insert into ADRESS (adressid, country, city, street)
values (659, 'United Kingdom', 'Edinburgh', '52 Winger Street');
insert into ADRESS (adressid, country, city, street)
values (660, 'Italy', 'Novara', '82 Platt Ave');
insert into ADRESS (adressid, country, city, street)
values (661, 'South Africa', 'Halfway house', '13 Reykjavik Ave');
insert into ADRESS (adressid, country, city, street)
values (662, 'USA', 'Framingham', '90 Valladolid Road');
insert into ADRESS (adressid, country, city, street)
values (663, 'USA', 'Double Oak', '96 McCain Road');
insert into ADRESS (adressid, country, city, street)
values (664, 'Denmark', 'Vejle', '56 Red');
insert into ADRESS (adressid, country, city, street)
values (665, 'Austria', 'Linz', '455 Silverdale Ave');
insert into ADRESS (adressid, country, city, street)
values (666, 'USA', 'San Francisco', '45 Almaty Drive');
insert into ADRESS (adressid, country, city, street)
values (667, 'Germany', 'Goslar', '56 Sewell Road');
insert into ADRESS (adressid, country, city, street)
values (668, 'Brazil', 'Sao roque', '12nd Street');
insert into ADRESS (adressid, country, city, street)
values (669, 'USA', 'Lowell', '76 Delbert Drive');
insert into ADRESS (adressid, country, city, street)
values (670, 'USA', 'Farmington Hills', '63 Guamo Ave');
insert into ADRESS (adressid, country, city, street)
values (671, 'France', 'Nancy', '51 Adler Drive');
insert into ADRESS (adressid, country, city, street)
values (672, 'Germany', 'Kaiserslautern', '51 Secada Road');
insert into ADRESS (adressid, country, city, street)
values (673, 'USA', 'Jacksonville', '65 Joey');
insert into ADRESS (adressid, country, city, street)
values (674, 'Liechtenstein', 'Vaduz', '555 Judi Street');
insert into ADRESS (adressid, country, city, street)
values (675, 'Australia', 'Milton', '598 Birmingham Street');
insert into ADRESS (adressid, country, city, street)
values (676, 'Denmark', 'Copenhagen', '130 Bosco Street');
insert into ADRESS (adressid, country, city, street)
values (677, 'Sweden', 'Stockholm', '90 East Providence Ave');
insert into ADRESS (adressid, country, city, street)
values (678, 'France', 'Saint Ouen', '42 Paramus Street');
insert into ADRESS (adressid, country, city, street)
values (679, 'Germany', 'Friedrichshafe', '12nd Street');
insert into ADRESS (adressid, country, city, street)
values (680, 'USA', 'Madison', '77 Davison Road');
insert into ADRESS (adressid, country, city, street)
values (681, 'USA', 'Solon', '22nd Street');
insert into ADRESS (adressid, country, city, street)
values (682, 'USA', 'Bellevue', '36 Palin Street');
insert into ADRESS (adressid, country, city, street)
values (683, 'Brazil', 'Irati', '32 Sinead');
insert into ADRESS (adressid, country, city, street)
values (684, 'United Kingdom', 'Coldmeece', '77 Nicosia Drive');
insert into ADRESS (adressid, country, city, street)
values (685, 'USA', 'Amherst', '92nd Street');
insert into ADRESS (adressid, country, city, street)
values (686, 'Cameroun', 'Douala', '40 Agoncillo Ave');
insert into ADRESS (adressid, country, city, street)
values (687, 'USA', 'Olivette', '31 Gina Road');
insert into ADRESS (adressid, country, city, street)
values (688, 'South Korea', 'Seongnam-si', '87 Copeland Ave');
insert into ADRESS (adressid, country, city, street)
values (689, 'United Kingdom', 'Maidenhead', '11st Street');
insert into ADRESS (adressid, country, city, street)
values (690, 'Japan', 'Yokohama', '21 Toronto Drive');
insert into ADRESS (adressid, country, city, street)
values (691, 'Switzerland', 'Appenzell', '40 Berkshire Street');
insert into ADRESS (adressid, country, city, street)
values (692, 'USA', 'Bham', '24 Vern');
insert into ADRESS (adressid, country, city, street)
values (693, 'Brazil', 'Cuiabá', '43rd Street');
insert into ADRESS (adressid, country, city, street)
values (694, 'Russia', 'Protvino', '82 Philip Street');
insert into ADRESS (adressid, country, city, street)
values (695, 'United Kingdom', 'Coventry', '48 Marina Street');
insert into ADRESS (adressid, country, city, street)
values (696, 'USA', 'San Ramon', '62nd Street');
insert into ADRESS (adressid, country, city, street)
values (697, 'USA', 'Albany', '52 Purley Road');
insert into ADRESS (adressid, country, city, street)
values (698, 'USA', 'Loveland', '10 Essex Road');
insert into ADRESS (adressid, country, city, street)
values (699, 'USA', 'Waco', '8 Mandy Street');
insert into ADRESS (adressid, country, city, street)
values (700, 'France', 'Nancy', '62nd Street');
commit;
prompt 700 records committed...
insert into ADRESS (adressid, country, city, street)
values (701, 'USA', 'Saint Paul', '16 Barnegat Road');
insert into ADRESS (adressid, country, city, street)
values (702, 'USA', 'Bingham Farms', '61 Warburton Road');
insert into ADRESS (adressid, country, city, street)
values (703, 'New Caledonia', 'Noumea', '5 Lipnicki');
insert into ADRESS (adressid, country, city, street)
values (704, 'USA', 'Raleigh', '23 Lily Road');
insert into ADRESS (adressid, country, city, street)
values (705, 'Brazil', 'Santa rita sapucaí', '21 Ribisi Blvd');
insert into ADRESS (adressid, country, city, street)
values (706, 'USA', 'Knoxville', '85 Duvall Road');
insert into ADRESS (adressid, country, city, street)
values (707, 'USA', 'Denver', '606 Osment Ave');
insert into ADRESS (adressid, country, city, street)
values (708, 'USA', 'New hartford', '920 Minneapolis Road');
insert into ADRESS (adressid, country, city, street)
values (709, 'USA', 'Stone Mountain', '13 Balk');
insert into ADRESS (adressid, country, city, street)
values (710, 'Germany', 'Herne', '19 Utada Road');
insert into ADRESS (adressid, country, city, street)
values (711, 'USA', 'Valencia', '14 Thelma Road');
insert into ADRESS (adressid, country, city, street)
values (712, 'USA', 'Nashua', '90 Swinton Road');
insert into ADRESS (adressid, country, city, street)
values (713, 'Germany', 'Friedrichshafe', '82 Edwardstown');
insert into ADRESS (adressid, country, city, street)
values (714, 'USA', 'Milpitas', '673 Buckingham Road');
insert into ADRESS (adressid, country, city, street)
values (715, 'Canada', 'Fort Saskatchewan', '61st Street');
insert into ADRESS (adressid, country, city, street)
values (716, 'Belgium', 'Paal Beringen', '14 Peebles Blvd');
insert into ADRESS (adressid, country, city, street)
values (717, 'USA', 'Laurel', '10 Nantes Drive');
insert into ADRESS (adressid, country, city, street)
values (718, 'USA', 'Laurel', '53 Penders Road');
insert into ADRESS (adressid, country, city, street)
values (719, 'USA', 'Boise', '72 Vai Street');
insert into ADRESS (adressid, country, city, street)
values (720, 'Canada', 'Bolton', '707 Sophie Drive');
insert into ADRESS (adressid, country, city, street)
values (721, 'USA', 'Whitehouse Station', '84 Greenville Blvd');
insert into ADRESS (adressid, country, city, street)
values (722, 'USA', 'Atlanta', '56 Douala Drive');
insert into ADRESS (adressid, country, city, street)
values (723, 'South Korea', 'Anyang-si', '4 Raybon Street');
insert into ADRESS (adressid, country, city, street)
values (724, 'Brazil', 'Sao caetano do sul', '56 Juazeiro Drive');
insert into ADRESS (adressid, country, city, street)
values (725, 'Italy', 'Pordenone', '42nd Street');
insert into ADRESS (adressid, country, city, street)
values (726, 'Switzerland', 'Zürich', '39 Peter Blvd');
insert into ADRESS (adressid, country, city, street)
values (727, 'France', 'Le chesnay', '72 DiBiasio Ave');
insert into ADRESS (adressid, country, city, street)
values (728, 'Japan', 'Kumamoto', '13 Nicholas Street');
insert into ADRESS (adressid, country, city, street)
values (729, 'Italy', 'Milan', '59 Redford Street');
insert into ADRESS (adressid, country, city, street)
values (730, 'United Kingdom', 'Banbury', '71 Alpharetta Drive');
insert into ADRESS (adressid, country, city, street)
values (731, 'Sweden', 'Gothenburg', '67 Merchant Road');
insert into ADRESS (adressid, country, city, street)
values (732, 'USA', 'Charlottesville', '60 Gauteng Road');
insert into ADRESS (adressid, country, city, street)
values (733, 'Iceland', 'Saudarkrokur', '95 Nakai Blvd');
insert into ADRESS (adressid, country, city, street)
values (734, 'United Kingdom', 'Warrington', '1 Neustadt Road');
insert into ADRESS (adressid, country, city, street)
values (735, 'Brazil', 'Pirapora bom Jesus', '46 Holly Ave');
insert into ADRESS (adressid, country, city, street)
values (736, 'Spain', 'Sant Cugat Del Valle', '12nd Street');
insert into ADRESS (adressid, country, city, street)
values (737, 'USA', 'Rockland', '52 Ratzenberger Street');
insert into ADRESS (adressid, country, city, street)
values (738, 'USA', 'Peachtree City', '1 Esposito Road');
insert into ADRESS (adressid, country, city, street)
values (739, 'Czech republic', 'Brno', '65 Rawls Street');
insert into ADRESS (adressid, country, city, street)
values (740, 'Italy', 'Firenze', '92 Tramaine Road');
insert into ADRESS (adressid, country, city, street)
values (741, 'USA', 'Sapulpa', '13 Apple Ave');
insert into ADRESS (adressid, country, city, street)
values (742, 'France', 'L''union', '60 Londrina Road');
insert into ADRESS (adressid, country, city, street)
values (743, 'Germany', 'Michendorf', '779 Tambor Street');
insert into ADRESS (adressid, country, city, street)
values (744, 'Germany', 'Kreuzau', '43 Green bay Drive');
insert into ADRESS (adressid, country, city, street)
values (745, 'USA', 'Reno', '60 Kazem Road');
insert into ADRESS (adressid, country, city, street)
values (746, 'Cameroun', 'Douala', '4 Bello Blvd');
insert into ADRESS (adressid, country, city, street)
values (747, 'France', 'Lyon', '89 Rosas Ave');
insert into ADRESS (adressid, country, city, street)
values (748, 'Denmark', 'Fredericia', '3 May Street');
insert into ADRESS (adressid, country, city, street)
values (749, 'Switzerland', 'Zuerich', '93 Miller Street');
insert into ADRESS (adressid, country, city, street)
values (750, 'Australia', 'Milsons Point', '854 Balin Road');
insert into ADRESS (adressid, country, city, street)
values (751, 'United Kingdom', 'High Wycombe', '60 Nakai Ave');
insert into ADRESS (adressid, country, city, street)
values (752, 'USA', 'Yucca', '550 Sandra Blvd');
insert into ADRESS (adressid, country, city, street)
values (753, 'USA', 'Mount Olive', '598 Kim Street');
insert into ADRESS (adressid, country, city, street)
values (754, 'USA', 'Coppell', '70 Sanchez Drive');
insert into ADRESS (adressid, country, city, street)
values (755, 'Portugal', 'Caguas', '50 Aaron Blvd');
insert into ADRESS (adressid, country, city, street)
values (756, 'Switzerland', 'Holderbank', '109 Ossie Street');
insert into ADRESS (adressid, country, city, street)
values (757, 'Germany', 'Gummersbach', '71 Norton Blvd');
insert into ADRESS (adressid, country, city, street)
values (758, 'USA', 'Benbrook', '12 Dorn Street');
insert into ADRESS (adressid, country, city, street)
values (759, 'Denmark', 'Soroe', '892 Matthau Street');
insert into ADRESS (adressid, country, city, street)
values (760, 'USA', 'Pompton Plains', '84 Minnie Ave');
insert into ADRESS (adressid, country, city, street)
values (761, 'Switzerland', 'Geneve', '375 Sepulveda Street');
insert into ADRESS (adressid, country, city, street)
values (762, 'USA', 'Milford', '679 Tilda Drive');
insert into ADRESS (adressid, country, city, street)
values (763, 'Spain', 'Valencia', '47 Suvari Drive');
insert into ADRESS (adressid, country, city, street)
values (764, 'Argentina', 'Neuquen', '89 Gates Road');
insert into ADRESS (adressid, country, city, street)
values (765, 'Germany', 'Leinfelden-Echterdin', '20 Elisabeth Ave');
insert into ADRESS (adressid, country, city, street)
values (766, 'United Kingdom', 'Thame', '296 Reubens Street');
insert into ADRESS (adressid, country, city, street)
values (767, 'USA', 'Grapevine', '386 Anthony Road');
insert into ADRESS (adressid, country, city, street)
values (768, 'Greece', 'Athens', '97 Allen Ave');
insert into ADRESS (adressid, country, city, street)
values (769, 'Italy', 'Fornacette', '40 Claire Drive');
insert into ADRESS (adressid, country, city, street)
values (770, 'USA', 'Slmea', '9 Franklin Road');
insert into ADRESS (adressid, country, city, street)
values (771, 'Switzerland', 'Hochwald', '13rd Street');
insert into ADRESS (adressid, country, city, street)
values (772, 'USA', 'Overland park', '56 Purley Road');
insert into ADRESS (adressid, country, city, street)
values (773, 'Brazil', 'Londrina', '29 Jon Street');
insert into ADRESS (adressid, country, city, street)
values (774, 'Norway', 'Oslo', '25 Lindsay Ave');
insert into ADRESS (adressid, country, city, street)
values (775, 'Germany', 'Herne', '67 Beaverton Road');
insert into ADRESS (adressid, country, city, street)
values (776, 'USA', 'Rockford', '100 Fuchstal-asch Road');
insert into ADRESS (adressid, country, city, street)
values (777, 'Norway', 'Oslo', '176 William Drive');
insert into ADRESS (adressid, country, city, street)
values (778, 'Japan', 'Morioka', '77 Atlas Drive');
insert into ADRESS (adressid, country, city, street)
values (779, 'Canada', 'Montréal', '7 Eileen Ave');
insert into ADRESS (adressid, country, city, street)
values (780, 'France', 'Gennevilliers', '82nd Street');
insert into ADRESS (adressid, country, city, street)
values (781, 'USA', 'Derwood', '82 Kobe Drive');
insert into ADRESS (adressid, country, city, street)
values (782, 'South Africa', 'Durban', '26 Regina Street');
insert into ADRESS (adressid, country, city, street)
values (783, 'USA', 'Altamonte Springs', '68 Beckham Road');
insert into ADRESS (adressid, country, city, street)
values (784, 'Switzerland', 'Holderbank', '68 Cuba Street');
insert into ADRESS (adressid, country, city, street)
values (785, 'Switzerland', 'Geneva', '32nd Street');
insert into ADRESS (adressid, country, city, street)
values (786, 'Brazil', 'Goiania', '98 Denis Street');
insert into ADRESS (adressid, country, city, street)
values (787, 'USA', 'Springfield', '82nd Street');
insert into ADRESS (adressid, country, city, street)
values (788, 'United Kingdom', 'Knutsford', '227 Miko');
insert into ADRESS (adressid, country, city, street)
values (789, 'Malaysia', 'Johor Bahru', '91 Maggie Drive');
insert into ADRESS (adressid, country, city, street)
values (790, 'Italy', 'Maserada sul Piave', '21 Illeana Street');
insert into ADRESS (adressid, country, city, street)
values (791, 'USA', 'Cambridge', '58 Berkoff Blvd');
insert into ADRESS (adressid, country, city, street)
values (792, 'Denmark', 'Frederiksberg', '37 Rosco Street');
insert into ADRESS (adressid, country, city, street)
values (793, 'South Korea', 'Pusan-city', '26 Kennedy Blvd');
insert into ADRESS (adressid, country, city, street)
values (794, 'Russia', 'Moscow', '11st Street');
insert into ADRESS (adressid, country, city, street)
values (795, 'USA', 'Warrenton', '39 Columbus Drive');
insert into ADRESS (adressid, country, city, street)
values (796, 'USA', 'Wilmington', '63 Ming-Na Street');
insert into ADRESS (adressid, country, city, street)
values (797, 'Austria', 'Bischofshofen', '303 Marx Road');
insert into ADRESS (adressid, country, city, street)
values (798, 'USA', 'Schenectady', '14 Mitchell Street');
insert into ADRESS (adressid, country, city, street)
values (799, 'Japan', 'Shizuoka', '94 Juneau Drive');
insert into ADRESS (adressid, country, city, street)
values (800, 'Germany', 'Dinslaken', '13 Hobson Ave');
commit;
prompt 800 records committed...
insert into ADRESS (adressid, country, city, street)
values (801, 'USA', 'Minneapolis', '927 Oyten Street');
insert into ADRESS (adressid, country, city, street)
values (802, 'USA', 'Plymouth Meeting', '26 Nicolas Drive');
insert into ADRESS (adressid, country, city, street)
values (803, 'USA', 'Richmond', '52 Lennix Drive');
insert into ADRESS (adressid, country, city, street)
values (804, 'Switzerland', 'Stans', '70 Milsons Point Blvd');
insert into ADRESS (adressid, country, city, street)
values (805, 'Germany', 'Cottbus', '45 Carmichael Road');
insert into ADRESS (adressid, country, city, street)
values (806, 'Switzerland', 'Chur', '22 Black Street');
insert into ADRESS (adressid, country, city, street)
values (807, 'Australia', 'Ringwood', '10 Field Drive');
insert into ADRESS (adressid, country, city, street)
values (808, 'USA', 'Woodbridge', '78 Jay Road');
insert into ADRESS (adressid, country, city, street)
values (809, 'USA', 'Stanford', '3 Kahn Street');
insert into ADRESS (adressid, country, city, street)
values (810, 'United Kingdom', 'Essex', '39 Mika Street');
insert into ADRESS (adressid, country, city, street)
values (811, 'USA', 'Chambersburg', '511 Rita Street');
insert into ADRESS (adressid, country, city, street)
values (812, 'Japan', 'Saga', '69 Cube Blvd');
insert into ADRESS (adressid, country, city, street)
values (813, 'Netherlands', 'Enschede', '13 Collette Road');
insert into ADRESS (adressid, country, city, street)
values (814, 'Netherlands', 'Maarssen', '97 Ben-Gurion Road');
insert into ADRESS (adressid, country, city, street)
values (815, 'Sweden', 'Sundsvall', '89 Dukakis Street');
insert into ADRESS (adressid, country, city, street)
values (816, 'Germany', 'Herzogenrath', '73 Carrie');
insert into ADRESS (adressid, country, city, street)
values (817, 'Canada', 'Waterloo', '83rd Street');
insert into ADRESS (adressid, country, city, street)
values (818, 'Germany', 'Münster', '90 Adkins Street');
insert into ADRESS (adressid, country, city, street)
values (819, 'USA', 'West Point', '100 Hector Street');
insert into ADRESS (adressid, country, city, street)
values (820, 'United Kingdom', 'Tadley', '61 Hanks Road');
insert into ADRESS (adressid, country, city, street)
values (821, 'Turkey', 'Istanbul', '90 Kuraby Road');
insert into ADRESS (adressid, country, city, street)
values (822, 'Brazil', 'Santa rita sapucaí', '37 Shaw Ave');
insert into ADRESS (adressid, country, city, street)
values (823, 'USA', 'Plymouth Meeting', '52nd Street');
insert into ADRESS (adressid, country, city, street)
values (824, 'USA', 'Monterey', '74 Baker Drive');
insert into ADRESS (adressid, country, city, street)
values (825, 'USA', 'Altamonte Springs', '32nd Street');
insert into ADRESS (adressid, country, city, street)
values (826, 'Canada', 'Brampton', '34 Quatro Road');
insert into ADRESS (adressid, country, city, street)
values (827, 'USA', 'Alexandria', '25 Pleasence Road');
insert into ADRESS (adressid, country, city, street)
values (828, 'South Korea', 'Suwon', '731 Fuchstal-asch Street');
insert into ADRESS (adressid, country, city, street)
values (829, 'Germany', 'Gelsenkirchen', '13rd Street');
insert into ADRESS (adressid, country, city, street)
values (830, 'Italy', 'Mantova', '84 Mollard Drive');
insert into ADRESS (adressid, country, city, street)
values (831, 'USA', 'Westport', '1 Brussel Road');
insert into ADRESS (adressid, country, city, street)
values (832, 'USA', 'Franklin', '42 Elijah Drive');
insert into ADRESS (adressid, country, city, street)
values (833, 'Germany', 'Lübeck', '52 Fiona Street');
insert into ADRESS (adressid, country, city, street)
values (834, 'USA', 'Rochester', '60 Kerava Blvd');
insert into ADRESS (adressid, country, city, street)
values (835, 'Japan', 'Aomori', '51 Wariner Road');
insert into ADRESS (adressid, country, city, street)
values (836, 'USA', 'Minneapolis', '13 Auckland Road');
insert into ADRESS (adressid, country, city, street)
values (837, 'Germany', 'Visselhövede', '89 Jeff Drive');
insert into ADRESS (adressid, country, city, street)
values (838, 'USA', 'Ithaca', '50 Snider Ave');
insert into ADRESS (adressid, country, city, street)
values (839, 'USA', 'Groton', '686 Ferraz  vasconcelos Blvd');
insert into ADRESS (adressid, country, city, street)
values (840, 'USA', 'Leawood', '73 Cary Street');
insert into ADRESS (adressid, country, city, street)
values (841, 'Japan', 'Kochi', '62 Danes Blvd');
insert into ADRESS (adressid, country, city, street)
values (842, 'Canada', 'Vancouver', '52nd Street');
insert into ADRESS (adressid, country, city, street)
values (843, 'Canada', 'Boucherville', '893 Zürich Road');
insert into ADRESS (adressid, country, city, street)
values (844, 'USA', 'Marietta', '39 Hayes Road');
insert into ADRESS (adressid, country, city, street)
values (845, 'Spain', 'Bergara', '78 Tobey');
insert into ADRESS (adressid, country, city, street)
values (846, 'Brazil', 'Joinville', '24 Gallant Road');
insert into ADRESS (adressid, country, city, street)
values (847, 'USA', 'Arlington', '39 Furay Street');
insert into ADRESS (adressid, country, city, street)
values (848, 'Italy', 'Fornacette', '89 Farrow Drive');
insert into ADRESS (adressid, country, city, street)
values (849, 'Canada', 'Winnipeg', '16 Springfield Ave');
insert into ADRESS (adressid, country, city, street)
values (850, 'USA', 'Hackensack', '237 League city Road');
insert into ADRESS (adressid, country, city, street)
values (851, 'Brazil', 'Rio de janeiro', '411 Natacha Street');
insert into ADRESS (adressid, country, city, street)
values (852, 'Liechtenstein', 'Vaduz', '20 Lucy Blvd');
insert into ADRESS (adressid, country, city, street)
values (853, 'USA', 'Chambersburg', '34 Sevenfold');
insert into ADRESS (adressid, country, city, street)
values (854, 'Germany', 'Bielefeld', '79 Duluth Road');
insert into ADRESS (adressid, country, city, street)
values (855, 'South Africa', 'Johannesburg', '34 Hayek Street');
insert into ADRESS (adressid, country, city, street)
values (856, 'USA', 'West Monroe', '91 Rudd Road');
insert into ADRESS (adressid, country, city, street)
values (857, 'Georgia', 'Tbilisi', '2 Scott Ave');
insert into ADRESS (adressid, country, city, street)
values (858, 'United Kingdom', 'Birmingham', '751 Suwon Street');
insert into ADRESS (adressid, country, city, street)
values (859, 'Switzerland', 'Barbengo', '80 Dushku Street');
insert into ADRESS (adressid, country, city, street)
values (860, 'Brazil', 'Ferraz  vasconcelos', '81st Street');
insert into ADRESS (adressid, country, city, street)
values (861, 'Mexico', 'Monterrey', '89 Reilly Street');
insert into ADRESS (adressid, country, city, street)
values (862, 'Netherlands', 'Tilburg', '46 Buscemi Drive');
insert into ADRESS (adressid, country, city, street)
values (863, 'Germany', 'Paderborn', '44 Soroe Ave');
insert into ADRESS (adressid, country, city, street)
values (864, 'USA', 'Plymouth Meeting', '63 Kutcher Road');
insert into ADRESS (adressid, country, city, street)
values (865, 'USA', 'Nashua', '3 Westfield Drive');
insert into ADRESS (adressid, country, city, street)
values (866, 'USA', 'Sacramento', '381 Theron Drive');
insert into ADRESS (adressid, country, city, street)
values (867, 'Australia', 'Melbourne', '22nd Street');
insert into ADRESS (adressid, country, city, street)
values (868, 'United Kingdom', 'Farnham', '19 Gough Street');
insert into ADRESS (adressid, country, city, street)
values (869, 'Canada', 'Burlington', '82nd Street');
insert into ADRESS (adressid, country, city, street)
values (870, 'USA', 'Burr Ridge', '20 Gwyneth Drive');
insert into ADRESS (adressid, country, city, street)
values (871, 'USA', 'East Peoria', '3 Lexington Street');
insert into ADRESS (adressid, country, city, street)
values (872, 'Germany', 'Lengdorf', '26 Scarlett Drive');
insert into ADRESS (adressid, country, city, street)
values (873, 'USA', 'East Providence', '488 Viggo Road');
insert into ADRESS (adressid, country, city, street)
values (874, 'Germany', 'Würzburg', '193 Scorsese Drive');
insert into ADRESS (adressid, country, city, street)
values (875, 'USA', 'Lancaster', '522 Virginia Beach Street');
insert into ADRESS (adressid, country, city, street)
values (876, 'Italy', 'Milano', '71 Weber Road');
insert into ADRESS (adressid, country, city, street)
values (877, 'USA', 'Tempe', '14 Aida Blvd');
insert into ADRESS (adressid, country, city, street)
values (878, 'USA', 'Ricardson', '81st Street');
insert into ADRESS (adressid, country, city, street)
values (879, 'USA', 'Portsmouth', '32 Magnuson Road');
insert into ADRESS (adressid, country, city, street)
values (880, 'Germany', 'Dresden', '35 Carr Street');
insert into ADRESS (adressid, country, city, street)
values (881, 'USA', 'Cromwell', '82 Thelma Drive');
insert into ADRESS (adressid, country, city, street)
values (882, 'Denmark', 'Copenhagen', '1 Ferry Street');
insert into ADRESS (adressid, country, city, street)
values (883, 'Brazil', 'Sorocaba', '70 Las Vegas Street');
insert into ADRESS (adressid, country, city, street)
values (884, 'USA', 'Staten Island', '10 Recife');
insert into ADRESS (adressid, country, city, street)
values (885, 'USA', 'Tampa', '87 Gertner');
insert into ADRESS (adressid, country, city, street)
values (886, 'United Kingdom', 'Market Harborough', '85 Sepulveda Ave');
insert into ADRESS (adressid, country, city, street)
values (887, 'Germany', 'Fuchstal-asch', '69 Algermissen Road');
insert into ADRESS (adressid, country, city, street)
values (888, 'United Kingdom', 'Sale', '94 Davis Drive');
insert into ADRESS (adressid, country, city, street)
values (889, 'Cyprus', 'Nicosia', '13rd Street');
insert into ADRESS (adressid, country, city, street)
values (890, 'Sweden', 'Stockholm', '68 Miyazaki Road');
insert into ADRESS (adressid, country, city, street)
values (891, 'Italy', 'Santorso', '22 Rock');
insert into ADRESS (adressid, country, city, street)
values (892, 'Germany', 'Berlin', '72 Nash Road');
insert into ADRESS (adressid, country, city, street)
values (893, 'Netherlands', 'Baarn', '482 Carlisle Ave');
insert into ADRESS (adressid, country, city, street)
values (894, 'Slovenia', 'Ljubljana', '72 Rydell Road');
insert into ADRESS (adressid, country, city, street)
values (895, 'Netherlands', 'Soest', '22 Potter Street');
insert into ADRESS (adressid, country, city, street)
values (896, 'Russia', 'Irkutsk', '100 Mantova');
insert into ADRESS (adressid, country, city, street)
values (897, 'Japan', 'Kochi', '87 Faithfull Street');
insert into ADRESS (adressid, country, city, street)
values (898, 'Germany', 'Fuchstal-asch', '85 Kevin Street');
insert into ADRESS (adressid, country, city, street)
values (899, 'Australia', 'Canberra', '45 Kevin Ave');
insert into ADRESS (adressid, country, city, street)
values (900, 'USA', 'Tampa', '77 Evett Ave');
commit;
prompt 900 records committed...
insert into ADRESS (adressid, country, city, street)
values (901, 'USA', 'Westport', '91 Matthew');
insert into ADRESS (adressid, country, city, street)
values (902, 'USA', 'Bend', '96 Davey Street');
insert into ADRESS (adressid, country, city, street)
values (903, 'Germany', 'Ravensburg', '46 Blossoms Road');
insert into ADRESS (adressid, country, city, street)
values (904, 'Canada', 'Dorval', '66 Dayne Road');
insert into ADRESS (adressid, country, city, street)
values (905, 'USA', 'Pasadena', '800 Jackson Blvd');
insert into ADRESS (adressid, country, city, street)
values (906, 'USA', 'Columbia', '67 Rosanne Drive');
insert into ADRESS (adressid, country, city, street)
values (907, 'USA', 'Eden prairie', '712 Leo Street');
insert into ADRESS (adressid, country, city, street)
values (908, 'USA', 'South Jordan', '99 Laurie Road');
insert into ADRESS (adressid, country, city, street)
values (909, 'USA', 'Fort Collins', '60 Grant Road');
insert into ADRESS (adressid, country, city, street)
values (910, 'USA', 'Walnut Creek', '42 Niven Blvd');
insert into ADRESS (adressid, country, city, street)
values (911, 'USA', 'Coppell', '44 Solido Road');
insert into ADRESS (adressid, country, city, street)
values (912, 'Spain', 'Elche', '43 Ernie Street');
insert into ADRESS (adressid, country, city, street)
values (913, 'Netherlands', 'Tilburg', '64 Quentin Road');
insert into ADRESS (adressid, country, city, street)
values (914, 'USA', 'Batavia', '65 Bancroft Road');
insert into ADRESS (adressid, country, city, street)
values (915, 'USA', 'Hines', '98 Ciudad del Este Street');
insert into ADRESS (adressid, country, city, street)
values (916, 'United Kingdom', 'Horsham', '23 Miriam Drive');
insert into ADRESS (adressid, country, city, street)
values (917, 'Japan', 'Nagoya', '65 Garfunkel Street');
insert into ADRESS (adressid, country, city, street)
values (918, 'United Kingdom', 'Oxon', '58 Steven Ave');
insert into ADRESS (adressid, country, city, street)
values (919, 'Germany', 'Erlangen', '99 Pfeiffer Street');
insert into ADRESS (adressid, country, city, street)
values (920, 'USA', 'Silverdale', '72 DiBiasio');
insert into ADRESS (adressid, country, city, street)
values (921, 'Denmark', 'Billund', '38 Kirk Road');
insert into ADRESS (adressid, country, city, street)
values (922, 'USA', 'Crete', '57 Marie Street');
insert into ADRESS (adressid, country, city, street)
values (923, 'Macau', 'Macau', '50 Szazhalombatta Blvd');
insert into ADRESS (adressid, country, city, street)
values (924, 'USA', 'Laurel', '71 Fonda Ave');
insert into ADRESS (adressid, country, city, street)
values (925, 'USA', 'San Dimas', '12 Thewlis');
insert into ADRESS (adressid, country, city, street)
values (926, 'France', 'Dardilly', '34 Horb Drive');
insert into ADRESS (adressid, country, city, street)
values (927, 'USA', 'Waldorf', '483 Eckhart Drive');
insert into ADRESS (adressid, country, city, street)
values (928, 'United Kingdom', 'High Wycombe', '28 Nara Ave');
insert into ADRESS (adressid, country, city, street)
values (929, 'Japan', 'Fukuoka', '972 Mumbai Road');
insert into ADRESS (adressid, country, city, street)
values (930, 'Australia', 'Highton', '22 Sidney Ave');
insert into ADRESS (adressid, country, city, street)
values (931, 'Denmark', 'Soroe', '10 Tlalpan Road');
insert into ADRESS (adressid, country, city, street)
values (932, 'Netherlands', 'Eindhoven', '16 Arquette Street');
insert into ADRESS (adressid, country, city, street)
values (933, 'Slovakia', 'Bratislava', '82nd Street');
insert into ADRESS (adressid, country, city, street)
values (934, 'USA', 'Anchorage', '335 Tokyo Road');
insert into ADRESS (adressid, country, city, street)
values (935, 'Japan', 'Matsuyama', '21st Street');
insert into ADRESS (adressid, country, city, street)
values (936, 'Germany', 'Dresden', '82 Barbengo Road');
insert into ADRESS (adressid, country, city, street)
values (937, 'South Africa', 'Halfway house', '25 Koufu Drive');
insert into ADRESS (adressid, country, city, street)
values (938, 'Switzerland', 'Winterthur', '96 Sheffield Ave');
insert into ADRESS (adressid, country, city, street)
values (939, 'USA', 'Lakeville', '78 Kier Street');
insert into ADRESS (adressid, country, city, street)
values (940, 'Japan', 'Yokohama', '73 Aniston Street');
insert into ADRESS (adressid, country, city, street)
values (941, 'United Kingdom', 'Cobham', '728 Kuraby Road');
insert into ADRESS (adressid, country, city, street)
values (942, 'Israel', 'Or-yehuda', '60 McDiarmid Drive');
insert into ADRESS (adressid, country, city, street)
values (943, 'USA', 'Reno', '28 Lonsdale Street');
insert into ADRESS (adressid, country, city, street)
values (944, 'South Africa', 'Stellenbosch', '85 CeCe Drive');
insert into ADRESS (adressid, country, city, street)
values (945, 'Italy', 'Villata', '86 Pryce Road');
insert into ADRESS (adressid, country, city, street)
values (946, 'Australia', 'Brisbane', '51 Jennifer Road');
insert into ADRESS (adressid, country, city, street)
values (947, 'Switzerland', 'Barbengo', '921 Biella Ave');
insert into ADRESS (adressid, country, city, street)
values (948, 'Japan', 'Takamatsu', '53 Naha Drive');
insert into ADRESS (adressid, country, city, street)
values (949, 'Norway', 'Eiksmarka', '83 Ahmad Drive');
insert into ADRESS (adressid, country, city, street)
values (950, 'USA', 'Louisville', '196 O''Neal Street');
insert into ADRESS (adressid, country, city, street)
values (951, 'Germany', 'Lippetal', '31 Cevin Ave');
insert into ADRESS (adressid, country, city, street)
values (952, 'USA', 'Debary', '37 Berwyn Road');
insert into ADRESS (adressid, country, city, street)
values (953, 'Sweden', 'Goteborg', '74 Caviezel Drive');
insert into ADRESS (adressid, country, city, street)
values (954, 'USA', 'Framingham', '273 Tobey Ave');
insert into ADRESS (adressid, country, city, street)
values (955, 'South Africa', 'Gauteng', '6 Trini Street');
insert into ADRESS (adressid, country, city, street)
values (956, 'USA', 'Ashland', '58 Lehi Street');
insert into ADRESS (adressid, country, city, street)
values (957, 'Russia', 'Nizhnevartovsk', '87 Amy Road');
insert into ADRESS (adressid, country, city, street)
values (958, 'Germany', 'Duesseldorf', '71 McCready Drive');
insert into ADRESS (adressid, country, city, street)
values (959, 'Germany', 'Leipzig', '859 Carol');
insert into ADRESS (adressid, country, city, street)
values (960, 'Australia', 'Adelaide', '61 Pensacola Road');
insert into ADRESS (adressid, country, city, street)
values (961, 'USA', 'Encinitas', '33 Chicago Street');
insert into ADRESS (adressid, country, city, street)
values (962, 'Netherlands', 'Zaandam', '8 Moss Ave');
insert into ADRESS (adressid, country, city, street)
values (963, 'United Kingdom', 'Storrington', '42 Americana Street');
insert into ADRESS (adressid, country, city, street)
values (964, 'USA', 'Middleburg Heights', '27 Colm Drive');
insert into ADRESS (adressid, country, city, street)
values (965, 'United Kingdom', 'Paisley', '87 Bloemfontein Street');
insert into ADRESS (adressid, country, city, street)
values (966, 'Netherlands', 'Waalwijk', '72nd Street');
insert into ADRESS (adressid, country, city, street)
values (967, 'USA', 'Eden prairie', '30 Pullman Street');
insert into ADRESS (adressid, country, city, street)
values (968, 'USA', 'Baltimore', '83rd Street');
insert into ADRESS (adressid, country, city, street)
values (969, 'Brazil', 'Sorocaba', '44 Lisboa Street');
insert into ADRESS (adressid, country, city, street)
values (970, 'Italy', 'Trieste', '82 Butner Ave');
insert into ADRESS (adressid, country, city, street)
values (971, 'USA', 'Irving', '937 Morton Drive');
insert into ADRESS (adressid, country, city, street)
values (972, 'Brazil', 'Porto alegre', '61 Jude Drive');
insert into ADRESS (adressid, country, city, street)
values (973, 'Brazil', 'Paraju', '532 Parish Road');
insert into ADRESS (adressid, country, city, street)
values (974, 'USA', 'Princeton', '78 Shearer Blvd');
insert into ADRESS (adressid, country, city, street)
values (975, 'USA', 'Cle Elum', '47 Englewood Street');
insert into ADRESS (adressid, country, city, street)
values (976, 'USA', 'Menlo Park', '89 Kim Street');
insert into ADRESS (adressid, country, city, street)
values (977, 'Germany', 'Oppenheim', '12 Celia Street');
insert into ADRESS (adressid, country, city, street)
values (978, 'USA', 'Coppell', '78 Morton Street');
insert into ADRESS (adressid, country, city, street)
values (979, 'USA', 'Oklahoma city', '6 Watson Street');
insert into ADRESS (adressid, country, city, street)
values (980, 'USA', 'Melrose', '98 Griffith Blvd');
insert into ADRESS (adressid, country, city, street)
values (981, 'USA', 'Lake worth', '10 Loggins Ave');
insert into ADRESS (adressid, country, city, street)
values (982, 'Spain', 'Valladolid', '141 Warburton Street');
insert into ADRESS (adressid, country, city, street)
values (983, 'United Kingdom', 'Edenbridge', '51 Andre Blvd');
insert into ADRESS (adressid, country, city, street)
values (984, 'USA', 'Deerfield', '3 Judy Street');
insert into ADRESS (adressid, country, city, street)
values (985, 'Switzerland', 'Oberwangen', '33 Galecki Blvd');
insert into ADRESS (adressid, country, city, street)
values (986, 'USA', 'Archbold', '17 Sweet Ave');
insert into ADRESS (adressid, country, city, street)
values (987, 'USA', 'Omaha', '16 Bentley Blvd');
insert into ADRESS (adressid, country, city, street)
values (988, 'Switzerland', 'Obfelden', '97 Mason');
insert into ADRESS (adressid, country, city, street)
values (989, 'Spain', 'El Masnou', '749 Chrissie Drive');
insert into ADRESS (adressid, country, city, street)
values (990, 'Italy', 'Milano', '6 Amarillo Drive');
insert into ADRESS (adressid, country, city, street)
values (991, 'Sri lanka', 'Colombo', '52nd Street');
insert into ADRESS (adressid, country, city, street)
values (992, 'USA', 'Springville', '37 Di Savigliano Road');
insert into ADRESS (adressid, country, city, street)
values (993, 'United Kingdom', 'Bristol', '11 Vendetta Ave');
insert into ADRESS (adressid, country, city, street)
values (994, 'USA', 'Boulder', '15 Cassidy Street');
insert into ADRESS (adressid, country, city, street)
values (995, 'USA', 'Greenwood Village', '144 Kagoshima Street');
insert into ADRESS (adressid, country, city, street)
values (996, 'USA', 'New Hope', '27 Kris Drive');
insert into ADRESS (adressid, country, city, street)
values (997, 'USA', 'Bethesda', '11 Suzy Road');
insert into ADRESS (adressid, country, city, street)
values (998, 'Japan', 'Niigata', '14 Rapaport Drive');
insert into ADRESS (adressid, country, city, street)
values (999, 'USA', 'New Castle', '20 Dreieich Street');
insert into ADRESS (adressid, country, city, street)
values (1000, 'South Korea', 'Anyang-si', '16 Juice Ave');
commit;
prompt 1000 records committed...
insert into ADRESS (adressid, country, city, street)
values (1001, 'France', 'Toulouse', '69 Zürich');
insert into ADRESS (adressid, country, city, street)
values (1002, 'Italy', 'Roma', '94 Woking Street');
insert into ADRESS (adressid, country, city, street)
values (1003, 'Germany', 'Kreuzau', '17 Ned Drive');
insert into ADRESS (adressid, country, city, street)
values (1004, 'Denmark', 'Fredericia', '9 Cartlidge Ave');
insert into ADRESS (adressid, country, city, street)
values (1005, 'Denmark', 'Naestved', '60 Merillee Road');
insert into ADRESS (adressid, country, city, street)
values (1006, 'Netherlands', 'Uden', '36 McIntyre Street');
insert into ADRESS (adressid, country, city, street)
values (1007, 'USA', 'Stony Point', '67 Evett Blvd');
insert into ADRESS (adressid, country, city, street)
values (1008, 'USA', 'Pomona', '82 Eckhart Ave');
insert into ADRESS (adressid, country, city, street)
values (1009, 'Germany', 'Frankfurt', '32 Chaplin Drive');
insert into ADRESS (adressid, country, city, street)
values (1010, 'Austria', 'Bischofshofen', '20 Berry Drive');
commit;
prompt 1010 records loaded
prompt Loading COMPANY...
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (1, 'Google', to_date('05-04-2020', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (2, 'Intel', to_date('01-01-1963', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (3, 'G- Max', to_date('18-12-2038', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (4, 'Mobilay', to_date('09-10-2007', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (5, 'Check- Point', to_date('18-11-2029', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (6, 'Ebay', to_date('22-07-1961', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (8, 'Michrosoft', to_date('14-06-1955', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (9, 'IBM', to_date('18-05-1962', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (10, 'Pay- Pal', to_date('11-08-2049', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (7, 'Dell', to_date('18-12-1973', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (11, 'Security Check', to_date('21-08-1955', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (12, 'Execuscribe', to_date('18-09-2014', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (13, 'Kelmoore Investment', to_date('03-07-1983', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (14, 'Loss Mitigation Serv', to_date('11-05-1954', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (15, 'ZonePerfect Nutritio', to_date('21-06-2006', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (16, 'Magnet Communication', to_date('09-11-1990', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (17, 'AccuCode', to_date('20-05-2003', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (18, 'Diageo', to_date('08-10-1972', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (19, 'Commercial Energy of', to_date('22-02-2001', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (20, 'Nike', to_date('22-12-1981', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (21, 'Estee Lauder Cos.', to_date('04-02-1955', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (22, 'Spenser Communicatio', to_date('01-01-1939', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (23, 'Monitronics Internat', to_date('28-11-1985', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (24, 'Sensor Technologies', to_date('01-03-1969', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (25, 'S.C. Johnson & Son', to_date('28-11-1929', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (26, 'Fetch Logistics', to_date('12-08-1985', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (27, 'Capital Bank', to_date('07-02-1995', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (28, 'Restaurant Partners', to_date('28-07-2013', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (29, 'Portosan', to_date('21-12-1971', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (30, 'Laboratory Managemen', to_date('06-12-2015', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (31, 'SBC Communications', to_date('20-08-1924', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (32, 'Southern Financial B', to_date('18-09-1995', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (33, 'I.T.S.', to_date('08-07-1961', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (34, 'Studio B Productions', to_date('09-08-1922', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (35, 'Amerisource Funding', to_date('03-09-1978', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (36, 'AQuickDelivery', to_date('13-07-2018', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (37, 'Wells Financial', to_date('19-08-1943', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (38, 'Trek Equipment', to_date('25-09-1946', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (39, 'Blue Pumpkin Softwar', to_date('28-03-2000', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (40, 'Kimberly-Clark Corp.', to_date('26-08-1979', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (41, 'GRT', to_date('20-12-1931', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (42, 'WAV', to_date('14-02-1948', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (43, 'Virtual Financial Se', to_date('05-12-1959', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (44, 'Sprint Corp.', to_date('16-08-1974', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (45, 'Yash Technologies', to_date('01-03-1959', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (46, 'Honda Motor Co.', to_date('08-09-2018', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (47, 'Technology and Manag', to_date('12-12-1962', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (48, 'Marathon Heater', to_date('02-03-1986', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (49, 'Socket Internet', to_date('15-11-1958', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (50, 'Call Henry', to_date('20-01-1947', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (51, 'Third Millennium Tel', to_date('20-02-1978', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (52, 'Bashen Consulting', to_date('29-08-1965', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (53, 'Coridian Technologie', to_date('27-08-1998', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (54, 'General Mills', to_date('09-10-2016', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (55, 'httprint', to_date('06-10-1921', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (56, 'Jewett-Cameron Tradi', to_date('07-06-1923', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (57, 'Accurate Autobody', to_date('14-02-1994', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (58, 'Enterprise Computing', to_date('15-10-1989', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (59, 'Grant Harrison Adver', to_date('02-03-1946', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (60, 'Cody-Kramer Imports', to_date('01-08-1972', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (61, 'Phoenix Rehabilitati', to_date('19-02-1979', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (62, 'Carteret Mortgage', to_date('22-01-2020', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (63, 'United Asset Coverag', to_date('12-08-2000', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (64, 'ProClarity', to_date('13-05-1993', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (65, 'PSC Info Group', to_date('17-11-2011', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (66, 'Hewlett-Packard Co.', to_date('17-06-1995', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (67, 'Bioanalytical System', to_date('24-11-1978', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (68, 'Greyhawk North Ameri', to_date('20-05-1923', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (69, 'Palm Beach Tan', to_date('16-02-1933', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (70, 'Gateway', to_date('12-05-1992', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (71, 'Estee Lauder Cos.', to_date('25-07-1975', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (72, 'Legacy Financial Gro', to_date('01-03-1987', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (73, 'Data Warehouse', to_date('14-02-1925', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (74, 'WCI', to_date('15-07-2007', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (75, 'Unilever', to_date('05-10-1995', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (76, 'Yum Brands', to_date('18-10-2001', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (77, 'Outsource Group', to_date('20-09-2016', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (78, 'AT&T Wireless', to_date('31-03-1985', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (79, 'V-Span', to_date('19-02-2004', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (80, 'Genghis Grill', to_date('18-09-1950', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (81, 'Hilton Hotels Corp.', to_date('22-10-1937', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (82, 'Palm Beach Tan', to_date('17-09-1970', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (83, 'FSF Financial', to_date('17-04-2011', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (84, 'AC Technologies', to_date('12-11-2002', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (85, 'Diamond Group', to_date('20-03-1943', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (86, 'Alliance of Professi', to_date('22-04-1943', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (87, 'AT&T Corp.', to_date('23-08-1921', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (88, 'Merit Medical Systems', to_date('28-06-1941', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (89, 'Topics Entertainment', to_date('04-02-1967', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (90, 'Jolly Enterprises', to_date('15-05-1958', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (91, 'Access US', to_date('29-06-1924', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (92, 'Home Depot', to_date('28-02-1920', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (93, 'Partnership in Building', to_date('01-10-1981', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (94, 'TechRX', to_date('26-02-1947', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (95, 'Diamond Group', to_date('14-11-2014', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (96, 'Flow Management Technologies', to_date('17-05-2015', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (97, 'BASE Consulting Group', to_date('17-03-1967', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (98, 'Maverick Technologies', to_date('17-04-1990', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (99, 'FSF Financial', to_date('11-04-1975', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (100, 'Nike', to_date('02-08-1922', 'dd-mm-yyyy'), 'Start-Up');
commit;
prompt 100 records committed...
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (101, 'J.C. Penney Corp.', to_date('06-02-1965', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (102, 'CARBO Ceramics', to_date('23-05-1975', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (103, 'Dynacq International', to_date('16-05-1987', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (104, 'Alternative Technology', to_date('05-10-1967', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (105, 'Capital Automotive', to_date('07-01-1969', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (106, 'Schering-Plough Corp.', to_date('11-10-1939', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (107, 'Data Company', to_date('01-10-1924', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (108, 'Comm-Works', to_date('06-05-1999', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (109, 'GlaxoSmithKline', to_date('30-07-1960', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (110, 'Young Innovations', to_date('30-04-1928', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (111, 'Cold Stone Creamery', to_date('01-04-1982', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (112, 'Virtual Meeting Strategies', to_date('21-12-1921', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (113, 'Omega Insurance Services', to_date('29-05-1931', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (114, 'Imaging Business Machines', to_date('29-03-2007', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (115, 'Pfizer', to_date('21-07-1991', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (116, 'Baesch Computer Consulting', to_date('17-11-1941', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (117, 'SALT Group', to_date('27-02-1924', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (118, 'American Pan & Engineering', to_date('14-04-1930', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (119, 'Process Plus', to_date('29-05-1943', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (120, 'Momentum Marketing Services', to_date('09-03-1932', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (121, 'DC Group', to_date('07-12-1948', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (122, 'Unica', to_date('22-06-1999', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (123, 'Market-Based Solutions', to_date('24-11-2019', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (124, 'North Highland', to_date('29-07-1977', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (125, 'PrivateBancorp', to_date('26-10-1959', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (126, 'Providence Service', to_date('30-01-1940', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (127, 'Mattel', to_date('28-07-1980', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (128, 'Random Walk Computing', to_date('28-12-1940', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (129, 'SmartDraw.com', to_date('26-04-2000', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (130, 'SSCI', to_date('16-06-2008', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (131, 'Estee Lauder Cos.', to_date('25-06-1993', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (132, 'Consultants'' Choice', to_date('16-05-1960', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (133, 'Virtual Financial Services', to_date('08-12-1944', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (134, 'Ivory Systems', to_date('24-02-1991', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (135, 'L.E.M. Products', to_date('22-04-1977', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (136, 'Unilever', to_date('26-07-1970', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (137, 'Navigator Systems', to_date('27-03-2006', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (138, 'Serentec', to_date('13-03-1960', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (139, 'ProfitLine', to_date('02-03-2000', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (140, 'Solution Builders', to_date('13-12-2006', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (141, 'TEOCO', to_date('29-12-1969', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (142, 'Automated License Systems', to_date('26-08-2008', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (143, 'Pharmacia Corp.', to_date('08-11-1962', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (144, 'North Highland', to_date('17-05-1941', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (145, 'Solipsys', to_date('10-06-1994', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (146, 'Atlantic.Net', to_date('27-08-1952', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (147, 'Legacy Financial Group', to_date('22-06-1950', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (148, 'Best Buy Co.', to_date('20-06-1952', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (149, 'Quicksilver Resources', to_date('03-08-1976', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (150, 'GDA Technologies', to_date('06-09-2011', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (151, 'DaimlerChrysler', to_date('24-10-1934', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (152, 'Team', to_date('12-06-1926', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (153, 'Sequoia System International', to_date('07-03-1968', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (154, 'J.C. Penney Corp.', to_date('17-09-1968', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (155, 'Hencie', to_date('26-11-1958', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (156, 'Horizon Organic', to_date('20-11-1948', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (157, 'Floorgraphics', to_date('10-10-2007', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (158, 'Lynk Systems', to_date('06-07-1993', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (159, 'Gillette Co.', to_date('03-08-1940', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (160, 'Execuscribe', to_date('20-03-1932', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (161, 'Socket Internet', to_date('09-12-1982', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (162, 'MindIQ', to_date('20-03-1974', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (163, 'HealthScribe', to_date('24-01-1974', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (164, 'Toyota Motor Corp.', to_date('25-10-1983', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (165, 'Sara Lee Corp.', to_date('08-09-1959', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (166, 'Calence', to_date('07-12-1984', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (167, 'Networking Technologies and Support', to_date('11-09-2013', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (168, 'Shirt Factory', to_date('07-12-2013', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (169, 'Merck & Co.', to_date('22-06-1926', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (170, 'TMA Resources', to_date('02-02-1997', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (171, 'Canterbury Park', to_date('10-08-1970', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (172, 'Direct Data', to_date('14-12-1935', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (173, 'Genghis Grill', to_date('08-07-1945', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (174, 'Tastefully Simple', to_date('22-08-1997', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (175, 'Microsoft Corp.', to_date('29-10-1964', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (176, 'Scott Pipitone Design', to_date('06-08-2018', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (177, 'Span-America Medical Systems', to_date('12-03-2012', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (178, 'Allegiant Bancorp', to_date('28-06-1985', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (179, 'ATX Forms', to_date('25-12-1995', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (180, 'National Heritage Academies', to_date('03-02-1965', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (181, 'Heritage Microfilm', to_date('10-10-1958', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (182, 'Boldtech Systems', to_date('27-08-1948', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (183, 'National Heritage Academies', to_date('18-10-1936', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (184, 'Atlantic.Net', to_date('05-07-1965', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (185, 'Megha Systems', to_date('24-10-1965', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (186, 'AXSA Document Solutions', to_date('15-01-1950', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (187, 'Genex Technologies', to_date('31-12-1970', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (188, 'Albertson’s', to_date('31-08-1923', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (189, 'TechBooks', to_date('08-11-1946', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (190, 'Computer World Services', to_date('12-11-1969', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (191, 'Cody-Kramer Imports', to_date('28-03-2006', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (192, 'Turner Professional Services', to_date('11-05-1953', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (193, 'AC Technologies', to_date('11-05-1935', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (194, 'Advanced Technologies Group', to_date('13-02-1986', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (195, 'Blue Ocean Software', to_date('17-03-1951', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (196, 'Northwoods Software Development', to_date('11-11-2011', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (197, 'Boldtech Systems', to_date('14-12-1991', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (198, 'Trinity HomeCare', to_date('30-07-1991', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (199, 'Spenser Communications', to_date('15-02-1943', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (200, 'Tilson HR', to_date('08-11-1997', 'dd-mm-yyyy'), 'Research');
commit;
prompt 200 records committed...
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (201, 'Formatech', to_date('13-06-1993', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (202, 'Arkidata', to_date('21-03-1974', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (203, 'Staff Force', to_date('02-02-1940', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (204, 'Active Services', to_date('22-04-1949', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (205, 'IPS Advisory', to_date('29-03-1993', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (206, 'DataTrend Information Systems', to_date('27-02-2014', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (207, 'Hershey Foods Corp.', to_date('25-02-1936', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (208, 'North Coast Energy', to_date('14-12-2001', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (209, 'Questar Capital', to_date('04-12-1948', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (210, 'Sweet Productions', to_date('09-05-1968', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (211, 'Genex Technologies', to_date('17-01-1961', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (212, 'United Asset Coverage', to_date('02-05-1996', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (213, 'ID Label', to_date('01-06-1961', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (214, 'Montpelier Plastics', to_date('26-09-1956', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (215, 'Capella Education', to_date('14-11-1960', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (216, 'Montpelier Plastics', to_date('20-08-1959', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (217, 'Amerisource Funding', to_date('06-10-1972', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (218, 'York Enterprise Solutions', to_date('18-07-1959', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (219, 'TimeVision', to_date('28-03-1984', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (220, 'Access US', to_date('30-09-1986', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (221, 'Megha Systems', to_date('05-07-2016', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (222, 'CIW Services', to_date('15-12-1991', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (223, 'Advantage Credit International', to_date('29-08-2012', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (224, 'Linksys', to_date('27-03-1989', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (225, 'Travizon', to_date('22-04-2018', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (226, 'Advertising Ventures', to_date('09-05-1923', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (227, 'Quantum Loyalty Systems', to_date('08-03-2011', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (228, 'BASE Consulting Group', to_date('23-03-2008', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (229, 'Invision.com', to_date('15-01-1988', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (230, 'CLT Meetings International', to_date('17-10-1952', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (231, 'Invision.com', to_date('07-07-1992', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (232, 'Outta the Box Dispensers', to_date('06-05-1994', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (233, 'Greyhawk North America', to_date('26-10-1954', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (234, 'Royal Gold', to_date('01-07-1949', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (235, 'Mercantile Bank', to_date('20-03-2014', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (236, 'Tarragon Realty', to_date('27-03-2003', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (237, 'Joseph Sheairs Associates', to_date('16-06-1930', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (238, 'SSCI', to_date('17-06-1932', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (239, 'ACS International Resources', to_date('21-08-1952', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (240, 'Scott Pipitone Design', to_date('11-04-1962', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (241, 'AT&T Corp.', to_date('10-05-2010', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (242, 'Analytics Operations Engineering', to_date('04-07-1948', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (243, 'Alternative Technology', to_date('24-09-1932', 'dd-mm-yyyy'), 'Research');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (244, 'Extra Mile Transportation', to_date('16-07-2007', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (245, 'Summit Energy', to_date('02-12-1937', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (246, 'Advanced Neuromodulation', to_date('03-05-1956', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (247, 'STI Knowledge', to_date('11-11-1994', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (248, 'Mitsubishi Motors Corp.', to_date('04-02-1991', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (249, 'Infinity Software Development', to_date('03-12-2008', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (250, 'American Service Systems', to_date('14-06-1945', 'dd-mm-yyyy'), 'Start-Up');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (251, 'Baesch Computer Consulting', to_date('05-04-1928', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (252, 'Kroger Co.', to_date('26-03-2016', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (253, 'Spinnaker Exploration', to_date('19-05-1965', 'dd-mm-yyyy'), 'Testing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (254, 'Sensor Technologies', to_date('23-12-1937', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (255, 'Progressive Medical', to_date('02-11-1922', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (256, 'Uniserve Facilities Services', to_date('09-03-1944', 'dd-mm-yyyy'), 'Software Development');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (257, 'Clorox Co.', to_date('20-12-1926', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (258, 'Lydian Trust', to_date('29-09-1950', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (259, 'Montpelier Plastics', to_date('30-04-1989', 'dd-mm-yyyy'), 'Marketing');
insert into COMPANY (companyid, companyname, foundationdate, compantstatus)
values (260, 'QSS Group', to_date('22-05-1982', 'dd-mm-yyyy'), 'Software Development');
commit;
prompt 260 records loaded
prompt Loading PERSON...
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('207265711', 'Rivka', 'Zizovi', to_date('05-04-2000', 'dd-mm-yyyy'), '0509229869', 'zizovirivaka@gmail.com', 1);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('21281968', 'Shiri', 'Nissim', to_date('01-01-2001', 'dd-mm-yyyy'), '0583214580', 'shira999995@gmail.com', 2);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('244557811', 'Yael', 'Cohen', to_date('05-01-1998', 'dd-mm-yyyy'), '0502345869', 'yael@gmail.com', 3);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('207265234', 'Yehuda', 'Cohen', to_date('05-04-1985', 'dd-mm-yyyy'), '0534579869', 'zioni@gmail.com', 3);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('207265713', 'Israel', 'Haim', to_date('05-09-2001', 'dd-mm-yyyy'), '0509227321', 'Israel@gmail.com', 5);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('207578934', 'Hadar', 'Lavi', to_date('01-01-1997', 'dd-mm-yyyy'), '0506229250', 'Hadarush@gmail.com', 6);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('987545711', 'Michael', 'Ben-Haim', to_date('05-10-1995', 'dd-mm-yyyy'), '0507338927', 'Michael@gmail.com', 7);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('207993212', 'Shalev', 'Miron', to_date('09-08-1998', 'dd-mm-yyyy'), '0504435669', 'shalevm@gmail.com', 8);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('211235719', 'Tamir', 'Mardi', to_date('07-06-1993', 'dd-mm-yyyy'), '0508867569', 'tamir556@gmail.com', 9);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('232567788', 'Sarit', 'Kimchi', to_date('03-02-1996', 'dd-mm-yyyy'), '0523459869', 'sarit@gmail.com', 10);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('886303132', 'Ethan', 'Frost', to_date('20-11-1994', 'dd-mm-yyyy'), '0096662783', 'ethanf@bioanalytical.com', 755);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('765973770', 'Azucar', 'Watson', to_date('01-09-1988', 'dd-mm-yyyy'), '0608416679', 'azucar.w@3tsystems.com', 709);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('615324629', 'Earl', 'Calle', to_date('26-09-1992', 'dd-mm-yyyy'), '0707532459', 'earl.calle@timevision.br', 261);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('362289581', 'Chet', 'Idle', to_date('09-06-1993', 'dd-mm-yyyy'), '0077950915', 'chet.idle@unilever.com', 116);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('157524610', 'Jennifer', 'Fonda', to_date('17-02-1998', 'dd-mm-yyyy'), '0099099713', 'jennifer.fonda@linersdirect.fr', 992);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('690727298', 'Marlon', 'Judd', to_date('28-05-1990', 'dd-mm-yyyy'), '0385540737', 'marlon.judd@glaxosmithkline.cz', 569);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('953425582', 'Beverley', 'Duvall', to_date('02-07-1991', 'dd-mm-yyyy'), '0724718824', 'beverleyd@philipmorris.za', 33);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('642412911', 'Robin', 'Weaver', to_date('21-03-1998', 'dd-mm-yyyy'), '0282970052', 'robin@chhc.com', 979);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('997406796', 'Sylvester', 'Levin', to_date('25-10-2000', 'dd-mm-yyyy'), '0777792806', 'sylvester@younginnovations.uk', 598);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('519194876', 'Sydney', 'Del Toro', to_date('10-01-2000', 'dd-mm-yyyy'), '0370288469', 'sydney.d@sds.il', 14);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('492518744', 'Courtney', 'Iglesias', to_date('12-10-1992', 'dd-mm-yyyy'), '0675965399', 'courtney.i@fordmotor.pt', 220);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('770687076', 'Shannyn', 'Warburton', to_date('08-09-1987', 'dd-mm-yyyy'), '0018201628', 'shannyn.warburton@processplus.uk', 854);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('871724338', 'Andrae', 'McCann', to_date('15-11-1997', 'dd-mm-yyyy'), '0356023956', 'andrae.mccann@shar.be', 773);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('019902928', 'Kelli', 'Marie', to_date('10-05-1989', 'dd-mm-yyyy'), '0639685054', 'kelli.marie@educationaldevelopment.', 519);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('889671111', 'Eliza', 'Rhymes', to_date('14-06-1996', 'dd-mm-yyyy'), '0512896324', 'eliza@dell.it', 122);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('426999514', 'Remy', 'Crimson', to_date('30-12-1995', 'dd-mm-yyyy'), '0702145745', 'r.crimson@fetchlogistics.com', 9);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('013700665', 'Chris', 'Diffie', to_date('04-06-1999', 'dd-mm-yyyy'), '0773232841', 'chris.diffie@computersource.de', 324);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('427381821', 'Miki', 'Zane', to_date('15-03-1999', 'dd-mm-yyyy'), '0493870126', 'miki.zane@ait.com', 5);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('771262246', 'Oded', 'Postlethwaite', to_date('14-01-2001', 'dd-mm-yyyy'), '0898116446', 'opostlethwaite@accucode.fr', 465);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('020361031', 'First', 'Tolkan', to_date('04-02-1997', 'dd-mm-yyyy'), '0661756881', 'first@apexsystems.de', 910);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('996074274', 'Hugh', 'Stanley', to_date('08-12-1994', 'dd-mm-yyyy'), '0634936214', 'hugh.stanley@usainstruments.com', 914);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('087031799', 'Jamie', 'Monk', to_date('23-12-1993', 'dd-mm-yyyy'), '0545934019', 'jamie.monk@harrison.de', 421);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('554788594', 'Wendy', 'El-Saher', to_date('03-01-1987', 'dd-mm-yyyy'), '0374870603', 'wendy.elsaher@fordmotor.com', 201);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('084234052', 'Armin', 'Collins', to_date('08-06-1988', 'dd-mm-yyyy'), '0770454425', 'armin.collins@speakeasy.de', 899);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('477886791', 'Annie', 'DeVita', to_date('19-02-1997', 'dd-mm-yyyy'), '0908479472', 'annie.d@adeasolutions.fi', 18);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('783907365', 'Charles', 'Bedelia', to_date('11-03-1998', 'dd-mm-yyyy'), '0432867408', 'charles@tlsservicebureau.jp', 575);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('661703086', 'Garland', 'Del Toro', to_date('24-03-2001', 'dd-mm-yyyy'), '0928564959', 'gdeltoro@trafficmanagement.ca', 91);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('623774957', 'Radney', 'Norton', to_date('03-10-1992', 'dd-mm-yyyy'), '0713765879', 'radney@streetglow.uk', 18);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('758515404', 'Oliver', 'Moffat', to_date('20-06-2001', 'dd-mm-yyyy'), '0237187465', 'oliver@kingland.com', 599);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('000252841', 'Max', 'Guest', to_date('02-09-2001', 'dd-mm-yyyy'), '0941650493', 'mguest@gagwear.de', 982);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('411594779', 'Johnny', 'urban', to_date('24-01-1994', 'dd-mm-yyyy'), '0613876254', 'johnny.urban@fnb.com', 863);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('200465126', 'Grace', 'Frakes', to_date('03-03-1998', 'dd-mm-yyyy'), '0389470733', 'grace.frakes@stm.com', 804);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('730141201', 'Javon', 'Mifune', to_date('07-10-1991', 'dd-mm-yyyy'), '0040192264', 'javon.mifune@typhoon.ca', 983);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('899940033', 'David', 'Himmelman', to_date('15-12-1992', 'dd-mm-yyyy'), '0177471995', 'david@philipmorris.com', 791);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('833947923', 'Dorry', 'Ramis', to_date('02-05-1998', 'dd-mm-yyyy'), '0648342038', 'dorry.ramis@carboceramics.jp', 650);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('780010323', 'Morris', 'Penn', to_date('01-07-1990', 'dd-mm-yyyy'), '0694177197', 'm.penn@operationaltechnologies.cy', 344);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('511659200', 'Art', 'Redford', to_date('01-12-1999', 'dd-mm-yyyy'), '0465032067', 'aredford@vms.de', 624);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('641303940', 'Ellen', 'Shepherd', to_date('27-02-1991', 'dd-mm-yyyy'), '0954075058', 'ellen.s@sbc.uk', 953);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('041826843', 'Shelby', 'Slater', to_date('08-06-1997', 'dd-mm-yyyy'), '0329757902', 'shelby.slater@ecopy.com', 387);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('977103240', 'Fairuza', 'Dushku', to_date('09-08-1987', 'dd-mm-yyyy'), '0528050312', 'fairuzad@hfn.uk', 742);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('442012123', 'Raul', 'Garofalo', to_date('18-12-1994', 'dd-mm-yyyy'), '0062286123', 'raul.garofalo@gbas.ch', 661);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('755315777', 'Nicky', 'Fender', to_date('26-09-1998', 'dd-mm-yyyy'), '0201970867', 'nicky@mms.com', 351);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('357504979', 'Miko', 'Prowse', to_date('11-10-2000', 'dd-mm-yyyy'), '0400531990', 'miko@intel.com', 330);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('859829661', 'Desmond', 'Hutch', to_date('23-01-2000', 'dd-mm-yyyy'), '0389198432', 'desmond@trinityhomecare.nl', 594);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('866068038', 'Liv', 'urban', to_date('30-08-1993', 'dd-mm-yyyy'), '0610480601', 'liv.urban@aventis.be', 679);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('625635278', 'Kathleen', 'Kretschmann', to_date('25-12-1999', 'dd-mm-yyyy'), '0604016364', 'kathleenk@parker.gr', 767);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('856793590', 'Rob', 'Chandler', to_date('01-09-1992', 'dd-mm-yyyy'), '0704688308', 'r.chandler@glaxosmithkline.it', 81);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('552694767', 'Lance', 'Charles', to_date('17-06-1994', 'dd-mm-yyyy'), '0971091906', 'lance.charles@mwh.ch', 195);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('468710196', 'Burt', 'Ball', to_date('07-01-1993', 'dd-mm-yyyy'), '0763767019', 'burt@pepsico.com', 454);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('488648450', 'Gaby', 'Blaine', to_date('01-02-1994', 'dd-mm-yyyy'), '0932059712', 'gaby.blaine@capellaeducation.in', 170);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('663812521', 'Elisabeth', 'Warren', to_date('03-05-1987', 'dd-mm-yyyy'), '0800219993', 'elisabeth.w@bioanalytical.uk', 34);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('900541542', 'Emma', 'LaSalle', to_date('26-06-1996', 'dd-mm-yyyy'), '0528573684', 'emma.lasalle@yumbrands.uk', 357);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('990877877', 'Chaka', 'Li', to_date('30-04-1997', 'dd-mm-yyyy'), '0900164706', 'chaka@gltg.com', 883);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('504517223', 'Praga', 'McDonald', to_date('04-10-1997', 'dd-mm-yyyy'), '0721037488', 'praga.m@prosum.au', 540);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('436189350', 'Nathan', 'Douglas', to_date('03-01-1995', 'dd-mm-yyyy'), '0867282939', 'nathan.douglas@tilsonlandscape.com', 790);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('401501930', 'Lindsey', 'Deschanel', to_date('12-11-1988', 'dd-mm-yyyy'), '0628030743', 'l.deschanel@unilever.fr', 967);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('410147718', 'Edwin', 'Gaines', to_date('29-02-2000', 'dd-mm-yyyy'), '0052717814', 'edwin.gaines@prosum.uk', 335);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('639510792', 'Jonny', 'Chao', to_date('08-01-2000', 'dd-mm-yyyy'), '0516700124', 'jonny.chao@heritagemicrofilm.com', 485);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('899265968', 'Cesar', 'Haysbert', to_date('30-08-2000', 'dd-mm-yyyy'), '0927060167', 'cesarh@bashen.com', 747);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('572801217', 'Alessandro', 'David', to_date('25-07-2000', 'dd-mm-yyyy'), '0926580158', 'adavid@accucode.ch', 7);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('271556211', 'Meg', 'Slater', to_date('28-10-1995', 'dd-mm-yyyy'), '0102881306', 'meg.slater@escalade.se', 213);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('269697309', 'Val', 'Weaving', to_date('07-08-1989', 'dd-mm-yyyy'), '0604595456', 'val.weaving@pragmatechsoftware.it', 741);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('466848622', 'Ronny', 'Craddock', to_date('12-02-2000', 'dd-mm-yyyy'), '0125003163', 'ronny.craddock@mission.com', 834);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('460569057', 'Ahmad', 'Frost', to_date('28-12-1996', 'dd-mm-yyyy'), '0617918880', 'ahmad.frost@epiqsystems.mx', 886);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('575202130', 'Fairuza', 'Pride', to_date('06-01-1992', 'dd-mm-yyyy'), '0201703079', 'fairuza.pride@capitalautomotive.au', 978);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('426920654', 'Collin', 'Burmester', to_date('03-01-1998', 'dd-mm-yyyy'), '0622422173', 'collin.burmester@kingston.in', 906);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('534714313', 'Ethan', 'DiCaprio', to_date('24-01-1995', 'dd-mm-yyyy'), '0940818819', 'ethan@linersdirect.com', 46);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('565846884', 'Benicio', 'Rizzo', to_date('16-12-2001', 'dd-mm-yyyy'), '0521672369', 'benicior@magnet.fr', 217);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('854473983', 'Edie', 'Beals', to_date('26-06-1998', 'dd-mm-yyyy'), '0401768735', 'edieb@onstaff.com', 595);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('214123005', 'Blair', 'Neuwirth', to_date('02-10-1997', 'dd-mm-yyyy'), '0372446884', 'blair.neuwirth@fam.se', 565);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('818227481', 'Danni', 'Costner', to_date('03-07-1990', 'dd-mm-yyyy'), '0893836675', 'd.costner@cmi.jp', 441);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('289419199', 'Cary', 'Reid', to_date('28-07-1994', 'dd-mm-yyyy'), '0654222846', 'cary.r@bedfordbancshares.com', 848);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('095492426', 'Bebe', 'Randal', to_date('21-02-1991', 'dd-mm-yyyy'), '0661694356', 'b.randal@hardwoodwholesalers.com', 623);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('118479329', 'Joey', 'Cattrall', to_date('13-04-1993', 'dd-mm-yyyy'), '0060242024', 'joeyc@capital.ca', 485);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('388481104', 'Clive', 'Furay', to_date('22-07-1996', 'dd-mm-yyyy'), '0347305100', 'clivef@priorityexpress.com', 86);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('554064825', 'Milla', 'Mohr', to_date('02-02-1991', 'dd-mm-yyyy'), '0507586964', 'milla.m@refinery.uk', 234);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('667566215', 'Clea', 'Mann', to_date('19-05-1995', 'dd-mm-yyyy'), '0252216050', 'clea.m@usenergyservices.de', 684);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('737637796', 'Roberta', 'Wheel', to_date('23-01-1987', 'dd-mm-yyyy'), '0670255907', 'roberta.wheel@marketfirst.jp', 816);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('531906195', 'Luke', 'Santa Rosa', to_date('12-03-1998', 'dd-mm-yyyy'), '0199129157', 'luke@keymark.uk', 545);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('042465046', 'Derrick', 'Askew', to_date('31-03-1987', 'dd-mm-yyyy'), '0363165173', 'd.askew@captechventures.br', 1006);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('269326877', 'Yolanda', 'Gray', to_date('02-11-1998', 'dd-mm-yyyy'), '0768225633', 'y.gray@bristolmyers.com', 517);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('154630375', 'Ozzy', 'Bancroft', to_date('15-07-1999', 'dd-mm-yyyy'), '0115657796', 'ozzy.bancroft@unitedasset.il', 53);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('310934517', 'Glenn', 'Chandler', to_date('09-05-1987', 'dd-mm-yyyy'), '0381476795', 'glenn.chandler@hps.de', 900);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('840598865', 'Robert', 'Abraham', to_date('18-04-1994', 'dd-mm-yyyy'), '0863629147', 'r.abraham@summitenergy.de', 975);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('644070925', 'Sally', 'Larter', to_date('18-10-2000', 'dd-mm-yyyy'), '0400937278', 'sallyl@unica.hk', 134);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('218785058', 'Merrilee', 'Coward', to_date('13-03-1987', 'dd-mm-yyyy'), '0800135813', 'merrilee.coward@privatebancorp.nl', 37);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('664083292', 'Diane', 'Balaban', to_date('06-10-1998', 'dd-mm-yyyy'), '0676016458', 'diane@adeasolutions.dk', 674);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('446427784', 'Christian', 'Lewin', to_date('21-02-1999', 'dd-mm-yyyy'), '0760552525', 'christian.lewin@northhighland.za', 918);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('763037057', 'Molly', 'Maguire', to_date('01-08-1994', 'dd-mm-yyyy'), '0341964568', 'm.maguire@smi.it', 28);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('797874553', 'Elle', 'McIntosh', to_date('28-12-1998', 'dd-mm-yyyy'), '0785415634', 'elle@grs.se', 177);
commit;
prompt 100 records committed...
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('562372864', 'Charles', 'Conroy', to_date('26-12-1989', 'dd-mm-yyyy'), '0812924875', 'charles.conroy@keymark.com', 222);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('628451211', 'Ray', 'Davidtz', to_date('13-10-1999', 'dd-mm-yyyy'), '0484003178', 'ray.d@alogent.fr', 133);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('547700431', 'Collective', 'Sainte-Marie', to_date('19-09-1994', 'dd-mm-yyyy'), '0124144166', 'collective.s@jma.com', 720);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('295806506', 'Rick', 'David', to_date('14-06-1992', 'dd-mm-yyyy'), '0238771794', 'rick.d@solipsys.br', 692);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('739566112', 'Denise', 'Donovan', to_date('30-11-2000', 'dd-mm-yyyy'), '0659200851', 'denise.donovan@ois.de', 756);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('419412673', 'Carole', 'Cummings', to_date('23-04-1991', 'dd-mm-yyyy'), '0536322953', 'carole.cummings@toyotamotor.com', 552);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('792749442', 'Embeth', 'Red', to_date('07-11-1987', 'dd-mm-yyyy'), '0638915771', 'ered@advancedneuromodulation.com', 421);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('440530099', 'Willem', 'Zevon', to_date('01-03-1990', 'dd-mm-yyyy'), '0876018635', 'wzevon@democracydata.nl', 2);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('335423522', 'Moe', 'Chambers', to_date('21-01-1998', 'dd-mm-yyyy'), '0161575515', 'moe.chambers@spectrum.com', 637);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('911057100', 'Miki', 'Williamson', to_date('12-06-1997', 'dd-mm-yyyy'), '0551365958', 'miki.williamson@saksinc.fr', 621);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('216335951', 'Julianne', 'Weisz', to_date('18-05-1992', 'dd-mm-yyyy'), '0805919263', 'julianne.weisz@sds.com', 599);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('133509328', 'Percy', 'Cromwell', to_date('13-02-1999', 'dd-mm-yyyy'), '0117276008', 'percy.c@kiamotors.fr', 638);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('659842684', 'Cameron', 'Woodard', to_date('16-03-1998', 'dd-mm-yyyy'), '0802935844', 'cameron@at.com', 153);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('780209218', 'Nils', 'Ronstadt', to_date('20-05-1999', 'dd-mm-yyyy'), '0938640385', 'nils.ronstadt@adolph.com', 920);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('462407196', 'Ernie', 'Cronin', to_date('15-06-1988', 'dd-mm-yyyy'), '0866019234', 'ecronin@sci.at', 914);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('564903590', 'Kay', 'O''Keefe', to_date('12-01-1989', 'dd-mm-yyyy'), '0932594166', 'kay.okeefe@hondamotor.ch', 303);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('688833787', 'Natasha', 'Weir', to_date('22-12-1989', 'dd-mm-yyyy'), '0805042653', 'natasha@conquestsystems.it', 634);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('192961199', 'Tony', 'Laurie', to_date('20-08-1995', 'dd-mm-yyyy'), '0549567029', 't.laurie@aventis.gr', 454);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('607414468', 'Peter', 'Bates', to_date('11-01-1990', 'dd-mm-yyyy'), '0990898734', 'peter.bates@deutschetelekom.com', 38);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('926121149', 'Chanté', 'Judd', to_date('21-11-1990', 'dd-mm-yyyy'), '0111367911', 'chant@marketbased.ch', 251);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('989117067', 'Adina', 'Shawn', to_date('09-04-1998', 'dd-mm-yyyy'), '0502671577', 'a.shawn@aristotle.com', 876);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('950569391', 'Christina', 'Cornell', to_date('01-03-1991', 'dd-mm-yyyy'), '0183839494', 'christina@tropicaloasis.de', 87);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('015283521', 'CeCe', 'Pesci', to_date('13-12-1997', 'dd-mm-yyyy'), '0326222658', 'c.pesci@visionarysystems.ca', 551);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('548965002', 'Arnold', 'Biel', to_date('01-01-1996', 'dd-mm-yyyy'), '0054330397', 'a.biel@fra.com', 85);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('939195930', 'Chaka', 'Finney', to_date('12-01-1988', 'dd-mm-yyyy'), '0777420258', 'chaka.finney@usainstruments.uk', 597);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('159118621', 'Sheena', 'Campbell', to_date('13-06-1997', 'dd-mm-yyyy'), '0419014875', 'sheena.c@infovision.it', 425);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('150770269', 'Christina', 'Valentin', to_date('19-07-1992', 'dd-mm-yyyy'), '0759804302', 'christina.valentin@gcd.com', 279);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('598047701', 'Carla', 'Hagar', to_date('22-02-1993', 'dd-mm-yyyy'), '0894110942', 'carla@air.com', 680);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('229102150', 'Cate', 'Maguire', to_date('06-01-1989', 'dd-mm-yyyy'), '0439649821', 'cate@trm.com', 39);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('371917778', 'Merillee', 'Henstridge', to_date('08-11-1997', 'dd-mm-yyyy'), '0531216634', 'merillee.henstridge@taycorfinancial', 784);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('704853465', 'Sinead', 'Schneider', to_date('03-02-1989', 'dd-mm-yyyy'), '0316191838', 'sinead@royalgold.pl', 154);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('059180452', 'Matthew', 'Darren', to_date('18-04-1999', 'dd-mm-yyyy'), '0048258191', 'matthew.darren@loreal.au', 59);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('561314896', 'Albertina', 'Allison', to_date('08-10-1995', 'dd-mm-yyyy'), '0559047777', 'albertina.allison@tmt.ca', 751);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('159716219', 'Giovanni', 'Arkenstone', to_date('03-12-1988', 'dd-mm-yyyy'), '0069062589', 'giovanni.arkenstone@bedfordbancshar', 568);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('634034918', 'Robby', 'Rodgers', to_date('06-07-2000', 'dd-mm-yyyy'), '0043053962', 'r.rodgers@linacsystems.com', 410);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('945565666', 'Ronny', 'Paltrow', to_date('19-08-1988', 'dd-mm-yyyy'), '0848203816', 'ronny.paltrow@innovateecommerce.com', 437);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('680977691', 'Charlize', 'Gracie', to_date('01-12-1992', 'dd-mm-yyyy'), '0638677832', 'charlize.gracie@teamstudio.de', 220);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('519147121', 'Gilberto', 'Murray', to_date('06-02-1993', 'dd-mm-yyyy'), '0809640977', 'g.murray@hondamotor.de', 58);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('385214883', 'Desmond', 'Guilfoyle', to_date('23-08-2000', 'dd-mm-yyyy'), '0637809498', 'desmond.guilfoyle@dataprise.in', 425);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('200459479', 'Brendan', 'Amos', to_date('26-06-1994', 'dd-mm-yyyy'), '0659581077', 'brendan.amos@als.com', 518);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('103677264', 'Kirsten', 'Stowe', to_date('14-12-1999', 'dd-mm-yyyy'), '0476164961', 'kirstens@balchem.com', 726);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('979621779', 'Marisa', 'Nelson', to_date('06-06-1994', 'dd-mm-yyyy'), '0679969188', 'marisa.nelson@spas.com', 845);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('170680663', 'Ritchie', 'Van Damme', to_date('14-02-1988', 'dd-mm-yyyy'), '0709822623', 'r.vandamme@timevision.es', 816);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('136079834', 'Ramsey', 'Carlyle', to_date('06-10-1989', 'dd-mm-yyyy'), '0289824756', 'r.carlyle@its.br', 542);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('023212398', 'Lou', 'Cartlidge', to_date('10-11-1994', 'dd-mm-yyyy'), '0582332210', 'l.cartlidge@netnumina.uk', 742);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('930453297', 'Judge', 'Rucker', to_date('28-07-1993', 'dd-mm-yyyy'), '0737149868', 'judge.r@pacificdatadesigns.ar', 452);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('881356592', 'Loretta', 'McGowan', to_date('06-03-1993', 'dd-mm-yyyy'), '0470687251', 'loretta@airmethods.com', 217);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('342567622', 'Terence', 'Hatchet', to_date('13-02-1996', 'dd-mm-yyyy'), '0925127091', 'terence.hatchet@smi.ch', 528);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('025103331', 'Robby', 'Sawa', to_date('19-07-1996', 'dd-mm-yyyy'), '0963719034', 'robby.sawa@caliber.is', 153);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('076120624', 'Ruth', 'Zahn', to_date('13-07-1996', 'dd-mm-yyyy'), '0651288779', 'ruth.z@columbiabancorp.ch', 957);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('448457770', 'Darren', 'Lopez', to_date('26-10-1991', 'dd-mm-yyyy'), '0482498092', 'darren.lopez@serentec.de', 883);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('198902554', 'Loreena', 'Michaels', to_date('30-01-1989', 'dd-mm-yyyy'), '0176407407', 'loreena@zaiqtechnologies.nl', 340);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('963632769', 'Edward', 'Zane', to_date('08-03-1999', 'dd-mm-yyyy'), '0234984400', 'edward@adeasolutions.com', 535);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('599998728', 'William', 'Leoni', to_date('05-04-1987', 'dd-mm-yyyy'), '0701253370', 'w.leoni@ssi.jp', 66);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('833027699', 'Buddy', 'Oldman', to_date('17-02-1991', 'dd-mm-yyyy'), '0523211322', 'buddy.o@trm.com', 308);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('530981004', 'Doug', 'Potter', to_date('05-07-1996', 'dd-mm-yyyy'), '0257595945', 'd.potter@tropicaloasis.si', 686);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('551786746', 'Suzanne', 'Hauser', to_date('17-09-1998', 'dd-mm-yyyy'), '0399051687', 'suzanne.hauser@newtoninteractive.jp', 236);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('612807614', 'Renee', 'Scheider', to_date('29-10-1989', 'dd-mm-yyyy'), '0280870352', 'r.scheider@coadvantageresources.se', 97);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('273251555', 'Mia', 'Sossamon', to_date('12-12-1999', 'dd-mm-yyyy'), '0499532283', 'mia.sossamon@adolph.de', 904);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('821463309', 'Stellan', 'Allison', to_date('28-10-1996', 'dd-mm-yyyy'), '0677588957', 'stellan@progressivedesigns.jp', 222);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('678903034', 'Colin', 'Crimson', to_date('01-02-1996', 'dd-mm-yyyy'), '0569241331', 'colin.crimson@dell.com', 275);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('188731408', 'Pete', 'Tripplehorn', to_date('22-08-2001', 'dd-mm-yyyy'), '0737627104', 'pete@restaurantpartners.com', 927);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('299989503', 'Grant', 'MacDonald', to_date('28-01-1988', 'dd-mm-yyyy'), '0180577234', 'grant.macdonald@microtek.uk', 16);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('807478919', 'Pierce', 'Torn', to_date('22-02-1996', 'dd-mm-yyyy'), '0588687347', 'pierce.torn@woronocobancorp.jp', 850);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('886549088', 'Moe', 'McAnally', to_date('19-07-1993', 'dd-mm-yyyy'), '0345034968', 'mmcanally@volkswagen.uk', 465);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('444730036', 'Timothy', 'Bullock', to_date('14-12-1998', 'dd-mm-yyyy'), '0292994555', 'timothy.bullock@surmodics.com', 684);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('790588554', 'Beverley', 'Ifans', to_date('07-04-1994', 'dd-mm-yyyy'), '0210612444', 'beverley.ifans@webgroup.uk', 896);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('180292679', 'Lin', 'Dawson', to_date('05-10-1991', 'dd-mm-yyyy'), '0594875452', 'lin@componentgraphics.com', 129);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('995632251', 'Jonathan', 'Humphrey', to_date('09-09-1998', 'dd-mm-yyyy'), '0261514974', 'jhumphrey@airmethods.com', 607);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('323980079', 'Joanna', 'Aiken', to_date('01-12-1989', 'dd-mm-yyyy'), '0388362782', 'joanna.aiken@fmi.fr', 230);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('960238264', 'Cyndi', 'Driver', to_date('14-04-1993', 'dd-mm-yyyy'), '0406226631', 'cyndi.driver@royalgold.jp', 621);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('743489359', 'Annie', 'Williamson', to_date('23-06-1998', 'dd-mm-yyyy'), '0277222236', 'annie.williamson@nhhc.nl', 979);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('403148912', 'Mac', 'Brickell', to_date('12-01-1994', 'dd-mm-yyyy'), '0816964641', 'mac.brickell@mission.cn', 753);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('106300135', 'Kevin', 'Carlton', to_date('16-08-1997', 'dd-mm-yyyy'), '0844897686', 'kevin.carlton@marketfirst.com', 147);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('651947299', 'Lin', 'Belushi', to_date('02-07-1992', 'dd-mm-yyyy'), '0839856175', 'lin.belushi@ads.com', 366);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('227672371', 'Forest', 'Braugher', to_date('19-06-1989', 'dd-mm-yyyy'), '0368250609', 'forest.braugher@connected.br', 546);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('605842621', 'Shirley', 'DeVita', to_date('18-04-1997', 'dd-mm-yyyy'), '0177033270', 'sdevita@accurateautobody.cn', 989);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('195229946', 'Irene', 'Bates', to_date('05-09-1998', 'dd-mm-yyyy'), '0078366088', 'irene.bates@esoftsolutions.it', 904);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('082304384', 'Yolanda', 'Hersh', to_date('24-01-1988', 'dd-mm-yyyy'), '0994998312', 'yolanda.hersh@solipsys.uk', 892);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('806469359', 'Balthazar', 'Waits', to_date('16-12-2001', 'dd-mm-yyyy'), '0992238111', 'balthazar.waits@at.it', 958);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('632059434', 'Malcolm', 'Plummer', to_date('15-04-1998', 'dd-mm-yyyy'), '0100548267', 'malcolm@safeway.de', 258);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('819332196', 'Angie', 'Imbruglia', to_date('12-01-1990', 'dd-mm-yyyy'), '0777770759', 'a.imbruglia@valleyoaksystems.ca', 248);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('533771898', 'Pelvic', 'Carlton', to_date('14-11-1991', 'dd-mm-yyyy'), '0405583836', 'pelvic.carlton@ogiointernational.br', 824);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('173957645', 'Nicole', 'Neil', to_date('12-01-1999', 'dd-mm-yyyy'), '0437973586', 'n.neil@navigatorsystems.com', 767);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('728551733', 'Tara', 'Fraser', to_date('28-12-1990', 'dd-mm-yyyy'), '0344638272', 'tara.fraser@comglobalsystems.de', 326);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('464785866', 'Gwyneth', 'Spector', to_date('17-06-1995', 'dd-mm-yyyy'), '0823058650', 'gwyneth.spector@httprint.de', 804);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('321960313', 'Jane', 'Rankin', to_date('04-11-1994', 'dd-mm-yyyy'), '0046908320', 'jane.rankin@saltgroup.uk', 488);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('818974714', 'Debby', 'White', to_date('20-03-1987', 'dd-mm-yyyy'), '0918744213', 'debby@telecheminternational.ec', 667);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('479324552', 'Eliza', 'Loggins', to_date('13-07-1989', 'dd-mm-yyyy'), '0759327750', 'e.loggins@coridiantechnologies.br', 251);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('246058901', 'Sheryl', 'Cara', to_date('21-03-1997', 'dd-mm-yyyy'), '0586718962', 'sheryl.cara@scripnet.com', 610);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('569794322', 'Tia', 'Maxwell', to_date('02-12-1990', 'dd-mm-yyyy'), '0917506345', 'tia.maxwell@lms.ca', 876);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('420064308', 'Elias', 'Lindley', to_date('23-03-1990', 'dd-mm-yyyy'), '0074796067', 'elindley@smg.com', 296);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('960467698', 'Goldie', 'Chaykin', to_date('26-04-1998', 'dd-mm-yyyy'), '0616974981', 'goldie.c@streetglow.nl', 686);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('714774858', 'Heath', 'Shatner', to_date('17-05-1999', 'dd-mm-yyyy'), '0715044672', 'heath@eagleone.au', 601);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('823024119', 'Liv', 'Pearce', to_date('26-04-1989', 'dd-mm-yyyy'), '0329251608', 'liv.pearce@irissoftware.com', 939);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('702564984', 'Trick', 'Sledge', to_date('19-01-1997', 'dd-mm-yyyy'), '0775314764', 'tsledge@comnetinternational.fr', 554);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('613927468', 'Lari', 'Lee', to_date('17-11-2001', 'dd-mm-yyyy'), '0262289334', 'lari.l@ait.nl', 547);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('378564581', 'Andrea', 'Mattea', to_date('23-11-1993', 'dd-mm-yyyy'), '0156720085', 'a.mattea@keymark.com', 550);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('961238816', 'Randall', 'Lorenz', to_date('19-07-1987', 'dd-mm-yyyy'), '0070652783', 'randall.lorenz@ptg.de', 926);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('483114131', 'Mira', 'Pony', to_date('15-08-1990', 'dd-mm-yyyy'), '0876953979', 'mira.p@cardinalcartridge.com', 688);
commit;
prompt 200 records committed...
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('902791479', 'Lila', 'Warden', to_date('16-02-1997', 'dd-mm-yyyy'), '0079654305', 'lwarden@bowman.com', 968);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('672970491', 'Gil', 'Chapman', to_date('28-03-1999', 'dd-mm-yyyy'), '0191483908', 'gil.chapman@voicelog.fr', 674);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('184052122', 'Michael', 'Humphrey', to_date('16-02-1995', 'dd-mm-yyyy'), '0233957743', 'michael@genghisgrill.au', 979);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('786489205', 'Austin', 'Llewelyn', to_date('09-05-1991', 'dd-mm-yyyy'), '0442340037', 'austin.llewelyn@stm.uk', 987);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('599141121', 'Lindsey', 'Swayze', to_date('24-06-1990', 'dd-mm-yyyy'), '0529506241', 'lindseys@ubp.com', 126);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('933278843', 'Bo', 'Krieger', to_date('03-08-1995', 'dd-mm-yyyy'), '0247654025', 'b.krieger@fsffinancial.il', 579);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('977201711', 'Vivica', 'Connick', to_date('31-12-1997', 'dd-mm-yyyy'), '0583003653', 'vivica.connick@hitechpharmacal.com', 555);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('145116670', 'Kirk', 'Thorton', to_date('17-08-1990', 'dd-mm-yyyy'), '0814807449', 'kirk.t@trm.com', 187);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('458840206', 'Dom', 'Reilly', to_date('23-08-1990', 'dd-mm-yyyy'), '0213095907', 'dom.reilly@commworks.com', 908);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('199703903', 'Jet', 'Lucas', to_date('19-05-1998', 'dd-mm-yyyy'), '0184461806', 'jet.lucas@verizon.hu', 613);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('445284626', 'Joaquim', 'Aiken', to_date('09-08-1998', 'dd-mm-yyyy'), '0788045434', 'joaquim.aiken@employerservices.de', 340);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('806642896', 'Mili', 'Woodward', to_date('20-03-1998', 'dd-mm-yyyy'), '0817930483', 'mili.woodward@americanvanguard.uk', 991);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('025074272', 'Gavin', 'Clarkson', to_date('09-04-1993', 'dd-mm-yyyy'), '0901977487', 'gavinc@mcdonalds.de', 888);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('535180829', 'Harriet', 'Cusack', to_date('23-05-2001', 'dd-mm-yyyy'), '0649170110', 'h.cusack@hersheyfoods.com', 444);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('486372121', 'Brothers', 'Koyana', to_date('18-01-2000', 'dd-mm-yyyy'), '0445156040', 'brothers.koyana@aco.br', 796);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('140969969', 'Powers', 'Cromwell', to_date('06-10-1996', 'dd-mm-yyyy'), '0481063790', 'powers.cromwell@whitewave.com', 436);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('065156132', 'Willem', 'Marshall', to_date('30-07-1991', 'dd-mm-yyyy'), '0675311496', 'willem.marshall@spd.com', 787);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('084468342', 'Luke', 'Balaban', to_date('09-02-1994', 'dd-mm-yyyy'), '0025325567', 'luke.balaban@fmt.ca', 560);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('264923710', 'Loretta', 'Stiller', to_date('08-09-1999', 'dd-mm-yyyy'), '0899849685', 'loretta.stiller@contract.uk', 856);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('328931761', 'Morgan', 'Askew', to_date('15-02-1994', 'dd-mm-yyyy'), '0743698099', 'morgan.askew@pioneermortgage.za', 254);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('513523815', 'Cathy', 'DiBiasio', to_date('01-06-1998', 'dd-mm-yyyy'), '0275655886', 'cathy@yashtechnologies.at', 236);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('436373857', 'Mos', 'Tanon', to_date('26-05-1996', 'dd-mm-yyyy'), '0170814790', 'm.tanon@unica.uk', 524);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('472096633', 'Debby', 'Nugent', to_date('17-08-1993', 'dd-mm-yyyy'), '0949343415', 'debbyn@procurementcentre.com', 699);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('581395996', 'Jean-Claude', 'Tennison', to_date('27-01-2001', 'dd-mm-yyyy'), '0913000821', 'j.tennison@newmedia.com', 129);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('832355942', 'Glenn', 'Jay', to_date('29-11-1989', 'dd-mm-yyyy'), '0436399335', 'glenn.jay@usgovernment.com', 428);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('585906154', 'Cherry', 'McClinton', to_date('27-08-1996', 'dd-mm-yyyy'), '0798384015', 'c.mcclinton@randomwalk.com', 807);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('261891327', 'Allan', 'McNeice', to_date('27-09-1988', 'dd-mm-yyyy'), '0357492335', 'allanm@doctorsassociates.br', 188);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('120563835', 'Charlie', 'Mraz', to_date('24-08-1997', 'dd-mm-yyyy'), '0404009350', 'charlie.mraz@epiqsystems.com', 516);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('927870487', 'Rhys', 'Holbrook', to_date('30-12-1995', 'dd-mm-yyyy'), '0724277505', 'rhys.holbrook@fam.ch', 237);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('443347647', 'Emily', 'Foxx', to_date('26-11-1988', 'dd-mm-yyyy'), '0096901818', 'emily.foxx@tps.de', 716);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('080600263', 'Larenz', 'Katt', to_date('13-02-1996', 'dd-mm-yyyy'), '0631727765', 'larenzk@techbooks.com', 426);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('323308901', 'Vonda', 'Jay', to_date('21-06-1994', 'dd-mm-yyyy'), '0200382532', 'vondaj@stm.com', 519);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('394782633', 'Avril', 'Ojeda', to_date('06-05-1997', 'dd-mm-yyyy'), '0678735383', 'avril.o@servicesource.nl', 353);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('240903488', 'Robby', 'Gatlin', to_date('31-03-1999', 'dd-mm-yyyy'), '0320129624', 'robby.gatlin@quicksilverresources.c', 612);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('703315102', 'Collective', 'Rifkin', to_date('09-06-1994', 'dd-mm-yyyy'), '0100260042', 'c.rifkin@spas.com', 728);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('190058870', 'Crispin', 'Doucette', to_date('11-11-1989', 'dd-mm-yyyy'), '0205857836', 'crispind@cis.es', 766);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('657481928', 'Lena', 'Pesci', to_date('02-11-1999', 'dd-mm-yyyy'), '0608035593', 'lena.pesci@adeasolutions.com', 357);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('260611584', 'Joey', 'Bassett', to_date('01-10-1997', 'dd-mm-yyyy'), '0211295775', 'joey@ibfh.de', 386);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('709007510', 'Cate', 'de Lancie', to_date('19-09-1996', 'dd-mm-yyyy'), '0355653804', 'c.delancie@lindin.com', 569);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('615564911', 'Henry', 'Peebles', to_date('12-09-1992', 'dd-mm-yyyy'), '0721962179', 'henryp@credopetroleum.com', 593);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('411570462', 'Barry', 'Harmon', to_date('02-08-1996', 'dd-mm-yyyy'), '0526213285', 'barry.h@quicksilverresources.com', 242);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('325716651', 'Cuba', 'Gugino', to_date('14-07-1994', 'dd-mm-yyyy'), '0743346517', 'c.gugino@fds.fr', 340);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('286233229', 'Ian', 'Rodgers', to_date('24-03-2000', 'dd-mm-yyyy'), '0707159933', 'ian.rodgers@marlabs.de', 384);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('732303788', 'Davis', 'Katt', to_date('17-01-1998', 'dd-mm-yyyy'), '0908817416', 'davis.katt@summitenergy.ca', 817);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('529585640', 'Bob', 'Holeman', to_date('08-05-1989', 'dd-mm-yyyy'), '0148177186', 'bob.h@eastmankodak.com', 114);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('502963692', 'Hope', 'Beatty', to_date('25-05-1991', 'dd-mm-yyyy'), '0328450710', 'hope.beatty@actechnologies.fr', 208);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('460735104', 'Rhys', 'Walken', to_date('14-07-1990', 'dd-mm-yyyy'), '0011110404', 'rhys.walken@democracydata.de', 546);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('666603298', 'Pete', 'Paxton', to_date('08-03-1997', 'dd-mm-yyyy'), '0461121811', 'p.paxton@sysconmedia.com', 830);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('098298524', 'Elizabeth', 'Shepherd', to_date('05-02-2001', 'dd-mm-yyyy'), '0579390160', 'e.shepherd@diversitech.com', 523);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('587179576', 'Joy', 'Penn', to_date('17-09-1995', 'dd-mm-yyyy'), '0028136370', 'jpenn@powerlight.uk', 859);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('265412187', 'Ryan', 'Deschanel', to_date('20-03-1990', 'dd-mm-yyyy'), '0908421679', 'ryan.deschanel@meridiangold.fr', 419);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('223387462', 'Keanu', 'Metcalf', to_date('19-12-1999', 'dd-mm-yyyy'), '0117488955', 'keanu.metcalf@mls.com', 224);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('910060105', 'Hookah', 'Caine', to_date('19-11-2001', 'dd-mm-yyyy'), '0607159874', 'hookah.caine@dillards.com', 469);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('024173901', 'Al', 'Scaggs', to_date('13-08-2001', 'dd-mm-yyyy'), '0236069444', 'als@millersystems.com', 849);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('949455945', 'Mel', 'Shalhoub', to_date('05-08-1987', 'dd-mm-yyyy'), '0821732906', 'mel.shalhoub@isd.de', 164);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('439735279', 'Julianna', 'Curtis', to_date('20-11-1996', 'dd-mm-yyyy'), '0937936609', 'julianna.curtis@wlt.com', 437);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('723701036', 'Geraldine', 'Sizemore', to_date('29-07-1999', 'dd-mm-yyyy'), '0964389978', 'gsizemore@unica.com', 447);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('050600329', 'Judd', 'Rhodes', to_date('20-01-2001', 'dd-mm-yyyy'), '0796542324', 'judd.rhodes@viacom.com', 503);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('076523062', 'Demi', 'McCabe', to_date('04-12-1999', 'dd-mm-yyyy'), '0469317985', 'demim@glmt.se', 1000);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('165369761', 'Peabo', 'Page', to_date('11-11-1988', 'dd-mm-yyyy'), '0983522185', 'peabo.page@microsoft.de', 136);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('788298397', 'Scott', 'Walken', to_date('27-01-1992', 'dd-mm-yyyy'), '0211087681', 'scott.w@columbiabancorp.ca', 50);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('834206696', 'Charlie', 'Napolitano', to_date('26-07-1992', 'dd-mm-yyyy'), '0905328901', 'charlie.napolitano@bioanalytical.ca', 566);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('794475379', 'Frederic', 'Foster', to_date('14-05-1989', 'dd-mm-yyyy'), '0805160696', 'frederic.foster@solutionbuilders.co', 759);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('013298698', 'Debby', 'Torn', to_date('24-03-1991', 'dd-mm-yyyy'), '0488390217', 'd.torn@visainternational.jp', 465);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('344336623', 'Bebe', 'Mifune', to_date('23-01-1989', 'dd-mm-yyyy'), '0453561564', 'bebe.m@ceo.com', 936);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('839161222', 'Chris', 'Heche', to_date('22-04-1988', 'dd-mm-yyyy'), '0463735701', 'chrish@loreal.de', 966);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('887078899', 'Taryn', 'Jordan', to_date('23-05-1999', 'dd-mm-yyyy'), '0662179207', 't.jordan@smartdrawcom.com', 726);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('266005313', 'Julianne', 'Rain', to_date('07-07-1988', 'dd-mm-yyyy'), '0185710989', 'julianne.rain@dillards.com', 913);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('086527199', 'Minnie', 'McIntyre', to_date('17-05-2000', 'dd-mm-yyyy'), '0340192801', 'minnie.mcintyre@smartdrawcom.ch', 421);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('656439597', 'Embeth', 'McGoohan', to_date('12-05-1990', 'dd-mm-yyyy'), '0176929934', 'embeth.mcgoohan@nhhc.com', 574);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('629399441', 'Petula', 'Pollak', to_date('23-04-1993', 'dd-mm-yyyy'), '0361195488', 'petula.pollak@bashen.com', 641);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('997117718', 'Mike', 'Crowell', to_date('23-04-1998', 'dd-mm-yyyy'), '0785489243', 'mike.crowell@alternativetechnology.', 712);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('920902975', 'Jena', 'Witt', to_date('13-01-1998', 'dd-mm-yyyy'), '0778538095', 'jena.witt@unit.com', 518);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('619424857', 'Keanu', 'Archer', to_date('14-07-1996', 'dd-mm-yyyy'), '0276707043', 'keanu.archer@alternativetechnology.', 406);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('112836847', 'Raul', 'Lerner', to_date('01-11-1995', 'dd-mm-yyyy'), '0521820297', 'r.lerner@bat.ca', 99);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('765559371', 'Janeane', 'Nolte', to_date('19-06-1992', 'dd-mm-yyyy'), '0479575159', 'janeane.nolte@typhoon.com', 758);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('499772461', 'Victor', 'Dalley', to_date('22-10-1997', 'dd-mm-yyyy'), '0494667161', 'victor.d@gbas.br', 851);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('557931488', 'Jeremy', 'Flanery', to_date('24-10-1987', 'dd-mm-yyyy'), '0784881016', 'jeremyf@johnson.au', 223);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('456843106', 'Sean', 'Vance', to_date('13-12-1993', 'dd-mm-yyyy'), '0298397884', 'seanv@ois.jp', 23);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('952890216', 'Sheena', 'Kelly', to_date('21-03-2001', 'dd-mm-yyyy'), '0538014853', 's.kelly@csi.com', 876);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('891759770', 'Anthony', 'Bryson', to_date('19-11-1993', 'dd-mm-yyyy'), '0734207269', 'anthony.bryson@hcoa.ch', 815);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('278590082', 'Carlos', 'Child', to_date('19-07-1995', 'dd-mm-yyyy'), '0489195864', 'carlos.child@genextechnologies.com', 662);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('694503220', 'Ricky', 'McGill', to_date('24-11-1999', 'dd-mm-yyyy'), '0244413219', 'ricky.mcgill@daimlerchrysler.jp', 284);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('920937386', 'Daryl', 'Wilder', to_date('19-03-1988', 'dd-mm-yyyy'), '0105316107', 'daryl.wilder@nhhc.de', 72);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('250572626', 'Ice', 'Apple', to_date('01-05-1991', 'dd-mm-yyyy'), '0266981806', 'ice@northhighland.pt', 955);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('236777172', 'Scarlett', 'Bratt', to_date('26-01-1993', 'dd-mm-yyyy'), '0544072008', 's.bratt@boldtechsystems.se', 284);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('316789085', 'Alana', 'Carrey', to_date('26-11-1999', 'dd-mm-yyyy'), '0037809301', 'alana.c@qssgroup.ch', 137);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('903295332', 'Natascha', 'Balk', to_date('19-02-1991', 'dd-mm-yyyy'), '0171988615', 'natascha.balk@mwh.com', 704);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('148531270', 'Kirk', 'Collie', to_date('08-05-1989', 'dd-mm-yyyy'), '0260786838', 'kirkc@fns.com', 614);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('917297719', 'Whoopi', 'Hackman', to_date('22-09-1999', 'dd-mm-yyyy'), '0953449396', 'whoopi.hackman@nmr.de', 356);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('238929772', 'Oded', 'Pleasence', to_date('19-07-1990', 'dd-mm-yyyy'), '0429876429', 'oded.pleasence@capitalautomotive.ca', 951);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('711212086', 'Phil', 'Oldman', to_date('29-04-2000', 'dd-mm-yyyy'), '0149055639', 'phil.oldman@hersheyfoods.com', 348);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('842004671', 'Famke', 'Dreyfuss', to_date('21-01-1991', 'dd-mm-yyyy'), '0528557715', 'famke.dreyfuss@mattel.com', 163);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('464483832', 'Bernie', 'Mathis', to_date('12-07-1996', 'dd-mm-yyyy'), '0130995740', 'bernie.m@hitechpharmacal.com', 771);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('331439121', 'Courtney', 'Tomei', to_date('11-03-1991', 'dd-mm-yyyy'), '0724534727', 'courtney.tomei@sfmai.com', 807);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('705567748', 'Tracy', 'Brandt', to_date('28-03-1996', 'dd-mm-yyyy'), '0848106051', 'tracy.b@capitolbancorp.de', 253);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('665841224', 'First', 'Clarkson', to_date('15-04-1992', 'dd-mm-yyyy'), '0114976463', 'fclarkson@oriservices.it', 335);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('300453882', 'Gordon', 'Loeb', to_date('02-01-1998', 'dd-mm-yyyy'), '0082230300', 'gloeb@fordmotor.it', 738);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('878964497', 'Mae', 'Moss', to_date('22-10-1992', 'dd-mm-yyyy'), '0579721520', 'mae.moss@nissanmotor.jp', 1003);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('257285772', 'Earl', 'Caine', to_date('25-08-2000', 'dd-mm-yyyy'), '0591679097', 'earl@merck.de', 591);
commit;
prompt 300 records committed...
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('173100769', 'Nicholas', 'Cantrell', to_date('18-12-1996', 'dd-mm-yyyy'), '0264451493', 'nicholas.cantrell@tama.de', 585);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('516502505', 'Debby', 'Levy', to_date('25-03-1987', 'dd-mm-yyyy'), '0253755127', 'debby.levy@ris.com', 104);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('643603834', 'Goldie', 'Murdock', to_date('02-08-1994', 'dd-mm-yyyy'), '0803039669', 'gmurdock@pharmacia.com', 792);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('004906430', 'Alessandro', 'Connick', to_date('30-10-1995', 'dd-mm-yyyy'), '0976976880', 'alessandro.connick@refinery.uk', 2);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('926782462', 'Jim', 'Pfeiffer', to_date('10-11-1998', 'dd-mm-yyyy'), '0945986098', 'jim.pfeiffer@elitemedical.br', 333);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('480306624', 'Jose', 'Tah', to_date('15-11-1999', 'dd-mm-yyyy'), '0358901742', 'jose.tah@nissanmotor.dk', 251);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('506526392', 'Amy', 'Gano', to_date('21-08-1998', 'dd-mm-yyyy'), '0416265758', 'amy.gano@campbellsoup.de', 309);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('479408037', 'Meredith', 'Swinton', to_date('18-02-1996', 'dd-mm-yyyy'), '0281733867', 'meredith.swinton@fnb.uk', 694);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('374243895', 'Carlos', 'Uggams', to_date('08-08-1998', 'dd-mm-yyyy'), '0481669426', 'carlos.u@nlx.com', 665);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('819385868', 'Gord', 'Krieger', to_date('22-02-1994', 'dd-mm-yyyy'), '0059659739', 'gord.krieger@callhenry.com', 564);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('191357082', 'Dylan', 'Kennedy', to_date('27-04-1994', 'dd-mm-yyyy'), '0952403763', 'dylan.k@oss.cl', 947);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('119510556', 'Nelly', 'Bale', to_date('08-09-2000', 'dd-mm-yyyy'), '0316286185', 'n.bale@trinityhomecare.com', 275);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('611888673', 'Woody', 'Sanders', to_date('27-01-1994', 'dd-mm-yyyy'), '0301559267', 'wsanders@eagleone.jp', 87);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('398086315', 'Teena', 'Saxon', to_date('18-12-1991', 'dd-mm-yyyy'), '0531274581', 'teena.saxon@gdatechnologies.com', 982);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('354056013', 'Mena', 'Loeb', to_date('03-01-1997', 'dd-mm-yyyy'), '0472622927', 'mena.loeb@dynacqinternational.com', 30);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('605553184', 'Geraldine', 'Wiest', to_date('21-11-1987', 'dd-mm-yyyy'), '0869551949', 'geraldine.wiest@usainstruments.pt', 422);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('646469451', 'Treat', 'Berry', to_date('13-07-1992', 'dd-mm-yyyy'), '0389934072', 'treat.berry@saksinc.com', 573);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('042355655', 'Hal', 'Hawke', to_date('01-04-1987', 'dd-mm-yyyy'), '0399212199', 'hal@bioreliance.com', 706);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('308888572', 'Molly', 'Niven', to_date('09-03-1998', 'dd-mm-yyyy'), '0200683324', 'm.niven@axis.ca', 375);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('398389087', 'Brendan', 'Chinlund', to_date('11-01-1998', 'dd-mm-yyyy'), '0119683275', 'bchinlund@dearbornbancorp.com', 179);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('952053970', 'Breckin', 'Drive', to_date('29-10-1997', 'dd-mm-yyyy'), '0870284978', 'breckin.drive@jlphor.com', 653);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('744400388', 'Bret', 'Holliday', to_date('26-11-1992', 'dd-mm-yyyy'), '0090162446', 'breth@nlx.com', 819);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('150230428', 'Seth', 'McKean', to_date('02-02-1987', 'dd-mm-yyyy'), '0995900542', 'seth.mckean@gagwear.com', 357);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('287156862', 'Ethan', 'Chambers', to_date('06-11-2000', 'dd-mm-yyyy'), '0051594317', 'ethan.chambers@portageenvironmental', 623);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('538274247', 'Steve', 'Webb', to_date('25-09-1992', 'dd-mm-yyyy'), '0525407130', 'steve.webb@fmb.de', 481);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('559550314', 'Kyra', 'Romijn-Stamos', to_date('20-06-1989', 'dd-mm-yyyy'), '0742368754', 'kyrar@bat.fr', 823);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('228343553', 'Wayman', 'Collins', to_date('21-03-1999', 'dd-mm-yyyy'), '0154569216', 'wayman.collins@grt.com', 488);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('116838814', 'Karen', 'Chandler', to_date('23-04-2000', 'dd-mm-yyyy'), '0679104335', 'karen.chandler@kelmooreinvestment.c', 484);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('301398056', 'Chazz', 'Ojeda', to_date('02-01-1992', 'dd-mm-yyyy'), '0345081873', 'chazz.ojeda@consultants.fr', 435);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('870585639', 'Leelee', 'Cash', to_date('01-12-2000', 'dd-mm-yyyy'), '0074655866', 'leelee.cash@ungertechnologies.com', 434);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('184268549', 'Carole', 'Underwood', to_date('29-06-1998', 'dd-mm-yyyy'), '0313507039', 'carole@bayer.com', 135);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('502997791', 'Gailard', 'Blossoms', to_date('01-05-1995', 'dd-mm-yyyy'), '0719877648', 'gailard.blossoms@hcoa.com', 793);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('040885141', 'Jesse', 'Chambers', to_date('07-08-1995', 'dd-mm-yyyy'), '0092775884', 'jesse@shar.fr', 569);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('326886370', 'Stewart', 'Keitel', to_date('27-05-1998', 'dd-mm-yyyy'), '0650714249', 'stewart.k@gcd.nl', 341);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('749577354', 'Morris', 'Blanchett', to_date('13-10-1993', 'dd-mm-yyyy'), '0419454778', 'm.blanchett@jcpenney.com', 589);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('535451751', 'Rod', 'Green', to_date('19-03-1988', 'dd-mm-yyyy'), '0924301772', 'rod.green@scjohnson.com', 385);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('608404078', 'Joely', 'Simpson', to_date('15-09-2000', 'dd-mm-yyyy'), '0647471238', 'joely.simpson@sensortechnologies.uk', 45);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('491058748', 'Collin', 'Logue', to_date('11-08-1990', 'dd-mm-yyyy'), '0673232620', 'c.logue@bowman.com', 692);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('006693782', 'Val', 'Holeman', to_date('15-02-1991', 'dd-mm-yyyy'), '0818053594', 'val@dillards.uk', 330);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('069787488', 'Ethan', 'Assante', to_date('15-01-1995', 'dd-mm-yyyy'), '0017627119', 'ethan.assante@pinnaclestaffing.fi', 921);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('744338036', 'Miles', 'Heslov', to_date('20-02-1999', 'dd-mm-yyyy'), '0725503049', 'miles.heslov@benecongroup.com', 576);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('790369237', 'Holly', 'Merchant', to_date('12-06-2001', 'dd-mm-yyyy'), '0687430332', 'holly.merchant@mathis.pl', 191);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('975552389', 'Russell', 'Hanks', to_date('08-08-1988', 'dd-mm-yyyy'), '0932030024', 'russell.hanks@logisticare.com', 179);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('950803814', 'Milla', 'Gatlin', to_date('09-11-1995', 'dd-mm-yyyy'), '0552414483', 'millag@parksite.jp', 512);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('031397669', 'Loreena', 'Dorff', to_date('18-10-1989', 'dd-mm-yyyy'), '0526971434', 'loreena.dorff@irissoftware.za', 717);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('502583978', 'Suzi', 'Holm', to_date('21-08-1994', 'dd-mm-yyyy'), '0126832591', 'suzi.h@spectrum.au', 326);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('307217082', 'Jeffrey', 'Tah', to_date('29-06-1989', 'dd-mm-yyyy'), '0521274480', 'jeffrey.tah@creditorsinterchange.co', 771);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('528569441', 'Katrin', 'McGill', to_date('29-05-1988', 'dd-mm-yyyy'), '0716108144', 'katrin@nrae.com', 440);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('225702496', 'Denise', 'Trevino', to_date('02-01-1990', 'dd-mm-yyyy'), '0258850622', 'denise.t@johnkeeler.com', 621);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('871736529', 'Kelli', 'Van Helden', to_date('08-05-2001', 'dd-mm-yyyy'), '0759221971', 'kelli.vanhelden@idas.com', 781);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('063960310', 'Tony', 'Stanley', to_date('19-03-1988', 'dd-mm-yyyy'), '0065552353', 't.stanley@faef.de', 649);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('211147665', 'Rickie', 'Horizon', to_date('06-11-1996', 'dd-mm-yyyy'), '0553599279', 'rickie.horizon@studiobproductions.d', 653);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('039815841', 'Ann', 'Hyde', to_date('15-06-1988', 'dd-mm-yyyy'), '0283692637', 'ann.hyde@max.dk', 782);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('312814235', 'Lorraine', 'Pressly', to_date('22-09-1989', 'dd-mm-yyyy'), '0233981125', 'lorraine.pressly@career.com', 677);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('710338024', 'Jena', 'Carmen', to_date('29-01-1990', 'dd-mm-yyyy'), '0092437721', 'jena.carmen@drinkmorewater.com', 297);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('969340540', 'Scott', 'Barkin', to_date('28-05-1992', 'dd-mm-yyyy'), '0218208247', 'sbarkin@abs.com', 507);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('597804245', 'Geoff', 'Crimson', to_date('28-12-1993', 'dd-mm-yyyy'), '0402328716', 'g.crimson@authoria.it', 856);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('738676792', 'Dorry', 'Carrey', to_date('09-07-1996', 'dd-mm-yyyy'), '0520617946', 'dcarrey@ungertechnologies.ca', 505);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('506969048', 'Phoebe', 'Haynes', to_date('28-03-1995', 'dd-mm-yyyy'), '0618951057', 'phaynes@prometheuslaboratories.dk', 823);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('356673486', 'Taylor', 'Chaykin', to_date('16-11-1992', 'dd-mm-yyyy'), '0224749497', 'taylor.chaykin@keith.com', 172);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('153812810', 'Loreena', 'Kilmer', to_date('19-12-1987', 'dd-mm-yyyy'), '0747730380', 'loreena.kilmer@investmentscorecard.', 646);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('745164844', 'Liam', 'Merchant', to_date('14-11-1992', 'dd-mm-yyyy'), '0686782755', 'liam.merchant@inspirationsoftware.f', 887);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('384052743', 'Aidan', 'Hawthorne', to_date('25-05-2001', 'dd-mm-yyyy'), '0620668022', 'aidan.hawthorne@hardwoodwholesalers', 560);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('621113814', 'Mint', 'Kramer', to_date('19-12-1999', 'dd-mm-yyyy'), '0023996439', 'mint.kramer@fmi.se', 993);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('787508950', 'Alan', 'Cassel', to_date('21-07-2000', 'dd-mm-yyyy'), '0760929953', 'alan@gagwear.uk', 834);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('247271599', 'Hazel', 'Day-Lewis', to_date('03-08-1993', 'dd-mm-yyyy'), '0015190000', 'hazel.daylewis@hewlettpackard.com', 714);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('360504764', 'Olga', 'Spears', to_date('28-01-1987', 'dd-mm-yyyy'), '0585374328', 'o.spears@pragmatechsoftware.ch', 798);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('844673039', 'Kristin', 'Wariner', to_date('30-10-1999', 'dd-mm-yyyy'), '0394897793', 'kristin.wariner@ositissoftware.uk', 918);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('683929577', 'Parker', 'Alexander', to_date('19-02-1998', 'dd-mm-yyyy'), '0502676326', 'parker@pinnaclestaffing.de', 37);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('696669891', 'Earl', 'Short', to_date('04-04-1993', 'dd-mm-yyyy'), '0458753057', 'earl.s@clorox.jp', 143);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('626361980', 'Hazel', 'Warden', to_date('09-04-1987', 'dd-mm-yyyy'), '0254485971', 'hazel.warden@kingston.com', 31);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('045225914', 'Jann', 'Chandler', to_date('04-07-2000', 'dd-mm-yyyy'), '0301837931', 'jann.chandler@pinnaclestaffing.at', 668);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('073905523', 'Stellan', 'Francis', to_date('23-06-1997', 'dd-mm-yyyy'), '0831934647', 'sfrancis@sourcegear.com', 858);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('973222580', 'Bryan', 'Tarantino', to_date('19-05-2001', 'dd-mm-yyyy'), '0170199495', 'bryan.tarantino@simplycertificates.', 507);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('584256948', 'Owen', 'Francis', to_date('17-12-1989', 'dd-mm-yyyy'), '0480736799', 'owen.francis@seiaarons.com', 547);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('247309639', 'Roy', 'Elizabeth', to_date('08-12-1992', 'dd-mm-yyyy'), '0540582544', 'roy.e@creditorsinterchange.it', 282);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('417953620', 'Omar', 'DeVita', to_date('02-12-1999', 'dd-mm-yyyy'), '0062576222', 'omar.devita@vertexsolutions.il', 686);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('593306730', 'Cole', 'Holiday', to_date('14-04-1989', 'dd-mm-yyyy'), '0911242388', 'coleh@serentec.com', 973);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('862493074', 'Brent', 'Van Helden', to_date('10-08-1987', 'dd-mm-yyyy'), '0410010476', 'b.vanhelden@callhenry.com', 765);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('434530964', 'Breckin', 'Pitt', to_date('12-03-1994', 'dd-mm-yyyy'), '0471340135', 'breckin.p@base.uk', 115);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('335873962', 'Luis', 'Logue', to_date('24-07-1994', 'dd-mm-yyyy'), '0490914995', 'luis.logue@ubp.jp', 651);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('399332060', 'Night', 'Jackman', to_date('13-10-1991', 'dd-mm-yyyy'), '0336996193', 'night.jackman@aco.nl', 584);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('442303438', 'Lin', 'Deschanel', to_date('22-01-1997', 'dd-mm-yyyy'), '0602735917', 'l.deschanel@nlx.es', 591);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('142123746', 'Cevin', 'Elizondo', to_date('07-05-1991', 'dd-mm-yyyy'), '0515609798', 'cevin@ipsadvisory.com', 603);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('254078022', 'Joseph', 'Davison', to_date('13-12-1991', 'dd-mm-yyyy'), '0753015278', 'joseph.davison@interfacesoftware.es', 113);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('635257790', 'Paula', 'Madonna', to_date('29-05-1993', 'dd-mm-yyyy'), '0249354623', 'pmadonna@sps.uk', 200);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('745669668', 'Woody', 'Mahoney', to_date('12-10-1988', 'dd-mm-yyyy'), '0341582387', 'woody.mahoney@diageo.de', 943);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('371929077', 'Adina', 'Winslet', to_date('06-05-1997', 'dd-mm-yyyy'), '0456813278', 'adina.winslet@granitesystems.it', 770);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('447452331', 'Kim', 'Crowe', to_date('02-08-1994', 'dd-mm-yyyy'), '0874415883', 'kim@circuitcitystores.com', 141);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('725066790', 'Lizzy', 'Jolie', to_date('26-10-1989', 'dd-mm-yyyy'), '0890146073', 'lizzy@dps.com', 653);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('114676727', 'Kris', 'Elliott', to_date('12-10-1998', 'dd-mm-yyyy'), '0511829376', 'kris.e@valleyoaksystems.de', 627);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('340942789', 'Marley', 'Wahlberg', to_date('14-11-1989', 'dd-mm-yyyy'), '0174150341', 'marley@ahl.de', 647);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('698651065', 'Eddie', 'Thewlis', to_date('14-06-1997', 'dd-mm-yyyy'), '0202482942', 'eddiet@at.de', 237);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('721280923', 'Gary', 'Wopat', to_date('30-04-1990', 'dd-mm-yyyy'), '0115964855', 'gary.wopat@ghrsystems.uk', 488);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('683571677', 'Mena', 'Krumholtz', to_date('26-11-1995', 'dd-mm-yyyy'), '0340365491', 'm.krumholtz@prahs.ca', 227);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('961976664', 'Kurtwood', 'McClinton', to_date('14-11-1993', 'dd-mm-yyyy'), '0112724405', 'kurtwood@kimberlyclark.com', 239);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('548299749', 'Chalee', 'Firth', to_date('27-06-1989', 'dd-mm-yyyy'), '0719099021', 'c.firth@bowman.es', 373);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('140645704', 'Cary', 'Diffie', to_date('22-06-1991', 'dd-mm-yyyy'), '0457737331', 'cary@peerlessmanufacturing.uk', 917);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('862540003', 'Veruca', 'Branch', to_date('05-02-1999', 'dd-mm-yyyy'), '0366240694', 'veruca.branch@stonetechprofessional', 251);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('383765919', 'Nicole', 'Vaughn', to_date('01-08-1991', 'dd-mm-yyyy'), '0359011155', 'nicole.vaughn@caliber.es', 586);
commit;
prompt 400 records committed...
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('132161649', 'Irene', 'Blanchett', to_date('20-10-1998', 'dd-mm-yyyy'), '0766072872', 'irene.blanchett@pds.de', 615);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('841773511', 'Elias', 'Chestnut', to_date('11-08-1991', 'dd-mm-yyyy'), '0165336207', 'e.chestnut@flavorx.fr', 446);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('671206453', 'Sean', 'O''Sullivan', to_date('13-11-1990', 'dd-mm-yyyy'), '0899748132', 'sean.osullivan@mastercardinternatio', 252);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('588600203', 'Miko', 'McAnally', to_date('01-07-1995', 'dd-mm-yyyy'), '0273254376', 'miko.mcanally@gdatechnologies.es', 417);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('225404525', 'Bernard', 'Kapanka', to_date('22-11-1995', 'dd-mm-yyyy'), '0555694945', 'bernard.k@circuitcitystores.com', 98);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('865717044', 'Peabo', 'Van Damme', to_date('26-02-1988', 'dd-mm-yyyy'), '0856534949', 'peabo.vandamme@ibfh.jp', 649);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('126469700', 'Brian', 'Hauer', to_date('24-11-2001', 'dd-mm-yyyy'), '0879043552', 'brian.hauer@tilia.it', 102);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('152496327', 'Peabo', 'Nielsen', to_date('03-04-1987', 'dd-mm-yyyy'), '0508450935', 'peabo.n@tmt.il', 439);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('564031775', 'Barbara', 'Tucci', to_date('14-08-1990', 'dd-mm-yyyy'), '0093535064', 'b.tucci@owm.tw', 68);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('250435829', 'Robin', 'Torn', to_date('16-02-1988', 'dd-mm-yyyy'), '0229752740', 'r.torn@hfg.it', 149);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('895445973', 'Rickie', 'Lucas', to_date('08-11-1988', 'dd-mm-yyyy'), '0593645720', 'rickie@safeway.com', 122);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('651589499', 'Lea', 'Harrelson', to_date('10-07-1988', 'dd-mm-yyyy'), '0065212781', 'lea.harrelson@shot.com', 798);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('656862167', 'Kitty', 'Bassett', to_date('06-09-1997', 'dd-mm-yyyy'), '0938756259', 'k.bassett@ogi.si', 101);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('758727176', 'Mary Beth', 'Costa', to_date('06-05-1987', 'dd-mm-yyyy'), '0989965500', 'marybeth.costa@operationaltechnolog', 875);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('105837988', 'Albert', 'Avalon', to_date('20-12-1993', 'dd-mm-yyyy'), '0890089916', 'albert.avalon@harrison.ca', 843);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('928814598', 'Hope', 'Kline', to_date('22-09-1993', 'dd-mm-yyyy'), '0885339685', 'hopek@smi.com', 283);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('367749833', 'Loren', 'Dench', to_date('29-02-1992', 'dd-mm-yyyy'), '0033745990', 'loren.dench@gha.tr', 216);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('310255797', 'Elias', 'Oszajca', to_date('08-03-2000', 'dd-mm-yyyy'), '0082442082', 'elias.oszajca@inspirationsoftware.j', 1009);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('213893445', 'Neve', 'Rosas', to_date('09-07-1998', 'dd-mm-yyyy'), '0332779001', 'neve.rosas@kmart.au', 249);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('297570023', 'Yaphet', 'Sampson', to_date('22-10-1992', 'dd-mm-yyyy'), '0948797628', 'ysampson@bat.com', 870);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('546243023', 'Desmond', 'Armstrong', to_date('27-05-1996', 'dd-mm-yyyy'), '0801804761', 'desmond.armstrong@logisticare.com', 465);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('321729408', 'Hex', 'Dalton', to_date('28-10-1990', 'dd-mm-yyyy'), '0437782369', 'hdalton@emt.jp', 318);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('866839298', 'Laura', 'Bean', to_date('31-07-1994', 'dd-mm-yyyy'), '0457194483', 'laura.bean@gdi.com', 846);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('543915297', 'Hex', 'Kinski', to_date('09-05-1987', 'dd-mm-yyyy'), '0715972557', 'hkinski@nexxtworks.jp', 953);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('777896600', 'Wayman', 'Karyo', to_date('28-04-1994', 'dd-mm-yyyy'), '0260893272', 'wayman.karyo@ibm.com', 905);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('147507174', 'Roscoe', 'Valentin', to_date('04-05-1989', 'dd-mm-yyyy'), '0513385305', 'roscoe.v@ungertechnologies.fi', 435);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('365375377', 'Mitchell', 'Adams', to_date('18-06-1988', 'dd-mm-yyyy'), '0269941401', 'mitchell.adams@zaiqtechnologies.uk', 910);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('852150737', 'Neil', 'Idle', to_date('15-01-1997', 'dd-mm-yyyy'), '0260841498', 'neili@americanmegacom.com', 648);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('718251978', 'Caroline', 'Romijn-Stamos', to_date('19-01-1998', 'dd-mm-yyyy'), '0862439411', 'cromijnstamos@yashtechnologies.br', 912);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('981592628', 'Ronny', 'Evans', to_date('21-05-2000', 'dd-mm-yyyy'), '0637823906', 'ronnye@swi.com', 855);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('631121934', 'Julia', 'Robards', to_date('12-03-1991', 'dd-mm-yyyy'), '0051566887', 'julia.robards@dillards.com', 675);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('907684160', 'John', 'Skerritt', to_date('15-10-1997', 'dd-mm-yyyy'), '0451409625', 'jskerritt@totalentertainment.com', 713);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('295939647', 'Neve', 'Gore', to_date('25-07-1992', 'dd-mm-yyyy'), '0087294190', 'neve.gore@venoco.ch', 953);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('326919516', 'Ronny', 'Witherspoon', to_date('22-10-1993', 'dd-mm-yyyy'), '0475863519', 'ronnyw@dataprise.com', 946);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('027143835', 'Nick', 'Steenburgen', to_date('28-11-1991', 'dd-mm-yyyy'), '0159288288', 'nick@kimberlyclark.com', 492);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('969614464', 'Maury', 'Badalucco', to_date('09-10-1994', 'dd-mm-yyyy'), '0226651746', 'maury@nbs.de', 698);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('425902005', 'Donna', 'Kristofferson', to_date('10-11-1993', 'dd-mm-yyyy'), '0125325606', 'donna@toyotamotor.com', 673);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('281323926', 'Brittany', 'Osmond', to_date('21-11-1998', 'dd-mm-yyyy'), '0661949338', 'brittany.osmond@limitedbrands.ca', 142);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('333963799', 'Chubby', 'Avital', to_date('18-11-1988', 'dd-mm-yyyy'), '0357050851', 'chubby@seafoxboat.de', 378);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('339187073', 'Julio', 'Hatchet', to_date('25-10-1991', 'dd-mm-yyyy'), '0223517826', 'julio.hatchet@conquestsystems.com', 983);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('579738143', 'Maggie', 'Conway', to_date('23-08-1990', 'dd-mm-yyyy'), '0932553463', 'mconway@shirtfactory.com', 70);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('588756866', 'Sophie', 'Goldberg', to_date('27-05-1990', 'dd-mm-yyyy'), '0995980999', 'sophie.goldberg@insurmark.br', 235);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('645709945', 'Jimmy', 'Vassar', to_date('15-03-2001', 'dd-mm-yyyy'), '0320305616', 'jimmy.vassar@monarchcasino.com', 485);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('501327543', 'Red', 'Tah', to_date('03-07-1997', 'dd-mm-yyyy'), '0171802503', 'r.tah@integramedamerica.jp', 912);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('720209228', 'Isaac', 'Russo', to_date('03-02-1991', 'dd-mm-yyyy'), '0921385994', 'irusso@jcpenney.com', 265);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('230850741', 'Jarvis', 'Rowlands', to_date('05-05-1988', 'dd-mm-yyyy'), '0041858297', 'jarvis.r@ufs.com', 137);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('808406071', 'Samantha', 'Pantoliano', to_date('12-06-2000', 'dd-mm-yyyy'), '0098376087', 'samantha.pantoliano@curagroup.at', 479);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('638398901', 'Trey', 'De Niro', to_date('06-01-1996', 'dd-mm-yyyy'), '0425541446', 'treyd@cis.com', 467);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('375063029', 'Freddy', 'Pollak', to_date('29-06-1998', 'dd-mm-yyyy'), '0927029010', 'freddy.pollak@linacsystems.uk', 660);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('597758983', 'Alex', 'Shelton', to_date('30-09-2001', 'dd-mm-yyyy'), '0046008606', 'alex.shelton@unilever.de', 859);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('377352170', 'Joaquim', 'Horizon', to_date('09-11-1991', 'dd-mm-yyyy'), '0667668977', 'jhorizon@glmt.com', 795);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('699703532', 'Connie', 'Sewell', to_date('01-07-1999', 'dd-mm-yyyy'), '0213408014', 'connie.s@directdata.za', 1009);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('201919951', 'Taryn', 'Swank', to_date('13-04-1993', 'dd-mm-yyyy'), '0994999824', 'taryn.swank@scriptsave.com', 256);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('871481613', 'Nanci', 'Bean', to_date('08-07-1995', 'dd-mm-yyyy'), '0221023565', 'nanci.bean@aoltimewarner.com', 532);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('024625118', 'Greg', 'Rauhofer', to_date('28-03-2001', 'dd-mm-yyyy'), '0744428071', 'gregr@unicru.de', 752);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('590067207', 'Dan', 'Conley', to_date('24-12-1998', 'dd-mm-yyyy'), '0611135589', 'dan.conley@cocacola.es', 561);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('402459198', 'Busta', 'Costa', to_date('27-07-1990', 'dd-mm-yyyy'), '0798007075', 'busta@mindiq.com', 757);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('355430094', 'Todd', 'Hurt', to_date('05-04-1990', 'dd-mm-yyyy'), '0890245946', 'todd.hurt@networkdisplay.uk', 797);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('723875710', 'Gordie', 'Busey', to_date('27-03-1989', 'dd-mm-yyyy'), '0730193305', 'gordie.busey@meritagetechnologies.c', 114);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('446775277', 'Kelli', 'Willis', to_date('24-04-1989', 'dd-mm-yyyy'), '0948805472', 'kelliw@meritagetechnologies.ca', 113);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('293406403', 'Annie', 'Idol', to_date('24-01-1987', 'dd-mm-yyyy'), '0401196996', 'annie.idol@conquest.mo', 567);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('369626971', 'Raymond', 'Supernaw', to_date('21-07-1996', 'dd-mm-yyyy'), '0900025777', 'raymond.supernaw@ositissoftware.ch', 525);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('803409847', 'Elizabeth', 'Durning', to_date('15-12-1993', 'dd-mm-yyyy'), '0330304556', 'elizabethd@morganresearch.au', 187);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('337898494', 'Suzanne', 'Holland', to_date('27-07-1988', 'dd-mm-yyyy'), '0288502805', 'suzanne@gentrasystems.com', 557);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('130693139', 'Natalie', 'Starr', to_date('16-12-1988', 'dd-mm-yyyy'), '0442461486', 'natalie@venoco.com', 665);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('882265199', 'Tal', 'Affleck', to_date('17-10-1988', 'dd-mm-yyyy'), '0754448796', 'taffleck@americanmegacom.com', 546);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('550860622', 'Armand', 'Hopkins', to_date('14-06-1991', 'dd-mm-yyyy'), '0114682470', 'armand@navigatorsystems.de', 724);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('889098342', 'Rachael', 'Detmer', to_date('01-11-1995', 'dd-mm-yyyy'), '0743540299', 'rachael.detmer@ecopy.in', 327);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('327978571', 'Saul', 'Chestnut', to_date('15-07-1989', 'dd-mm-yyyy'), '0563402433', 'saul.chestnut@mindworks.uk', 57);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('497464838', 'Talvin', 'Alda', to_date('06-07-1994', 'dd-mm-yyyy'), '0173070479', 'talvin@hfg.uk', 909);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('219044533', 'Derek', 'Lachey', to_date('28-06-1987', 'dd-mm-yyyy'), '0364335231', 'derekl@yumbrands.com', 924);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('764003897', 'Ty', 'Birch', to_date('04-07-1991', 'dd-mm-yyyy'), '0400034025', 't.birch@astafunding.com', 625);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('324372729', 'Jeffery', 'Rapaport', to_date('30-06-1995', 'dd-mm-yyyy'), '0519539273', 'jeffery.r@otbd.ca', 263);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('383813154', 'Mac', 'Meyer', to_date('06-12-2001', 'dd-mm-yyyy'), '0518838726', 'mac.m@waltdisney.de', 572);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('435351451', 'Karon', 'Myers', to_date('16-06-1998', 'dd-mm-yyyy'), '0806088252', 'karon.myers@novartis.com', 947);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('644023627', 'Pablo', 'Nicks', to_date('16-01-1994', 'dd-mm-yyyy'), '0803548990', 'pablo.nicks@nhr.de', 257);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('573661345', 'Miko', 'Worrell', to_date('18-05-1990', 'dd-mm-yyyy'), '0877460911', 'miko.worrell@innovativelighting.de', 287);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('725092846', 'Patty', 'McDonald', to_date('15-07-1992', 'dd-mm-yyyy'), '0642010540', 'patty.mcdonald@kramontrealty.com', 729);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('493823471', 'Thelma', 'Blanchett', to_date('13-09-1992', 'dd-mm-yyyy'), '0058718249', 'thelmab@netnumina.jp', 719);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('815695186', 'Harriet', 'Franks', to_date('24-07-1992', 'dd-mm-yyyy'), '0928667933', 'hfranks@ams.il', 7);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('250478302', 'Molly', 'Moreno', to_date('05-06-1991', 'dd-mm-yyyy'), '0184504555', 'molly.m@dearbornbancorp.hk', 794);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('720562049', 'Mitchell', 'Johnson', to_date('31-08-1998', 'dd-mm-yyyy'), '0004458880', 'mitchell.johnson@sandyspringbancorp', 319);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('285984423', 'Giancarlo', 'Tucci', to_date('27-03-1989', 'dd-mm-yyyy'), '0430515365', 'giancarlo.tucci@dsp.com', 352);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('936052547', 'Mandy', 'Armstrong', to_date('09-10-1998', 'dd-mm-yyyy'), '0025678497', 'marmstrong@spas.com', 479);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('612709460', 'Peter', 'Blanchett', to_date('05-02-1991', 'dd-mm-yyyy'), '0210363881', 'peter.blanchett@unica.de', 899);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('112828200', 'Rick', 'Bell', to_date('15-09-1996', 'dd-mm-yyyy'), '0171220573', 'rbell@chipssolutions.uk', 339);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('243805667', 'Geoff', 'Goodman', to_date('21-03-1990', 'dd-mm-yyyy'), '0243486832', 'geoffg@tilsonlandscape.com', 300);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('489662104', 'Kasey', 'Shocked', to_date('28-11-1991', 'dd-mm-yyyy'), '0850871697', 'kshocked@morganresearch.za', 42);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('442557888', 'Julianna', 'Gold', to_date('05-02-1987', 'dd-mm-yyyy'), '0121869096', 'julianna.gold@clorox.com', 297);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('251428315', 'Steven', 'Emmett', to_date('22-08-1989', 'dd-mm-yyyy'), '0849950185', 'stevene@ois.uk', 68);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('346547423', 'Ahmad', 'Nicks', to_date('02-03-1998', 'dd-mm-yyyy'), '0462757157', 'ahmad.nicks@accucode.br', 112);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('645799561', 'Pam', 'Morton', to_date('16-02-1997', 'dd-mm-yyyy'), '0549341986', 'pam@fmi.com', 949);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('760537710', 'Hikaru', 'Richards', to_date('25-12-1995', 'dd-mm-yyyy'), '0107386461', 'h.richards@floorgraphics.com', 977);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('715006691', 'Trey', 'Rain', to_date('09-05-1996', 'dd-mm-yyyy'), '0156516483', 'trey.rain@smi.com', 556);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('268945379', 'Geena', 'Kinney', to_date('01-08-2000', 'dd-mm-yyyy'), '0049014620', 'geena.k@mls.com', 634);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('935502278', 'Mena', 'El-Saher', to_date('25-10-1994', 'dd-mm-yyyy'), '0676273989', 'mena.elsaher@prosperitybancshares.n', 188);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('535848785', 'Jill', 'Gracie', to_date('25-02-1998', 'dd-mm-yyyy'), '0177345914', 'jill.gracie@saralee.com', 554);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('550609298', 'Lisa', 'Kahn', to_date('03-09-1991', 'dd-mm-yyyy'), '0268497473', 'lisa.kahn@ceom.com', 1004);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('223016999', 'Lily', 'Burmester', to_date('24-09-1999', 'dd-mm-yyyy'), '0279536881', 'lburmester@trc.ch', 627);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('022645109', 'Alan', 'Beals', to_date('26-08-2000', 'dd-mm-yyyy'), '0512690231', 'alan.beals@pepsico.si', 615);
commit;
prompt 500 records committed...
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('873702346', 'Christopher', 'McDowall', to_date('19-06-1996', 'dd-mm-yyyy'), '0278506150', 'christopherm@officedepot.com', 846);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('618010526', 'Jose', 'Hauer', to_date('15-07-1999', 'dd-mm-yyyy'), '0731811018', 'jhauer@democracydata.de', 926);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('478422514', 'Lari', 'Weiland', to_date('09-09-1989', 'dd-mm-yyyy'), '0756168983', 'lari.weiland@ultimus.com', 853);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('168874666', 'Frank', 'Reeves', to_date('08-07-1997', 'dd-mm-yyyy'), '0544444516', 'frank.reeves@gsat.jp', 668);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('968709602', 'Richie', 'Spader', to_date('18-08-1988', 'dd-mm-yyyy'), '0541746966', 'richie.s@comnetinternational.dk', 1004);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('592142766', 'Cloris', 'Sarsgaard', to_date('26-08-1988', 'dd-mm-yyyy'), '0894909761', 'cloris.sarsgaard@ois.pl', 991);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('641809487', 'Charlie', 'Bogguss', to_date('12-11-1998', 'dd-mm-yyyy'), '0514136342', 'charlie@nhhc.ch', 479);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('023086883', 'Teena', 'Zahn', to_date('16-04-1998', 'dd-mm-yyyy'), '0294083462', 'teena@ghrsystems.at', 295);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('933776347', 'Nile', 'Sherman', to_date('09-11-2001', 'dd-mm-yyyy'), '0477934956', 'n.sherman@capitalautomotive.id', 825);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('714922037', 'Jeff', 'Newman', to_date('11-03-1988', 'dd-mm-yyyy'), '0275879280', 'jeff.newman@woronocobancorp.jp', 609);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('517489912', 'Tim', 'Ward', to_date('30-03-1992', 'dd-mm-yyyy'), '0587126524', 'tim.ward@seiaarons.com', 146);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('587280564', 'Ted', 'Yorn', to_date('24-02-1990', 'dd-mm-yyyy'), '0377316733', 'ted.yorn@larkinenterprises.au', 754);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('519894730', 'Demi', 'Mahoney', to_date('07-10-1996', 'dd-mm-yyyy'), '0875991311', 'demi@computersource.de', 917);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('080919502', 'Taylor', 'Snow', to_date('07-01-1990', 'dd-mm-yyyy'), '0066130445', 'taylor.snow@nha.br', 922);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('379440420', 'Lari', 'Bailey', to_date('30-07-1987', 'dd-mm-yyyy'), '0960401864', 'lari.bailey@gulfmarkoffshore.ch', 769);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('117037843', 'Giancarlo', 'Allan', to_date('20-07-1987', 'dd-mm-yyyy'), '0075018195', 'giancarlo.allan@mag.com', 903);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('661465823', 'Meg', 'Keith', to_date('12-05-1990', 'dd-mm-yyyy'), '0170521493', 'meg.keith@officedepot.br', 229);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('070539559', 'Joan', 'Ranger', to_date('06-08-1998', 'dd-mm-yyyy'), '0436024291', 'joan@capellaeducation.it', 842);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('696974778', 'Latin', 'Wheel', to_date('19-08-1997', 'dd-mm-yyyy'), '0204085470', 'latin.wheel@mitsubishimotors.com', 913);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('959292420', 'Rutger', 'McCann', to_date('24-08-2001', 'dd-mm-yyyy'), '0060347203', 'rutger@directdata.com', 165);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('543374736', 'Davis', 'Blackmore', to_date('28-12-1987', 'dd-mm-yyyy'), '0755241734', 'davis.blackmore@stonebrewing.au', 824);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('284203983', 'Miko', 'Davis', to_date('21-05-1999', 'dd-mm-yyyy'), '0666113469', 'miko.davis@sourcegear.com', 661);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('048832448', 'Maureen', 'Stevenson', to_date('28-02-1989', 'dd-mm-yyyy'), '0578812121', 'maureen.s@scjohnson.de', 362);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('179563751', 'Collective', 'Wilder', to_date('10-02-1995', 'dd-mm-yyyy'), '0229946134', 'collective.wilder@sms.com', 433);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('582548571', 'Gordon', 'Callow', to_date('15-08-1991', 'dd-mm-yyyy'), '0584121752', 'gordon.callow@pharmafab.com', 698);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('024579902', 'Todd', 'Barrymore', to_date('17-10-1990', 'dd-mm-yyyy'), '0839497660', 'todd.b@shufflemaster.lt', 319);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('086023700', 'Solomon', 'Aiken', to_date('02-09-2001', 'dd-mm-yyyy'), '0048982982', 'solomon.aiken@gcd.com', 192);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('048140794', 'Kasey', 'Chaplin', to_date('14-12-2001', 'dd-mm-yyyy'), '0218850482', 'kasey.chaplin@smartdrawcom.com', 934);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('240279538', 'Eliza', 'Lowe', to_date('19-06-1993', 'dd-mm-yyyy'), '0009136258', 'elowe@elitemedical.cy', 983);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('670168461', 'Ahmad', 'Botti', to_date('27-05-1995', 'dd-mm-yyyy'), '0690049768', 'ahmad.botti@unit.de', 614);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('358451197', 'France', 'Withers', to_date('13-11-1995', 'dd-mm-yyyy'), '0745420699', 'france@sfb.com', 265);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('735305467', 'Lindsey', 'Sisto', to_date('14-08-1993', 'dd-mm-yyyy'), '0697776227', 'lindsey.sisto@dps.uk', 378);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('481753265', 'Trey', 'Judd', to_date('04-12-1993', 'dd-mm-yyyy'), '0551599118', 'trey.judd@shar.jp', 367);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('526677103', 'Ozzy', 'Merchant', to_date('20-07-1994', 'dd-mm-yyyy'), '0730287744', 'ozzy.merchant@gulfmarkoffshore.fi', 175);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('980950912', 'Allan', 'Breslin', to_date('29-03-1993', 'dd-mm-yyyy'), '0484629997', 'allan@acsis.au', 543);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('621488868', 'Ned', 'Heslov', to_date('25-03-1988', 'dd-mm-yyyy'), '0174101570', 'ned.heslov@efcbancorp.com', 859);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('641102038', 'Vienna', 'Cruz', to_date('22-04-2000', 'dd-mm-yyyy'), '0129232318', 'vienna.cruz@portageenvironmental.au', 890);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('141450306', 'Diane', 'Rodgers', to_date('24-03-1992', 'dd-mm-yyyy'), '0599573146', 'diane.rodgers@uem.com', 45);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('263668514', 'Alex', 'Sandler', to_date('23-01-1991', 'dd-mm-yyyy'), '0099931415', 'alex.sandler@otbd.com', 602);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('928554711', 'Meryl', 'Rankin', to_date('29-04-1994', 'dd-mm-yyyy'), '0897134795', 'meryl@daimlerchrysler.com', 563);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('255916483', 'Sydney', 'Carnes', to_date('15-04-1999', 'dd-mm-yyyy'), '0456404727', 'sydney.carnes@spotfireholdings.dk', 802);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('483153155', 'Bette', 'Brandt', to_date('23-06-1999', 'dd-mm-yyyy'), '0562255333', 'bette.brandt@kellogg.it', 936);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('952507188', 'Murray', 'Orlando', to_date('23-10-1999', 'dd-mm-yyyy'), '0416617795', 'murray@mag.ch', 428);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('106275449', 'Walter', 'Payne', to_date('27-01-1992', 'dd-mm-yyyy'), '0793503201', 'w.payne@trc.ca', 719);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('014731722', 'Laurence', 'Lizzy', to_date('09-11-1998', 'dd-mm-yyyy'), '0503717556', 'l.lizzy@ssi.com', 724);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('512510592', 'Collective', 'McGinley', to_date('11-09-2000', 'dd-mm-yyyy'), '0427523711', 'collective.m@spotfireholdings.com', 779);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('504247184', 'Rose', 'Allan', to_date('09-02-1998', 'dd-mm-yyyy'), '0617286392', 'rose.allan@sfgo.com', 126);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('743194148', 'Bebe', 'Loggins', to_date('24-10-1992', 'dd-mm-yyyy'), '0737796070', 'bebe.l@baesch.com', 482);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('558736817', 'Neil', 'Bergen', to_date('28-12-1990', 'dd-mm-yyyy'), '0399705181', 'neilb@aquickdelivery.uk', 42);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('056435471', 'Alec', 'Kimball', to_date('14-03-2000', 'dd-mm-yyyy'), '0300021634', 'alec.kimball@unit.com', 75);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('136598863', 'Lari', 'Dawson', to_date('25-02-1996', 'dd-mm-yyyy'), '0183263598', 'lari.dawson@ogiointernational.com', 410);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('857622098', 'Howie', 'Davidson', to_date('17-10-1996', 'dd-mm-yyyy'), '0296791194', 'howied@horizonorganic.com', 626);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('978413263', 'Andy', 'Farrell', to_date('24-06-2000', 'dd-mm-yyyy'), '0568249949', 'andy.farrell@allstar.uk', 711);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('521767158', 'Stephen', 'Alda', to_date('15-06-2000', 'dd-mm-yyyy'), '0830795227', 'stephena@diamondtechnologies.jp', 24);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('398538802', 'Bridgette', 'Hudson', to_date('18-04-1997', 'dd-mm-yyyy'), '0296442634', 'bridgette.hudson@ksj.com', 381);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('904527504', 'Stewart', 'Bracco', to_date('03-03-1988', 'dd-mm-yyyy'), '0598570907', 'stewart.bracco@codykramerimports.co', 863);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('075822022', 'Frederic', 'Mortensen', to_date('02-07-1993', 'dd-mm-yyyy'), '0760076935', 'fredericm@chipssolutions.com', 277);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('213894686', 'Clint', 'Ranger', to_date('20-05-2001', 'dd-mm-yyyy'), '0350459377', 'clint.ranger@campbellsoup.br', 112);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('498758946', 'Beverley', 'Buckingham', to_date('17-09-1993', 'dd-mm-yyyy'), '0035379536', 'beverley.buckingham@axis.com', 49);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('969438125', 'Rachid', 'McGoohan', to_date('02-05-1999', 'dd-mm-yyyy'), '0724710887', 'rachid.mcgoohan@kis.com', 919);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('463467765', 'Miki', 'Costa', to_date('07-03-1993', 'dd-mm-yyyy'), '0525202003', 'miki.costa@apexsystems.ca', 957);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('239507368', 'Tilda', 'Diffie', to_date('11-01-1990', 'dd-mm-yyyy'), '0757904273', 'tilda.diffie@lloydgroup.uk', 948);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('177869151', 'Tony', 'Preston', to_date('13-01-1998', 'dd-mm-yyyy'), '0563900792', 'tony@vitacostcom.ca', 944);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('279497005', 'Nastassja', 'Weiss', to_date('12-06-1999', 'dd-mm-yyyy'), '0111955249', 'nastassja.weiss@north.in', 108);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('283795738', 'Liquid', 'Shandling', to_date('30-12-1999', 'dd-mm-yyyy'), '0246235960', 'l.shandling@datawarehouse.ca', 994);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('186405883', 'Gary', 'Gilliam', to_date('12-08-1990', 'dd-mm-yyyy'), '0348286489', 'garyg@mls.ch', 546);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('391227654', 'Stewart', 'Martin', to_date('15-02-1992', 'dd-mm-yyyy'), '0799332130', 'stewart.martin@infovision.it', 68);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('868402996', 'Drew', 'Costello', to_date('13-11-1990', 'dd-mm-yyyy'), '0527877789', 'drew.costello@hencie.il', 593);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('382016998', 'Larenz', 'Ricci', to_date('30-10-1991', 'dd-mm-yyyy'), '0314905411', 'larenz.ricci@ksj.ge', 256);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('766935118', 'Rich', 'Moss', to_date('11-11-2001', 'dd-mm-yyyy'), '0836762177', 'rich.moss@fetchlogistics.hk', 889);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('298902634', 'Thomas', 'Benoit', to_date('19-09-1990', 'dd-mm-yyyy'), '0051668084', 'thomas.benoit@ezecastlesoftware.fr', 216);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('655364444', 'Kirk', 'Joli', to_date('08-07-1993', 'dd-mm-yyyy'), '0978096642', 'kirk.joli@diversitech.com', 515);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('171356889', 'Mary Beth', 'Torres', to_date('03-09-1990', 'dd-mm-yyyy'), '0541827894', 'marybeth.torres@conquest.uk', 83);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('174744730', 'Rosie', 'Reeves', to_date('28-02-1998', 'dd-mm-yyyy'), '0139974486', 'rosier@knightsbridge.com', 61);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('670301840', 'Nicole', 'Downey', to_date('20-08-2000', 'dd-mm-yyyy'), '0750860068', 'nicole.d@nbs.com', 245);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('473969383', 'Nikki', 'Dale', to_date('20-07-1991', 'dd-mm-yyyy'), '0700651205', 'nikki.dale@smi.de', 240);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('940738490', 'Buddy', 'Brown', to_date('19-04-1999', 'dd-mm-yyyy'), '0809585588', 'buddy.brown@serentec.com', 946);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('346776193', 'Arnold', 'Jeter', to_date('06-02-1999', 'dd-mm-yyyy'), '0805004437', 'arnold.jeter@fmb.de', 167);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('482917837', 'Nikki', 'Utada', to_date('28-06-1994', 'dd-mm-yyyy'), '0715257511', 'nikki.utada@infovision.pl', 1007);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('934529741', 'Phoebe', 'Burns', to_date('22-02-1996', 'dd-mm-yyyy'), '0197441634', 'phoebe.burns@venoco.jp', 124);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('382827869', 'Jet', 'Willard', to_date('03-09-1995', 'dd-mm-yyyy'), '0139483390', 'jwillard@glaxosmithkline.pl', 960);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('958421089', 'Linda', 'Douglas', to_date('21-12-1999', 'dd-mm-yyyy'), '0036520725', 'linda.douglas@insurmark.de', 795);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('724349050', 'Wallace', 'Platt', to_date('12-07-1992', 'dd-mm-yyyy'), '0777515918', 'wallace.platt@air.com', 219);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('006737707', 'Rick', 'Galecki', to_date('29-09-2000', 'dd-mm-yyyy'), '0332381051', 'rick.galecki@signalperfection.de', 633);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('532337622', 'Denis', 'Crosby', to_date('17-11-1999', 'dd-mm-yyyy'), '0479769193', 'denis.crosby@valleyoaksystems.nl', 441);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('857695845', 'Breckin', 'Mulroney', to_date('08-01-1990', 'dd-mm-yyyy'), '0676733094', 'breckin@grt.com', 847);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('191066947', 'Joaquim', 'Boothe', to_date('08-11-1999', 'dd-mm-yyyy'), '0800476912', 'jboothe@generalmotors.hu', 145);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('408888854', 'Toshiro', 'Flack', to_date('02-05-1993', 'dd-mm-yyyy'), '0974600681', 'toshirof@unilever.com', 522);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('878238610', 'Sander', 'Easton', to_date('24-03-1990', 'dd-mm-yyyy'), '0144049634', 'sander.easton@capellaeducation.dk', 714);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('327636786', 'Nancy', 'Crudup', to_date('28-10-1988', 'dd-mm-yyyy'), '0479234393', 'nancy.crudup@conagra.ch', 836);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('012522084', 'Aidan', 'Yulin', to_date('15-05-2001', 'dd-mm-yyyy'), '0208590442', 'aidan.yulin@allegiantbancorp.pl', 622);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('863786113', 'Lucy', 'Van Helden', to_date('19-08-1990', 'dd-mm-yyyy'), '0172223162', 'lucy.v@genextechnologies.com', 378);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('452442345', 'Desmond', 'Pfeiffer', to_date('19-08-1990', 'dd-mm-yyyy'), '0561132270', 'desmondp@privatebancorp.de', 284);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('449421274', 'Kim', 'Bloch', to_date('05-10-1996', 'dd-mm-yyyy'), '0262597874', 'kim.bloch@nexxtworks.com', 11);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('061159466', 'Naomi', 'Benson', to_date('10-09-1997', 'dd-mm-yyyy'), '0150703434', 'naomi.benson@americanpan.de', 734);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('613671695', 'Rhett', 'Davison', to_date('26-09-1987', 'dd-mm-yyyy'), '0954540979', 'rhett.davison@sensortechnologies.co', 464);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('534721757', 'Fred', 'Cotton', to_date('26-04-1998', 'dd-mm-yyyy'), '0391338336', 'fred.cotton@kwraf.br', 704);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('777459507', 'Denny', 'de Lancie', to_date('28-08-1992', 'dd-mm-yyyy'), '0320870582', 'denny@capitalautomotive.it', 725);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('329133780', 'Rickie', 'Holiday', to_date('13-07-1998', 'dd-mm-yyyy'), '0013931625', 'r.holiday@ipsadvisory.com', 975);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('317747981', 'Mary', 'Bosco', to_date('10-01-1997', 'dd-mm-yyyy'), '0048718143', 'mary@its.uk', 197);
commit;
prompt 600 records committed...
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('936645107', 'Earl', 'Fox', to_date('12-04-1997', 'dd-mm-yyyy'), '0123182438', 'earl.fox@trusecure.com', 871);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('440844331', 'Embeth', 'Dorn', to_date('05-05-1997', 'dd-mm-yyyy'), '0459662458', 'embeth.dorn@cis.au', 553);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('153084951', 'Davy', 'Rain', to_date('12-02-1987', 'dd-mm-yyyy'), '0098964556', 'davy.rain@jlphor.uk', 650);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('879371457', 'Garry', 'Cale', to_date('02-08-1997', 'dd-mm-yyyy'), '0596189807', 'garry.cale@berkshirehathaway.de', 732);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('648819071', 'Katie', 'Briscoe', to_date('18-05-2001', 'dd-mm-yyyy'), '0442141577', 'katie.briscoe@epamsystems.pl', 880);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('244133162', 'Christmas', 'Waite', to_date('27-08-1996', 'dd-mm-yyyy'), '0126197968', 'c.waite@randomwalk.jp', 521);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('548099649', 'Scott', 'Holland', to_date('03-11-1989', 'dd-mm-yyyy'), '0049624285', 'scott.holland@trm.com', 586);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('402251764', 'Ellen', 'Costello', to_date('18-12-1993', 'dd-mm-yyyy'), '0396977303', 'ellenc@ibm.com', 936);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('665873922', 'Stanley', 'Sheen', to_date('18-10-1993', 'dd-mm-yyyy'), '0669064247', 'stanley.sheen@mds.uk', 311);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('916561673', 'Aimee', 'Bush', to_date('26-06-1988', 'dd-mm-yyyy'), '0328143308', 'aimee.bush@procurementcentre.com', 621);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('361356344', 'Olympia', 'Holiday', to_date('11-12-1988', 'dd-mm-yyyy'), '0941166046', 'olympia.h@ecopy.com', 885);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('046662368', 'Nick', 'Estevez', to_date('19-09-1987', 'dd-mm-yyyy'), '0783945258', 'nestevez@shar.com', 606);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('453426639', 'Sharon', 'Tah', to_date('06-10-1994', 'dd-mm-yyyy'), '0824314022', 'sharon.t@bioanalytical.at', 239);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('620604622', 'George', 'Blanchett', to_date('28-12-1994', 'dd-mm-yyyy'), '0445758827', 'george.blanchett@shufflemaster.com', 18);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('926840103', 'Dar', 'Cassidy', to_date('26-12-2000', 'dd-mm-yyyy'), '0903056792', 'dar.cassidy@axis.com', 731);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('037411330', 'Rosie', 'Nightingale', to_date('25-06-1999', 'dd-mm-yyyy'), '0928784380', 'rosie.n@max.yu', 852);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('827899701', 'Kyra', 'Orton', to_date('25-02-1993', 'dd-mm-yyyy'), '0897725950', 'korton@dcgroup.ca', 738);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('610482447', 'Clive', 'O''Hara', to_date('04-02-2001', 'dd-mm-yyyy'), '0389141164', 'clive.ohara@ctg.au', 59);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('124283722', 'Eliza', 'Spears', to_date('20-07-1991', 'dd-mm-yyyy'), '0240114982', 'e.spears@spotfireholdings.com', 541);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('983855120', 'Saul', 'Nash', to_date('24-01-2001', 'dd-mm-yyyy'), '0543817267', 'saul.n@saksinc.com', 5);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('099723488', 'Holly', 'McGriff', to_date('27-08-1989', 'dd-mm-yyyy'), '0570142665', 'hollym@banfeproducts.it', 349);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('574906002', 'Sinead', 'Henstridge', to_date('06-04-2000', 'dd-mm-yyyy'), '0009214742', 'sinead.h@navigatorsystems.com', 816);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('722156301', 'Sara', 'Imbruglia', to_date('13-06-2001', 'dd-mm-yyyy'), '0735735716', 'sara@gsat.au', 960);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('108498144', 'Laura', 'Springfield', to_date('07-06-1989', 'dd-mm-yyyy'), '0414747817', 'laura.springfield@pharmafab.com', 915);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('675491874', 'Dan', 'Remar', to_date('13-09-2000', 'dd-mm-yyyy'), '0059520091', 'dremar@bigdoughcom.com', 252);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('099250802', 'Chad', 'Dzundza', to_date('15-01-1993', 'dd-mm-yyyy'), '0391496041', 'chad.d@morganresearch.com', 807);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('582031786', 'Candice', 'Waite', to_date('26-12-1995', 'dd-mm-yyyy'), '0995592137', 'candice@pragmatechsoftware.br', 912);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('991199704', 'Glenn', 'Weber', to_date('09-03-1991', 'dd-mm-yyyy'), '0853598632', 'glenn.w@jollyenterprises.pl', 844);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('508469586', 'Norm', 'Dukakis', to_date('14-07-1990', 'dd-mm-yyyy'), '0373665194', 'norm.dukakis@qssgroup.ca', 991);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('352211303', 'Glen', 'Depp', to_date('27-01-1997', 'dd-mm-yyyy'), '0079717007', 'glen.d@smi.ca', 554);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('166584871', 'Lizzy', 'Creek', to_date('23-02-2000', 'dd-mm-yyyy'), '0195160481', 'lizzy@safehomesecurity.uk', 334);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('553146719', 'Warren', 'Walker', to_date('24-05-1997', 'dd-mm-yyyy'), '0175642305', 'wwalker@marketbased.ar', 962);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('444170362', 'Tom', 'Armatrading', to_date('05-11-1995', 'dd-mm-yyyy'), '0399805485', 't.armatrading@meridiangold.com', 825);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('046127582', 'Chet', 'Khan', to_date('04-03-1992', 'dd-mm-yyyy'), '0903341503', 'ckhan@toyotamotor.com', 319);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('930454098', 'Lin', 'Rhodes', to_date('14-12-1996', 'dd-mm-yyyy'), '0241679565', 'lin.rhodes@ultimus.com', 248);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('667771144', 'Anne', 'Elizabeth', to_date('14-01-2001', 'dd-mm-yyyy'), '0383138378', 'annee@worldcom.jp', 328);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('738360690', 'Aida', 'Yorn', to_date('25-09-1998', 'dd-mm-yyyy'), '0118542082', 'aida@unilever.com', 205);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('961930704', 'Vivica', 'Bonham', to_date('15-06-1997', 'dd-mm-yyyy'), '0783362086', 'vivica@doctorsassociates.com', 59);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('005745143', 'Taye', 'Ratzenberger', to_date('19-02-1992', 'dd-mm-yyyy'), '0215498145', 'taye.r@asapstaffing.fi', 46);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('687836238', 'Delbert', 'Benson', to_date('01-07-2000', 'dd-mm-yyyy'), '0170908132', 'delbert.benson@unicru.at', 559);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('533589830', 'Devon', 'Dempsey', to_date('21-04-1999', 'dd-mm-yyyy'), '0540303605', 'devon.dempsey@ogi.com', 203);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('206395580', 'Julia', 'Masur', to_date('28-12-1987', 'dd-mm-yyyy'), '0348426525', 'julia.masur@generalelectric.uk', 748);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('615893503', 'Colm', 'Blades', to_date('16-03-1987', 'dd-mm-yyyy'), '0478852950', 'colm.blades@mse.uk', 200);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('467508572', 'Rosario', 'Walsh', to_date('08-07-1992', 'dd-mm-yyyy'), '0079054150', 'rosariow@computersource.fr', 497);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('747190598', 'Mac', 'Dzundza', to_date('07-04-1999', 'dd-mm-yyyy'), '0797046266', 'mac@pfizer.com', 346);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('269434965', 'Clive', 'Sarsgaard', to_date('12-12-1993', 'dd-mm-yyyy'), '0749037283', 'c.sarsgaard@circuitcitystores.com', 872);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('907606113', 'Natascha', 'Eckhart', to_date('04-06-1999', 'dd-mm-yyyy'), '0891592097', 'natascha@myricom.ca', 398);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('061574796', 'Vertical', 'Horizon', to_date('29-03-1993', 'dd-mm-yyyy'), '0539217814', 'vertical@powerlight.ca', 293);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('832145218', 'Collective', 'Postlethwaite', to_date('29-01-1992', 'dd-mm-yyyy'), '0447751777', 'collectivep@astute.com', 79);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('327410662', 'Randall', 'Cummings', to_date('13-09-1998', 'dd-mm-yyyy'), '0330595017', 'randall.cummings@investorstitle.ch', 770);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('627506555', 'Tori', 'Henriksen', to_date('23-09-1987', 'dd-mm-yyyy'), '0007653209', 't.henriksen@labradanutrition.pl', 620);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('663990879', 'Patti', 'Dafoe', to_date('17-12-1996', 'dd-mm-yyyy'), '0930594501', 'patti.dafoe@marathonheater.com', 678);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('968941795', 'Desmond', 'Mann', to_date('07-12-1987', 'dd-mm-yyyy'), '0715497095', 'dmann@componentgraphics.com', 780);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('989584881', 'Joanna', 'Short', to_date('27-06-2001', 'dd-mm-yyyy'), '0188001737', 'joanna@ads.com', 744);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('827886021', 'Anna', 'Conlee', to_date('22-02-1992', 'dd-mm-yyyy'), '0166148598', 'a.conlee@afs.com', 204);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('789225972', 'Bo', 'Byrne', to_date('16-08-2001', 'dd-mm-yyyy'), '0465830818', 'b.byrne@daimlerchrysler.com', 1010);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('907620344', 'Jeffrey', 'McLean', to_date('04-07-2000', 'dd-mm-yyyy'), '0390419405', 'jeffrey@learningvoyage.ch', 450);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('026207879', 'Charlton', 'Vannelli', to_date('15-09-1998', 'dd-mm-yyyy'), '0151995392', 'charlton.vannelli@fab.com', 935);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('194428041', 'Benjamin', 'Singletary', to_date('25-11-1997', 'dd-mm-yyyy'), '0250955635', 'benjamin.s@wlt.cz', 707);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('851500278', 'Sinead', 'Kirshner', to_date('08-08-1989', 'dd-mm-yyyy'), '0089093067', 'sinead.kirshner@chhc.de', 210);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('974043532', 'Harriet', 'Puckett', to_date('17-01-1989', 'dd-mm-yyyy'), '0754221120', 'harriet.puckett@epamsystems.de', 781);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('507397910', 'Dorry', 'Landau', to_date('12-05-1998', 'dd-mm-yyyy'), '0155613082', 'dorry@uem.ch', 338);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('679344850', 'Andie', 'Snow', to_date('03-09-2001', 'dd-mm-yyyy'), '0873989866', 'andie.snow@swi.dk', 848);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('996761642', 'Harriet', 'Perlman', to_date('23-12-2000', 'dd-mm-yyyy'), '0557526674', 'hperlman@authoria.com', 548);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('223772181', 'Lupe', 'Renfro', to_date('18-10-1993', 'dd-mm-yyyy'), '0272082768', 'lupe.renfro@biosite.de', 765);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('083033777', 'Ali', 'Fichtner', to_date('27-06-1990', 'dd-mm-yyyy'), '0357700487', 'a.fichtner@north.au', 411);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('677046121', 'Treat', 'Coward', to_date('17-06-2000', 'dd-mm-yyyy'), '0157586458', 'treat.coward@gtp.au', 118);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('597973499', 'Mili', 'Gertner', to_date('13-11-2001', 'dd-mm-yyyy'), '0494053441', 'milig@refinery.de', 96);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('342115162', 'Hugh', 'Rivers', to_date('02-08-1993', 'dd-mm-yyyy'), '0436565983', 'hugh.rivers@americanpan.fr', 448);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('190035391', 'Gina', 'Worrell', to_date('22-04-1993', 'dd-mm-yyyy'), '0219862462', 'ginaw@bestbuy.br', 317);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('659628156', 'Glenn', 'Kirkwood', to_date('16-12-1998', 'dd-mm-yyyy'), '0264524262', 'glenn.kirkwood@sourcegear.com', 839);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('821330468', 'Xander', 'Lang', to_date('02-02-1996', 'dd-mm-yyyy'), '0917478948', 'xanderl@mwh.com', 129);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('985567879', 'Arnold', 'Ontiveros', to_date('02-03-1999', 'dd-mm-yyyy'), '0834212320', 'arnold.ontiveros@mastercardinternat', 96);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('622557491', 'Joseph', 'Winter', to_date('16-09-1990', 'dd-mm-yyyy'), '0718835146', 'jwinter@aci.uk', 190);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('155544469', 'Scott', 'Gaynor', to_date('11-09-1999', 'dd-mm-yyyy'), '0134694254', 'scottg@nmr.com', 721);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('655389635', 'Tony', 'Newman', to_date('03-11-1988', 'dd-mm-yyyy'), '0209920389', 'tony.newman@conagra.com', 652);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('003635131', 'Burton', 'Matheson', to_date('23-12-1998', 'dd-mm-yyyy'), '0359551411', 'burton@horizon.com', 598);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('770417526', 'Cherry', 'Crosby', to_date('30-12-1999', 'dd-mm-yyyy'), '0211579743', 'c.crosby@catamount.fi', 560);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('382590965', 'Larry', 'Puckett', to_date('19-11-2001', 'dd-mm-yyyy'), '0965344555', 'larry.puckett@airmethods.es', 608);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('615443912', 'Tia', 'Dench', to_date('09-01-1998', 'dd-mm-yyyy'), '0595010173', 'tia.d@refinery.uk', 122);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('906853859', 'Amanda', 'Schwimmer', to_date('04-08-2001', 'dd-mm-yyyy'), '0997655175', 'amanda.s@zoneperfectnutrition.uk', 533);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('254024299', 'Jason', 'Gough', to_date('29-08-2000', 'dd-mm-yyyy'), '0575054644', 'j.gough@medamicus.com', 454);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('075183301', 'Liam', 'Moraz', to_date('01-12-2000', 'dd-mm-yyyy'), '0998120153', 'liamm@vfs.com', 422);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('011345266', 'Frank', 'Diggs', to_date('03-10-1999', 'dd-mm-yyyy'), '0404938686', 'frank.diggs@sfb.com', 435);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('151178492', 'Jean', 'Hirsch', to_date('01-09-1999', 'dd-mm-yyyy'), '0580529247', 'jean.hirsch@doraldentalusa.hu', 636);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('027412300', 'Shannyn', 'Herrmann', to_date('27-03-1997', 'dd-mm-yyyy'), '0136958837', 'shannyn.h@pearllawgroup.br', 898);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('391849146', 'Andrew', 'Candy', to_date('27-12-2001', 'dd-mm-yyyy'), '0583427464', 'andrew@globalwireless.com', 30);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('608708051', 'Domingo', 'Van Der Beek', to_date('29-12-1990', 'dd-mm-yyyy'), '0673406923', 'domingov@bayer.com', 242);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('459977075', 'Aaron', 'Gershon', to_date('19-11-1988', 'dd-mm-yyyy'), '0780974717', 'aaron@cyberthink.uk', 705);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('269614945', 'Steve', 'Bandy', to_date('31-12-1999', 'dd-mm-yyyy'), '0067991980', 'steve.bandy@nbs.com', 482);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('537907430', 'Shelby', 'Geldof', to_date('30-05-1998', 'dd-mm-yyyy'), '0487807035', 'sgeldof@netnumina.com', 905);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('339562961', 'Nicky', 'Arjona', to_date('27-10-2001', 'dd-mm-yyyy'), '0250577906', 'nicky.a@ceb.com', 7);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('397266455', 'Cathy', 'Pantoliano', to_date('16-07-1999', 'dd-mm-yyyy'), '0666996733', 'cathy.pantoliano@mercantilebank.com', 262);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('639815599', 'Corey', 'Rivers', to_date('17-01-1999', 'dd-mm-yyyy'), '0994720350', 'corey.rivers@generalmotors.com', 437);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('149127476', 'Debby', 'McGowan', to_date('27-08-1998', 'dd-mm-yyyy'), '0790230093', 'dmcgowan@businessplus.de', 410);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('821858115', 'Jack', 'Brolin', to_date('03-01-1999', 'dd-mm-yyyy'), '0548066348', 'jack.brolin@bestever.com', 305);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('199405399', 'Lili', 'Ingram', to_date('24-06-2000', 'dd-mm-yyyy'), '0623792373', 'lili.ingram@merck.com', 311);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('365033071', 'Janeane', 'Jeffreys', to_date('18-07-1988', 'dd-mm-yyyy'), '0897828203', 'janeane.jeffreys@businessplus.de', 873);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('898550992', 'Jack', 'Firth', to_date('16-12-1988', 'dd-mm-yyyy'), '0391616523', 'jack.firth@slt.fr', 458);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('855081684', 'Wade', 'Tisdale', to_date('10-08-1997', 'dd-mm-yyyy'), '0686081677', 'wade.tisdale@unicru.com', 452);
commit;
prompt 700 records committed...
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('812788391', 'Richard', 'Skaggs', to_date('24-06-1995', 'dd-mm-yyyy'), '0215980047', 'richard@allstar.fr', 763);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('790448700', 'Greg', 'Crimson', to_date('31-01-1993', 'dd-mm-yyyy'), '0178005556', 'greg.c@vertexsolutions.de', 71);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('563902300', 'Dennis', 'Twilley', to_date('20-08-1999', 'dd-mm-yyyy'), '0116525861', 'dennis.twilley@unilever.uk', 130);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('029730990', 'Beverley', 'Carnes', to_date('21-10-1995', 'dd-mm-yyyy'), '0337863494', 'beverley.c@cns.de', 497);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('232173384', 'Albertina', 'Tyson', to_date('15-12-1993', 'dd-mm-yyyy'), '0279599307', 'a.tyson@servicelink.dk', 592);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('544446385', 'Alicia', 'Diffie', to_date('10-02-1993', 'dd-mm-yyyy'), '0282225034', 'alicia@wci.de', 315);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('007512737', 'Rickie', 'Phillips', to_date('05-04-1994', 'dd-mm-yyyy'), '0593432561', 'rphillips@techrx.com', 24);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('196418290', 'Lee', 'Postlethwaite', to_date('07-10-1999', 'dd-mm-yyyy'), '0159786333', 'lee.postlethwaite@genextechnologies', 239);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('980890703', 'Jerry', 'Makowicz', to_date('07-07-1996', 'dd-mm-yyyy'), '0135509331', 'jerrym@vms.com', 511);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('357907728', 'William', 'Himmelman', to_date('18-06-1989', 'dd-mm-yyyy'), '0847179857', 'william.h@kingston.de', 815);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('051922296', 'Gene', 'Houston', to_date('31-03-1995', 'dd-mm-yyyy'), '0585211507', 'gene.houston@smi.com', 682);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('857965487', 'Isabella', 'Landau', to_date('16-02-1994', 'dd-mm-yyyy'), '0984130026', 'isabella.landau@shufflemaster.ar', 542);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('950087361', 'Loren', 'Albright', to_date('19-11-1996', 'dd-mm-yyyy'), '0139051754', 'loren.albright@nuinfosystems.com', 686);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('758046387', 'Pamela', 'Adams', to_date('28-10-2001', 'dd-mm-yyyy'), '0438044591', 'pamela.adams@mavericktechnologies.a', 523);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('279473695', 'Natascha', 'Firth', to_date('04-02-2001', 'dd-mm-yyyy'), '0117162284', 'nataschaf@stonetechprofessional.com', 666);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('732405586', 'Nathan', 'Gyllenhaal', to_date('06-07-1989', 'dd-mm-yyyy'), '0179538896', 'nathan.gyllenhaal@heritagemicrofilm', 507);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('481660892', 'Seth', 'Cattrall', to_date('31-12-1992', 'dd-mm-yyyy'), '0282180910', 'seth@procter.com', 687);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('707459082', 'Geoff', 'Ratzenberger', to_date('28-02-1998', 'dd-mm-yyyy'), '0188639234', 'geoff.ratzenberger@magnet.com', 833);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('708131112', 'Mitchell', 'Lindley', to_date('27-07-2001', 'dd-mm-yyyy'), '0991896144', 'mitchell.lindley@hitechpharmacal.au', 625);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('464137067', 'Gina', 'Palminteri', to_date('06-09-1997', 'dd-mm-yyyy'), '0580286459', 'gina@scjohnson.com', 379);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('300819735', 'Harry', 'Rhodes', to_date('06-01-1994', 'dd-mm-yyyy'), '0475454249', 'harry.rhodes@bigyanksports.com', 276);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('525337640', 'Rosie', 'Whitmore', to_date('27-05-1987', 'dd-mm-yyyy'), '0720096525', 'rosie.whitmore@logisticare.tr', 380);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('945469928', 'Curt', 'Mould', to_date('13-04-2000', 'dd-mm-yyyy'), '0529701788', 'curt.m@providenceservice.com', 590);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('156260996', 'Kiefer', 'Finney', to_date('20-08-1993', 'dd-mm-yyyy'), '0000361370', 'kfinney@entelligence.de', 483);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('524153631', 'Chaka', 'Makowicz', to_date('08-03-1995', 'dd-mm-yyyy'), '0237339894', 'chaka.makowicz@volkswagen.it', 195);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('657723692', 'Rhys', 'Purefoy', to_date('09-02-1988', 'dd-mm-yyyy'), '0644241546', 'rhys.purefoy@freedommedical.de', 91);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('489538253', 'Lennie', 'Perez', to_date('24-06-1989', 'dd-mm-yyyy'), '0750601589', 'lennie.perez@generalmills.com', 790);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('720995445', 'Kenneth', 'Channing', to_date('13-10-1998', 'dd-mm-yyyy'), '0518780500', 'kenneth@timevision.com', 839);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('289873378', 'Steve', 'Campbell', to_date('20-05-1993', 'dd-mm-yyyy'), '0726063016', 'steve@kramontrealty.es', 625);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('151429611', 'Lydia', 'Numan', to_date('01-03-1997', 'dd-mm-yyyy'), '0767742278', 'lydia.numan@lynksystems.br', 651);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('415502473', 'Juliana', 'Ponty', to_date('26-06-2001', 'dd-mm-yyyy'), '0670676317', 'juliana.ponty@medsource.com', 628);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('889130597', 'Beth', 'MacPherson', to_date('22-09-1989', 'dd-mm-yyyy'), '0831773425', 'beth.macpherson@diageo.com', 69);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('298487735', 'Bill', 'Downey', to_date('15-04-1998', 'dd-mm-yyyy'), '0482096397', 'billd@pragmatechsoftware.com', 329);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('973979390', 'Ozzy', 'Zevon', to_date('13-06-1999', 'dd-mm-yyyy'), '0951891507', 'ozzyz@interfacesoftware.it', 678);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('236453871', 'Bernie', 'Braugher', to_date('16-12-1996', 'dd-mm-yyyy'), '0867037531', 'b.braugher@operationaltechnologies.', 457);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('607655121', 'Stevie', 'Singh', to_date('25-07-1997', 'dd-mm-yyyy'), '0334021415', 'stevie.singh@iss.ca', 848);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('147156914', 'Nicholas', 'Overstreet', to_date('26-11-2000', 'dd-mm-yyyy'), '0960062196', 'nicholas.overstreet@idas.fr', 922);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('350070505', 'Tanya', 'MacPherson', to_date('18-10-1993', 'dd-mm-yyyy'), '0940142032', 'tanyam@procter.be', 981);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('866974926', 'Pam', 'Donovan', to_date('21-08-1988', 'dd-mm-yyyy'), '0903172241', 'pam.donovan@ads.ar', 987);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('119524327', 'Mary', 'Baranski', to_date('01-08-1996', 'dd-mm-yyyy'), '0161346735', 'mary@nestle.com', 748);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('436861515', 'Thin', 'Chestnut', to_date('10-07-2000', 'dd-mm-yyyy'), '0958653326', 'thin.chestnut@jsa.com', 889);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('714263066', 'Maggie', 'Duke', to_date('13-05-1994', 'dd-mm-yyyy'), '0438941591', 'maggie.duke@trusecure.it', 449);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('430689171', 'Gerald', 'Vassar', to_date('17-03-1994', 'dd-mm-yyyy'), '0703650556', 'gerald.vassar@benecongroup.uk', 681);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('109048083', 'Delroy', 'Krabbe', to_date('10-01-1988', 'dd-mm-yyyy'), '0732760691', 'dkrabbe@ach.fr', 290);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('698707624', 'Demi', 'Gano', to_date('01-02-1990', 'dd-mm-yyyy'), '0627739707', 'demi.gano@gsat.com', 253);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('611371673', 'Derek', 'O''Hara', to_date('20-06-1997', 'dd-mm-yyyy'), '0365924309', 'dereko@sci.com', 393);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('924132261', 'Mindy', 'Perez', to_date('23-02-1989', 'dd-mm-yyyy'), '0337209758', 'mindyp@dancor.com', 8);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('225666790', 'Hank', 'Collette', to_date('05-05-1997', 'dd-mm-yyyy'), '0054972252', 'h.collette@anworthmortgage.se', 363);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('227942129', 'Lupe', 'Broderick', to_date('30-10-1993', 'dd-mm-yyyy'), '0347781077', 'lupe@mms.com', 503);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('049829792', 'Devon', 'Buscemi', to_date('06-12-1993', 'dd-mm-yyyy'), '0330449920', 'devon.b@csi.com', 718);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('406417696', 'Thora', 'Dolenz', to_date('14-04-1989', 'dd-mm-yyyy'), '0945999589', 'thora.dolenz@conagra.br', 430);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('947040620', 'Wesley', 'Dalton', to_date('24-12-1993', 'dd-mm-yyyy'), '0302159483', 'wesley.dalton@powerlight.it', 613);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('747600716', 'Mena', 'Vince', to_date('01-04-1989', 'dd-mm-yyyy'), '0663472939', 'menav@tripwire.fr', 691);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('264719783', 'Aimee', 'Cohn', to_date('30-06-1993', 'dd-mm-yyyy'), '0151674922', 'aimee.cohn@tps.dk', 167);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('757839176', 'Chanté', 'Malone', to_date('08-09-2001', 'dd-mm-yyyy'), '0667153930', 'chant.malone@staffforce.de', 196);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('635994978', 'Cherry', 'Gosdin', to_date('29-09-1993', 'dd-mm-yyyy'), '0517579725', 'cherry.gosdin@wendysinternational.c', 996);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('455767140', 'Rhea', 'Spader', to_date('03-03-1999', 'dd-mm-yyyy'), '0174466247', 'rhea@gdi.com', 870);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('643824218', 'Goldie', 'Bacon', to_date('30-12-1987', 'dd-mm-yyyy'), '0961367781', 'goldie.bacon@woronocobancorp.ca', 590);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('829545163', 'Jonny', 'Rollins', to_date('11-03-1997', 'dd-mm-yyyy'), '0902934306', 'jonny.rollins@computersource.it', 129);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('450557181', 'Emma', 'Sorvino', to_date('24-11-1996', 'dd-mm-yyyy'), '0031422208', 'emma@usenergyservices.ca', 796);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('745701911', 'Teena', 'Cozier', to_date('23-10-1990', 'dd-mm-yyyy'), '0524901679', 'teena.cozier@tilsonhr.br', 648);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('449085052', 'Hilton', 'Parsons', to_date('17-08-2000', 'dd-mm-yyyy'), '0116893832', 'hparsons@bps.de', 667);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('623387258', 'Bette', 'Mathis', to_date('16-08-1989', 'dd-mm-yyyy'), '0212287775', 'b.mathis@gulfmarkoffshore.de', 765);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('355409884', 'Nanci', 'Byrd', to_date('17-03-2000', 'dd-mm-yyyy'), '0337333882', 'nanci.byrd@keith.com', 344);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('012274454', 'Tobey', 'Parsons', to_date('17-09-1996', 'dd-mm-yyyy'), '0520628641', 'tobey.parsons@integratelecom.pe', 762);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('040863022', 'Dar', 'Caldwell', to_date('05-09-1993', 'dd-mm-yyyy'), '0730942466', 'dar.caldwell@staffforce.de', 671);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('874759263', 'Lisa', 'Bonham', to_date('21-03-1989', 'dd-mm-yyyy'), '0851357571', 'lisa.bonham@connected.lt', 806);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('691594533', 'Gordon', 'Palminteri', to_date('19-12-1997', 'dd-mm-yyyy'), '0301471545', 'gordon.palminteri@pulaskifinancial.', 307);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('700584140', 'Victoria', 'Rhys-Davies', to_date('09-03-1997', 'dd-mm-yyyy'), '0631789120', 'victoria.rhysdavies@nrae.ch', 580);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('845161730', 'Gilberto', 'Gibbons', to_date('01-09-1999', 'dd-mm-yyyy'), '0042288763', 'gilberto@kramontrealty.ca', 956);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('282540294', 'Robby', 'Hector', to_date('30-12-1998', 'dd-mm-yyyy'), '0079450216', 'robby.hector@gha.com', 253);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('358343310', 'Guy', 'Gallant', to_date('14-10-1988', 'dd-mm-yyyy'), '0447305309', 'guyg@y2marketing.de', 963);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('744235579', 'Stephen', 'Armatrading', to_date('23-11-2000', 'dd-mm-yyyy'), '0781630542', 's.armatrading@onstaff.com', 524);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('225046475', 'Gloria', 'Bassett', to_date('16-07-1997', 'dd-mm-yyyy'), '0916125585', 'gloria.bassett@infovision.it', 92);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('669841604', 'Maria', 'MacDonald', to_date('25-11-1990', 'dd-mm-yyyy'), '0067857980', 'maria.macdonald@unicru.com', 902);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('702377149', 'Sonny', 'Lemmon', to_date('08-10-1991', 'dd-mm-yyyy'), '0059657903', 'sonny.lemmon@homedepot.com', 204);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('276682064', 'Miranda', 'Kutcher', to_date('16-11-1989', 'dd-mm-yyyy'), '0423308423', 'miranda.kutcher@irissoftware.dk', 429);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('574827120', 'Elisabeth', 'Sanders', to_date('14-12-1992', 'dd-mm-yyyy'), '0374187764', 'e.sanders@sbc.ch', 140);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('173202975', 'Paul', 'Pearce', to_date('03-11-1995', 'dd-mm-yyyy'), '0975746829', 'paul@vertexsolutions.fi', 785);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('246579173', 'Rodney', 'Detmer', to_date('12-02-1988', 'dd-mm-yyyy'), '0996291525', 'rodney.detmer@parker.ch', 112);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('764561139', 'Lili', 'McKellen', to_date('26-05-1988', 'dd-mm-yyyy'), '0870643721', 'l.mckellen@irissoftware.com', 971);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('664304473', 'Gwyneth', 'Law', to_date('23-10-1989', 'dd-mm-yyyy'), '0460927112', 'gwyneth@lifelinesystems.br', 475);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('434240394', 'Rosie', 'Wincott', to_date('03-05-1987', 'dd-mm-yyyy'), '0375039344', 'rosie.w@exinomtechnologies.com', 329);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('453308575', 'Lauren', 'Horizon', to_date('06-03-1988', 'dd-mm-yyyy'), '0115278475', 'lauren.horizon@marketfirst.com', 659);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('147405116', 'Chanté', 'Spacey', to_date('14-06-1998', 'dd-mm-yyyy'), '0435586132', 'cspacey@integratelecom.de', 476);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('497595275', 'Rita', 'Peniston', to_date('30-05-2000', 'dd-mm-yyyy'), '0547882905', 'rita@catamount.com', 597);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('745873706', 'Kirsten', 'Braugher', to_date('15-11-1994', 'dd-mm-yyyy'), '0771973999', 'kirsten.braugher@maverick.ar', 29);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('104740246', 'Danny', 'Bening', to_date('13-03-1991', 'dd-mm-yyyy'), '0507325484', 'danny.bening@viacom.es', 448);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('714522614', 'Vivica', 'Dukakis', to_date('17-02-1998', 'dd-mm-yyyy'), '0042437358', 'vivica@mqsoftware.ca', 125);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('567583608', 'Rade', 'Wells', to_date('19-04-1995', 'dd-mm-yyyy'), '0703215373', 'r.wells@digitalmotorworks.it', 581);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('620588483', 'Carlos', 'Brock', to_date('04-04-1994', 'dd-mm-yyyy'), '0612339423', 'carlosb@swp.ch', 944);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('134838990', 'Temuera', 'Loveless', to_date('25-09-1994', 'dd-mm-yyyy'), '0221011287', 'temuera.loveless@infovision.com', 60);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('641373385', 'Thora', 'Ryder', to_date('30-04-2000', 'dd-mm-yyyy'), '0695648177', 'thora.ryder@boldtechsystems.jp', 763);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('714254666', 'Laura', 'Mortensen', to_date('24-04-1995', 'dd-mm-yyyy'), '0610866182', 'laura@mainstreetbanks.com', 126);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('663947507', 'Laura', 'Blanchett', to_date('18-05-1995', 'dd-mm-yyyy'), '0033971511', 'l.blanchett@deutschetelekom.py', 263);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('673576281', 'Carl', 'Bush', to_date('29-03-1999', 'dd-mm-yyyy'), '0950452210', 'carl.bush@royalgold.uk', 823);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('327491347', 'Larenz', 'Wood', to_date('12-10-1998', 'dd-mm-yyyy'), '0106872002', 'larenzw@tama.mx', 539);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('607981663', 'Edgar', 'Hackman', to_date('03-11-1989', 'dd-mm-yyyy'), '0222864677', 'edgar.hackman@neogen.com', 909);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('721160937', 'Geena', 'Braugher', to_date('24-11-1998', 'dd-mm-yyyy'), '0887263578', 'geenab@ibm.ar', 5);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('458122429', 'Armand', 'Gleeson', to_date('20-09-1998', 'dd-mm-yyyy'), '0867555632', 'armand.gleeson@smartdrawcom.cz', 374);
commit;
prompt 800 records committed...
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('228626722', 'Rik', 'Stanley', to_date('03-03-1999', 'dd-mm-yyyy'), '0667142710', 'riks@educationaldevelopment.de', 534);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('515795787', 'Rik', 'Carmen', to_date('01-08-1993', 'dd-mm-yyyy'), '0322164856', 'rik@shot.com', 95);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('116197929', 'Loretta', 'Iglesias', to_date('12-11-1987', 'dd-mm-yyyy'), '0551823920', 'loretta.iglesias@qls.mx', 505);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('081252347', 'Rosanna', 'O''Neill', to_date('13-04-1999', 'dd-mm-yyyy'), '0968696997', 'rosanna.oneill@abs.com', 830);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('461142699', 'Gilberto', 'Day', to_date('12-04-1999', 'dd-mm-yyyy'), '0742447920', 'gilberto.day@directdata.com', 72);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('182777831', 'Christine', 'Duschel', to_date('23-07-1988', 'dd-mm-yyyy'), '0083595897', 'christined@trafficmanagement.de', 672);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('698127957', 'Sandra', 'Hiatt', to_date('19-06-1998', 'dd-mm-yyyy'), '0824531471', 'sandra.h@career.com', 565);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('795057209', 'Cate', 'Richardson', to_date('18-02-1993', 'dd-mm-yyyy'), '0325698359', 'c.richardson@mavericktechnologies.i', 484);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('367651164', 'Bernard', 'Head', to_date('14-01-1990', 'dd-mm-yyyy'), '0667301628', 'bernard@virbac.com', 434);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('689366514', 'Machine', 'Foster', to_date('07-08-1987', 'dd-mm-yyyy'), '0066979443', 'machine.foster@eastmankodak.com', 72);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('288118097', 'Larenz', 'Caldwell', to_date('25-04-1993', 'dd-mm-yyyy'), '0809813518', 'larenz.caldwell@smg.jp', 240);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('779136162', 'Delbert', 'Saxon', to_date('20-04-1993', 'dd-mm-yyyy'), '0724329344', 'd.saxon@captechventures.com', 194);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('035948178', 'Randall', 'Davison', to_date('07-11-1988', 'dd-mm-yyyy'), '0984965478', 'randall@solutionbuilders.com', 602);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('032072639', 'Neve', 'Mitchell', to_date('17-03-1999', 'dd-mm-yyyy'), '0515289305', 'neve.mitchell@staffone.nl', 260);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('981319115', 'Charles', 'Miles', to_date('22-02-2000', 'dd-mm-yyyy'), '0507235590', 'c.miles@fnb.com', 949);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('249539434', 'Kate', 'Klugh', to_date('30-05-1997', 'dd-mm-yyyy'), '0073505035', 'kate.klugh@acsis.dk', 815);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('575581959', 'Woody', 'Brothers', to_date('13-01-1994', 'dd-mm-yyyy'), '0150349129', 'woody.brothers@shar.com', 838);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('190554025', 'Salma', 'Shawn', to_date('28-06-1990', 'dd-mm-yyyy'), '0974687631', 's.shawn@aoltimewarner.com', 974);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('344917247', 'Howard', 'Sartain', to_date('21-06-1992', 'dd-mm-yyyy'), '0186236697', 'howard.sartain@jma.de', 831);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('583595623', 'Marianne', 'Thomas', to_date('27-04-1992', 'dd-mm-yyyy'), '0518090305', 'marianne.thomas@verizon.com', 618);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('969186817', 'Veruca', 'Stuermer', to_date('28-01-1993', 'dd-mm-yyyy'), '0248734308', 'veruca.s@albertsons.it', 280);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('493829613', 'Juliana', 'Perlman', to_date('05-06-1988', 'dd-mm-yyyy'), '0660522764', 'juliana.perlman@techbooks.com', 276);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('575963977', 'Anthony', 'Borden', to_date('24-11-1990', 'dd-mm-yyyy'), '0635034837', 'anthony@mindiq.com', 424);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('247448038', 'Omar', 'Ponce', to_date('26-04-1991', 'dd-mm-yyyy'), '0458868043', 'omarp@allstar.fr', 470);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('403521342', 'Dean', 'Lofgren', to_date('28-02-1996', 'dd-mm-yyyy'), '0019930039', 'dean.lofgren@elitemedical.nl', 535);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('907425713', 'Rebecca', 'Stanton', to_date('09-06-1991', 'dd-mm-yyyy'), '0377499598', 'rebecca.stanton@bayer.com', 987);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('149452198', 'Maury', 'Peniston', to_date('09-10-1996', 'dd-mm-yyyy'), '0918001305', 'maury@unitedasset.fr', 989);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('683358168', 'Gerald', 'Goldblum', to_date('01-07-1997', 'dd-mm-yyyy'), '0171586502', 'gerald.goldblum@gdi.com', 328);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('624364726', 'Collective', 'Lizzy', to_date('24-09-1990', 'dd-mm-yyyy'), '0364913308', 'collective.lizzy@ipsadvisory.uk', 502);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('618599987', 'William', 'Bacon', to_date('16-06-1998', 'dd-mm-yyyy'), '0400844540', 'william.bacon@capstone.com', 139);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('875497213', 'Nicole', 'Furay', to_date('18-09-1991', 'dd-mm-yyyy'), '0993789640', 'nicolef@airmethods.be', 704);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('732968533', 'Matthew', 'Glenn', to_date('09-10-1999', 'dd-mm-yyyy'), '0899073893', 'matthewg@inzone.uk', 169);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('930668756', 'Barry', 'Guzman', to_date('12-10-1988', 'dd-mm-yyyy'), '0102144754', 'barry.guzman@fmi.com', 472);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('048944382', 'Helen', 'Manning', to_date('06-04-1993', 'dd-mm-yyyy'), '0228871216', 'h.manning@americanland.com', 488);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('795610917', 'Lauren', 'Franks', to_date('27-04-1991', 'dd-mm-yyyy'), '0248356455', 'lauren.franks@arkidata.de', 857);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('715905858', 'Latin', 'Yankovic', to_date('07-03-1992', 'dd-mm-yyyy'), '0861346613', 'lyankovic@bis.com', 581);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('295549360', 'Winona', 'McCormack', to_date('12-06-2001', 'dd-mm-yyyy'), '0752162123', 'winona.mccormack@marketfirst.com', 902);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('930087656', 'Larenz', 'Braugher', to_date('15-01-1993', 'dd-mm-yyyy'), '0203760468', 'larenz.braugher@tilsonhr.br', 29);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('224737242', 'Joshua', 'Rispoli', to_date('01-03-1998', 'dd-mm-yyyy'), '0205472405', 'joshua@sis.fr', 23);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('197177391', 'Michael', 'Epps', to_date('26-08-1999', 'dd-mm-yyyy'), '0415625218', 'michael.epps@onstaff.fi', 690);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('170453905', 'Olympia', 'Kurtz', to_date('18-05-1988', 'dd-mm-yyyy'), '0660164910', 'o.kurtz@harrison.de', 244);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('852111607', 'Tcheky', 'Kinski', to_date('07-12-1990', 'dd-mm-yyyy'), '0594253842', 'tcheky@ogiointernational.es', 353);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('045378251', 'Rueben', 'Mould', to_date('03-04-1996', 'dd-mm-yyyy'), '0164143961', 'rueben.mould@nrae.fi', 151);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('027014178', 'Roy', 'Derringer', to_date('10-09-1991', 'dd-mm-yyyy'), '0610772272', 'royd@advancedneuromodulation.nl', 466);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('866575337', 'Sheryl', 'Bachman', to_date('31-10-1998', 'dd-mm-yyyy'), '0058927908', 'sheryl.bachman@infinity.com', 764);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('826119013', 'Keanu', 'Patillo', to_date('08-11-1992', 'dd-mm-yyyy'), '0919925362', 'keanu.p@diageo.ch', 964);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('093765218', 'Merle', 'Prinze', to_date('02-11-1999', 'dd-mm-yyyy'), '0148597098', 'mprinze@bedfordbancshares.de', 90);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('309038149', 'Thin', 'Saucedo', to_date('07-10-1999', 'dd-mm-yyyy'), '0809829739', 'thin.saucedo@marlabs.de', 261);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('324670635', 'Owen', 'Ponty', to_date('28-02-1998', 'dd-mm-yyyy'), '0839963369', 'owen@myricom.ca', 800);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('631319896', 'Clive', 'Edmunds', to_date('17-11-1995', 'dd-mm-yyyy'), '0026245448', 'clive.e@diageo.li', 506);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('816004359', 'Lucinda', 'Osborne', to_date('24-11-1997', 'dd-mm-yyyy'), '0184098625', 'lucinda.o@americanexpress.at', 529);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('727358635', 'Harrison', 'Lunch', to_date('21-01-1995', 'dd-mm-yyyy'), '0585513849', 'harrison.lunch@mls.com', 636);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('255579240', 'Mitchell', 'Rucker', to_date('18-12-1990', 'dd-mm-yyyy'), '0060461055', 'mrucker@speakeasy.com', 503);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('218880693', 'Vince', 'Hudson', to_date('30-01-1995', 'dd-mm-yyyy'), '0371740820', 'vince@sm.jp', 605);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('442967208', 'Harris', 'Puckett', to_date('16-04-1997', 'dd-mm-yyyy'), '0361465033', 'harris.puckett@heritagemicrofilm.co', 962);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('196733664', 'Randall', 'Woodward', to_date('15-04-1989', 'dd-mm-yyyy'), '0538641415', 'randall.w@mainstreetbanks.com', 125);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('549552694', 'Freddy', 'Cassidy', to_date('18-12-1997', 'dd-mm-yyyy'), '0610773479', 'freddy.cassidy@merck.ca', 19);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('953522249', 'Christine', 'Hirsch', to_date('22-06-1993', 'dd-mm-yyyy'), '0264551014', 'christine.hirsch@mms.de', 108);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('057602263', 'Kevn', 'Christie', to_date('03-11-2001', 'dd-mm-yyyy'), '0438254909', 'kevn.christie@newmedia.com', 779);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('274694530', 'King', 'Mellencamp', to_date('25-02-1996', 'dd-mm-yyyy'), '0135925219', 'king.mellencamp@trekequipment.nl', 874);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('357843875', 'Cole', 'Hauer', to_date('07-01-2001', 'dd-mm-yyyy'), '0185410489', 'cole.hauer@contract.com', 490);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('255080145', 'Cloris', 'Paymer', to_date('23-12-1998', 'dd-mm-yyyy'), '0083158991', 'cloris.paymer@envisiontelephony.dk', 642);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('730855848', 'Goran', 'Gilliam', to_date('16-08-1992', 'dd-mm-yyyy'), '0136478261', 'goran.gilliam@credopetroleum.com', 388);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('184062892', 'Jake', 'Akins', to_date('11-12-1996', 'dd-mm-yyyy'), '0314355563', 'jake.akins@career.de', 888);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('384579634', 'Ty', 'Blaine', to_date('02-02-1994', 'dd-mm-yyyy'), '0292431365', 'tyb@operationaltechnologies.com', 753);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('565197531', 'Morris', 'McFerrin', to_date('18-05-1987', 'dd-mm-yyyy'), '0378269415', 'morris.mcferrin@ceom.it', 807);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('925229120', 'Mel', 'Soda', to_date('02-03-1989', 'dd-mm-yyyy'), '0115314736', 'mel.soda@hardwoodwholesalers.com', 779);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('836968698', 'Donal', 'Plimpton', to_date('10-06-1992', 'dd-mm-yyyy'), '0428015794', 'donal.plimpton@universalsolutions.u', 860);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('351597676', 'Jared', 'Frakes', to_date('16-02-1999', 'dd-mm-yyyy'), '0229740692', 'jared@dearbornbancorp.com', 848);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('028322021', 'Ronny', 'Colin Young', to_date('11-12-1991', 'dd-mm-yyyy'), '0054535037', 'ronny.colinyoung@businessplus.com', 440);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('582504618', 'Quentin', 'Blades', to_date('06-09-1989', 'dd-mm-yyyy'), '0259768274', 'qblades@restaurantpartners.se', 87);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('921230029', 'Heather', 'Atkinson', to_date('18-04-1997', 'dd-mm-yyyy'), '0983288417', 'heathera@clubone.br', 669);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('053367108', 'Queen', 'Detmer', to_date('25-05-1987', 'dd-mm-yyyy'), '0924253212', 'queen.detmer@gci.com', 218);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('087622500', 'Alfred', 'Epps', to_date('17-01-1999', 'dd-mm-yyyy'), '0165765707', 'alfred.e@employerservices.nl', 78);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('482740177', 'LeVar', 'Brando', to_date('24-10-1999', 'dd-mm-yyyy'), '0230829466', 'levar.brando@wellsfinancial.com', 669);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('641916847', 'Ian', 'Carnes', to_date('30-04-1998', 'dd-mm-yyyy'), '0185589655', 'ian@kingland.de', 57);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('251810613', 'Goran', 'Dillane', to_date('28-07-1992', 'dd-mm-yyyy'), '0292462322', 'goran.dillane@alohanysystems.uk', 518);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('703408099', 'Petula', 'Elliott', to_date('04-07-1998', 'dd-mm-yyyy'), '0932471859', 'petula.elliott@softworld.com', 190);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('110547820', 'Isabella', 'Pfeiffer', to_date('04-09-1987', 'dd-mm-yyyy'), '0764349420', 'i.pfeiffer@royalgold.com', 635);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('217182827', 'Ashley', 'Newton', to_date('19-12-2001', 'dd-mm-yyyy'), '0193449799', 'ashley.newton@technica.fr', 735);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('918223584', 'Brad', 'Rippy', to_date('03-01-2000', 'dd-mm-yyyy'), '0914780539', 'brad.rippy@dvdt.com', 87);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('115269670', 'Trace', 'Burmester', to_date('06-06-1988', 'dd-mm-yyyy'), '0653123563', 'trace.burmester@younginnovations.jp', 354);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('980551762', 'Gilberto', 'Avalon', to_date('14-01-1993', 'dd-mm-yyyy'), '0929709673', 'gilberto.avalon@peerlessmanufacturi', 949);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('493644370', 'Emerson', 'Sainte-Marie', to_date('10-05-2001', 'dd-mm-yyyy'), '0491936126', 'emerson.saintemarie@terrafirma.com', 156);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('528755041', 'Azucar', 'Chinlund', to_date('30-12-1993', 'dd-mm-yyyy'), '0193057424', 'achinlund@prahs.br', 649);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('279052241', 'Christina', 'Himmelman', to_date('22-01-2001', 'dd-mm-yyyy'), '0559830063', 'christina@trinityhomecare.au', 758);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('043950220', 'Terrence', 'Farina', to_date('24-04-1988', 'dd-mm-yyyy'), '0879402709', 'terrence@tilia.ch', 341);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('931627255', 'Chrissie', 'Braugher', to_date('19-08-2000', 'dd-mm-yyyy'), '0983453545', 'chrissie.braugher@ataservices.com', 616);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('480084289', 'LeVar', 'Williamson', to_date('10-02-2001', 'dd-mm-yyyy'), '0604501043', 'levarw@safehomesecurity.jp', 182);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('333942083', 'Judi', 'Apple', to_date('06-10-1999', 'dd-mm-yyyy'), '0568760179', 'judi.apple@gha.com', 897);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('332094665', 'Mel', 'Gaines', to_date('25-01-1988', 'dd-mm-yyyy'), '0480501543', 'mel.g@efcbancorp.fr', 389);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('381313716', 'Samantha', 'Levy', to_date('03-04-1991', 'dd-mm-yyyy'), '0008427811', 'samantha.levy@gbas.com', 194);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('324093947', 'Joan', 'Shalhoub', to_date('30-01-1987', 'dd-mm-yyyy'), '0519968740', 'jshalhoub@sms.com', 791);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('137837782', 'Patricia', 'Stone', to_date('05-12-1998', 'dd-mm-yyyy'), '0788445695', 'patricia.stone@mds.it', 974);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('619167924', 'Trick', 'Steiger', to_date('21-01-1998', 'dd-mm-yyyy'), '0962336059', 'trick.steiger@ecopy.za', 934);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('890982672', 'Fiona', 'Perry', to_date('09-03-1987', 'dd-mm-yyyy'), '0527391393', 'fiona.p@capitalbank.com', 335);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('196733267', 'Bonnie', 'Lennox', to_date('17-03-1987', 'dd-mm-yyyy'), '0124523816', 'bonnie.l@servicesource.au', 298);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('543310124', 'Wayne', 'DeVito', to_date('10-11-1992', 'dd-mm-yyyy'), '0148935894', 'wayne.devito@ait.de', 625);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('280527107', 'Dick', 'Lauper', to_date('26-12-1989', 'dd-mm-yyyy'), '0609498439', 'dick.lauper@verizon.com', 547);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('614414921', 'Viggo', 'Osbourne', to_date('01-05-1996', 'dd-mm-yyyy'), '0023236250', 'viggo@tastefullysimple.pt', 430);
commit;
prompt 900 records committed...
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('587914006', 'Peter', 'Mantegna', to_date('16-06-1992', 'dd-mm-yyyy'), '0994065769', 'p.mantegna@spd.ie', 312);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('223300085', 'Lena', 'Patrick', to_date('14-02-2001', 'dd-mm-yyyy'), '0101568316', 'lpatrick@tigris.nl', 843);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('509314529', 'Grace', 'Avital', to_date('31-03-1992', 'dd-mm-yyyy'), '0330127635', 'gracea@conquest.com', 514);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('463345351', 'Campbell', 'Beck', to_date('06-11-1997', 'dd-mm-yyyy'), '0007549880', 'c.beck@swi.com', 120);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('333215742', 'Seann', 'Wilson', to_date('22-12-2000', 'dd-mm-yyyy'), '0621088203', 'seann.wilson@visainternational.de', 987);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('271327282', 'Curtis', 'Loggins', to_date('17-09-1991', 'dd-mm-yyyy'), '0497510042', 'curtis.loggins@afs.uk', 653);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('140958809', 'Seann', 'Sutherland', to_date('06-10-1989', 'dd-mm-yyyy'), '0080084218', 'seann.sutherland@mse.jp', 42);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('151496654', 'Alfie', 'Fisher', to_date('16-11-1997', 'dd-mm-yyyy'), '0887985397', 'alfief@unilever.com', 47);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('475698681', 'Carole', 'Johansen', to_date('21-06-2001', 'dd-mm-yyyy'), '0827340896', 'carole.johansen@logisticare.com', 755);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('958603102', 'Rita', 'Haslam', to_date('12-06-1989', 'dd-mm-yyyy'), '0590419454', 'rita.haslam@campbellsoup.com', 382);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('209740540', 'Michael', 'Elwes', to_date('03-01-2000', 'dd-mm-yyyy'), '0010348695', 'michael.e@linersdirect.jp', 682);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('224748637', 'Talvin', 'Levine', to_date('13-05-1988', 'dd-mm-yyyy'), '0696526193', 'talvin.levine@cynergydata.fi', 216);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('673439814', 'Scott', 'Ermey', to_date('27-11-1998', 'dd-mm-yyyy'), '0574089239', 'scott.ermey@questarcapital.br', 782);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('393725381', 'Gino', 'Randal', to_date('14-07-1996', 'dd-mm-yyyy'), '0010411394', 'g.randal@venoco.fr', 581);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('738858388', 'Lionel', 'Marin', to_date('19-03-1999', 'dd-mm-yyyy'), '0111428173', 'lionel.marin@pepsico.fr', 457);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('543141436', 'Davey', 'Redford', to_date('01-07-1994', 'dd-mm-yyyy'), '0303998332', 'davey.redford@tilsonhr.com', 280);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('164786196', 'Leon', 'Hannah', to_date('09-05-1988', 'dd-mm-yyyy'), '0255398085', 'lhannah@jlphor.de', 542);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('887590903', 'Raul', 'Stoltz', to_date('21-01-1995', 'dd-mm-yyyy'), '0685016737', 'raul@canterburypark.com', 206);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('412307841', 'Trace', 'Latifah', to_date('17-03-2000', 'dd-mm-yyyy'), '0930330240', 'trace@harrison.uk', 376);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('760714012', 'Shirley', 'Everett', to_date('11-12-1990', 'dd-mm-yyyy'), '0193272715', 'severett@keymark.com', 324);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('518407549', 'Carl', 'Blige', to_date('29-01-1988', 'dd-mm-yyyy'), '0593752573', 'carlb@ibm.au', 530);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('132108706', 'Gwyneth', 'Coward', to_date('02-05-1996', 'dd-mm-yyyy'), '0269773045', 'gwyneth.c@telesynthesis.au', 94);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('935958243', 'Jarvis', 'Bush', to_date('11-09-1997', 'dd-mm-yyyy'), '0694827245', 'j.bush@adeasolutions.com', 78);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('748167334', 'Jay', 'Kirshner', to_date('13-09-1990', 'dd-mm-yyyy'), '0930044312', 'jay.kirshner@allstar.ch', 101);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('535455980', 'Brian', 'Wright', to_date('04-02-1996', 'dd-mm-yyyy'), '0225632525', 'brianw@progressivemedical.com', 213);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('385070236', 'Randy', 'Close', to_date('04-12-1990', 'dd-mm-yyyy'), '0282969940', 'randy.close@thinktanksystems.fr', 129);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('297112351', 'Boz', 'Krabbe', to_date('19-01-2000', 'dd-mm-yyyy'), '0590011984', 'boz.krabbe@eagleone.com', 923);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('284244788', 'Vertical', 'Gershon', to_date('22-08-1999', 'dd-mm-yyyy'), '0843223241', 'vertical@printtech.au', 706);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('569918993', 'Avenged', 'Leguizamo', to_date('15-03-1988', 'dd-mm-yyyy'), '0119270629', 'avenged.leguizamo@hotmail.uk', 681);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('357683157', 'Ozzy', 'Rundgren', to_date('25-08-1999', 'dd-mm-yyyy'), '0918334286', 'ozzy.rundgren@kroger.de', 417);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('458746323', 'Nile', 'Lightfoot', to_date('24-06-1991', 'dd-mm-yyyy'), '0708620202', 'n.lightfoot@tama.com', 529);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('051975805', 'Denis', 'Tennison', to_date('02-07-1999', 'dd-mm-yyyy'), '0529921236', 'denis@integramedamerica.ar', 137);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('791620549', 'Jonny', 'Gyllenhaal', to_date('12-04-1988', 'dd-mm-yyyy'), '0777144321', 'jonny.gyllenhaal@integratelecom.uk', 975);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('242156051', 'Julia', 'Gano', to_date('08-11-1999', 'dd-mm-yyyy'), '0917525081', 'julia.gano@unica.com', 276);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('433928010', 'Boz', 'Rodriguez', to_date('11-06-1988', 'dd-mm-yyyy'), '0932620413', 'boz.rodriguez@fab.de', 765);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('628650660', 'Terence', 'Weisberg', to_date('22-10-1990', 'dd-mm-yyyy'), '0538317408', 'terence@vspan.mx', 584);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('003430094', 'Lizzy', 'Savage', to_date('10-05-1997', 'dd-mm-yyyy'), '0321700409', 'lizzy.savage@supplycorecom.lt', 831);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('210316218', 'Jill', 'Downie', to_date('15-11-1999', 'dd-mm-yyyy'), '0101529214', 'jill.downie@sht.lk', 157);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('995674958', 'Beth', 'Kirkwood', to_date('30-07-1997', 'dd-mm-yyyy'), '0978744422', 'beth.kirkwood@proclarity.com', 483);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('530541326', 'Colin', 'Miller', to_date('30-10-1999', 'dd-mm-yyyy'), '0136763939', 'cmiller@hardwoodwholesalers.ca', 943);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('560738660', 'Kenneth', 'Brolin', to_date('18-02-1995', 'dd-mm-yyyy'), '0323462710', 'kenneth.brolin@globalwireless.in', 266);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('922332425', 'Vivica', 'Aiken', to_date('13-06-1993', 'dd-mm-yyyy'), '0037991062', 'vivica.a@news.ca', 747);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('605767818', 'Edgar', 'Gryner', to_date('01-11-1994', 'dd-mm-yyyy'), '0512892996', 'edgar.gryner@hfg.com', 725);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('477448048', 'Caroline', 'Kahn', to_date('23-11-1994', 'dd-mm-yyyy'), '0898452262', 'caroline.kahn@albertsons.de', 196);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('903923630', 'Joaquim', 'Kane', to_date('29-03-1997', 'dd-mm-yyyy'), '0019001761', 'j.kane@target.pk', 543);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('493472405', 'Diamond', 'Hynde', to_date('02-04-1998', 'dd-mm-yyyy'), '0012941619', 'diamond@jma.com', 633);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('757548870', 'Chazz', 'Costner', to_date('21-02-1999', 'dd-mm-yyyy'), '0860164148', 'chazz.costner@scjohnson.uk', 627);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('160917246', 'Clarence', 'Redford', to_date('10-08-1994', 'dd-mm-yyyy'), '0752340177', 'clarence.redford@signature.uk', 769);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('773375621', 'Chet', 'Bridges', to_date('05-06-1999', 'dd-mm-yyyy'), '0049051799', 'chetb@creditorsinterchange.com', 34);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('887687675', 'Omar', 'Metcalf', to_date('08-10-1988', 'dd-mm-yyyy'), '0007023358', 'omar.metcalf@bigyanksports.in', 67);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('999264028', 'Wes', 'McConaughey', to_date('19-12-1989', 'dd-mm-yyyy'), '0163627610', 'w.mcconaughey@fetchlogistics.com', 496);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('274714968', 'Gates', 'Holy', to_date('11-02-1998', 'dd-mm-yyyy'), '0299523046', 'gholy@bluffcitysteel.com', 400);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('464632757', 'Carlos', 'O''Keefe', to_date('14-06-1999', 'dd-mm-yyyy'), '0881834846', 'cokeefe@esteelauder.com', 775);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('247099706', 'Grace', 'McCormack', to_date('17-03-1989', 'dd-mm-yyyy'), '0969572177', 'gmccormack@genextechnologies.com', 256);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('644370307', 'Brenda', 'Sevenfold', to_date('22-04-1988', 'dd-mm-yyyy'), '0306791204', 'brendas@mindiq.com', 862);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('440131422', 'Rolando', 'Rifkin', to_date('05-06-2001', 'dd-mm-yyyy'), '0716979349', 'rolando@vspan.com', 827);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('318338979', 'Cuba', 'Robards', to_date('20-12-1987', 'dd-mm-yyyy'), '0487116347', 'cuba.robards@palmbeachtan.uk', 626);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('127959474', 'Colleen', 'Johnson', to_date('07-03-1994', 'dd-mm-yyyy'), '0801097641', 'colleen@restaurantpartners.it', 960);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('871996624', 'Crystal', 'Harnes', to_date('02-04-1997', 'dd-mm-yyyy'), '0143084586', 'crystal@hfn.de', 550);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('841122102', 'Richard', 'Sirtis', to_date('18-11-1990', 'dd-mm-yyyy'), '0503860218', 'richard.sirtis@esoftsolutions.ch', 802);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('093669743', 'Tzi', 'Saxon', to_date('28-06-1999', 'dd-mm-yyyy'), '0795996275', 'tzi.s@isd.com', 23);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('686338264', 'Nicky', 'Gayle', to_date('21-05-1988', 'dd-mm-yyyy'), '0839638783', 'nicky.gayle@bayer.com', 418);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('971348382', 'Dianne', 'Shepherd', to_date('15-05-2001', 'dd-mm-yyyy'), '0861871605', 'diannes@ppr.ch', 281);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('748577866', 'Junior', 'Raye', to_date('27-09-1995', 'dd-mm-yyyy'), '0480814957', 'junior.raye@kramontrealty.com', 158);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('400785535', 'Mint', 'Duke', to_date('09-07-1995', 'dd-mm-yyyy'), '0160377976', 'mint.d@banfeproducts.ca', 885);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('975711422', 'Chad', 'Eat World', to_date('07-07-1991', 'dd-mm-yyyy'), '0608445756', 'chad@pioneerdatasystems.de', 705);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('394972123', 'Vivica', 'Tippe', to_date('05-01-1991', 'dd-mm-yyyy'), '0935912984', 'vtippe@ceo.pt', 580);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('024740271', 'Kirsten', 'Branch', to_date('15-11-1987', 'dd-mm-yyyy'), '0051190474', 'kirsten@accuship.pl', 886);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('290013511', 'Bobbi', 'Brooke', to_date('22-11-1987', 'dd-mm-yyyy'), '0839061603', 'bobbi.brooke@newhorizons.za', 60);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('822236171', 'Joan', 'Fehr', to_date('08-01-2000', 'dd-mm-yyyy'), '0279774868', 'joanf@scooterstore.com', 196);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('514307370', 'Gil', 'Rebhorn', to_date('25-05-1987', 'dd-mm-yyyy'), '0663545955', 'gil@telecheminternational.com', 929);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('597449208', 'Woody', 'Stamp', to_date('28-03-1993', 'dd-mm-yyyy'), '0899688828', 'woodys@infopros.it', 580);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('260653353', 'Faye', 'McGinley', to_date('06-06-1990', 'dd-mm-yyyy'), '0466033505', 'faye@dbprofessionals.com', 489);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('060462427', 'Ike', 'Short', to_date('28-08-1996', 'dd-mm-yyyy'), '0562460220', 'ike.short@horizon.com', 956);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('730344263', 'Sal', 'Womack', to_date('07-04-1990', 'dd-mm-yyyy'), '0616962019', 'sal.womack@irissoftware.dk', 345);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('980068951', 'Nikka', 'Tankard', to_date('25-06-1998', 'dd-mm-yyyy'), '0909248870', 'nikka.tankard@comnetinternational.f', 614);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('595223184', 'Sophie', 'Warden', to_date('16-10-1992', 'dd-mm-yyyy'), '0384140877', 'sophiew@providenceservice.il', 216);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('491316712', 'Dean', 'Shue', to_date('07-05-1997', 'dd-mm-yyyy'), '0467803531', 'dean.shue@enterprise.au', 955);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('783504458', 'Loreena', 'Ellis', to_date('28-04-1991', 'dd-mm-yyyy'), '0050650797', 'loreena.ellis@isd.br', 107);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('509608552', 'Beth', 'Brown', to_date('07-07-2000', 'dd-mm-yyyy'), '0244502920', 'bethb@clorox.lt', 160);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('109850885', 'Shawn', 'Emmerich', to_date('10-10-1990', 'dd-mm-yyyy'), '0600382094', 'shawn.emmerich@evergreenresources.c', 990);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('384408509', 'Patti', 'Idol', to_date('17-03-1997', 'dd-mm-yyyy'), '0813575783', 'patti@integramedamerica.it', 179);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('639512743', 'Willem', 'Wahlberg', to_date('10-07-1988', 'dd-mm-yyyy'), '0160403841', 'willem.wahlberg@ctg.com', 889);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('143521723', 'Vivica', 'Furtado', to_date('15-05-1997', 'dd-mm-yyyy'), '0541746994', 'vivica@mainstreetbanks.fi', 672);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('069940406', 'Franz', 'Leoni', to_date('10-04-1989', 'dd-mm-yyyy'), '0396293112', 'franz.l@accesssystems.com', 756);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('041914476', 'Miki', 'Gold', to_date('02-01-1999', 'dd-mm-yyyy'), '0942218226', 'mikig@ultimus.pt', 261);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('192138708', 'Sammy', 'Driver', to_date('02-06-1995', 'dd-mm-yyyy'), '0578655405', 'sammyd@qls.com', 1005);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('325179749', 'Vondie', 'Close', to_date('11-03-1987', 'dd-mm-yyyy'), '0397669464', 'v.close@digitalmotorworks.com', 676);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('678604709', 'Dermot', 'Nielsen', to_date('11-04-1994', 'dd-mm-yyyy'), '0935113347', 'dermot.nielsen@whitewave.com', 667);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('075221711', 'Lin', 'Purefoy', to_date('11-05-2000', 'dd-mm-yyyy'), '0858211776', 'lin.purefoy@philipmorris.com', 525);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('861103587', 'Sydney', 'Gleeson', to_date('20-10-1998', 'dd-mm-yyyy'), '0573637780', 'sydney.gleeson@servicelink.nl', 229);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('310389966', 'Willie', 'Dupree', to_date('17-03-1989', 'dd-mm-yyyy'), '0295837003', 'willie.dupree@fra.ca', 91);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('003153221', 'Adrien', 'Benson', to_date('04-09-1993', 'dd-mm-yyyy'), '0985295901', 'adrienb@techrx.com', 89);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('790036557', 'Jake', 'Dalton', to_date('01-01-1993', 'dd-mm-yyyy'), '0880314485', 'jdalton@sds.com', 522);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('287532568', 'Neil', 'McCracken', to_date('27-12-1997', 'dd-mm-yyyy'), '0091992384', 'nmccracken@smi.tw', 531);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('303981782', 'Rory', 'Chaplin', to_date('22-01-1987', 'dd-mm-yyyy'), '0838323509', 'rory.chaplin@prosperitybancshares.c', 387);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('565364283', 'Charles', 'Elwes', to_date('07-09-1987', 'dd-mm-yyyy'), '0610114230', 'celwes@newhorizons.ar', 354);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('489782650', 'Rita', 'Llewelyn', to_date('28-03-2000', 'dd-mm-yyyy'), '0481338049', 'rita.llewelyn@smi.com', 986);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('081687329', 'Tim', 'Bachman', to_date('17-09-2000', 'dd-mm-yyyy'), '0344308239', 'tim.bachman@stonetechprofessional.c', 39);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('834599722', 'Rachel', 'Rodgers', to_date('24-01-1990', 'dd-mm-yyyy'), '0108372387', 'rachel.r@bmm.com', 288);
commit;
prompt 1000 records committed...
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('112865612', 'Jean-Claude', 'Mann', to_date('30-05-1995', 'dd-mm-yyyy'), '0439526115', 'jeanclaude.mann@qssgroup.com', 888);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('620897202', 'Forest', 'Bassett', to_date('15-04-1990', 'dd-mm-yyyy'), '0849073733', 'forest.bassett@fmb.com', 984);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('966562021', 'Rory', 'Domino', to_date('03-11-1994', 'dd-mm-yyyy'), '0003007074', 'rory.domino@doctorsassociates.cy', 571);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('391319643', 'Kimberly', 'Redgrave', to_date('11-12-1994', 'dd-mm-yyyy'), '0222600370', 'kimberly.redgrave@pharmafab.com', 770);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('484663724', 'Patti', 'Law', to_date('29-11-1995', 'dd-mm-yyyy'), '0456483999', 'patti@officedepot.uk', 107);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('453931453', 'Maureen', 'Cochran', to_date('19-10-2001', 'dd-mm-yyyy'), '0214858891', 'maureen@doraldentalusa.com', 303);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('760435488', 'Benjamin', 'Imperioli', to_date('10-09-1996', 'dd-mm-yyyy'), '0126408693', 'benjamin.imperioli@staffforce.uk', 82);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('896022170', 'Catherine', 'Giannini', to_date('27-03-2001', 'dd-mm-yyyy'), '0903065711', 'catherine@tlsservicebureau.com', 700);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('067632957', 'Gord', 'Hanks', to_date('28-01-1990', 'dd-mm-yyyy'), '0899538536', 'gord.h@vitacostcom.com', 58);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('230719677', 'Jose', 'Cage', to_date('25-12-1988', 'dd-mm-yyyy'), '0079538220', 'jose.cage@nissanmotor.uk', 739);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('393616037', 'Raul', 'Potter', to_date('26-11-2000', 'dd-mm-yyyy'), '0401261932', 'raul.potter@solutionbuilders.br', 792);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('919285820', 'Jonny', 'Harrelson', to_date('07-12-1999', 'dd-mm-yyyy'), '0716197864', 'jonny.harrelson@usainstruments.de', 526);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('268935808', 'Roddy', 'Hall', to_date('28-10-1999', 'dd-mm-yyyy'), '0803933274', 'rhall@prometheuslaboratories.br', 638);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('153344647', 'Mae', 'Lachey', to_date('27-08-2001', 'dd-mm-yyyy'), '0060372184', 'mael@jewettcameron.com', 627);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('095973102', 'Seann', 'Allison', to_date('28-09-1994', 'dd-mm-yyyy'), '0176923279', 'seann.a@staffone.com', 806);
insert into PERSON (personid, firstname, lastname, birthdate, phonenumber, email, adressid)
values ('812267552', 'Garth', 'Cusack', to_date('14-04-1992', 'dd-mm-yyyy'), '0307238909', 'garth@faef.ar', 1);
commit;
prompt 1016 records loaded
prompt Loading GUIDE...
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('760435488', 'Head Of Department', 6, 'Emotional Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('975711422', 'Counselor', 5, 'Commercial Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('324670635', 'Counselor', 5, 'Academic Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('890982672', 'Counselor', 6, 'Academic Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('918223584', 'Counselor', 9, 'Commercial Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('615443912', 'Academic Counselor', 8, 'Emotional Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('866575337', 'Guide', 17, 'Objective Opinion');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('477448048', 'Guide', 16, 'Objective Opinion');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('714263066', 'Guide', 21, 'Commercial Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('839161222', 'Guide', 10, 'Emotional Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('227942129', 'Head Of Department', 20, 'Commercial Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('974043532', 'Guide', 21, 'Commercial Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('723701036', 'Head Of Department', 14, 'Objective Opinion');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('575581959', 'Academic Counselor', 14, 'Objective Opinion');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('108498144', 'Employment- Oriented', 12, 'Commercial Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('979621779', 'Counselor', 21, 'Emotional Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('879371457', 'Employment- Oriented', 7, 'Academic Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('489538253', 'Counselor', 11, 'Objective Opinion');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('611888673', 'Head Of Department', 19, 'Academic Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('022645109', 'Head Of Department', 7, 'Commercial Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('667566215', 'Head Of Department', 3, 'Commercial Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('936645107', 'Employment- Oriented', 9, 'Emotional Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('196418290', 'Employment- Oriented', 6, 'Academic Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('550609298', 'Head Of Department', 8, 'Objective Opinion');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('458746323', 'Academic Counselor', 17, 'Academic Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('491058748', 'Employment- Oriented', 20, 'Academic Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('980950912', 'Academic Counselor', 19, 'Emotional Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('889130597', 'Counselor', 8, 'Academic Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('427381821', 'Counselor', 4, 'Emotional Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('554788594', 'Guide', 12, 'Emotional Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('783907365', 'Head Of Department', 16, 'Objective Opinion');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('623774957', 'Employment- Oriented', 5, 'Commercial Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('411594779', 'Head Of Department', 10, 'Academic Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('899940033', 'Counselor', 11, 'Objective Opinion');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('511659200', 'Counselor', 20, 'Emotional Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('357504979', 'Academic Counselor', 19, 'Commercial Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('552694767', 'Guide', 8, 'Objective Opinion');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('410147718', 'Guide', 6, 'Commercial Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('105837988', 'Counselor', 13, 'Commercial Consulting');
insert into GUIDE (gpersonid, grole, experience, specialization)
values ('945469928', 'Counselor', 7, 'Emotional Consulting');
commit;
prompt 40 records loaded
prompt Loading STUDENT...
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('207265711', 'Science Computing', 'UI', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('21281968', 'Science Computing', 'UI', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('244557811', 'Science Computing', 'Cyber', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('207265234', 'Software Engineering', 'Data Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('207265713', 'Software Engineering', 'Communication', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('207578934', 'Software Engineering', 'Cyber', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('987545711', 'Buisness', 'Digital Marketing', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('207993212', 'Buisness Administration', 'Data Applications', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('211235719', 'Bioinformatics', 'Computing', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('232567788', 'Life Science', 'Education', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('402459198', 'Computer Science'''' Software En', 'Marketing', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('803409847', 'Accounting', 'Management', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('357907728', 'Buisness Administration', 'Marketing', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('398086315', 'Pharmacy', 'Data Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('327636786', 'Accounting', 'Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('442303438', 'Buisness Administration', 'Management', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('251810613', 'Physics', 'Marketing', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('920937386', 'Accounting', 'Data Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('328931761', 'Bioinformatics', 'Marketing', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('819385868', 'Mathematics', 'Digital', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('011345266', 'Industrial& Management', 'Data Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('263668514', 'Bioinformatics', 'Management', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('196733664', 'Pharmacy', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('529585640', 'Pharmacy', 'Society', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('807478919', 'Computer Science'''' Software En', 'Management', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('841122102', 'Accounting', 'Management', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('481660892', 'Nursing', 'Marketing', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('519894730', 'Mathematics', 'Management', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('455767140', 'Accounting', 'Digital', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('639815599', 'Physics', 'Digital', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('357504979', 'Accounting', 'Data Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('618010526', 'Physics', 'Digital', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('410147718', 'Computer Science'''' Software En', 'Society', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('620588483', 'Accounting', 'Data Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('149452198', 'Industrial& Management', 'Society', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('479324552', 'Pharmacy', 'Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('790588554', 'Accounting', 'Marketing', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('159118621', 'Computer Science'''' Software En', 'Society', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('526677103', 'Pharmacy', 'Society', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('498758946', 'Computer Science'''' Software En', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('918223584', 'Nursing', 'Management', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('106275449', 'Bioinformatics', 'Management', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('384408509', 'Accounting', 'Society', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('061574796', 'Physics', 'Society', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('935502278', 'Physics', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('517489912', 'Buisness Administration', 'Marketing', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('477448048', 'Pharmacy', 'Management', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('638398901', 'Physics', 'Society', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('444730036', 'Physics', 'Society', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('642412911', 'Nursing', 'Management', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('243805667', 'Mathematics', 'Management', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('480306624', 'Computer Science'''' Software En', 'Society', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('635994978', 'Physics', 'Marketing', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('195229946', 'Mathematics', 'Science', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('464632757', 'Buisness Administration', 'Management', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('073905523', 'Mathematics', 'Data Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('842004671', 'Mathematics', 'Digital', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('300819735', 'Bioinformatics', 'Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('887687675', 'Pharmacy', 'Marketing', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('430689171', 'Industrial& Management', 'Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('645799561', 'Bioinformatics', 'Data Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('398538802', 'Mathematics', 'Marketing', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('525337640', 'Bioinformatics', 'Digital', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('997406796', 'Industrial& Management', 'Science', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('506526392', 'Computer Science'''' Software En', 'Marketing', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('565197531', 'Pharmacy', 'Marketing', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('996761642', 'Industrial& Management', 'Society', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('075822022', 'Mathematics', 'Society', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('080919502', 'Physics', 'Management', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('534721757', 'Nursing', 'Society', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('899940033', 'Pharmacy', 'Marketing', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('945469928', 'Bioinformatics', 'Society', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('665841224', 'Computer Science'''' Software En', 'Society', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('535455980', 'Accounting', 'Data Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('134838990', 'Industrial& Management', 'Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('076523062', 'Industrial& Management', 'Marketing', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('109048083', 'Mathematics', 'Management', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('098298524', 'Nursing', 'Marketing', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('667566215', 'Buisness Administration', 'Management', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('197177391', 'Pharmacy', 'Science', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('673439814', 'Mathematics', 'Data Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('200459479', 'Accounting', 'Society', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('659628156', 'Accounting', 'Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('560738660', 'Buisness Administration', 'Digital', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('029730990', 'Bioinformatics', 'Society', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('281323926', 'Physics', 'Society', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('411570462', 'Industrial& Management', 'Digital', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('148531270', 'Mathematics', 'Management', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('622557491', 'Accounting', 'Society', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('904527504', 'Buisness Administration', 'Digital', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('318338979', 'Pharmacy', 'Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('271556211', 'Industrial& Management', 'Data Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('879371457', 'Nursing', 'Digital', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('940738490', 'Mathematics', 'Management', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('170680663', 'Buisness Administration', 'Data Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('980890703', 'Accounting', 'Management', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('531906195', 'Nursing', 'Management', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('160917246', 'Computer Science'''' Software En', 'Society', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('153812810', 'Buisness Administration', 'Management', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('382827869', 'Accounting', 'Data Science', 'Second', 1);
commit;
prompt 100 records committed...
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('196418290', 'Pharmacy', 'Society', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('667771144', 'Accounting', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('342115162', 'Nursing', 'Society', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('150770269', 'Mathematics', 'Digital', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('821858115', 'Physics', 'Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('069940406', 'Physics', 'Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('247309639', 'Accounting', 'Marketing', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('466848622', 'Buisness Administration', 'Management', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('385070236', 'Accounting', 'Management', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('327410662', 'Bioinformatics', 'Data Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('075221711', 'Pharmacy', 'Marketing', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('933776347', 'Computer Science'''' Software En', 'Data Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('439735279', 'Buisness Administration', 'Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('621113814', 'Accounting', 'Data Science', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('268935808', 'Bioinformatics', 'Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('611888673', 'Bioinformatics', 'Society', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('996074274', 'Industrial& Management', 'Society', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('337898494', 'Computer Science'''' Software En', 'Data Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('518407549', 'Nursing', 'Society', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('588756866', 'Nursing', 'Digital', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('151429611', 'Buisness Administration', 'Marketing', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('621488868', 'Pharmacy', 'Data Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('283795738', 'Mathematics', 'Management', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('216335951', 'Buisness Administration', 'Data Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('007512737', 'Industrial& Management', 'Data Science', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('324093947', 'Bioinformatics', 'Management', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('625635278', 'Buisness Administration', 'Marketing', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('834599722', 'Pharmacy', 'Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('149127476', 'Physics', 'Society', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('687836238', 'Physics', 'Marketing', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('615893503', 'Mathematics', 'Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('274694530', 'Buisness Administration', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('743489359', 'Mathematics', 'Management', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('747190598', 'Accounting', 'Digital', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('411594779', 'Nursing', 'Society', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('673576281', 'Mathematics', 'Digital', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('969340540', 'Computer Science'''' Software En', 'Management', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('714263066', 'Computer Science'''' Software En', 'Management', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('748167334', 'Bioinformatics', 'Management', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('479408037', 'Nursing', 'Marketing', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('790036557', 'Buisness Administration', 'Marketing', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('623387258', 'Pharmacy', 'Data Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('551786746', 'Physics', 'Management', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('184268549', 'Accounting', 'Marketing', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('199405399', 'Industrial& Management', 'Data Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('130693139', 'Buisness Administration', 'Management', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('841773511', 'Buisness Administration', 'Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('595223184', 'Pharmacy', 'Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('165369761', 'Buisness Administration', 'Science', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('583595623', 'Computer Science'''' Software En', 'Society', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('076120624', 'Pharmacy', 'Management', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('223772181', 'Buisness Administration', 'Marketing', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('661703086', 'Industrial& Management', 'Society', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('056435471', 'Accounting', 'Society', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('620604622', 'Mathematics', 'Digital', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('834206696', 'Mathematics', 'Marketing', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('788298397', 'Nursing', 'Marketing', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('569794322', 'Industrial& Management', 'Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('063960310', 'Nursing', 'Marketing', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('290013511', 'Industrial& Management', 'Society', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('464785866', 'Pharmacy', 'Data Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('827886021', 'Nursing', 'Marketing', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('403148912', 'Bioinformatics', 'Society', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('698707624', 'Pharmacy', 'Science', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('953522249', 'Pharmacy', 'Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('973979390', 'Nursing', 'Society', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('027014178', 'Nursing', 'Science', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('990877877', 'Nursing', 'Marketing', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('463467765', 'Bioinformatics', 'Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('548299749', 'Physics', 'Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('780010323', 'Industrial& Management', 'Data Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('806642896', 'Pharmacy', 'Data Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('679344850', 'Computer Science'''' Software En', 'Management', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('698127957', 'Industrial& Management', 'Society', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('703408099', 'Nursing', 'Society', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('391849146', 'Pharmacy', 'Marketing', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('452442345', 'Accounting', 'Society', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('574827120', 'Pharmacy', 'Digital', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('224748637', 'Physics', 'Data Science', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('502997791', 'Industrial& Management', 'Marketing', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('515795787', 'Pharmacy', 'Digital', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('045378251', 'Nursing', 'Management', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('355430094', 'Pharmacy', 'Society', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('732968533', 'Industrial& Management', 'Data Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('082304384', 'Buisness Administration', 'Data Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('472096633', 'Industrial& Management', 'Digital', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('815695186', 'Industrial& Management', 'Data Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('210316218', 'Accounting', 'Marketing', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('611371673', 'Pharmacy', 'Marketing', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('273251555', 'Physics', 'Data Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('004906430', 'Accounting', 'Marketing', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('855081684', 'Computer Science'''' Software En', 'Data Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('192138708', 'Mathematics', 'Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('288118097', 'Industrial& Management', 'Marketing', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('763037057', 'Mathematics', 'Management', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('012274454', 'Industrial& Management', 'Management', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('297112351', 'Industrial& Management', 'Marketing', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('425902005', 'Physics', 'Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('917297719', 'Buisness Administration', 'Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('213894686', 'Computer Science'''' Software En', 'Science', 'Second', 2);
commit;
prompt 200 records committed...
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('394972123', 'Pharmacy', 'Marketing', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('279497005', 'Industrial& Management', 'Digital', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('219044533', 'Computer Science'''' Software En', 'Management', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('217182827', 'Industrial& Management', 'Data Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('709007510', 'Bioinformatics', 'Marketing', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('504517223', 'Physics', 'Marketing', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('854473983', 'Buisness Administration', 'Science', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('794475379', 'Nursing', 'Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('415502473', 'Computer Science'''' Software En', 'Management', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('926840103', 'Nursing', 'Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('025074272', 'Mathematics', 'Marketing', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('812788391', 'Physics', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('393725381', 'Industrial& Management', 'Management', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('188731408', 'Bioinformatics', 'Digital', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('228343553', 'Accounting', 'Society', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('084468342', 'Physics', 'Management', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('147156914', 'Buisness Administration', 'Marketing', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('612709460', 'Nursing', 'Data Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('276682064', 'Accounting', 'Society', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('464483832', 'Pharmacy', 'Management', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('393616037', 'Computer Science'''' Software En', 'Digital', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('521767158', 'Mathematics', 'Data Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('935958243', 'Physics', 'Data Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('099250802', 'Pharmacy', 'Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('086527199', 'Accounting', 'Marketing', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('199703903', 'Nursing', 'Management', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('950569391', 'Industrial& Management', 'Society', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('634034918', 'Physics', 'Data Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('573661345', 'Industrial& Management', 'Digital', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('514307370', 'Industrial& Management', 'Management', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('644070925', 'Mathematics', 'Society', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('903923630', 'Nursing', 'Society', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('631121934', 'Buisness Administration', 'Data Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('725092846', 'Bioinformatics', 'Science', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('889098342', 'Accounting', 'Management', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('087031799', 'Bioinformatics', 'Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('981319115', 'Mathematics', 'Data Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('565846884', 'Mathematics', 'Management', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('369626971', 'Computer Science'''' Software En', 'Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('298487735', 'Buisness Administration', 'Digital', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('851500278', 'Bioinformatics', 'Digital', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('833027699', 'Computer Science'''' Software En', 'Management', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('655364444', 'Buisness Administration', 'Management', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('585906154', 'Accounting', 'Marketing', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('352211303', 'Accounting', 'Society', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('489662104', 'Bioinformatics', 'Digital', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('186405883', 'Bioinformatics', 'Society', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('694503220', 'Buisness Administration', 'Society', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('299989503', 'Computer Science'''' Software En', 'Data Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('651947299', 'Pharmacy', 'Digital', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('567583608', 'Mathematics', 'Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('947040620', 'Physics', 'Digital', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('124283722', 'Computer Science'''' Software En', 'Marketing', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('406417696', 'Bioinformatics', 'Marketing', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('116838814', 'Physics', 'Marketing', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('211147665', 'Nursing', 'Society', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('866575337', 'Bioinformatics', 'Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('427381821', 'Industrial& Management', 'Management', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('358343310', 'Mathematics', 'Marketing', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('613927468', 'Buisness Administration', 'Marketing', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('575963977', 'Computer Science'''' Software En', 'Digital', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('240903488', 'Industrial& Management', 'Society', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('357843875', 'Industrial& Management', 'Society', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('721280923', 'Bioinformatics', 'Management', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('391319643', 'Computer Science'''' Software En', 'Management', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('192961199', 'Bioinformatics', 'Digital', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('665873922', 'Accounting', 'Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('936052547', 'Nursing', 'Society', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('895445973', 'Accounting', 'Data Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('960467698', 'Industrial& Management', 'Data Science', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('790369237', 'Mathematics', 'Data Science', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('417953620', 'Pharmacy', 'Digital', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('958603102', 'Accounting', 'Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('110547820', 'Industrial& Management', 'Digital', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('612807614', 'Accounting', 'Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('223300085', 'Bioinformatics', 'Management', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('597804245', 'Industrial& Management', 'Marketing', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('973222580', 'Accounting', 'Marketing', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('840598865', 'Bioinformatics', 'Marketing', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('227672371', 'Bioinformatics', 'Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('173957645', 'Accounting', 'Marketing', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('744338036', 'Buisness Administration', 'Data Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('827899701', 'Computer Science'''' Software En', 'Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('048832448', 'Buisness Administration', 'Society', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('758046387', 'Pharmacy', 'Society', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('614414921', 'Nursing', 'Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('246058901', 'Bioinformatics', 'Society', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('486372121', 'Nursing', 'Society', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('983855120', 'Mathematics', 'Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('530541326', 'Mathematics', 'Management', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('298902634', 'Physics', 'Society', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('727358635', 'Buisness Administration', 'Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('143521723', 'Bioinformatics', 'Data Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('467508572', 'Pharmacy', 'Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('519194876', 'Computer Science'''' Software En', 'Data Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('365375377', 'Computer Science'''' Software En', 'Society', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('504247184', 'Physics', 'Society', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('615443912', 'Accounting', 'Marketing', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('720562049', 'Nursing', 'Data Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('157524610', 'Physics', 'Management', 'Third', 2);
commit;
prompt 300 records committed...
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('508469586', 'Industrial& Management', 'Society', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('528755041', 'Bioinformatics', 'Society', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('857622098', 'Pharmacy', 'Data Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('663990879', 'Buisness Administration', 'Marketing', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('663947507', 'Bioinformatics', 'Management', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('458840206', 'Mathematics', 'Digital', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('114676727', 'Accounting', 'Digital', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('770417526', 'Buisness Administration', 'Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('659842684', 'Physics', 'Society', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('133509328', 'Computer Science'''' Software En', 'Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('482917837', 'Buisness Administration', 'Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('501327543', 'Pharmacy', 'Data Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('147507174', 'Accounting', 'Digital', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('104740246', 'Industrial& Management', 'Science', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('511659200', 'Nursing', 'Data Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('738676792', 'Nursing', 'Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('786489205', 'Buisness Administration', 'Society', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('218880693', 'Accounting', 'Digital', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('966562021', 'Physics', 'Management', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('397266455', 'Physics', 'Data Science', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('384579634', 'Mathematics', 'Management', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('723701036', 'Physics', 'Data Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('773375621', 'Nursing', 'Marketing', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('907606113', 'Physics', 'Data Science', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('317747981', 'Pharmacy', 'Marketing', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('371917778', 'Bioinformatics', 'Data Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('981592628', 'Accounting', 'Management', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('564031775', 'Accounting', 'Data Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('147405116', 'Pharmacy', 'Data Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('032072639', 'Nursing', 'Data Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('031397669', 'Computer Science'''' Software En', 'Data Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('497595275', 'Bioinformatics', 'Data Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('284203983', 'Pharmacy', 'Digital', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('434530964', 'Mathematics', 'Data Science', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('095492426', 'Buisness Administration', 'Management', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('720995445', 'Industrial& Management', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('379440420', 'Buisness Administration', 'Digital', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('284244788', 'Nursing', 'Society', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('836968698', 'Pharmacy', 'Society', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('745164844', 'Computer Science'''' Software En', 'Digital', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('886549088', 'Bioinformatics', 'Data Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('037411330', 'Buisness Administration', 'Data Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('724349050', 'Pharmacy', 'Data Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('607414468', 'Buisness Administration', 'Marketing', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('355409884', 'Bioinformatics', 'Marketing', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('643603834', 'Industrial& Management', 'Data Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('323980079', 'Industrial& Management', 'Society', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('963632769', 'Computer Science'''' Software En', 'Science', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('795610917', 'Computer Science'''' Software En', 'Data Science', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('907684160', 'Physics', 'Marketing', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('787508950', 'Bioinformatics', 'Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('381313716', 'Accounting', 'Society', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('080600263', 'Pharmacy', 'Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('137837782', 'Buisness Administration', 'Digital', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('497464838', 'Mathematics', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('332094665', 'Mathematics', 'Digital', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('725066790', 'Nursing', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('675491874', 'Industrial& Management', 'Marketing', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('324670635', 'Bioinformatics', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('384052743', 'Computer Science'''' Software En', 'Management', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('327491347', 'Accounting', 'Marketing', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('266005313', 'Industrial& Management', 'Digital', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('627506555', 'Accounting', 'Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('182777831', 'Nursing', 'Society', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('446427784', 'Nursing', 'Digital', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('900541542', 'Buisness Administration', 'Digital', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('683358168', 'Computer Science'''' Software En', 'Data Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('852111607', 'Physics', 'Management', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('400785535', 'Bioinformatics', 'Marketing', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('661465823', 'Computer Science'''' Software En', 'Data Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('463345351', 'Buisness Administration', 'Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('812267552', 'Nursing', 'Data Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('886303132', 'Mathematics', 'Marketing', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('644370307', 'Pharmacy', 'Digital', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('051975805', 'Nursing', 'Society', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('546243023', 'Computer Science'''' Software En', 'Digital', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('624364726', 'Buisness Administration', 'Marketing', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('714922037', 'Pharmacy', 'Data Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('919285820', 'Physics', 'Digital', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('711212086', 'Accounting', 'Digital', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('974043532', 'Industrial& Management', 'Society', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('795057209', 'Bioinformatics', 'Management', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('388481104', 'Accounting', 'Management', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('440530099', 'Buisness Administration', 'Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('989584881', 'Computer Science'''' Software En', 'Marketing', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('236453871', 'Mathematics', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('925229120', 'Buisness Administration', 'Digital', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('489782650', 'Buisness Administration', 'Data Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('480084289', 'Buisness Administration', 'Society', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('307217082', 'Bioinformatics', 'Society', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('833947923', 'Computer Science'''' Software En', 'Data Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('171356889', 'Physics', 'Science', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('324372729', 'Mathematics', 'Digital', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('026207879', 'Mathematics', 'Society', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('509314529', 'Bioinformatics', 'Digital', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('339187073', 'Buisness Administration', 'Management', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('744235579', 'Pharmacy', 'Data Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('821330468', 'Mathematics', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('629399441', 'Physics', 'Management', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('433928010', 'Nursing', 'Society', 'First', 1);
commit;
prompt 400 records committed...
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('475698681', 'Accounting', 'Data Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('443347647', 'Bioinformatics', 'Society', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('213893445', 'Physics', 'Data Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('209740540', 'Bioinformatics', 'Society', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('862493074', 'Physics', 'Society', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('067632957', 'Mathematics', 'Society', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('509608552', 'Physics', 'Management', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('200465126', 'Bioinformatics', 'Data Science', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('670168461', 'Accounting', 'Digital', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('952053970', 'Bioinformatics', 'Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('930453297', 'Mathematics', 'Management', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('478422514', 'Pharmacy', 'Management', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('488648450', 'Physics', 'Data Science', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('093669743', 'Bioinformatics', 'Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('906853859', 'Physics', 'Management', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('608404078', 'Physics', 'Digital', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('969186817', 'Accounting', 'Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('440844331', 'Physics', 'Marketing', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('749577354', 'Bioinformatics', 'Data Science', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('730141201', 'Computer Science'''' Software En', 'Management', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('006693782', 'Physics', 'Management', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('251428315', 'Industrial& Management', 'Management', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('656439597', 'Computer Science'''' Software En', 'Management', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('191066947', 'Accounting', 'Data Science', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('926782462', 'Buisness Administration', 'Data Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('502963692', 'Industrial& Management', 'Management', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('286233229', 'Mathematics', 'Digital', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('707459082', 'Physics', 'Data Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('247448038', 'Pharmacy', 'Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('453308575', 'Pharmacy', 'Digital', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('156260996', 'Mathematics', 'Society', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('254078022', 'Physics', 'Marketing', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('829545163', 'Bioinformatics', 'Society', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('891759770', 'Pharmacy', 'Society', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('236777172', 'Accounting', 'Science', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('770687076', 'Industrial& Management', 'Data Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('519147121', 'Pharmacy', 'Marketing', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('543915297', 'Accounting', 'Society', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('150230428', 'Buisness Administration', 'Marketing', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('174744730', 'Physics', 'Management', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('027412300', 'Computer Science'''' Software En', 'Society', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('301398056', 'Mathematics', 'Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('534714313', 'Accounting', 'Society', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('656862167', 'Physics', 'Digital', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('641303940', 'Physics', 'Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('260611584', 'Accounting', 'Society', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('688833787', 'Industrial& Management', 'Marketing', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('477886791', 'Physics', 'Digital', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('224737242', 'Physics', 'Management', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('552694767', 'Mathematics', 'Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('117037843', 'Computer Science'''' Software En', 'Marketing', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('023086883', 'Buisness Administration', 'Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('777459507', 'Computer Science'''' Software En', 'Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('559550314', 'Nursing', 'Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('461142699', 'Pharmacy', 'Management', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('610482447', 'Computer Science'''' Software En', 'Digital', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('543374736', 'Accounting', 'Management', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('639510792', 'Mathematics', 'Management', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('316789085', 'Pharmacy', 'Data Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('453426639', 'Pharmacy', 'Marketing', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('502583978', 'Industrial& Management', 'Management', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('898550992', 'Pharmacy', 'Data Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('180292679', 'Pharmacy', 'Marketing', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('931627255', 'Bioinformatics', 'Marketing', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('042465046', 'Industrial& Management', 'Management', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('735305467', 'Physics', 'Society', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('132108706', 'Buisness Administration', 'Marketing', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('512510592', 'Computer Science'''' Software En', 'Management', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('528569441', 'Physics', 'Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('367749833', 'Buisness Administration', 'Science', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('151178492', 'Mathematics', 'Data Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('698651065', 'Bioinformatics', 'Digital', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('865717044', 'Bioinformatics', 'Data Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('822236171', 'Buisness Administration', 'Digital', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('260653353', 'Computer Science'''' Software En', 'Marketing', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('651589499', 'Computer Science'''' Software En', 'Society', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('757839176', 'Buisness Administration', 'Society', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('419412673', 'Industrial& Management', 'Management', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('832355942', 'Bioinformatics', 'Marketing', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('683571677', 'Nursing', 'Digital', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('269697309', 'Accounting', 'Society', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('408888854', 'Nursing', 'Data Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('346776193', 'Computer Science'''' Software En', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('524153631', 'Pharmacy', 'Marketing', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('648819071', 'Mathematics', 'Marketing', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('028322021', 'Computer Science'''' Software En', 'Digital', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('562372864', 'Bioinformatics', 'Data Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('264923710', 'Pharmacy', 'Management', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('024625118', 'Mathematics', 'Data Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('873702346', 'Mathematics', 'Digital', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('593306730', 'Computer Science'''' Software En', 'Marketing', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('289873378', 'Physics', 'Marketing', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('191357082', 'Industrial& Management', 'Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('971348382', 'Computer Science'''' Software En', 'Data Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('420064308', 'Mathematics', 'Society', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('945565666', 'Mathematics', 'Marketing', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('282540294', 'Mathematics', 'Data Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('287532568', 'Bioinformatics', 'Management', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('223016999', 'Bioinformatics', 'Data Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('605842621', 'Physics', 'Digital', 'First', 2);
commit;
prompt 500 records committed...
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('975552389', 'Industrial& Management', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('377352170', 'Computer Science'''' Software En', 'Society', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('664083292', 'Computer Science'''' Software En', 'Digital', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('927870487', 'Pharmacy', 'Digital', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('136598863', 'Pharmacy', 'Marketing', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('572801217', 'Computer Science'''' Software En', 'Management', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('646469451', 'Buisness Administration', 'Digital', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('875497213', 'Pharmacy', 'Society', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('403521342', 'Physics', 'Digital', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('899265968', 'Bioinformatics', 'Digital', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('285984423', 'Buisness Administration', 'Data Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('190035391', 'Computer Science'''' Software En', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('975711422', 'Mathematics', 'Society', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('473969383', 'Mathematics', 'Society', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('269434965', 'Bioinformatics', 'Society', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('164786196', 'Pharmacy', 'Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('084234052', 'Mathematics', 'Management', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('548965002', 'Bioinformatics', 'Data Science', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('060462427', 'Mathematics', 'Management', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('126469700', 'Nursing', 'Marketing', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('902791479', 'Industrial& Management', 'Management', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('050600329', 'Pharmacy', 'Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('310934517', 'Bioinformatics', 'Data Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('310389966', 'Nursing', 'Data Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('532337622', 'Accounting', 'Society', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('184062892', 'Pharmacy', 'Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('816004359', 'Pharmacy', 'Management', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('765559371', 'Pharmacy', 'Data Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('720209228', 'Nursing', 'Data Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('960238264', 'Industrial& Management', 'Digital', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('861103587', 'Nursing', 'Digital', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('458746323', 'Buisness Administration', 'Society', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('249539434', 'Industrial& Management', 'Society', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('755315777', 'Bioinformatics', 'Management', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('930668756', 'Buisness Administration', 'Data Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('871481613', 'Accounting', 'Digital', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('544446385', 'Computer Science'''' Software En', 'Management', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('857965487', 'Computer Science'''' Software En', 'Digital', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('483153155', 'Mathematics', 'Marketing', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('019902928', 'Bioinformatics', 'Digital', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('961930704', 'Nursing', 'Data Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('250572626', 'Accounting', 'Society', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('765973770', 'Computer Science'''' Software En', 'Society', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('399332060', 'Buisness Administration', 'Society', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('760537710', 'Industrial& Management', 'Digital', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('565364283', 'Physics', 'Digital', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('321960313', 'Accounting', 'Management', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('295549360', 'Computer Science'''' Software En', 'Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('287156862', 'Mathematics', 'Management', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('718251978', 'Physics', 'Society', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('683929577', 'Computer Science'''' Software En', 'Digital', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('678903034', 'Industrial& Management', 'Marketing', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('027143835', 'Industrial& Management', 'Management', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('677046121', 'Physics', 'Marketing', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('444170362', 'Industrial& Management', 'Management', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('118479329', 'Buisness Administration', 'Digital', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('598047701', 'Nursing', 'Society', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('882265199', 'Industrial& Management', 'Marketing', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('671206453', 'Buisness Administration', 'Digital', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('247271599', 'Pharmacy', 'Society', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('645709945', 'Industrial& Management', 'Digital', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('401501930', 'Pharmacy', 'Digital', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('696974778', 'Bioinformatics', 'Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('119524327', 'Nursing', 'Society', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('229102150', 'Pharmacy', 'Data Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('436373857', 'Physics', 'Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('081252347', 'Bioinformatics', 'Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('257285772', 'Bioinformatics', 'Digital', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('483114131', 'Industrial& Management', 'Data Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('721160937', 'Mathematics', 'Digital', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('760435488', 'Industrial& Management', 'Society', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('239507368', 'Physics', 'Data Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('584256948', 'Mathematics', 'Marketing', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('041914476', 'Industrial& Management', 'Management', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('491316712', 'Buisness Administration', 'Management', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('977103240', 'Buisness Administration', 'Science', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('916561673', 'Industrial& Management', 'Marketing', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('564903590', 'Industrial& Management', 'Marketing', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('968941795', 'Accounting', 'Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('116197929', 'Physics', 'Digital', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('362289581', 'Bioinformatics', 'Digital', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('663812521', 'Buisness Administration', 'Marketing', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('344917247', 'Computer Science'''' Software En', 'Society', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('569918993', 'Industrial& Management', 'Digital', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('715006691', 'Pharmacy', 'Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('543310124', 'Nursing', 'Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('250435829', 'Physics', 'Management', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('764561139', 'Buisness Administration', 'Digital', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('460735104', 'Buisness Administration', 'Digital', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('445284626', 'Nursing', 'Digital', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('907425713', 'Physics', 'Management', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('991199704', 'Industrial& Management', 'Management', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('442012123', 'Mathematics', 'Science', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('274714968', 'Nursing', 'Data Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('440131422', 'Industrial& Management', 'Marketing', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('766935118', 'Bioinformatics', 'Marketing', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('550860622', 'Nursing', 'Digital', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('871996624', 'Physics', 'Marketing', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('859829661', 'Buisness Administration', 'Digital', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('326919516', 'Pharmacy', 'Marketing', 'Second', 0);
commit;
prompt 600 records committed...
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('715905858', 'Accounting', 'Management', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('664304473', 'Pharmacy', 'Marketing', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('269614945', 'Physics', 'Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('254024299', 'Accounting', 'Management', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('095973102', 'Industrial& Management', 'Management', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('140958809', 'Mathematics', 'Society', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('818974714', 'Buisness Administration', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('597758983', 'Computer Science'''' Software En', 'Science', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('003153221', 'Pharmacy', 'Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('939195930', 'Physics', 'Data Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('574906002', 'Industrial& Management', 'Society', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('070539559', 'Nursing', 'Society', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('516502505', 'Buisness Administration', 'Digital', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('481753265', 'Nursing', 'Data Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('402251764', 'Industrial& Management', 'Society', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('696669891', 'Buisness Administration', 'Data Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('493829613', 'Pharmacy', 'Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('690727298', 'Industrial& Management', 'Society', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('758515404', 'Bioinformatics', 'Marketing', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('046127582', 'Computer Science'''' Software En', 'Society', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('335873962', 'Pharmacy', 'Digital', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('333963799', 'Buisness Administration', 'Science', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('043950220', 'Bioinformatics', 'Marketing', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('757548870', 'Pharmacy', 'Digital', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('356673486', 'Accounting', 'Marketing', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('489538253', 'Buisness Administration', 'Digital', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('732405586', 'Industrial& Management', 'Data Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('190554025', 'Industrial& Management', 'Digital', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('109850885', 'Bioinformatics', 'Marketing', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('587179576', 'Buisness Administration', 'Management', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('375063029', 'Industrial& Management', 'Marketing', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('699703532', 'Accounting', 'Data Science', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('615564911', 'Buisness Administration', 'Marketing', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('949455945', 'Computer Science'''' Software En', 'Digital', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('024173901', 'Buisness Administration', 'Management', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('868402996', 'Buisness Administration', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('969438125', 'Nursing', 'Marketing', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('426920654', 'Accounting', 'Digital', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('728551733', 'Bioinformatics', 'Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('643824218', 'Mathematics', 'Data Science', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('995674958', 'Computer Science'''' Software En', 'Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('391227654', 'Pharmacy', 'Marketing', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('764003897', 'Bioinformatics', 'Marketing', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('053367108', 'Physics', 'Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('003635131', 'Accounting', 'Management', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('985567879', 'Accounting', 'Society', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('464137067', 'Industrial& Management', 'Data Science', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('383765919', 'Buisness Administration', 'Society', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('930087656', 'Physics', 'Digital', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('039815841', 'Accounting', 'Data Science', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('154630375', 'Physics', 'Science', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('959292420', 'Accounting', 'Marketing', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('887078899', 'Mathematics', 'Data Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('361356344', 'Accounting', 'Data Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('230719677', 'Mathematics', 'Science', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('780209218', 'Computer Science'''' Software En', 'Management', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('857695845', 'Buisness Administration', 'Society', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('738360690', 'Physics', 'Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('112865612', 'Mathematics', 'Science', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('783504458', 'Physics', 'Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('714254666', 'Physics', 'Society', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('300453882', 'Bioinformatics', 'Science', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('250478302', 'Mathematics', 'Digital', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('426999514', 'Mathematics', 'Digital', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('086023700', 'Physics', 'Data Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('331439121', 'Mathematics', 'Data Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('365033071', 'Physics', 'Management', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('907620344', 'Physics', 'Data Science', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('261891327', 'Mathematics', 'Society', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('308888572', 'Buisness Administration', 'Management', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('279052241', 'Computer Science'''' Software En', 'Digital', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('412307841', 'Bioinformatics', 'Digital', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('006737707', 'Pharmacy', 'Management', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('280527107', 'Computer Science'''' Software En', 'Society', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('549552694', 'Accounting', 'Data Science', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('303981782', 'Pharmacy', 'Data Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('550609298', 'Computer Science'''' Software En', 'Society', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('924132261', 'Nursing', 'Marketing', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('442557888', 'Physics', 'Marketing', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('890982672', 'Buisness Administration', 'Data Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('339562961', 'Computer Science'''' Software En', 'Digital', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('732303788', 'Buisness Administration', 'Data Science', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('866068038', 'Industrial& Management', 'Digital', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('458122429', 'Computer Science'''' Software En', 'Digital', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('934529741', 'Physics', 'Management', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('739566112', 'Physics', 'Science', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('592142766', 'Accounting', 'Society', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('689366514', 'Computer Science'''' Software En', 'Marketing', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('012522084', 'Bioinformatics', 'Marketing', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('779136162', 'Buisness Administration', 'Marketing', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('003430094', 'Buisness Administration', 'Data Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('206395580', 'Mathematics', 'Digital', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('293406403', 'Pharmacy', 'Digital', 'First', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('862540003', 'Physics', 'Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('866839298', 'Physics', 'Society', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('057602263', 'Buisness Administration', 'Society', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('289419199', 'Physics', 'Management', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('378564581', 'Physics', 'Management', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('279473695', 'Nursing', 'Marketing', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('599141121', 'Buisness Administration', 'Science', 'First', 2);
commit;
prompt 700 records committed...
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('244133162', 'Accounting', 'Management', 'First', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('575202130', 'Industrial& Management', 'Marketing', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('491058748', 'Nursing', 'Digital', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('151496654', 'Computer Science'''' Software En', 'Management', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('558736817', 'Nursing', 'Science', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('708131112', 'Buisness Administration', 'Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('686338264', 'Accounting', 'Marketing', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('702377149', 'Industrial& Management', 'Data Science', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('177869151', 'Accounting', 'Society', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('535848785', 'Pharmacy', 'Digital', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('641809487', 'Physics', 'Society', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('921230029', 'Bioinformatics', 'Science', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('447452331', 'Buisness Administration', 'Science', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('025103331', 'Computer Science'''' Software En', 'Science', 'Second', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('723875710', 'Bioinformatics', 'Data Science', 'Fourth', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('367651164', 'Pharmacy', 'Marketing', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('385214883', 'Mathematics', 'Marketing', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('450557181', 'Pharmacy', 'Digital', 'Third', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('225666790', 'Nursing', 'Digital', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('980950912', 'Nursing', 'Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('499772461', 'Accounting', 'Science', 'Third', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('933278843', 'Buisness Administration', 'Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('268945379', 'Buisness Administration', 'Marketing', 'Second', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('887590903', 'Mathematics', 'Digital', 'First', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('978413263', 'Industrial& Management', 'Marketing', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('819332196', 'Accounting', 'Data Science', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('874759263', 'Mathematics', 'Data Science', 'Second', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('548099649', 'Pharmacy', 'Science', 'Third', 2);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('613671695', 'Buisness Administration', 'Data Science', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('357683157', 'Accounting', 'Marketing', 'Fourth', 1);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('000252841', 'Physics', 'Society', 'Fourth', 0);
insert into STUDENT (spersonid, sdegree, specialization, academicyear, workexperience)
values ('327978571', 'Mathematics', 'Data Science', 'Second', 2);
commit;
prompt 732 records loaded
prompt Loading CONSULTING...
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (1, '899940033', '244557811', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (2, '714263066', '987545711', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (3, '974043532', '232567788', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (4, '575581959', '803409847', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (5, '979621779', '398086315', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (6, '489538253', '442303438', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (7, '022645109', '920937386', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (8, '936645107', '819385868', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (9, '550609298', '263668514', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (10, '980950912', '807478919', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (11, '105837988', '887590903', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (12, '918223584', '548965002', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (13, '936645107', '698707624', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (14, '357504979', '812267552', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (15, '427381821', '190035391', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (16, '979621779', '207578934', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (17, '974043532', '137837782', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (18, '975711422', '151496654', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (19, '489538253', '822236171', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (20, '975711422', '900541542', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (21, '723701036', '081252347', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (22, '866575337', '930453297', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (23, '458746323', '190035391', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (24, '491058748', '118479329', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (25, '899940033', '940738490', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (26, '489538253', '790036557', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (27, '760435488', '504247184', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (28, '324670635', '857622098', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (29, '974043532', '686338264', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (30, '550609298', '170680663', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (31, '477448048', '498758946', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (32, '552694767', '180292679', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (33, '410147718', '173957645', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (34, '866575337', '290013511', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (35, '723701036', '160917246', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (36, '714263066', '007512737', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (37, '554788594', '031397669', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (38, '866575337', '739566112', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (39, '477448048', '023086883', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (40, '975711422', '724349050', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (41, '357504979', '342115162', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (42, '945469928', '472096633', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (43, '552694767', '504517223', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (44, '105837988', '151178492', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (45, '477448048', '398086315', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (46, '477448048', '803409847', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (47, '357504979', '973222580', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (48, '411594779', '524153631', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (49, '489538253', '110547820', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (50, '918223584', '975552389', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (51, '227942129', '886549088', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (52, '975711422', '213893445', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (53, '979621779', '095973102', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (54, '974043532', '019902928', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (55, '839161222', '114676727', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (56, '458746323', '335873962', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (57, '615443912', '935958243', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (58, '760435488', '149452198', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (59, '783907365', '961930704', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (60, '489538253', '391849146', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (61, '491058748', '377352170', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (62, '575581959', '755315777', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (63, '615443912', '550860622', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (64, '866575337', '197177391', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (65, '324670635', '375063029', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (66, '615443912', '933278843', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (67, '974043532', '890982672', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (68, '974043532', '106275449', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (69, '783907365', '446427784', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (70, '022645109', '247309639', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (71, '410147718', '024625118', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (72, '899940033', '298902634', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (73, '945469928', '765973770', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (74, '899940033', '157524610', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (75, '783907365', '300453882', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (76, '108498144', '890982672', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (77, '723701036', '479324552', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (78, '879371457', '213893445', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (79, '357504979', '529585640', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (80, '615443912', '159118621', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (81, '918223584', '611371673', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (82, '196418290', '184062892', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (83, '611888673', '247448038', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (84, '866575337', '575963977', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (85, '411594779', '567583608', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (86, '980950912', '223016999', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (87, '889130597', '651947299', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (88, '491058748', '357843875', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (89, '611888673', '206395580', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (90, '979621779', '147405116', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (91, '975711422', '225666790', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (92, '623774957', '207265713', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (93, '975711422', '815695186', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (94, '411594779', '482917837', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (95, '411594779', '402459198', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (96, '611888673', '739566112', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (97, '889130597', '738360690', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (98, '427381821', '861103587', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (99, '575581959', '223772181', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (100, '889130597', '842004671', '12:00 - 15:00', 'consult@gmail.com');
commit;
prompt 100 records committed...
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (101, '714263066', '247271599', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (102, '108498144', '981319115', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (103, '760435488', '199703903', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (104, '890982672', '453308575', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (105, '945469928', '615443912', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (106, '918223584', '930668756', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (107, '489538253', '621488868', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (108, '489538253', '011345266', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (109, '550609298', '728551733', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (110, '427381821', '344917247', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (111, '105837988', '887687675', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (112, '879371457', '624364726', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (113, '623774957', '963632769', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (114, '918223584', '548099649', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (115, '879371457', '391849146', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (116, '866575337', '273251555', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (117, '975711422', '355430094', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (118, '783907365', '875497213', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (119, '477448048', '903923630', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (120, '575581959', '779136162', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (121, '890982672', '926840103', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (122, '575581959', '667566215', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (123, '899940033', '747190598', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (124, '410147718', '408888854', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (125, '458746323', '861103587', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (126, '511659200', '646469451', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (127, '411594779', '025074272', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (128, '783907365', '573661345', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (129, '108498144', '613671695', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (130, '108498144', '973222580', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (131, '615443912', '572801217', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (132, '623774957', '458840206', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (133, '889130597', '188731408', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (134, '615443912', '444730036', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (135, '575581959', '491058748', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (136, '890982672', '857965487', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (137, '427381821', '134838990', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (138, '324670635', '728551733', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (139, '879371457', '069940406', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (140, '427381821', '615443912', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (141, '410147718', '000252841', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (142, '552694767', '639815599', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (143, '714263066', '046127582', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (144, '936645107', '667771144', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (145, '611888673', '406417696', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (146, '489538253', '112865612', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (147, '410147718', '871481613', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (148, '550609298', '339562961', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (149, '866575337', '159118621', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (150, '667566215', '463467765', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (151, '196418290', '812788391', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (152, '667566215', '355409884', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (153, '575581959', '464483832', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (154, '491058748', '718251978', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (155, '714263066', '207578934', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (156, '879371457', '218880693', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (157, '974043532', '271556211', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (158, '623774957', '696974778', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (159, '477448048', '463467765', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (160, '411594779', '287532568', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (161, '357504979', '229102150', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (162, '410147718', '190035391', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (163, '554788594', '552694767', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (164, '839161222', '043950220', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (165, '879371457', '006693782', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (166, '105837988', '987545711', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (167, '552694767', '023086883', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (168, '889130597', '211147665', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (169, '980950912', '509608552', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (170, '945469928', '501327543', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (171, '410147718', '099250802', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (172, '458746323', '886549088', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (173, '623774957', '981319115', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (174, '022645109', '528569441', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (175, '760435488', '025103331', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (176, '890982672', '934529741', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (177, '879371457', '227672371', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (178, '760435488', '639815599', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (179, '324670635', '249539434', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (180, '324670635', '969340540', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (181, '108498144', '718251978', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (182, '552694767', '337898494', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (183, '975711422', '458122429', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (184, '714263066', '607414468', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (185, '667566215', '073905523', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (186, '889130597', '195229946', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (187, '623774957', '960238264', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (188, '723701036', '690727298', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (189, '550609298', '749577354', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (190, '554788594', '042465046', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (191, '427381821', '714922037', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (192, '022645109', '489782650', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (193, '196418290', '780209218', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (194, '890982672', '326919516', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (195, '611888673', '659628156', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (196, '760435488', '732303788', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (197, '196418290', '543374736', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (198, '511659200', '037411330', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (199, '511659200', '728551733', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (200, '714263066', '081252347', '16:00 - 19:00', 'mainoffice@gmail.com');
commit;
prompt 200 records committed...
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (201, '411594779', '149452198', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (202, '477448048', '095492426', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (203, '980950912', '257285772', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (204, '899940033', '939195930', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (205, '105837988', '480306624', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (206, '760435488', '400785535', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (207, '979621779', '841773511', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (208, '575581959', '029730990', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (209, '491058748', '642412911', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (210, '105837988', '159118621', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (211, '945469928', '969340540', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (212, '550609298', '317747981', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (213, '623774957', '924132261', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (214, '936645107', '895445973', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (215, '783907365', '788298397', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (216, '575581959', '279497005', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (217, '357504979', '989584881', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (218, '975711422', '861103587', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (219, '022645109', '613927468', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (220, '411594779', '116838814', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (221, '477448048', '216335951', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (222, '879371457', '027412300', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (223, '974043532', '866839298', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (224, '105837988', '871996624', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (225, '936645107', '656862167', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (226, '022645109', '358343310', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (227, '980950912', '436373857', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (228, '899940033', '732303788', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (229, '491058748', '551786746', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (230, '324670635', '971348382', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (231, '108498144', '715905858', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (232, '427381821', '190554025', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (233, '975711422', '219044533', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (234, '611888673', '391227654', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (235, '554788594', '051975805', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (236, '491058748', '939195930', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (237, '410147718', '279052241', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (238, '105837988', '610482447', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (239, '552694767', '543374736', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (240, '899940033', '611371673', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (241, '491058748', '023086883', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (242, '783907365', '450557181', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (243, '879371457', '608404078', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (244, '714263066', '499772461', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (245, '866575337', '463467765', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (246, '723701036', '543374736', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (247, '108498144', '921230029', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (248, '324670635', '952053970', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (249, '489538253', '519194876', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (250, '980950912', '715006691', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (251, '458746323', '679344850', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (252, '980950912', '497464838', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (253, '227942129', '289873378', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (254, '324670635', '095973102', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (255, '108498144', '895445973', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (256, '410147718', '087031799', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (257, '714263066', '114676727', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (258, '196418290', '188731408', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (259, '458746323', '357683157', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (260, '760435488', '211235719', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (261, '108498144', '807478919', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (262, '022645109', '218880693', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (263, '491058748', '983855120', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (264, '760435488', '124283722', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (265, '458746323', '024173901', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (266, '839161222', '303981782', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (267, '918223584', '029730990', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (268, '427381821', '039815841', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (269, '723701036', '130693139', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (270, '918223584', '593306730', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (271, '879371457', '184268549', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (272, '889130597', '356673486', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (273, '890982672', '550609298', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (274, '839161222', '477448048', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (275, '980950912', '667566215', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (276, '357504979', '683571677', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (277, '324670635', '150230428', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (278, '489538253', '678903034', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (279, '975711422', '790369237', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (280, '611888673', '324670635', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (281, '105837988', '949455945', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (282, '324670635', '663812521', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (283, '760435488', '698127957', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (284, '550609298', '080919502', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (285, '575581959', '812267552', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (286, '477448048', '592142766', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (287, '615443912', '818974714', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (288, '552694767', '720995445', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (289, '477448048', '352211303', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (290, '357504979', '620604622', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (291, '714263066', '961930704', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (292, '667566215', '219044533', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (293, '918223584', '110547820', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (294, '866575337', '140958809', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (295, '022645109', '516502505', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (296, '866575337', '535455980', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (297, '410147718', '852111607', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (298, '108498144', '720209228', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (299, '615443912', '688833787', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (300, '979621779', '381313716', '9:00 - 13:00', 'help@gmail.com');
commit;
prompt 300 records committed...
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (301, '890982672', '757839176', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (302, '889130597', '725092846', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (303, '889130597', '656862167', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (304, '427381821', '857695845', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (305, '889130597', '562372864', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (306, '491058748', '149127476', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (307, '979621779', '698707624', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (308, '623774957', '070539559', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (309, '511659200', '667771144', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (310, '839161222', '715006691', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (311, '196418290', '498758946', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (312, '611888673', '006737707', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (313, '554788594', '514307370', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (314, '623774957', '575963977', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (315, '554788594', '217182827', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (316, '899940033', '952053970', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (317, '945469928', '565197531', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (318, '945469928', '980950912', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (319, '196418290', '670168461', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (320, '723701036', '516502505', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (321, '105837988', '663812521', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (322, '552694767', '661465823', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (323, '477448048', '764561139', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (324, '022645109', '931627255', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (325, '357504979', '180292679', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (326, '974043532', '147405116', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (327, '936645107', '384579634', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (328, '511659200', '177869151', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (329, '899940033', '981319115', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (330, '899940033', '588756866', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (332, '975711422', '109048083', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (333, '491058748', '075221711', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (334, '575581959', '466848622', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (335, '489538253', '159118621', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (336, '357504979', '795610917', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (337, '477448048', '327410662', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (338, '889130597', '295549360', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (339, '975711422', '250435829', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (340, '324670635', '690727298', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (341, '975711422', '931627255', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (342, '550609298', '069940406', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (343, '489538253', '024625118', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (344, '108498144', '659628156', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (345, '623774957', '515795787', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (346, '550609298', '384408509', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (347, '975711422', '642412911', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (349, '975711422', '333963799', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (350, '723701036', '615564911', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (351, '667566215', '504247184', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (352, '889130597', '080919502', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (353, '945469928', '401501930', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (354, '105837988', '21281968', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (355, '760435488', '369626971', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (356, '550609298', '531906195', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (357, '760435488', '743489359', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (358, '477448048', '597804245', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (359, '839161222', '548965002', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (360, '667566215', '534714313', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (361, '324670635', '659842684', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (362, '196418290', '749577354', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (363, '918223584', '276682064', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (364, '723701036', '357907728', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (365, '889130597', '702377149', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (366, '760435488', '164786196', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (367, '410147718', '552694767', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (368, '611888673', '857695845', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (369, '575581959', '081252347', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (370, '227942129', '866575337', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (371, '458746323', '720209228', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (372, '552694767', '795610917', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (373, '554788594', '613927468', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (374, '196418290', '076523062', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (375, '575581959', '391849146', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (376, '324670635', '969186817', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (377, '550609298', '247309639', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (378, '945469928', '921230029', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (379, '575581959', '613927468', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (380, '611888673', '271556211', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (381, '324670635', '834206696', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (382, '324670635', '930453297', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (383, '889130597', '321960313', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (384, '879371457', '026207879', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (385, '945469928', '725092846', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (386, '410147718', '081252347', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (387, '979621779', '213893445', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (388, '324670635', '207265234', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (389, '890982672', '698707624', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (390, '611888673', '980950912', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (391, '489538253', '134838990', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (392, '427381821', '399332060', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (393, '477448048', '227672371', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (394, '108498144', '196733664', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (395, '227942129', '207265713', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (396, '511659200', '298902634', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (397, '760435488', '528569441', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (398, '975711422', '199703903', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (400, '324670635', '624364726', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (401, '489538253', '124283722', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (402, '760435488', '744338036', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (403, '410147718', '749577354', '16:00 - 19:00', 'help@gmail.com');
commit;
prompt 400 records committed...
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (404, '889130597', '511659200', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (405, '550609298', '524153631', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (406, '575581959', '188731408', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (407, '477448048', '611888673', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (408, '760435488', '519194876', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (409, '108498144', '902791479', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (410, '357504979', '153812810', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (411, '491058748', '613671695', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (412, '714263066', '974043532', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (413, '196418290', '900541542', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (414, '357504979', '298487735', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (415, '611888673', '136598863', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (416, '615443912', '042465046', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (417, '196418290', '028322021', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (418, '196418290', '230719677', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (419, '714263066', '790369237', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (420, '866575337', '981319115', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (421, '410147718', '758515404', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (422, '427381821', '624364726', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (423, '667566215', '042465046', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (424, '477448048', '344917247', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (425, '458746323', '840598865', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (426, '975711422', '656862167', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (427, '945469928', '887687675', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (428, '839161222', '082304384', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (429, '623774957', '287532568', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (430, '196418290', '966562021', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (431, '196418290', '439735279', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (432, '105837988', '780010323', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (433, '945469928', '667566215', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (434, '554788594', '879371457', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (435, '108498144', '857695845', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (436, '783907365', '969186817', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (437, '511659200', '446427784', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (438, '427381821', '709007510', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (439, '723701036', '723875710', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (440, '575581959', '023086883', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (441, '723701036', '818974714', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (442, '554788594', '906853859', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (443, '899940033', '200465126', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (444, '554788594', '592142766', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (445, '489538253', '282540294', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (446, '491058748', '136598863', '9:00 - 13:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (447, '623774957', '934529741', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (448, '022645109', '732968533', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (449, '667566215', '491058748', '9:00 - 13:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (450, '945469928', '509608552', '9:00 - 13:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (451, '890982672', '720209228', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (452, '615443912', '136598863', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (453, '550609298', '707459082', '16:00 - 19:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (454, '410147718', '977103240', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (455, '410147718', '385070236', '16:00 - 19:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (456, '783907365', '027014178', '12:00 - 15:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (457, '324670635', '871481613', '16:00 - 19:00', 'consult@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (458, '945469928', '213894686', '12:00 - 15:00', 'mainoffice@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (459, '554788594', '918223584', '12:00 - 15:00', 'help@gmail.com');
insert into CONSULTING (consultid, gpersonid, spersonid, receptiontime, contactemail)
values (460, '979621779', '821330468', '12:00 - 15:00', 'mainoffice@gmail.com');
commit;
prompt 457 records loaded
prompt Loading OPENDAYS...
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (1, 100, 25, 5, '9:00');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (2, 150, 14, 7, '15:00');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (3, 100, 1, 4, '12:00');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (4, 75, 5, 8, '11:00');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (5, 80, 4, 7, '16:30');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (6, 200, 22, 3, '21:00');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (7, 250, 21, 6, '12:30');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (8, 250, 13, 12, '13:00');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (9, 100, 4, 9, '14:00');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (10, 80, 29, 11, '15:30');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (11, 200, 16, 9, '12');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (13, 200, 29, 4, '9');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (14, 75, 14, 1, '12');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (15, 80, 13, 5, '9');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (16, 100, 20, 3, '9');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (17, 100, 1, 1, '13');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (18, 75, 22, 1, '13');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (19, 75, 1, 1, '15');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (20, 150, 8, 6, '14');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (21, 150, 22, 9, '14');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (22, 150, 21, 8, '13');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (23, 250, 27, 6, '13');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (24, 250, 27, 4, '15');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (25, 100, 17, 2, '12');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (26, 100, 28, 9, '11');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (27, 100, 3, 3, '17');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (28, 75, 13, 12, '9');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (29, 250, 13, 10, '14');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (30, 75, 28, 3, '9');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (31, 80, 26, 6, '9');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (32, 200, 26, 1, '16');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (33, 150, 24, 9, '17');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (34, 200, 13, 1, '11');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (35, 150, 11, 12, '11');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (36, 100, 13, 10, '21');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (37, 100, 22, 9, '16');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (38, 250, 17, 1, '14');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (39, 100, 5, 1, '13');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (40, 250, 28, 10, '9');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (41, 250, 7, 11, '14');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (42, 250, 31, 2, '9');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (43, 150, 11, 6, '14');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (44, 150, 23, 12, '14');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (45, 150, 16, 11, '19');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (46, 150, 6, 10, '13');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (47, 80, 20, 7, '12');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (48, 200, 6, 6, '10');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (49, 150, 28, 10, '10');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (50, 75, 18, 4, '16');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (51, 80, 20, 11, '16');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (52, 100, 18, 10, '11');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (53, 150, 10, 1, '15');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (54, 100, 21, 9, '10');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (55, 150, 2, 3, '15');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (56, 100, 15, 6, '16');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (57, 150, 7, 2, '13');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (58, 250, 11, 9, '18');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (59, 80, 23, 10, '15');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (60, 80, 27, 2, '17');
insert into OPENDAYS (opendayid, numparticipants, o_day, o_month, o_hour)
values (12, 75, 7, 11, '20');
commit;
prompt 60 records loaded
prompt Loading GUESTLECTURES...
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (14, 12, 'LaborMarket', 'Popko-12');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (15, 34, 'DigitalMarketing', 'Popko-11');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (16, 40, 'CapitalMarket', 'Popko-13');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (17, 25, 'DigitalMarketing', 'Popko-24');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (18, 9, 'DigitalMarketing', 'Popko-2');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (19, 18, 'PreparingToTechnicalInterview', 'Popko-50');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (20, 26, 'Resume', 'Popko-24');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (21, 38, 'HighTech-Career', 'Popko-13');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (22, 5, 'WorkInterview', 'Popko-50');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (23, 14, 'PreparingToWork', 'Popko-50');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (24, 35, 'PreparingToTechnicalInterview', 'Popko-2');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (25, 5, 'PreparingToTechnicalInterview', 'Popko-13');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (26, 47, 'WorkInterview', 'Popko-2');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (27, 24, 'Resume', 'Popko-13');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (28, 29, 'LaborMarket', 'Popko-24');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (29, 19, 'DigitalMarketing', 'Popko-12');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (30, 50, 'HighTech-Career', 'Popko-12');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (31, 12, 'PreparingToTechnicalInterview', 'Popko-24');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (32, 18, 'LinkedIn', 'Popko-50');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (33, 35, 'HowToDealStress', 'Popko-50');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (34, 37, 'LinkedIn', 'Popko-11');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (35, 43, 'LaborMarket', 'Popko-11');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (36, 7, 'DigitalMarketing', 'Popko-50');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (1, 1, ' LinkedIn', ' Popko-12');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (2, 2, ' PreparingToTechnicalInterview', ' Popko-24');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (3, 3, ' CapitalMarket', ' Popko-11');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (4, 4, ' Resume', ' Popko-13');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (5, 5, ' HowToDealStress', ' Popko-13');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (6, 6, ' Resume', ' Popko-2');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (7, 7, ' LaborMarket', ' Popko-11');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (8, 8, ' HighTech-Career', ' Popko-12');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (9, 9, ' WorkInterview', ' Popko-2');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (10, 10, ' WorkInterview', ' Popko-12');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (11, 11, ' PreparingToWork', ' Popko-24');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (12, 12, ' DigitalMarketing', ' Popko-50');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (13, 7, 'WorkInterview', 'Popko-2');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (37, 2, 'Resume', 'Popko-12');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (38, 15, 'LinkedIn', 'Popko-24');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (39, 10, 'HowToDealStress', 'Popko-13');
insert into GUESTLECTURES (lectureid, opendayid, subject, lecturelocation)
values (40, 29, 'LaborMarket', 'Popko-24');
commit;
prompt 40 records loaded
prompt Loading LOCATEDAT...
insert into LOCATEDAT (companyid, adressid)
values (1, 700);
insert into LOCATEDAT (companyid, adressid)
values (2, 65);
insert into LOCATEDAT (companyid, adressid)
values (3, 49);
insert into LOCATEDAT (companyid, adressid)
values (4, 73);
insert into LOCATEDAT (companyid, adressid)
values (5, 101);
insert into LOCATEDAT (companyid, adressid)
values (6, 629);
insert into LOCATEDAT (companyid, adressid)
values (7, 863);
insert into LOCATEDAT (companyid, adressid)
values (8, 827);
insert into LOCATEDAT (companyid, adressid)
values (9, 192);
insert into LOCATEDAT (companyid, adressid)
values (10, 100);
insert into LOCATEDAT (companyid, adressid)
values (11, 609);
insert into LOCATEDAT (companyid, adressid)
values (12, 489);
insert into LOCATEDAT (companyid, adressid)
values (13, 786);
insert into LOCATEDAT (companyid, adressid)
values (14, 42);
insert into LOCATEDAT (companyid, adressid)
values (15, 427);
insert into LOCATEDAT (companyid, adressid)
values (16, 322);
insert into LOCATEDAT (companyid, adressid)
values (17, 446);
insert into LOCATEDAT (companyid, adressid)
values (18, 924);
insert into LOCATEDAT (companyid, adressid)
values (19, 46);
insert into LOCATEDAT (companyid, adressid)
values (20, 148);
insert into LOCATEDAT (companyid, adressid)
values (21, 235);
insert into LOCATEDAT (companyid, adressid)
values (22, 567);
insert into LOCATEDAT (companyid, adressid)
values (23, 877);
insert into LOCATEDAT (companyid, adressid)
values (24, 834);
insert into LOCATEDAT (companyid, adressid)
values (25, 566);
insert into LOCATEDAT (companyid, adressid)
values (26, 356);
insert into LOCATEDAT (companyid, adressid)
values (27, 95);
insert into LOCATEDAT (companyid, adressid)
values (28, 886);
insert into LOCATEDAT (companyid, adressid)
values (29, 282);
insert into LOCATEDAT (companyid, adressid)
values (30, 603);
insert into LOCATEDAT (companyid, adressid)
values (31, 231);
insert into LOCATEDAT (companyid, adressid)
values (32, 392);
insert into LOCATEDAT (companyid, adressid)
values (33, 427);
insert into LOCATEDAT (companyid, adressid)
values (34, 175);
insert into LOCATEDAT (companyid, adressid)
values (35, 939);
insert into LOCATEDAT (companyid, adressid)
values (36, 737);
insert into LOCATEDAT (companyid, adressid)
values (37, 968);
insert into LOCATEDAT (companyid, adressid)
values (38, 211);
insert into LOCATEDAT (companyid, adressid)
values (39, 90);
insert into LOCATEDAT (companyid, adressid)
values (40, 371);
insert into LOCATEDAT (companyid, adressid)
values (41, 22);
insert into LOCATEDAT (companyid, adressid)
values (42, 225);
insert into LOCATEDAT (companyid, adressid)
values (43, 232);
insert into LOCATEDAT (companyid, adressid)
values (44, 316);
insert into LOCATEDAT (companyid, adressid)
values (45, 393);
insert into LOCATEDAT (companyid, adressid)
values (46, 410);
insert into LOCATEDAT (companyid, adressid)
values (47, 608);
insert into LOCATEDAT (companyid, adressid)
values (48, 27);
insert into LOCATEDAT (companyid, adressid)
values (49, 160);
insert into LOCATEDAT (companyid, adressid)
values (50, 975);
insert into LOCATEDAT (companyid, adressid)
values (51, 579);
insert into LOCATEDAT (companyid, adressid)
values (52, 814);
insert into LOCATEDAT (companyid, adressid)
values (53, 882);
insert into LOCATEDAT (companyid, adressid)
values (54, 696);
insert into LOCATEDAT (companyid, adressid)
values (55, 176);
insert into LOCATEDAT (companyid, adressid)
values (56, 966);
insert into LOCATEDAT (companyid, adressid)
values (57, 591);
insert into LOCATEDAT (companyid, adressid)
values (58, 181);
insert into LOCATEDAT (companyid, adressid)
values (59, 921);
insert into LOCATEDAT (companyid, adressid)
values (60, 303);
insert into LOCATEDAT (companyid, adressid)
values (61, 577);
insert into LOCATEDAT (companyid, adressid)
values (62, 398);
insert into LOCATEDAT (companyid, adressid)
values (63, 214);
insert into LOCATEDAT (companyid, adressid)
values (64, 822);
insert into LOCATEDAT (companyid, adressid)
values (65, 714);
insert into LOCATEDAT (companyid, adressid)
values (66, 460);
insert into LOCATEDAT (companyid, adressid)
values (67, 93);
insert into LOCATEDAT (companyid, adressid)
values (68, 444);
insert into LOCATEDAT (companyid, adressid)
values (69, 734);
insert into LOCATEDAT (companyid, adressid)
values (70, 866);
insert into LOCATEDAT (companyid, adressid)
values (71, 944);
insert into LOCATEDAT (companyid, adressid)
values (72, 380);
insert into LOCATEDAT (companyid, adressid)
values (73, 849);
insert into LOCATEDAT (companyid, adressid)
values (74, 531);
insert into LOCATEDAT (companyid, adressid)
values (75, 459);
insert into LOCATEDAT (companyid, adressid)
values (76, 387);
insert into LOCATEDAT (companyid, adressid)
values (77, 473);
insert into LOCATEDAT (companyid, adressid)
values (78, 393);
insert into LOCATEDAT (companyid, adressid)
values (79, 246);
insert into LOCATEDAT (companyid, adressid)
values (80, 918);
insert into LOCATEDAT (companyid, adressid)
values (81, 46);
insert into LOCATEDAT (companyid, adressid)
values (82, 387);
insert into LOCATEDAT (companyid, adressid)
values (83, 484);
insert into LOCATEDAT (companyid, adressid)
values (84, 77);
insert into LOCATEDAT (companyid, adressid)
values (85, 167);
insert into LOCATEDAT (companyid, adressid)
values (86, 62);
insert into LOCATEDAT (companyid, adressid)
values (87, 671);
insert into LOCATEDAT (companyid, adressid)
values (88, 846);
insert into LOCATEDAT (companyid, adressid)
values (89, 516);
insert into LOCATEDAT (companyid, adressid)
values (90, 236);
insert into LOCATEDAT (companyid, adressid)
values (91, 518);
insert into LOCATEDAT (companyid, adressid)
values (92, 839);
insert into LOCATEDAT (companyid, adressid)
values (93, 347);
insert into LOCATEDAT (companyid, adressid)
values (94, 311);
insert into LOCATEDAT (companyid, adressid)
values (95, 340);
insert into LOCATEDAT (companyid, adressid)
values (96, 751);
insert into LOCATEDAT (companyid, adressid)
values (97, 509);
insert into LOCATEDAT (companyid, adressid)
values (98, 251);
insert into LOCATEDAT (companyid, adressid)
values (99, 545);
insert into LOCATEDAT (companyid, adressid)
values (100, 230);
commit;
prompt 100 records committed...
insert into LOCATEDAT (companyid, adressid)
values (101, 176);
insert into LOCATEDAT (companyid, adressid)
values (102, 339);
insert into LOCATEDAT (companyid, adressid)
values (103, 83);
insert into LOCATEDAT (companyid, adressid)
values (104, 671);
insert into LOCATEDAT (companyid, adressid)
values (105, 897);
insert into LOCATEDAT (companyid, adressid)
values (106, 134);
insert into LOCATEDAT (companyid, adressid)
values (107, 28);
insert into LOCATEDAT (companyid, adressid)
values (108, 325);
insert into LOCATEDAT (companyid, adressid)
values (109, 519);
insert into LOCATEDAT (companyid, adressid)
values (110, 353);
insert into LOCATEDAT (companyid, adressid)
values (111, 527);
insert into LOCATEDAT (companyid, adressid)
values (112, 715);
insert into LOCATEDAT (companyid, adressid)
values (113, 200);
insert into LOCATEDAT (companyid, adressid)
values (114, 511);
insert into LOCATEDAT (companyid, adressid)
values (115, 838);
insert into LOCATEDAT (companyid, adressid)
values (116, 164);
insert into LOCATEDAT (companyid, adressid)
values (117, 519);
insert into LOCATEDAT (companyid, adressid)
values (118, 593);
insert into LOCATEDAT (companyid, adressid)
values (119, 269);
insert into LOCATEDAT (companyid, adressid)
values (120, 993);
insert into LOCATEDAT (companyid, adressid)
values (121, 279);
insert into LOCATEDAT (companyid, adressid)
values (122, 96);
insert into LOCATEDAT (companyid, adressid)
values (123, 157);
insert into LOCATEDAT (companyid, adressid)
values (124, 639);
insert into LOCATEDAT (companyid, adressid)
values (125, 797);
insert into LOCATEDAT (companyid, adressid)
values (126, 176);
insert into LOCATEDAT (companyid, adressid)
values (127, 161);
insert into LOCATEDAT (companyid, adressid)
values (128, 845);
insert into LOCATEDAT (companyid, adressid)
values (129, 481);
insert into LOCATEDAT (companyid, adressid)
values (130, 750);
insert into LOCATEDAT (companyid, adressid)
values (131, 601);
insert into LOCATEDAT (companyid, adressid)
values (132, 596);
insert into LOCATEDAT (companyid, adressid)
values (133, 156);
insert into LOCATEDAT (companyid, adressid)
values (134, 789);
insert into LOCATEDAT (companyid, adressid)
values (135, 599);
insert into LOCATEDAT (companyid, adressid)
values (136, 413);
insert into LOCATEDAT (companyid, adressid)
values (137, 428);
insert into LOCATEDAT (companyid, adressid)
values (138, 226);
insert into LOCATEDAT (companyid, adressid)
values (139, 216);
insert into LOCATEDAT (companyid, adressid)
values (140, 333);
insert into LOCATEDAT (companyid, adressid)
values (141, 921);
insert into LOCATEDAT (companyid, adressid)
values (142, 101);
insert into LOCATEDAT (companyid, adressid)
values (143, 885);
insert into LOCATEDAT (companyid, adressid)
values (144, 502);
insert into LOCATEDAT (companyid, adressid)
values (145, 351);
insert into LOCATEDAT (companyid, adressid)
values (146, 884);
insert into LOCATEDAT (companyid, adressid)
values (147, 714);
insert into LOCATEDAT (companyid, adressid)
values (148, 354);
insert into LOCATEDAT (companyid, adressid)
values (149, 724);
insert into LOCATEDAT (companyid, adressid)
values (150, 132);
insert into LOCATEDAT (companyid, adressid)
values (151, 681);
insert into LOCATEDAT (companyid, adressid)
values (152, 741);
insert into LOCATEDAT (companyid, adressid)
values (153, 974);
insert into LOCATEDAT (companyid, adressid)
values (154, 42);
insert into LOCATEDAT (companyid, adressid)
values (155, 619);
insert into LOCATEDAT (companyid, adressid)
values (156, 452);
insert into LOCATEDAT (companyid, adressid)
values (157, 1001);
insert into LOCATEDAT (companyid, adressid)
values (158, 286);
insert into LOCATEDAT (companyid, adressid)
values (159, 508);
insert into LOCATEDAT (companyid, adressid)
values (160, 78);
insert into LOCATEDAT (companyid, adressid)
values (161, 937);
insert into LOCATEDAT (companyid, adressid)
values (162, 333);
insert into LOCATEDAT (companyid, adressid)
values (163, 605);
insert into LOCATEDAT (companyid, adressid)
values (164, 102);
insert into LOCATEDAT (companyid, adressid)
values (165, 918);
insert into LOCATEDAT (companyid, adressid)
values (166, 287);
insert into LOCATEDAT (companyid, adressid)
values (167, 296);
insert into LOCATEDAT (companyid, adressid)
values (168, 620);
insert into LOCATEDAT (companyid, adressid)
values (169, 858);
insert into LOCATEDAT (companyid, adressid)
values (170, 684);
insert into LOCATEDAT (companyid, adressid)
values (171, 804);
insert into LOCATEDAT (companyid, adressid)
values (172, 189);
insert into LOCATEDAT (companyid, adressid)
values (173, 951);
insert into LOCATEDAT (companyid, adressid)
values (174, 917);
insert into LOCATEDAT (companyid, adressid)
values (175, 11);
insert into LOCATEDAT (companyid, adressid)
values (176, 681);
insert into LOCATEDAT (companyid, adressid)
values (177, 878);
insert into LOCATEDAT (companyid, adressid)
values (178, 237);
insert into LOCATEDAT (companyid, adressid)
values (179, 209);
insert into LOCATEDAT (companyid, adressid)
values (180, 3);
insert into LOCATEDAT (companyid, adressid)
values (181, 973);
insert into LOCATEDAT (companyid, adressid)
values (182, 515);
insert into LOCATEDAT (companyid, adressid)
values (183, 349);
insert into LOCATEDAT (companyid, adressid)
values (184, 261);
insert into LOCATEDAT (companyid, adressid)
values (185, 802);
insert into LOCATEDAT (companyid, adressid)
values (186, 56);
insert into LOCATEDAT (companyid, adressid)
values (187, 176);
insert into LOCATEDAT (companyid, adressid)
values (188, 601);
insert into LOCATEDAT (companyid, adressid)
values (189, 932);
insert into LOCATEDAT (companyid, adressid)
values (190, 380);
insert into LOCATEDAT (companyid, adressid)
values (191, 458);
insert into LOCATEDAT (companyid, adressid)
values (192, 787);
insert into LOCATEDAT (companyid, adressid)
values (193, 811);
insert into LOCATEDAT (companyid, adressid)
values (194, 612);
insert into LOCATEDAT (companyid, adressid)
values (195, 915);
insert into LOCATEDAT (companyid, adressid)
values (196, 415);
insert into LOCATEDAT (companyid, adressid)
values (197, 74);
insert into LOCATEDAT (companyid, adressid)
values (198, 896);
insert into LOCATEDAT (companyid, adressid)
values (199, 781);
insert into LOCATEDAT (companyid, adressid)
values (200, 115);
commit;
prompt 200 records committed...
insert into LOCATEDAT (companyid, adressid)
values (201, 714);
insert into LOCATEDAT (companyid, adressid)
values (202, 81);
insert into LOCATEDAT (companyid, adressid)
values (203, 70);
insert into LOCATEDAT (companyid, adressid)
values (204, 257);
insert into LOCATEDAT (companyid, adressid)
values (205, 780);
insert into LOCATEDAT (companyid, adressid)
values (206, 496);
insert into LOCATEDAT (companyid, adressid)
values (207, 906);
insert into LOCATEDAT (companyid, adressid)
values (208, 978);
insert into LOCATEDAT (companyid, adressid)
values (209, 784);
insert into LOCATEDAT (companyid, adressid)
values (210, 539);
insert into LOCATEDAT (companyid, adressid)
values (211, 449);
insert into LOCATEDAT (companyid, adressid)
values (212, 565);
insert into LOCATEDAT (companyid, adressid)
values (213, 841);
insert into LOCATEDAT (companyid, adressid)
values (214, 498);
insert into LOCATEDAT (companyid, adressid)
values (215, 510);
insert into LOCATEDAT (companyid, adressid)
values (216, 561);
insert into LOCATEDAT (companyid, adressid)
values (217, 132);
insert into LOCATEDAT (companyid, adressid)
values (218, 833);
insert into LOCATEDAT (companyid, adressid)
values (219, 651);
insert into LOCATEDAT (companyid, adressid)
values (220, 982);
insert into LOCATEDAT (companyid, adressid)
values (221, 452);
insert into LOCATEDAT (companyid, adressid)
values (222, 656);
insert into LOCATEDAT (companyid, adressid)
values (223, 369);
insert into LOCATEDAT (companyid, adressid)
values (224, 592);
insert into LOCATEDAT (companyid, adressid)
values (225, 694);
insert into LOCATEDAT (companyid, adressid)
values (226, 375);
insert into LOCATEDAT (companyid, adressid)
values (227, 896);
insert into LOCATEDAT (companyid, adressid)
values (228, 253);
insert into LOCATEDAT (companyid, adressid)
values (229, 678);
insert into LOCATEDAT (companyid, adressid)
values (230, 593);
insert into LOCATEDAT (companyid, adressid)
values (231, 396);
insert into LOCATEDAT (companyid, adressid)
values (232, 576);
insert into LOCATEDAT (companyid, adressid)
values (233, 685);
insert into LOCATEDAT (companyid, adressid)
values (234, 726);
insert into LOCATEDAT (companyid, adressid)
values (235, 855);
insert into LOCATEDAT (companyid, adressid)
values (236, 472);
insert into LOCATEDAT (companyid, adressid)
values (237, 467);
insert into LOCATEDAT (companyid, adressid)
values (238, 23);
insert into LOCATEDAT (companyid, adressid)
values (239, 779);
insert into LOCATEDAT (companyid, adressid)
values (240, 440);
insert into LOCATEDAT (companyid, adressid)
values (241, 732);
insert into LOCATEDAT (companyid, adressid)
values (242, 931);
insert into LOCATEDAT (companyid, adressid)
values (243, 554);
insert into LOCATEDAT (companyid, adressid)
values (244, 545);
insert into LOCATEDAT (companyid, adressid)
values (245, 296);
insert into LOCATEDAT (companyid, adressid)
values (246, 811);
insert into LOCATEDAT (companyid, adressid)
values (247, 146);
insert into LOCATEDAT (companyid, adressid)
values (248, 455);
insert into LOCATEDAT (companyid, adressid)
values (249, 479);
insert into LOCATEDAT (companyid, adressid)
values (250, 744);
insert into LOCATEDAT (companyid, adressid)
values (251, 346);
insert into LOCATEDAT (companyid, adressid)
values (252, 57);
insert into LOCATEDAT (companyid, adressid)
values (253, 324);
insert into LOCATEDAT (companyid, adressid)
values (254, 760);
insert into LOCATEDAT (companyid, adressid)
values (255, 866);
insert into LOCATEDAT (companyid, adressid)
values (256, 471);
insert into LOCATEDAT (companyid, adressid)
values (257, 813);
insert into LOCATEDAT (companyid, adressid)
values (258, 633);
insert into LOCATEDAT (companyid, adressid)
values (259, 939);
insert into LOCATEDAT (companyid, adressid)
values (260, 432);
commit;
prompt 260 records loaded
prompt Loading PARTICIPANTIN...
insert into PARTICIPANTIN (personid, opendayid)
values ('000252841', 7);
insert into PARTICIPANTIN (personid, opendayid)
values ('007512737', 41);
insert into PARTICIPANTIN (personid, opendayid)
values ('011345266', 14);
insert into PARTICIPANTIN (personid, opendayid)
values ('012522084', 1);
insert into PARTICIPANTIN (personid, opendayid)
values ('012522084', 6);
insert into PARTICIPANTIN (personid, opendayid)
values ('023086883', 43);
insert into PARTICIPANTIN (personid, opendayid)
values ('024173901', 2);
insert into PARTICIPANTIN (personid, opendayid)
values ('024625118', 47);
insert into PARTICIPANTIN (personid, opendayid)
values ('027014178', 7);
insert into PARTICIPANTIN (personid, opendayid)
values ('027143835', 36);
insert into PARTICIPANTIN (personid, opendayid)
values ('027412300', 10);
insert into PARTICIPANTIN (personid, opendayid)
values ('027412300', 57);
insert into PARTICIPANTIN (personid, opendayid)
values ('028322021', 60);
insert into PARTICIPANTIN (personid, opendayid)
values ('029730990', 24);
insert into PARTICIPANTIN (personid, opendayid)
values ('029730990', 31);
insert into PARTICIPANTIN (personid, opendayid)
values ('037411330', 42);
insert into PARTICIPANTIN (personid, opendayid)
values ('045378251', 11);
insert into PARTICIPANTIN (personid, opendayid)
values ('046127582', 21);
insert into PARTICIPANTIN (personid, opendayid)
values ('046127582', 30);
insert into PARTICIPANTIN (personid, opendayid)
values ('046127582', 37);
insert into PARTICIPANTIN (personid, opendayid)
values ('050600329', 30);
insert into PARTICIPANTIN (personid, opendayid)
values ('051975805', 41);
insert into PARTICIPANTIN (personid, opendayid)
values ('053367108', 23);
insert into PARTICIPANTIN (personid, opendayid)
values ('056435471', 4);
insert into PARTICIPANTIN (personid, opendayid)
values ('056435471', 17);
insert into PARTICIPANTIN (personid, opendayid)
values ('060462427', 9);
insert into PARTICIPANTIN (personid, opendayid)
values ('067632957', 16);
insert into PARTICIPANTIN (personid, opendayid)
values ('070539559', 49);
insert into PARTICIPANTIN (personid, opendayid)
values ('073905523', 22);
insert into PARTICIPANTIN (personid, opendayid)
values ('076120624', 36);
insert into PARTICIPANTIN (personid, opendayid)
values ('081252347', 28);
insert into PARTICIPANTIN (personid, opendayid)
values ('082304384', 2);
insert into PARTICIPANTIN (personid, opendayid)
values ('082304384', 13);
insert into PARTICIPANTIN (personid, opendayid)
values ('082304384', 60);
insert into PARTICIPANTIN (personid, opendayid)
values ('084468342', 59);
insert into PARTICIPANTIN (personid, opendayid)
values ('086023700', 12);
insert into PARTICIPANTIN (personid, opendayid)
values ('086023700', 16);
insert into PARTICIPANTIN (personid, opendayid)
values ('086023700', 38);
insert into PARTICIPANTIN (personid, opendayid)
values ('086527199', 10);
insert into PARTICIPANTIN (personid, opendayid)
values ('093669743', 41);
insert into PARTICIPANTIN (personid, opendayid)
values ('104740246', 44);
insert into PARTICIPANTIN (personid, opendayid)
values ('104740246', 58);
insert into PARTICIPANTIN (personid, opendayid)
values ('114676727', 29);
insert into PARTICIPANTIN (personid, opendayid)
values ('116197929', 33);
insert into PARTICIPANTIN (personid, opendayid)
values ('116197929', 56);
insert into PARTICIPANTIN (personid, opendayid)
values ('116838814', 35);
insert into PARTICIPANTIN (personid, opendayid)
values ('117037843', 58);
insert into PARTICIPANTIN (personid, opendayid)
values ('118479329', 59);
insert into PARTICIPANTIN (personid, opendayid)
values ('119524327', 16);
insert into PARTICIPANTIN (personid, opendayid)
values ('124283722', 20);
insert into PARTICIPANTIN (personid, opendayid)
values ('137837782', 19);
insert into PARTICIPANTIN (personid, opendayid)
values ('140958809', 45);
insert into PARTICIPANTIN (personid, opendayid)
values ('143521723', 8);
insert into PARTICIPANTIN (personid, opendayid)
values ('143521723', 37);
insert into PARTICIPANTIN (personid, opendayid)
values ('147156914', 3);
insert into PARTICIPANTIN (personid, opendayid)
values ('147405116', 4);
insert into PARTICIPANTIN (personid, opendayid)
values ('147405116', 53);
insert into PARTICIPANTIN (personid, opendayid)
values ('147507174', 33);
insert into PARTICIPANTIN (personid, opendayid)
values ('149127476', 5);
insert into PARTICIPANTIN (personid, opendayid)
values ('151178492', 5);
insert into PARTICIPANTIN (personid, opendayid)
values ('151429611', 50);
insert into PARTICIPANTIN (personid, opendayid)
values ('151496654', 21);
insert into PARTICIPANTIN (personid, opendayid)
values ('154630375', 22);
insert into PARTICIPANTIN (personid, opendayid)
values ('156260996', 38);
insert into PARTICIPANTIN (personid, opendayid)
values ('159118621', 5);
insert into PARTICIPANTIN (personid, opendayid)
values ('164786196', 51);
insert into PARTICIPANTIN (personid, opendayid)
values ('165369761', 20);
insert into PARTICIPANTIN (personid, opendayid)
values ('170680663', 5);
insert into PARTICIPANTIN (personid, opendayid)
values ('174744730', 49);
insert into PARTICIPANTIN (personid, opendayid)
values ('180292679', 56);
insert into PARTICIPANTIN (personid, opendayid)
values ('182777831', 45);
insert into PARTICIPANTIN (personid, opendayid)
values ('182777831', 60);
insert into PARTICIPANTIN (personid, opendayid)
values ('184062892', 29);
insert into PARTICIPANTIN (personid, opendayid)
values ('190554025', 45);
insert into PARTICIPANTIN (personid, opendayid)
values ('191357082', 48);
insert into PARTICIPANTIN (personid, opendayid)
values ('195229946', 20);
insert into PARTICIPANTIN (personid, opendayid)
values ('196418290', 18);
insert into PARTICIPANTIN (personid, opendayid)
values ('196418290', 53);
insert into PARTICIPANTIN (personid, opendayid)
values ('196733664', 10);
insert into PARTICIPANTIN (personid, opendayid)
values ('197177391', 11);
insert into PARTICIPANTIN (personid, opendayid)
values ('199703903', 8);
insert into PARTICIPANTIN (personid, opendayid)
values ('200465126', 11);
insert into PARTICIPANTIN (personid, opendayid)
values ('206395580', 47);
insert into PARTICIPANTIN (personid, opendayid)
values ('207265713', 5);
insert into PARTICIPANTIN (personid, opendayid)
values ('207578934', 7);
insert into PARTICIPANTIN (personid, opendayid)
values ('207578934', 30);
insert into PARTICIPANTIN (personid, opendayid)
values ('209740540', 10);
insert into PARTICIPANTIN (personid, opendayid)
values ('210316218', 2);
insert into PARTICIPANTIN (personid, opendayid)
values ('21281968', 42);
insert into PARTICIPANTIN (personid, opendayid)
values ('217182827', 8);
insert into PARTICIPANTIN (personid, opendayid)
values ('218880693', 14);
insert into PARTICIPANTIN (personid, opendayid)
values ('218880693', 18);
insert into PARTICIPANTIN (personid, opendayid)
values ('218880693', 19);
insert into PARTICIPANTIN (personid, opendayid)
values ('223016999', 16);
insert into PARTICIPANTIN (personid, opendayid)
values ('225666790', 46);
insert into PARTICIPANTIN (personid, opendayid)
values ('227672371', 7);
insert into PARTICIPANTIN (personid, opendayid)
values ('228343553', 3);
insert into PARTICIPANTIN (personid, opendayid)
values ('228343553', 46);
insert into PARTICIPANTIN (personid, opendayid)
values ('230719677', 22);
insert into PARTICIPANTIN (personid, opendayid)
values ('230719677', 45);
commit;
prompt 100 records committed...
insert into PARTICIPANTIN (personid, opendayid)
values ('230719677', 50);
insert into PARTICIPANTIN (personid, opendayid)
values ('232567788', 20);
insert into PARTICIPANTIN (personid, opendayid)
values ('236777172', 58);
insert into PARTICIPANTIN (personid, opendayid)
values ('243805667', 48);
insert into PARTICIPANTIN (personid, opendayid)
values ('243805667', 53);
insert into PARTICIPANTIN (personid, opendayid)
values ('244557811', 12);
insert into PARTICIPANTIN (personid, opendayid)
values ('244557811', 43);
insert into PARTICIPANTIN (personid, opendayid)
values ('244557811', 51);
insert into PARTICIPANTIN (personid, opendayid)
values ('247271599', 26);
insert into PARTICIPANTIN (personid, opendayid)
values ('247271599', 47);
insert into PARTICIPANTIN (personid, opendayid)
values ('247271599', 52);
insert into PARTICIPANTIN (personid, opendayid)
values ('247309639', 20);
insert into PARTICIPANTIN (personid, opendayid)
values ('249539434', 46);
insert into PARTICIPANTIN (personid, opendayid)
values ('250435829', 14);
insert into PARTICIPANTIN (personid, opendayid)
values ('250435829', 38);
insert into PARTICIPANTIN (personid, opendayid)
values ('250435829', 47);
insert into PARTICIPANTIN (personid, opendayid)
values ('250478302', 12);
insert into PARTICIPANTIN (personid, opendayid)
values ('250572626', 13);
insert into PARTICIPANTIN (personid, opendayid)
values ('254024299', 34);
insert into PARTICIPANTIN (personid, opendayid)
values ('254078022', 46);
insert into PARTICIPANTIN (personid, opendayid)
values ('257285772', 19);
insert into PARTICIPANTIN (personid, opendayid)
values ('257285772', 27);
insert into PARTICIPANTIN (personid, opendayid)
values ('257285772', 29);
insert into PARTICIPANTIN (personid, opendayid)
values ('260611584', 18);
insert into PARTICIPANTIN (personid, opendayid)
values ('260611584', 27);
insert into PARTICIPANTIN (personid, opendayid)
values ('260653353', 56);
insert into PARTICIPANTIN (personid, opendayid)
values ('261891327', 19);
insert into PARTICIPANTIN (personid, opendayid)
values ('263668514', 27);
insert into PARTICIPANTIN (personid, opendayid)
values ('264923710', 19);
insert into PARTICIPANTIN (personid, opendayid)
values ('264923710', 26);
insert into PARTICIPANTIN (personid, opendayid)
values ('266005313', 56);
insert into PARTICIPANTIN (personid, opendayid)
values ('268945379', 6);
insert into PARTICIPANTIN (personid, opendayid)
values ('268945379', 38);
insert into PARTICIPANTIN (personid, opendayid)
values ('269697309', 31);
insert into PARTICIPANTIN (personid, opendayid)
values ('271556211', 15);
insert into PARTICIPANTIN (personid, opendayid)
values ('271556211', 25);
insert into PARTICIPANTIN (personid, opendayid)
values ('280527107', 28);
insert into PARTICIPANTIN (personid, opendayid)
values ('280527107', 52);
insert into PARTICIPANTIN (personid, opendayid)
values ('284203983', 36);
insert into PARTICIPANTIN (personid, opendayid)
values ('288118097', 4);
insert into PARTICIPANTIN (personid, opendayid)
values ('295549360', 47);
insert into PARTICIPANTIN (personid, opendayid)
values ('297112351', 32);
insert into PARTICIPANTIN (personid, opendayid)
values ('299989503', 7);
insert into PARTICIPANTIN (personid, opendayid)
values ('300453882', 37);
insert into PARTICIPANTIN (personid, opendayid)
values ('300819735', 29);
insert into PARTICIPANTIN (personid, opendayid)
values ('300819735', 52);
insert into PARTICIPANTIN (personid, opendayid)
values ('301398056', 37);
insert into PARTICIPANTIN (personid, opendayid)
values ('303981782', 6);
insert into PARTICIPANTIN (personid, opendayid)
values ('307217082', 31);
insert into PARTICIPANTIN (personid, opendayid)
values ('310389966', 7);
insert into PARTICIPANTIN (personid, opendayid)
values ('310389966', 20);
insert into PARTICIPANTIN (personid, opendayid)
values ('310389966', 36);
insert into PARTICIPANTIN (personid, opendayid)
values ('310934517', 26);
insert into PARTICIPANTIN (personid, opendayid)
values ('318338979', 47);
insert into PARTICIPANTIN (personid, opendayid)
values ('318338979', 49);
insert into PARTICIPANTIN (personid, opendayid)
values ('324093947', 7);
insert into PARTICIPANTIN (personid, opendayid)
values ('324670635', 54);
insert into PARTICIPANTIN (personid, opendayid)
values ('327410662', 40);
insert into PARTICIPANTIN (personid, opendayid)
values ('327636786', 55);
insert into PARTICIPANTIN (personid, opendayid)
values ('327978571', 37);
insert into PARTICIPANTIN (personid, opendayid)
values ('332094665', 44);
insert into PARTICIPANTIN (personid, opendayid)
values ('335873962', 45);
insert into PARTICIPANTIN (personid, opendayid)
values ('337898494', 32);
insert into PARTICIPANTIN (personid, opendayid)
values ('339187073', 23);
insert into PARTICIPANTIN (personid, opendayid)
values ('339187073', 60);
insert into PARTICIPANTIN (personid, opendayid)
values ('339562961', 14);
insert into PARTICIPANTIN (personid, opendayid)
values ('344917247', 14);
insert into PARTICIPANTIN (personid, opendayid)
values ('356673486', 45);
insert into PARTICIPANTIN (personid, opendayid)
values ('357504979', 29);
insert into PARTICIPANTIN (personid, opendayid)
values ('357504979', 58);
insert into PARTICIPANTIN (personid, opendayid)
values ('357843875', 37);
insert into PARTICIPANTIN (personid, opendayid)
values ('357907728', 8);
insert into PARTICIPANTIN (personid, opendayid)
values ('361356344', 22);
insert into PARTICIPANTIN (personid, opendayid)
values ('362289581', 13);
insert into PARTICIPANTIN (personid, opendayid)
values ('362289581', 32);
insert into PARTICIPANTIN (personid, opendayid)
values ('365033071', 40);
insert into PARTICIPANTIN (personid, opendayid)
values ('365375377', 3);
insert into PARTICIPANTIN (personid, opendayid)
values ('365375377', 49);
insert into PARTICIPANTIN (personid, opendayid)
values ('369626971', 46);
insert into PARTICIPANTIN (personid, opendayid)
values ('375063029', 14);
insert into PARTICIPANTIN (personid, opendayid)
values ('375063029', 34);
insert into PARTICIPANTIN (personid, opendayid)
values ('375063029', 44);
insert into PARTICIPANTIN (personid, opendayid)
values ('377352170', 36);
insert into PARTICIPANTIN (personid, opendayid)
values ('377352170', 51);
insert into PARTICIPANTIN (personid, opendayid)
values ('379440420', 33);
insert into PARTICIPANTIN (personid, opendayid)
values ('382827869', 16);
insert into PARTICIPANTIN (personid, opendayid)
values ('382827869', 39);
insert into PARTICIPANTIN (personid, opendayid)
values ('383765919', 46);
insert into PARTICIPANTIN (personid, opendayid)
values ('383765919', 49);
insert into PARTICIPANTIN (personid, opendayid)
values ('384052743', 39);
insert into PARTICIPANTIN (personid, opendayid)
values ('384408509', 46);
insert into PARTICIPANTIN (personid, opendayid)
values ('384579634', 37);
insert into PARTICIPANTIN (personid, opendayid)
values ('385214883', 7);
insert into PARTICIPANTIN (personid, opendayid)
values ('388481104', 47);
insert into PARTICIPANTIN (personid, opendayid)
values ('391227654', 45);
insert into PARTICIPANTIN (personid, opendayid)
values ('391849146', 27);
insert into PARTICIPANTIN (personid, opendayid)
values ('391849146', 40);
insert into PARTICIPANTIN (personid, opendayid)
values ('391849146', 55);
insert into PARTICIPANTIN (personid, opendayid)
values ('393725381', 2);
insert into PARTICIPANTIN (personid, opendayid)
values ('397266455', 37);
commit;
prompt 200 records committed...
insert into PARTICIPANTIN (personid, opendayid)
values ('403148912', 16);
insert into PARTICIPANTIN (personid, opendayid)
values ('403521342', 16);
insert into PARTICIPANTIN (personid, opendayid)
values ('408888854', 15);
insert into PARTICIPANTIN (personid, opendayid)
values ('408888854', 48);
insert into PARTICIPANTIN (personid, opendayid)
values ('410147718', 35);
insert into PARTICIPANTIN (personid, opendayid)
values ('410147718', 42);
insert into PARTICIPANTIN (personid, opendayid)
values ('410147718', 47);
insert into PARTICIPANTIN (personid, opendayid)
values ('411570462', 44);
insert into PARTICIPANTIN (personid, opendayid)
values ('411594779', 18);
insert into PARTICIPANTIN (personid, opendayid)
values ('411594779', 33);
insert into PARTICIPANTIN (personid, opendayid)
values ('412307841', 22);
insert into PARTICIPANTIN (personid, opendayid)
values ('426920654', 1);
insert into PARTICIPANTIN (personid, opendayid)
values ('426920654', 46);
insert into PARTICIPANTIN (personid, opendayid)
values ('426999514', 12);
insert into PARTICIPANTIN (personid, opendayid)
values ('427381821', 10);
insert into PARTICIPANTIN (personid, opendayid)
values ('430689171', 6);
insert into PARTICIPANTIN (personid, opendayid)
values ('433928010', 56);
insert into PARTICIPANTIN (personid, opendayid)
values ('434530964', 4);
insert into PARTICIPANTIN (personid, opendayid)
values ('434530964', 8);
insert into PARTICIPANTIN (personid, opendayid)
values ('436373857', 54);
insert into PARTICIPANTIN (personid, opendayid)
values ('439735279', 25);
insert into PARTICIPANTIN (personid, opendayid)
values ('442303438', 7);
insert into PARTICIPANTIN (personid, opendayid)
values ('443347647', 47);
insert into PARTICIPANTIN (personid, opendayid)
values ('446427784', 2);
insert into PARTICIPANTIN (personid, opendayid)
values ('446427784', 12);
insert into PARTICIPANTIN (personid, opendayid)
values ('446427784', 54);
insert into PARTICIPANTIN (personid, opendayid)
values ('458122429', 35);
insert into PARTICIPANTIN (personid, opendayid)
values ('458122429', 48);
insert into PARTICIPANTIN (personid, opendayid)
values ('458746323', 8);
insert into PARTICIPANTIN (personid, opendayid)
values ('460735104', 39);
insert into PARTICIPANTIN (personid, opendayid)
values ('460735104', 53);
insert into PARTICIPANTIN (personid, opendayid)
values ('464137067', 35);
insert into PARTICIPANTIN (personid, opendayid)
values ('464137067', 44);
insert into PARTICIPANTIN (personid, opendayid)
values ('464632757', 37);
insert into PARTICIPANTIN (personid, opendayid)
values ('464785866', 29);
insert into PARTICIPANTIN (personid, opendayid)
values ('467508572', 28);
insert into PARTICIPANTIN (personid, opendayid)
values ('477448048', 45);
insert into PARTICIPANTIN (personid, opendayid)
values ('479324552', 10);
insert into PARTICIPANTIN (personid, opendayid)
values ('479324552', 56);
insert into PARTICIPANTIN (personid, opendayid)
values ('480084289', 15);
insert into PARTICIPANTIN (personid, opendayid)
values ('481753265', 30);
insert into PARTICIPANTIN (personid, opendayid)
values ('483114131', 5);
insert into PARTICIPANTIN (personid, opendayid)
values ('483114131', 57);
insert into PARTICIPANTIN (personid, opendayid)
values ('489662104', 36);
insert into PARTICIPANTIN (personid, opendayid)
values ('491316712', 47);
insert into PARTICIPANTIN (personid, opendayid)
values ('493829613', 4);
insert into PARTICIPANTIN (personid, opendayid)
values ('498758946', 47);
insert into PARTICIPANTIN (personid, opendayid)
values ('499772461', 37);
insert into PARTICIPANTIN (personid, opendayid)
values ('501327543', 7);
insert into PARTICIPANTIN (personid, opendayid)
values ('501327543', 25);
insert into PARTICIPANTIN (personid, opendayid)
values ('501327543', 26);
insert into PARTICIPANTIN (personid, opendayid)
values ('502963692', 5);
insert into PARTICIPANTIN (personid, opendayid)
values ('502963692', 18);
insert into PARTICIPANTIN (personid, opendayid)
values ('509314529', 28);
insert into PARTICIPANTIN (personid, opendayid)
values ('511659200', 17);
insert into PARTICIPANTIN (personid, opendayid)
values ('514307370', 18);
insert into PARTICIPANTIN (personid, opendayid)
values ('514307370', 57);
insert into PARTICIPANTIN (personid, opendayid)
values ('515795787', 25);
insert into PARTICIPANTIN (personid, opendayid)
values ('515795787', 26);
insert into PARTICIPANTIN (personid, opendayid)
values ('515795787', 38);
insert into PARTICIPANTIN (personid, opendayid)
values ('518407549', 58);
insert into PARTICIPANTIN (personid, opendayid)
values ('519194876', 3);
insert into PARTICIPANTIN (personid, opendayid)
values ('521767158', 15);
insert into PARTICIPANTIN (personid, opendayid)
values ('528755041', 7);
insert into PARTICIPANTIN (personid, opendayid)
values ('530541326', 15);
insert into PARTICIPANTIN (personid, opendayid)
values ('530541326', 59);
insert into PARTICIPANTIN (personid, opendayid)
values ('531906195', 10);
insert into PARTICIPANTIN (personid, opendayid)
values ('534721757', 33);
insert into PARTICIPANTIN (personid, opendayid)
values ('535455980', 19);
insert into PARTICIPANTIN (personid, opendayid)
values ('548099649', 7);
insert into PARTICIPANTIN (personid, opendayid)
values ('548099649', 36);
insert into PARTICIPANTIN (personid, opendayid)
values ('548299749', 55);
insert into PARTICIPANTIN (personid, opendayid)
values ('551786746', 54);
insert into PARTICIPANTIN (personid, opendayid)
values ('558736817', 13);
insert into PARTICIPANTIN (personid, opendayid)
values ('560738660', 9);
insert into PARTICIPANTIN (personid, opendayid)
values ('562372864', 59);
insert into PARTICIPANTIN (personid, opendayid)
values ('565197531', 20);
insert into PARTICIPANTIN (personid, opendayid)
values ('565197531', 22);
insert into PARTICIPANTIN (personid, opendayid)
values ('565197531', 53);
insert into PARTICIPANTIN (personid, opendayid)
values ('565364283', 55);
insert into PARTICIPANTIN (personid, opendayid)
values ('565846884', 42);
insert into PARTICIPANTIN (personid, opendayid)
values ('569918993', 41);
insert into PARTICIPANTIN (personid, opendayid)
values ('573661345', 54);
insert into PARTICIPANTIN (personid, opendayid)
values ('575202130', 46);
insert into PARTICIPANTIN (personid, opendayid)
values ('583595623', 8);
insert into PARTICIPANTIN (personid, opendayid)
values ('583595623', 45);
insert into PARTICIPANTIN (personid, opendayid)
values ('587179576', 16);
insert into PARTICIPANTIN (personid, opendayid)
values ('587179576', 28);
insert into PARTICIPANTIN (personid, opendayid)
values ('588756866', 3);
insert into PARTICIPANTIN (personid, opendayid)
values ('592142766', 31);
insert into PARTICIPANTIN (personid, opendayid)
values ('593306730', 54);
insert into PARTICIPANTIN (personid, opendayid)
values ('595223184', 20);
insert into PARTICIPANTIN (personid, opendayid)
values ('599141121', 38);
insert into PARTICIPANTIN (personid, opendayid)
values ('607414468', 30);
insert into PARTICIPANTIN (personid, opendayid)
values ('608404078', 26);
insert into PARTICIPANTIN (personid, opendayid)
values ('610482447', 21);
insert into PARTICIPANTIN (personid, opendayid)
values ('611888673', 16);
insert into PARTICIPANTIN (personid, opendayid)
values ('611888673', 26);
insert into PARTICIPANTIN (personid, opendayid)
values ('611888673', 54);
insert into PARTICIPANTIN (personid, opendayid)
values ('612807614', 18);
commit;
prompt 300 records committed...
insert into PARTICIPANTIN (personid, opendayid)
values ('613927468', 45);
insert into PARTICIPANTIN (personid, opendayid)
values ('614414921', 11);
insert into PARTICIPANTIN (personid, opendayid)
values ('614414921', 16);
insert into PARTICIPANTIN (personid, opendayid)
values ('615564911', 36);
insert into PARTICIPANTIN (personid, opendayid)
values ('615893503', 27);
insert into PARTICIPANTIN (personid, opendayid)
values ('620604622', 58);
insert into PARTICIPANTIN (personid, opendayid)
values ('621113814', 43);
insert into PARTICIPANTIN (personid, opendayid)
values ('621488868', 39);
insert into PARTICIPANTIN (personid, opendayid)
values ('623387258', 54);
insert into PARTICIPANTIN (personid, opendayid)
values ('624364726', 35);
insert into PARTICIPANTIN (personid, opendayid)
values ('625635278', 39);
insert into PARTICIPANTIN (personid, opendayid)
values ('629399441', 1);
insert into PARTICIPANTIN (personid, opendayid)
values ('631121934', 17);
insert into PARTICIPANTIN (personid, opendayid)
values ('635994978', 8);
insert into PARTICIPANTIN (personid, opendayid)
values ('638398901', 60);
insert into PARTICIPANTIN (personid, opendayid)
values ('641303940', 21);
insert into PARTICIPANTIN (personid, opendayid)
values ('641809487', 15);
insert into PARTICIPANTIN (personid, opendayid)
values ('643603834', 45);
insert into PARTICIPANTIN (personid, opendayid)
values ('643824218', 43);
insert into PARTICIPANTIN (personid, opendayid)
values ('644070925', 36);
insert into PARTICIPANTIN (personid, opendayid)
values ('644070925', 42);
insert into PARTICIPANTIN (personid, opendayid)
values ('644370307', 59);
insert into PARTICIPANTIN (personid, opendayid)
values ('646469451', 16);
insert into PARTICIPANTIN (personid, opendayid)
values ('646469451', 39);
insert into PARTICIPANTIN (personid, opendayid)
values ('648819071', 7);
insert into PARTICIPANTIN (personid, opendayid)
values ('651589499', 20);
insert into PARTICIPANTIN (personid, opendayid)
values ('651589499', 37);
insert into PARTICIPANTIN (personid, opendayid)
values ('655364444', 48);
insert into PARTICIPANTIN (personid, opendayid)
values ('655364444', 56);
insert into PARTICIPANTIN (personid, opendayid)
values ('656862167', 1);
insert into PARTICIPANTIN (personid, opendayid)
values ('659628156', 14);
insert into PARTICIPANTIN (personid, opendayid)
values ('659842684', 14);
insert into PARTICIPANTIN (personid, opendayid)
values ('659842684', 40);
insert into PARTICIPANTIN (personid, opendayid)
values ('661703086', 47);
insert into PARTICIPANTIN (personid, opendayid)
values ('663947507', 55);
insert into PARTICIPANTIN (personid, opendayid)
values ('665841224', 16);
insert into PARTICIPANTIN (personid, opendayid)
values ('665841224', 55);
insert into PARTICIPANTIN (personid, opendayid)
values ('665841224', 56);
insert into PARTICIPANTIN (personid, opendayid)
values ('665873922', 49);
insert into PARTICIPANTIN (personid, opendayid)
values ('667566215', 27);
insert into PARTICIPANTIN (personid, opendayid)
values ('670168461', 53);
insert into PARTICIPANTIN (personid, opendayid)
values ('671206453', 26);
insert into PARTICIPANTIN (personid, opendayid)
values ('673576281', 2);
insert into PARTICIPANTIN (personid, opendayid)
values ('673576281', 47);
insert into PARTICIPANTIN (personid, opendayid)
values ('675491874', 33);
insert into PARTICIPANTIN (personid, opendayid)
values ('679344850', 44);
insert into PARTICIPANTIN (personid, opendayid)
values ('683929577', 53);
insert into PARTICIPANTIN (personid, opendayid)
values ('686338264', 39);
insert into PARTICIPANTIN (personid, opendayid)
values ('687836238', 3);
insert into PARTICIPANTIN (personid, opendayid)
values ('687836238', 19);
insert into PARTICIPANTIN (personid, opendayid)
values ('687836238', 34);
insert into PARTICIPANTIN (personid, opendayid)
values ('688833787', 13);
insert into PARTICIPANTIN (personid, opendayid)
values ('688833787', 48);
insert into PARTICIPANTIN (personid, opendayid)
values ('694503220', 45);
insert into PARTICIPANTIN (personid, opendayid)
values ('698127957', 10);
insert into PARTICIPANTIN (personid, opendayid)
values ('698651065', 24);
insert into PARTICIPANTIN (personid, opendayid)
values ('699703532', 33);
insert into PARTICIPANTIN (personid, opendayid)
values ('702377149', 3);
insert into PARTICIPANTIN (personid, opendayid)
values ('702377149', 44);
insert into PARTICIPANTIN (personid, opendayid)
values ('709007510', 1);
insert into PARTICIPANTIN (personid, opendayid)
values ('711212086', 53);
insert into PARTICIPANTIN (personid, opendayid)
values ('711212086', 59);
insert into PARTICIPANTIN (personid, opendayid)
values ('714254666', 1);
insert into PARTICIPANTIN (personid, opendayid)
values ('714263066', 52);
insert into PARTICIPANTIN (personid, opendayid)
values ('714922037', 33);
insert into PARTICIPANTIN (personid, opendayid)
values ('715006691', 40);
insert into PARTICIPANTIN (personid, opendayid)
values ('718251978', 4);
insert into PARTICIPANTIN (personid, opendayid)
values ('718251978', 20);
insert into PARTICIPANTIN (personid, opendayid)
values ('720209228', 31);
insert into PARTICIPANTIN (personid, opendayid)
values ('720209228', 45);
insert into PARTICIPANTIN (personid, opendayid)
values ('720562049', 18);
insert into PARTICIPANTIN (personid, opendayid)
values ('720995445', 47);
insert into PARTICIPANTIN (personid, opendayid)
values ('721160937', 22);
insert into PARTICIPANTIN (personid, opendayid)
values ('723875710', 12);
insert into PARTICIPANTIN (personid, opendayid)
values ('724349050', 42);
insert into PARTICIPANTIN (personid, opendayid)
values ('724349050', 52);
insert into PARTICIPANTIN (personid, opendayid)
values ('725066790', 1);
insert into PARTICIPANTIN (personid, opendayid)
values ('725066790', 50);
insert into PARTICIPANTIN (personid, opendayid)
values ('725092846', 39);
insert into PARTICIPANTIN (personid, opendayid)
values ('725092846', 56);
insert into PARTICIPANTIN (personid, opendayid)
values ('730141201', 12);
insert into PARTICIPANTIN (personid, opendayid)
values ('732405586', 11);
insert into PARTICIPANTIN (personid, opendayid)
values ('732968533', 2);
insert into PARTICIPANTIN (personid, opendayid)
values ('732968533', 10);
insert into PARTICIPANTIN (personid, opendayid)
values ('735305467', 6);
insert into PARTICIPANTIN (personid, opendayid)
values ('735305467', 54);
insert into PARTICIPANTIN (personid, opendayid)
values ('738360690', 55);
insert into PARTICIPANTIN (personid, opendayid)
values ('738676792', 7);
insert into PARTICIPANTIN (personid, opendayid)
values ('739566112', 60);
insert into PARTICIPANTIN (personid, opendayid)
values ('744235579', 46);
insert into PARTICIPANTIN (personid, opendayid)
values ('744338036', 18);
insert into PARTICIPANTIN (personid, opendayid)
values ('744338036', 50);
insert into PARTICIPANTIN (personid, opendayid)
values ('749577354', 52);
insert into PARTICIPANTIN (personid, opendayid)
values ('757548870', 20);
insert into PARTICIPANTIN (personid, opendayid)
values ('757839176', 35);
insert into PARTICIPANTIN (personid, opendayid)
values ('758515404', 59);
insert into PARTICIPANTIN (personid, opendayid)
values ('760435488', 52);
insert into PARTICIPANTIN (personid, opendayid)
values ('760537710', 54);
insert into PARTICIPANTIN (personid, opendayid)
values ('763037057', 32);
insert into PARTICIPANTIN (personid, opendayid)
values ('763037057', 39);
commit;
prompt 400 records committed...
insert into PARTICIPANTIN (personid, opendayid)
values ('763037057', 53);
insert into PARTICIPANTIN (personid, opendayid)
values ('764561139', 53);
insert into PARTICIPANTIN (personid, opendayid)
values ('770417526', 3);
insert into PARTICIPANTIN (personid, opendayid)
values ('770687076', 41);
insert into PARTICIPANTIN (personid, opendayid)
values ('773375621', 49);
insert into PARTICIPANTIN (personid, opendayid)
values ('777459507', 10);
insert into PARTICIPANTIN (personid, opendayid)
values ('780209218', 55);
insert into PARTICIPANTIN (personid, opendayid)
values ('783504458', 25);
insert into PARTICIPANTIN (personid, opendayid)
values ('788298397', 8);
insert into PARTICIPANTIN (personid, opendayid)
values ('794475379', 11);
insert into PARTICIPANTIN (personid, opendayid)
values ('795610917', 23);
insert into PARTICIPANTIN (personid, opendayid)
values ('806642896', 38);
insert into PARTICIPANTIN (personid, opendayid)
values ('806642896', 56);
insert into PARTICIPANTIN (personid, opendayid)
values ('812267552', 49);
insert into PARTICIPANTIN (personid, opendayid)
values ('812267552', 52);
insert into PARTICIPANTIN (personid, opendayid)
values ('812267552', 57);
insert into PARTICIPANTIN (personid, opendayid)
values ('812788391', 4);
insert into PARTICIPANTIN (personid, opendayid)
values ('815695186', 2);
insert into PARTICIPANTIN (personid, opendayid)
values ('815695186', 30);
insert into PARTICIPANTIN (personid, opendayid)
values ('815695186', 58);
insert into PARTICIPANTIN (personid, opendayid)
values ('816004359', 44);
insert into PARTICIPANTIN (personid, opendayid)
values ('827886021', 25);
insert into PARTICIPANTIN (personid, opendayid)
values ('827886021', 32);
insert into PARTICIPANTIN (personid, opendayid)
values ('827886021', 42);
insert into PARTICIPANTIN (personid, opendayid)
values ('829545163', 16);
insert into PARTICIPANTIN (personid, opendayid)
values ('832355942', 50);
insert into PARTICIPANTIN (personid, opendayid)
values ('833027699', 51);
insert into PARTICIPANTIN (personid, opendayid)
values ('833947923', 27);
insert into PARTICIPANTIN (personid, opendayid)
values ('834206696', 30);
insert into PARTICIPANTIN (personid, opendayid)
values ('836968698', 5);
insert into PARTICIPANTIN (personid, opendayid)
values ('836968698', 38);
insert into PARTICIPANTIN (personid, opendayid)
values ('840598865', 29);
insert into PARTICIPANTIN (personid, opendayid)
values ('841122102', 15);
insert into PARTICIPANTIN (personid, opendayid)
values ('841773511', 25);
insert into PARTICIPANTIN (personid, opendayid)
values ('851500278', 30);
insert into PARTICIPANTIN (personid, opendayid)
values ('857695845', 25);
insert into PARTICIPANTIN (personid, opendayid)
values ('861103587', 29);
insert into PARTICIPANTIN (personid, opendayid)
values ('862493074', 8);
insert into PARTICIPANTIN (personid, opendayid)
values ('862540003', 51);
insert into PARTICIPANTIN (personid, opendayid)
values ('866068038', 29);
insert into PARTICIPANTIN (personid, opendayid)
values ('866575337', 36);
insert into PARTICIPANTIN (personid, opendayid)
values ('871481613', 21);
insert into PARTICIPANTIN (personid, opendayid)
values ('871996624', 32);
insert into PARTICIPANTIN (personid, opendayid)
values ('871996624', 34);
insert into PARTICIPANTIN (personid, opendayid)
values ('871996624', 51);
insert into PARTICIPANTIN (personid, opendayid)
values ('874759263', 52);
insert into PARTICIPANTIN (personid, opendayid)
values ('886549088', 25);
insert into PARTICIPANTIN (personid, opendayid)
values ('887590903', 28);
insert into PARTICIPANTIN (personid, opendayid)
values ('887687675', 20);
insert into PARTICIPANTIN (personid, opendayid)
values ('887687675', 29);
insert into PARTICIPANTIN (personid, opendayid)
values ('890982672', 34);
insert into PARTICIPANTIN (personid, opendayid)
values ('890982672', 46);
insert into PARTICIPANTIN (personid, opendayid)
values ('898550992', 24);
insert into PARTICIPANTIN (personid, opendayid)
values ('902791479', 2);
insert into PARTICIPANTIN (personid, opendayid)
values ('902791479', 5);
insert into PARTICIPANTIN (personid, opendayid)
values ('902791479', 12);
insert into PARTICIPANTIN (personid, opendayid)
values ('904527504', 15);
insert into PARTICIPANTIN (personid, opendayid)
values ('904527504', 20);
insert into PARTICIPANTIN (personid, opendayid)
values ('904527504', 59);
insert into PARTICIPANTIN (personid, opendayid)
values ('907425713', 3);
insert into PARTICIPANTIN (personid, opendayid)
values ('907606113', 3);
insert into PARTICIPANTIN (personid, opendayid)
values ('916561673', 42);
insert into PARTICIPANTIN (personid, opendayid)
values ('916561673', 57);
insert into PARTICIPANTIN (personid, opendayid)
values ('917297719', 8);
insert into PARTICIPANTIN (personid, opendayid)
values ('919285820', 52);
insert into PARTICIPANTIN (personid, opendayid)
values ('919285820', 59);
insert into PARTICIPANTIN (personid, opendayid)
values ('921230029', 3);
insert into PARTICIPANTIN (personid, opendayid)
values ('921230029', 46);
insert into PARTICIPANTIN (personid, opendayid)
values ('921230029', 48);
insert into PARTICIPANTIN (personid, opendayid)
values ('924132261', 40);
insert into PARTICIPANTIN (personid, opendayid)
values ('926840103', 5);
insert into PARTICIPANTIN (personid, opendayid)
values ('926840103', 32);
insert into PARTICIPANTIN (personid, opendayid)
values ('926840103', 55);
insert into PARTICIPANTIN (personid, opendayid)
values ('927870487', 41);
insert into PARTICIPANTIN (personid, opendayid)
values ('930087656', 31);
insert into PARTICIPANTIN (personid, opendayid)
values ('933278843', 34);
insert into PARTICIPANTIN (personid, opendayid)
values ('935958243', 18);
insert into PARTICIPANTIN (personid, opendayid)
values ('935958243', 49);
insert into PARTICIPANTIN (personid, opendayid)
values ('940738490', 14);
insert into PARTICIPANTIN (personid, opendayid)
values ('947040620', 13);
insert into PARTICIPANTIN (personid, opendayid)
values ('950569391', 3);
insert into PARTICIPANTIN (personid, opendayid)
values ('950569391', 25);
insert into PARTICIPANTIN (personid, opendayid)
values ('952053970', 17);
insert into PARTICIPANTIN (personid, opendayid)
values ('952053970', 35);
insert into PARTICIPANTIN (personid, opendayid)
values ('953522249', 6);
insert into PARTICIPANTIN (personid, opendayid)
values ('958603102', 25);
insert into PARTICIPANTIN (personid, opendayid)
values ('959292420', 35);
insert into PARTICIPANTIN (personid, opendayid)
values ('960238264', 59);
insert into PARTICIPANTIN (personid, opendayid)
values ('969186817', 1);
insert into PARTICIPANTIN (personid, opendayid)
values ('969340540', 53);
insert into PARTICIPANTIN (personid, opendayid)
values ('969438125', 42);
insert into PARTICIPANTIN (personid, opendayid)
values ('971348382', 41);
insert into PARTICIPANTIN (personid, opendayid)
values ('973222580', 26);
insert into PARTICIPANTIN (personid, opendayid)
values ('974043532', 18);
insert into PARTICIPANTIN (personid, opendayid)
values ('974043532', 21);
insert into PARTICIPANTIN (personid, opendayid)
values ('974043532', 24);
insert into PARTICIPANTIN (personid, opendayid)
values ('975711422', 5);
insert into PARTICIPANTIN (personid, opendayid)
values ('975711422', 13);
insert into PARTICIPANTIN (personid, opendayid)
values ('981319115', 24);
insert into PARTICIPANTIN (personid, opendayid)
values ('989584881', 25);
commit;
prompt 500 records committed...
insert into PARTICIPANTIN (personid, opendayid)
values ('990877877', 14);
insert into PARTICIPANTIN (personid, opendayid)
values ('991199704', 28);
insert into PARTICIPANTIN (personid, opendayid)
values ('996761642', 17);
insert into PARTICIPANTIN (personid, opendayid)
values ('996761642', 27);
insert into PARTICIPANTIN (personid, opendayid)
values ('996761642', 59);
insert into PARTICIPANTIN (personid, opendayid)
values ('997406796', 46);
commit;
prompt 506 records loaded
prompt Loading TOURAT...
insert into TOURAT (tourid, companyid, opendayid)
values (1, 8, 2);
insert into TOURAT (tourid, companyid, opendayid)
values (2, 83, 35);
insert into TOURAT (tourid, companyid, opendayid)
values (3, 75, 12);
insert into TOURAT (tourid, companyid, opendayid)
values (4, 155, 44);
insert into TOURAT (tourid, companyid, opendayid)
values (5, 49, 27);
insert into TOURAT (tourid, companyid, opendayid)
values (6, 112, 19);
insert into TOURAT (tourid, companyid, opendayid)
values (7, 16, 23);
insert into TOURAT (tourid, companyid, opendayid)
values (8, 194, 37);
insert into TOURAT (tourid, companyid, opendayid)
values (9, 23, 6);
insert into TOURAT (tourid, companyid, opendayid)
values (10, 97, 52);
insert into TOURAT (tourid, companyid, opendayid)
values (11, 185, 50);
insert into TOURAT (tourid, companyid, opendayid)
values (12, 16, 56);
insert into TOURAT (tourid, companyid, opendayid)
values (13, 40, 5);
insert into TOURAT (tourid, companyid, opendayid)
values (14, 22, 39);
insert into TOURAT (tourid, companyid, opendayid)
values (15, 7, 54);
insert into TOURAT (tourid, companyid, opendayid)
values (16, 236, 35);
insert into TOURAT (tourid, companyid, opendayid)
values (17, 213, 18);
insert into TOURAT (tourid, companyid, opendayid)
values (18, 187, 21);
insert into TOURAT (tourid, companyid, opendayid)
values (19, 252, 13);
insert into TOURAT (tourid, companyid, opendayid)
values (20, 233, 49);
commit;
prompt 20 records loaded
prompt Enabling foreign key constraints for PERSON...
alter table PERSON enable constraint SYS_C0013548;
prompt Enabling foreign key constraints for GUIDE...
alter table GUIDE enable constraint SYS_C0013561;
prompt Enabling foreign key constraints for STUDENT...
alter table STUDENT enable constraint SYS_C0013555;
prompt Enabling foreign key constraints for CONSULTING...
alter table CONSULTING enable constraint SYS_C0013569;
alter table CONSULTING enable constraint SYS_C0013570;
prompt Enabling foreign key constraints for GUESTLECTURES...
alter table GUESTLECTURES enable constraint SYS_C0013592;
prompt Enabling foreign key constraints for LOCATEDAT...
alter table LOCATEDAT enable constraint SYS_C0013579;
alter table LOCATEDAT enable constraint SYS_C0013580;
prompt Enabling foreign key constraints for PARTICIPANTIN...
alter table PARTICIPANTIN enable constraint SYS_C0013596;
alter table PARTICIPANTIN enable constraint SYS_C0013597;
prompt Enabling foreign key constraints for TOURAT...
alter table TOURAT enable constraint SYS_C0013603;
alter table TOURAT enable constraint SYS_C0013604;
prompt Enabling triggers for ADRESS...
alter table ADRESS enable all triggers;
prompt Enabling triggers for COMPANY...
alter table COMPANY enable all triggers;
prompt Enabling triggers for PERSON...
alter table PERSON enable all triggers;
prompt Enabling triggers for GUIDE...
alter table GUIDE enable all triggers;
prompt Enabling triggers for STUDENT...
alter table STUDENT enable all triggers;
prompt Enabling triggers for CONSULTING...
alter table CONSULTING enable all triggers;
prompt Enabling triggers for OPENDAYS...
alter table OPENDAYS enable all triggers;
prompt Enabling triggers for GUESTLECTURES...
alter table GUESTLECTURES enable all triggers;
prompt Enabling triggers for LOCATEDAT...
alter table LOCATEDAT enable all triggers;
prompt Enabling triggers for PARTICIPANTIN...
alter table PARTICIPANTIN enable all triggers;
prompt Enabling triggers for TOURAT...
alter table TOURAT enable all triggers;

set feedback on
set define on
prompt Done

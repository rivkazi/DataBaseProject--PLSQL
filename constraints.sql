--------------------------------------------CONSTARINT1--------------------------------------------------------
ALTER TABLE person
ADD CONSTRAINT ValidEmail
CHECK(email LIKE '%@%');

-----SHOWING THAT THE CONSTAINT WORKS
insert into PERSON (PERSONID, FIRSTNAME, LASTNAME, BIRTHDATE, PHONENUMBER, EMAIL, ADDRESSID)
values ('999999999', 'shalom', 'may', to_date('03-08-1970', 'dd-mm-yyyy'), '0503455569', 'shalomay.com', 1);


--------------------------------------------CONSTARINT2--------------------------------------------------------
ALTER TABLE openDays
ADD CONSTRAINT ValidNumParticipants
CHECK(numParticipants > 20);

-----SHOWING THAT THE CONSTAINT WORKS
insert into OPENDAYS (OPENDAYID, NUMPARTICIPANTS, O_DAY, O_MONTH, O_HOUR)
values (61, 15, 27, 3, '9:00');

--------------------------------------------CONSTARINT3--------------------------------------------------------
ALTER TABLE guide
ADD CONSTRAINT ValidLicenseNumber
CHECK((licenseNumber >= 1000 and licenseNumber <= 9999) OR licenseNumber IS NULL );

-----SHOWING THAT THE CONSTAINT WORKS
insert into GUIDE (GPERSONID, GROLE, EXPERIENCE, LICENSENUMBER, AREANAME)
values ('987545711', 'Counselor', 4, 123, 'computerScience');
commit;












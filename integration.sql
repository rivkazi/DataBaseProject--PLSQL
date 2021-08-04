---------------------------------------------ADDRESS--------------------------------------------
SELECT COUNT(addressID), NUMaddress
FROM address,(SELECT COUNT(addressID) AS NUMaddress
              FROM address0)T
GROUP BY NUMaddress;      

ALTER TABLE address0 MODIFY country VARCHAR2(30);
ALTER TABLE address0 MODIFY city VARCHAR2(30);

INSERT INTO address0 SELECT CONCAT(addressID, 2222), country, city, street
                     FROM address;
commit;

---------------------------------------------PERSON---------------------------------------------
SELECT COUNT(personID), NUMperson
FROM person,(SELECT COUNT(personID) AS NUMperson
             FROM person0)P
GROUP BY NUMperson; 

-----CHANGE TO BE THE EXPANDED SIZE
ALTER TABLE person0 MODIFY firstname VARCHAR2(30);
ALTER TABLE person0 MODIFY lastname VARCHAR2(30);
ALTER TABLE person0 MODIFY phonenumber VARCHAR2(30);

INSERT INTO address SELECT CONCAT(addressID, 2222), country, city, street
                     FROM address;
commit;

UPDATE PERSON
SET addressid = CONCAT(addressID ,2222);
commit;

INSERT INTO person0 SELECT personID, firstName, lastName, birthDate, phoneNumber, email, addressID
                    FROM person
                    WHERE personid NOT IN (SELECT personid
                                           FROM person0);
commit; 

---------------------------------------------INTERESTEDIN---------------------------------------------
-----DELETE THE FOREIGN KEY TO PERSON TABLE OF UNIT1                                           
ALTER TABLE interested
  DROP CONSTRAINT SYS_C0018128;
  
-----CREATE FOREIGN KEY TO THE UNITED TABLE OF PERSON 
ALTER TABLE interested
  ADD FOREIGN KEY (personID_)
  REFERENCES person0 (personID);
                                                        
INSERT INTO interested SELECT DISTINCT personID
                       FROM Participantin
                       WHERE personid NOT IN (SELECT personID_
                                              FROM interested);
commit;


---------------------------------------------PARTICIPANTIN---------------------------------------------
-----DELETE THE FOREIGN KEY TO STUDENT TABLE 
ALTER TABLE participantIn
  DROP CONSTRAINT SYS_C0018085;
-----CREATE FOREIGN KEY TO INSERTED TABLE
ALTER TABLE participantIn
  ADD FOREIGN KEY (personID)
  REFERENCES interested (personID_);


-----------------------------------------------COUNSELOR------------------------------------------------
-----ADD COLUMN EXPERIENCE, GROLE
ALTER TABLE counselor
ADD experience INTEGER;
ALTER TABLE counselor
ADD GRole VARCHAR2(20); 
-----INSERT NULL VALUES CAUSE ITS UNKNOWN
UPDATE counselor
SET experience= NULL, grole= NULL;
commit;



-------------------------------------------------GUIDE--------------------------------------------------  
-----DROP COLUMN SPECIALIZATION
ALTER TABLE guide
DROP COLUMN specialization; 
-----ADD COLUMN LICENCENUMBER, AREANAME
ALTER TABLE guide
ADD licenceNumber INTEGER;
ALTER TABLE guide
ADD areaName VARCHAR2(30);
-----INSERT NULL VALUES CAUSE ITS UNKNOWN
UPDATE guide
SET licenceNumber= NULL, areaName= NULL;
commit;

-----CHANGE THEM TO BE NULLABLE FOR THE UNION
ALTER TABLE guide MODIFY grole NULL;
ALTER TABLE guide MODIFY experience NULL;

INSERT INTO guide SELECT personID, GRole, experience, licenseNumber, areaName
                  FROM counselor
                  WHERE personid NOT IN (SELECT GPersonID
                                         FROM guide);

ALTER TABLE GUIDE
  ADD FOREIGN KEY (areaName)
  REFERENCES areastudy (areaName);

------------------------------------------------MEETING-------------------------------------------------  
-----ADD COLUMN CONTACTEMAIL
ALTER TABLE meeting
ADD contactEmail VARCHAR2(35);
-----INSERT NULL VALUES CAUSE ITS UNKNOWN
UPDATE meeting
SET contactEmail= NULL;
commit;

-----DELETE THE FOREIGN KEY TO COUNSELOR TABLE OF UNIT1 
ALTER TABLE meeting
  DROP CONSTRAINT SYS_C0018139;
-----CREATE FOREIGN KEY TO THE GUIDE TABLE
ALTER TABLE meeting
  ADD FOREIGN KEY (counselorID)
  REFERENCES guide (GPersonID);
 
INSERT INTO interested SELECT DISTINCT personID
                       FROM consulting
                       WHERE personid NOT IN (SELECT personID_
                                              FROM interested);  
  
-----CHANGE THEM TO BE NULLABLE FOR THE UNION
ALTER TABLE consulting RENAME COLUMN gpersonid TO counselorID;
ALTER TABLE consulting RENAME COLUMN spersonid to personID;
INSERT INTO meeting SELECT personID, counselorID, TIMESTAMP '2020-01-01 00:00:00 US/Pacific', contactEmail
                    FROM consulting
                    WHERE (counselorID, personID) NOT IN (SELECT counselorID, personID
                                                          FROM meeting);
commit;     

                                                                                             

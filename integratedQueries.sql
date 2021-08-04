-------------------------------------------------------------------------------------------------------------------------OUR UNIT

--------------------------------------------------------SELECT-----------------------------------------------------
---Q1
SELECT T.subject, T.NUMPARTICIPANTS, 
       /*THE PERCENTAGE OF PARTICIPANTS OUT OF THE NUMBER OF STUDENTS*/
       CONCAT((ROUND(T.NUMPARTICIPANTS/ COUNT(spersonid)*100)), ' %')AS PERCENTAGE
FROM student, (/*SUM HOW MUCH PARTICIPANTS TOOK PART IN EVERY LECTURE*/
               SELECT subject, SUM(numparticipants) AS NUMPARTICIPANTS
               FROM opendays NATURAL JOIN guestlectures
               GROUP BY subject)T
GROUP BY T.subject, T.NUMPARTICIPANTS
ORDER BY T.NUMPARTICIPANTS DESC; 


---Q2
SELECT p.personid, p.firstname, p.lastname 
FROM (/*ALL STUDENTS WHO IN THEIR FOURTH ACADEMIC YEAR*/
      SELECT spersonid
      FROM student
      WHERE academicyear = 'Fourth'
           INTERSECT
      /*ALL STUDENTS WHO HAS WORK EXPERIENCE*/
      SELECT spersonid
      FROM student
      WHERE workexperience <> 0)I, person0 p 
WHERE I.spersonid = p.personid;       


---Q3
-----CHANGED THE TABLE FROM STUDENT TO PERSON0, CHANGED THE COLUMN FROM SPERSONID TO PERSONID, AND ALSO IN THE CONSITION 'IN'& 'WHERE'
SELECT p.personid, p.firstname, p.lastname
FROM person0 p, (/*ALL STUDENTS WHO TOOK PART IN BOTH CONSULTING MEETING AND OPEN DAY*/
                 SELECT personid
                 FROM person0
                 WHERE personid IN 
                 -----CHANGED THE TABLE NAME FROM CONSULTING TO NEETING, CHANGED THE NAME OF COLUMN FROM SPERSONID TO PERSONID
                                    (SELECT personid
                                     FROM (/*ALL THE STUDENTS TOOK CONSULTING MEETING*/
                                           SELECT personid
                                           FROM meeting)s1 
                                               NATURAL JOIN
                                          (/*ALL THE STUDENTS TOOK PART IN OPEN DAY AFTER MARCH*/
                                           SELECT personid
                                           FROM participantin NATURAL JOIN opendays
                                           WHERE o_month > 3)s2))N
WHERE p.personid = N.personid;


---Q4
-----CHANGED THE TABLE NAME FROM PERSON TO PERSON0
SELECT personid, firstname, lastname
FROM person0, (/*FIND ALL PEOPLE'S ID WHO PARTICIPANT IN TWO DIFFERENT LECTURES*/
               SELECT s1.spersonid
               FROM student s1, participantin p1, participantin p2, (/*FIND TWO DIFFERENT LECTURE'S SUBJECT*/
                                                                    SELECT DISTINCT g1.opendayid AS gl1, g2.opendayid AS gl2
                                                                    FROM guestlectures g1, guestlectures g2
                                                                    WHERE g1.subject <> g2.subject)O
               WHERE p1.personid = s1.spersonid and p2.personid = s1.spersonid 
                    and p1.opendayid = gl1 and p2.opendayid = gl2)
WHERE personid= spersonid; 


---Q5
-----CHANGED THE TABLE NAME FROM ADDRESS TO ADDRESS0
SELECT companyid, companyname
FROM company NATURAL JOIN (/*ALL COMPANIRS LOCATED AT THE USA*/
                           SELECT DISTINCT companyid
                           FROM locatedat NATURAL JOIN address0
                           WHERE country = 'USA')A
WHERE EXTRACT(year FROM foundationdate) >= '1970'
ORDER BY companyid;  


---Q6
SELECT sDegree, COUNT(*)
FROM student
GROUP BY sDegree
HAVING COUNT(*) > 50
ORDER BY COUNT(*) DESC;  


---Q7
-----CHANGED THE TABLE NAME FROM CONSULTING TO MEETING, PERSON TO PERSON0 AND COLUMN GPERSONID TO COUNSELORID IN MEETING
SELECT p1.personid, CONCAT(CONCAT(p1.firstname, ' '), p1.lastname) AS NAME1,
       p2.personid, CONCAT(CONCAT(p2.firstname, ' '), p2.lastname) AS NAME2
FROM student s, guide g, meeting m, person0 p1, person0 p2
WHERE m.personid = s.spersonid and m.counselorid = g.gpersonid
      and s.spersonid = p1.personid and g.gpersonid = p2.personid
      and p1.firstname LIKE '%y' and p2.firstname LIKE '%y';               
            

---Q8      
SELECT DISTINCT companyname, compantstatus, foundationdate 
FROM company
WHERE companyid IN (/*ALL COMPANIES WHO HOST A TOUR*/
                    SELECT c.companyid
                    FROM company c, tourat t
                    WHERE t.companyid = c.companyid);       



------------------------------------------------Update----------------------------------------------------

---Q1
-----CHANGED THE TABLE NAME FROM PERSON TO PERSON0
SELECT *
FROM person0;

UPDATE person0
SET phonenumber = CONCAT(CONCAT((SUBSTR(phonenumber,1,3)),
                                 '-'),
                                (SUBSTR(phonenumber,4,7)));                              
SELECT *
FROM person0;  
COMMIT;  


---Q2
SELECT *
FROM student
WHERE sdegree= 'Nursing';

UPDATE student
SET sdegree = 'Medical Nurses'
WHERE sdegree= 'Nursing';

SELECT *
FROM student
WHERE sdegree= 'Medical Nurses';
commit;    


-------------------------------------------------Delete----------------------------------------------  
---Q1
SELECT lectureid
FROM guestlectures g, opendays o
WHERE g.opendayid = o.opendayid and o.o_month < '4';                  

DELETE guestlectures g
WHERE g.lectureid in (SELECT g.lectureid
       FROM guestlectures g, opendays o
       WHERE g.opendayid = o.opendayid and o.o_month< '4'); 
       
SELECT lectureid
FROM guestlectures g, opendays o
WHERE g.opendayid = o.opendayid and o.o_month < '4';


---Q2
SELECT tourid, companyname
FROM tourat NATURAL JOIN company
WHERE companyname LIKE 'K%';

DELETE tourat t
WHERE tourid IN (SELECT tourid
                 FROM tourat NATURAL JOIN company
                 WHERE companyname LIKE 'K%');
                 
SELECT tourid, companyname
FROM tourat NATURAL JOIN company
WHERE companyname LIKE 'K%';


-------------------------------------------------------------------------------------------------------------------------UNIT1

--------------------------------------------------------SELECT-----------------------------------------------------
---Q1
(SELECT PERSONID, AREANAME
FROM (/* GET LIST OF: PERSONID, AREANAME AND NUMBER OF BAGRUT TEST THAT THE INTERESTED 
GET THE MINIMUN GRADE FOR THE SPECIFIC AREASTUDY */ 
SELECT PERSONID, AREANAME, COUNT(BAGRUTID) AS HAVE_BAGRUT
FROM (SELECT * FROM INTERESTEDOF NATURAL JOIN ADMISSIONBAGRUT) IA 
     JOIN TESTED USING(PERSONID, BAGRUTID)
WHERE GRADE >= MINBAGRUTGRADE
GROUP BY PERSONID, AREANAME) HAVE
NATURAL JOIN

(/* GET LIST OF: PERSONID, AREANAME AND NUMBER OF BAGRUT TEST THAT THE INTERESTED 
NEED TO GET THE MINIMUN GRADE FOR THE SPECIFIC AREASTUDY */
SELECT PERSONID, AREANAME, COUNT(BAGRUTID) AS NEED_BAGRUT
FROM (SELECT * FROM INTERESTEDOF NATURAL JOIN ADMISSIONBAGRUT) IA 
      LEFT JOIN TESTED USING(PERSONID, BAGRUTID)
GROUP BY PERSONID, AREANAME) NEED

WHERE HAVE_BAGRUT = NEED_BAGRUT)

UNION 

SELECT PERSONID, AREANAME
FROM (SELECT AREANAME FROM AREASTUDY
     MINUS 
     SELECT DISTINCT AREANAME FROM ADMISSIONBAGRUT)
     NATURAL JOIN INTERESTEDOF;
     

---Q2    
CREATE VIEW INTERESTED_PSYCHO AS (
    SELECT PERSONID, PSYCHOGRADE 
    FROM psychometric NATURAL JOIN
                  (SELECT P.PERSONID, MAX(P.PSYCHODATE) AS PSYCHODATE
                   FROM psychometric P
                   GROUP BY P.PERSONID) PD
    WHERE PSYCHODATE >=  sysdate - interval '7' year
);

SELECT PERSONID, AREANAME
FROM INTERESTEDOF NATURAL JOIN AREASTUDY
 NATURAL JOIN INTERESTED_PSYCHO
WHERE PSYCHOGRADE >= MINPSYCHOGRADE;


---Q3
SELECT AREANAME, NUMBER_PASSED, NUMBER_INTERESTED, NUMBER_PASSED/NUMBER_INTERESTED AS IN_PRECENT
FROM (SELECT AREANAME, COUNT(PERSONID) AS NUMBER_PASSED
FROM ((SELECT PERSONID, AREANAME
FROM INTERESTEDOF NATURAL JOIN AREASTUDY
             NATURAL JOIN INTERESTED_PSYCHO
WHERE PSYCHOGRADE >= MINPSYCHOGRADE)
UNION
(SELECT PERSONID, AREANAME
FROM ( SELECT PERSONID, AREANAME, COUNT(BAGRUTID) AS HAVE_BAGRUT
FROM (SELECT * FROM INTERESTEDOF NATURAL JOIN ADMISSIONBAGRUT) IA 
     JOIN TESTED USING(PERSONID, BAGRUTID)
WHERE GRADE >= MINBAGRUTGRADE
GROUP BY PERSONID, AREANAME) HAVE
NATURAL JOIN 
(SELECT PERSONID, AREANAME, COUNT(BAGRUTID) AS NEED_BAGRUT
FROM (SELECT * FROM INTERESTEDOF NATURAL JOIN ADMISSIONBAGRUT) IA 
      LEFT JOIN TESTED USING(PERSONID, BAGRUTID)
GROUP BY PERSONID, AREANAME) NEED
WHERE HAVE_BAGRUT = NEED_BAGRUT) 
UNION 
(SELECT PERSONID, AREANAME
      FROM (SELECT AREANAME FROM AREASTUDY MINUS 
      SELECT DISTINCT AREANAME FROM ADMISSIONBAGRUT)
      NATURAL JOIN INTERESTEDOF)) VALID_PERSON
GROUP BY AREANAME) PASS
NATURAL JOIN
(SELECT AREANAME, COUNT(PERSONID) AS NUMBER_INTERESTED
FROM INTERESTEDOF
GROUP BY AREANAME) INTER


---Q4
-----CHANGED THE TABLE NAME FROM PERSON TO PERSON0
CREATE VIEW COUNSELOR_MEETING AS(
    SELECT COUNSELORID, COUNT(PERSONID) AS NUM_MEETING
    FROM MEETING 
    WHERE EXTRACT(YEAR FROM MEETDATE) = 2021
    GROUP BY COUNSELORID);
    
SELECT CONCAT(CONCAT(FIRSTNAME, ' '), LASTNAME) AS NAME, NUM_MEETING 
FROM (SELECT COUNSELORID AS PERSONID, NUM_MEETING, ROW_NUMBER()
     OVER (ORDER BY NUM_MEETING) AS ROW_NUM
     FROM COUNSELOR_MEETING) NATURAL JOIN PERSON0
WHERE ROW_NUM >= (SELECT COUNT(DISTINCT COUNSELORID) 
                  FROM COUNSELOR_MEETING)*0.75
ORDER BY NAME; 


---Q5
-----CHANGED THE TABLE NAME FROM COUNSELOR TO GUIDE, PERSON TO PERSON0, ADDRESS TO ADDRESS0
SELECT LASTNAME, FIRSTNAME
FROM COUNSELOR NATURAL JOIN PERSON
WHERE PERSONID IN (SELECT COUNSELORID 
                   FROM MEETING
                   WHERE PERSONID IN
                       (SELECT PERSONID_
                        FROM INTERESTED NATURAL JOIN PERSON0
                              NATURAL JOIN ADDRESS0
                        WHERE COUNTRY != 'ISRAEL'))
AND AREANAME = 'laws'
ORDER BY LASTNAME;


---Q6
-----CHANGED THE TABLE NAME FROM PERSON TO PERSON0, ADDRESS TO ADDRESS0 AND 
SELECT distinct FIRSTNAME, LASTNAME, STREET
-----CHANGED TO CARTESIAN PRODUCT INSTEAD OF NATURAL JOIN AND THE COMPARESSION TO BE BERWEEN PERSONID_ TO PERSONID
FROM INTERESTED i, PERSON0 p NATURAL JOIN ADDRESS0
WHERE i.personid_ = p.personid and
      city='Tel aviv' or city='Haifa' or city='Jerusalem'
AND
 EXTRACT(YEAR FROM p.birthdate) > 2000
AND
 p.PERSONID IN (SELECT M.PERSONID 
                FROM MEETING M 
                WHERE M.COUNSELORID IN  
                    (SELECT PERSONID
                     FROM PERSON0 NATURAL JOIN ADDRESS0
                     WHERE city='Tel aviv' or city='Haifa' or city='Jerusalem'));
                     
                     
---Q7
-----CHANGED THE TABLE NAME FROM PERSON TO PERSON0, ADDRESS TO ADDRESS0
SELECT COUNTRY, COUNT(PERSONID) AS NUM_INTERESTED_COMPUTER_SCIENCE
FROM ADDRESS0 NATURAL JOIN PERSON0 NATURAL JOIN
            (SELECT IO.PERSONID  
             FROM INTERESTED I, INTERESTEDOF IO
             WHERE I.PERSONID_ = IO.PERSONID
               AND (IO.AREANAME = 'computer science' 
               OR IO.AREANAME = 'Mathmatics'))
GROUP BY COUNTRY;


---Q8
-----CHANGED THE TABLE NAME FROM PERSON TO PERSON0, ADDRESS TO ADDRESS0
SELECT CONCAT(CONCAT(P1.FIRSTNAME, ' '), P1.LASTNAME) AS INTERESTED,
 CONCAT(CONCAT(P2.FIRSTNAME, ' '), P2.LASTNAME) AS COUNSELOR
FROM MEETING M, PERSON0 P1, PERSON0 P2, ADDRESS0 A1, ADDRESS0 A2
WHERE M.PERSONID = P1.PERSONID AND
      M.COUNSELORID = P2.PERSONID AND
      P1.ADDRESSID = A1.ADDRESSID AND
      P2.ADDRESSID = A2.ADDRESSID AND
      A1.CITY = A2.CITY;
                             

--------------------------------------------------------UPDATE-----------------------------------------------------

---Q1
UPDATE PERSON0  
SET ADDRESSID = (SELECT MIN(DISTINCT A.ADDRESSID)
                 FROM ADDRESS0 A)
WHERE EXTRACT(MONTH FROM BIRTHDATE) IN ('1','3','5','7','9','11')
      AND FIRSTNAME LIKE 'A%' AND LASTNAME LIKE 'A%';
      
---Q2      
UPDATE ADDRESS
SET city = 'Nof HaGalil'
WHERE city = ' Nazareth Illit';


---Q3
-----CHANGED THE TABLE NAME FROM PERSON TO PERSON0
UPDATE PSYCHOMETRIC
SET psychograde = psychograde * 1.03
WHERE EXTRACT (YEAR FROM psychodate) = 2020 and personid in
                 (SELECT personid 
                 from person0
                 where extract(YEAR FROM birthdate) < 2000);
                 
                 
                 
--------------------------------------------------------DELETE-----------------------------------------------------
---Q1
-----CHANGED THE TABLE NAME FROM PERSON TO PERSON0, ADDRESS TO ADDRESS0
DELETE FROM MEETING
WHERE EXTRACT(YEAR FROM meetdate) = 2021
      AND EXTRACT(MONTH FROM meetdate) = 3
      AND EXTRACT(DAY FROM meetdate) = 23
      AND (PERSONID IN (SELECT PERSONID
                        FROM PERSON0 NATURAL JOIN ADDRESS0 
                        WHERE COUNTRY='Israel')
      or counselorid in(SELECT PERSONID 
                        FROM PERSON0 NATURAL JOIN ADDRESS0 
                        WHERE COUNTRY='Israel'));  
                        
                        
---Q2
-----CHANGED THE TABLE NAME FROM PERSON TO PERSON0, COUNSELOR TO GUIDE
DELETE MEETING
WHERE COUNSELORID IN (SELECT PERSONID 
                      FROM PERSON0 NATURAL JOIN GUIDE
                      WHERE BIRTHDATE <= SYSDATE - INTERVAL '60' YEAR);
                      
-----CHANGED THE TABLE NAME FROM PERSON TO PERSON0, COUNSELOR TO GUIDE
DELETE GUIDE
WHERE GPERSONID IN (SELECT PERSONID 
                   FROM PERSON0 
                   WHERE BIRTHDATE <= SYSDATE - INTERVAL '60' YEAR);
COMMIT;

-----CHANGED THE TABLE NAME FROM PERSON TO PERSON0        
DELETE PERSON0
WHERE BIRTHDATE <= SYSDATE - INTERVAL '60' YEAR 
      AND PERSONID NOT IN (SELECT PERSONID_
                           FROM INTERESTED)
                                            

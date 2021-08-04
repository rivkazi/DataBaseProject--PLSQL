---------------------------------------------OUR UNIT-----------------------------------------------
CREATE VIEW OPENDAYS_LIST AS(
    SELECT opendayid, numparticipants,
           CONCAT(o_day, CONCAT('/', CONCAT(o_month ,CONCAT(' at ', o_hour)))) AS DATETIME,
           CONCAT('Lecture Number: ', lectureid) AS IDENTICALNUMBER, 
           CONCAT('Lecture About: ', subject) AS OPENDAYTYPE, lecturelocation AS TOOKPLACEIN
    FROM guestlectures NATURAL JOIN opendays
    
         UNION
         
    SELECT opendayid, numparticipants,
           CONCAT(o_day, CONCAT('/', CONCAT(o_month ,CONCAT('at ', o_hour)))) AS DATETIME,
           CONCAT('Tour Number: ',tourid), 
           CONCAT(CONCAT('Tour at: ', compantstatus), ' company'), companyname
    FROM opendays NATURAL JOIN (tourat NATURAL JOIN company));  
      
---SELECT *
SELECT *
FROM OPENDAYS_LIST;

---Q1 
SELECT t.opendayid, COUNT(personid)
FROM participantin p, (/*RETURN ONLY OPENDAYS HAVE MORE THAN ONE EVENT IN THIS DAY*/
                       SELECT opendayid
                       FROM OPENDAYS_LIST
                       GROUP BY opendayid
                       HAVING COUNT(opendayid) > 1 )o
WHERE p.opendayid = o.opendayid
GROUP BY o.opendayid;

---Q2
SELECT addressid, country, city, street
FROM address NATURAL JOIN (SELECT addressid
                          FROM locatedat
                          WHERE companyid IN (SELECT companyid
                                              FROM tourat
                                              WHERE tourid IN (SELECT SUBSTR(identicalnumber, 14) AS TOURID
                                              FROM OPENDAYS_LIST
                                              WHERE opendaytype LIKE 'Tour at%')))

---UPDATE
UPDATE OPENDAYS_LIST
SET numparticipants = 120
WHERE opendayid =(SELECT MIN(opendayid)
                  FROM OPENDAYS_LIST);

---DELETE
DELETE OPENDAYS_LIST O
WHERE tookplacein LIKE 'D%';

---DROP
DROP VIEW OPENDAYS_LIST;
 

------------------------------------------------UNIT1--------------------------------------------------
CREATE VIEW INTERESTEDÉ_AT AS(
SELECT personid_, 'Psychometric Test' AS EVENT_TYPE,
       CONCAT('Test At: ', CAST(psychodate AS VARCHAR(30))) AS EVENT_DESCRIPTION
FROM interested i,  psychometric p
WHERE i.personid_ = p.personid

  UNION
  
SELECT personid_, 'Consult Meeting', 
       CONCAT('Meeting on: ', SUBSTR(CAST(meetdate AS VARCHAR(30)), 1, 18))
FROM interested i,  meeting m
WHERE i.personid_ = m.personid

  UNION
  
SELECT personid_, 'Area Studies Search', CONCAT('Studies In: ', areaname)
FROM interested i,  interestedof inof
WHERE i.personid_ = inof.personid                                 

  UNION
  
SELECT personid, 'Bagrut Test', CONCAT('Bagrut In: ', bagrutname)
FROM interested i, (SELECT personid, bagrutname
                    FROM tested NATURAL JOIN bagrutsubject)b   
WHERE i.personid_ = b.personid)
 
---SELECT *
SELECT *
FROM INTERESTEDÉ_AT;

---Q1
SELECT personid_, firstname, lastname
FROM person p , INTERESTEDÉ_AT i
WHERE p.personid = i.personid_
GROUP BY personid_, firstname, lastname
HAVING COUNT(event_type) >= 2      

---Q2
SELECT event_type, COUNT(DISTINCT personid_) AS NUMPERSONS,
                   CONCAT(ROUND(COUNT(DISTINCT personid_)/(SELECT COUNT(DISTINCT PERSONID_)
                                              FROM INTERESTEDÉ_AT) * 100), '%') AS PERCENTAGE
FROM INTERESTEDÉ_AT
GROUP BY event_type

---UPDATE
UPDATE INTERESTEDÉ_AT
SET event_description = 'sewing and design'
WHERE event_description = 'sewing'

---DELETE
DELETE INTERESTEDÉ_AT I
WHERE REVERSE(personid_) LIKE  '147%'

---DROP
DROP VIEW INTERESTEDÉ_AT;



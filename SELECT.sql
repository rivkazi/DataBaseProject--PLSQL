SELECT T.subject, T.NUMPARTICIPANTS, 
       /*THE PERCENTAGE OF PARTICIPANTS OUT OF THE NUMBER OF STUDENTS*/
       CONCAT((ROUND(T.NUMPARTICIPANTS/ COUNT(spersonid)*100)), ' %')AS PERCENTAGE
FROM student, (/*SUM HOW MUCH PARTICIPANTS TOOK PART IN EVERY LECTURE*/
               SELECT subject, SUM(numparticipants) AS NUMPARTICIPANTS
               FROM opendays NATURAL JOIN guestlectures
               GROUP BY subject)T
GROUP BY T.subject, T.NUMPARTICIPANTS
ORDER BY T.NUMPARTICIPANTS DESC; 


SELECT personid, firstname, lastname
FROM person, (/*FIND ALL PEOPLE'S ID WHO PARTICIPANT IN TWO DIFFERENT LECTURES*/
              SELECT s1.spersonid
              FROM student s1, participantin p1, participantin p2, (/*FIND TWO DIFFERENT LECTURE'S SUBJECT*/
                                                                    SELECT DISTINCT g1.opendayid AS gl1, g2.opendayid AS gl2
                                                                    FROM guestlectures g1, guestlectures g2
                                                                    WHERE g1.subject <> g2.subject)O
              WHERE p1.personid = s1.spersonid and p2.personid = s1.spersonid 
                    and p1.opendayid = gl1 and p2.opendayid = gl2)
WHERE personid= spersonid; 


SELECT p.personid, p.firstname, p.lastname 
FROM (/*ALL STUDENTS WHO IN THEIR FOURTH ACADEMIC YEAR*/
      SELECT spersonid
      FROM student
      WHERE academicyear = 'Fourth'
           INTERSECT
      /*ALL STUDENTS WHO HAS WORK EXPERIENCE*/
      SELECT spersonid
      FROM student
      WHERE workexperience <> 0)I, person p 
WHERE I.spersonid = p.personid;                                     


SELECT p.personid, p.firstname, p.lastname
FROM person p, (/*ALL STUDENTS WHO TOOK PART IN BOTH CONSULTING MEETING AND OPEN DAY*/
                 SELECT spersonid
                 FROM student
                 WHERE spersonid IN (SELECT spersonid
                                     FROM (/*ALL THE STUDENTS TOOK CONSULTING MEETING*/
                                           SELECT spersonid
                                           FROM consulting)s1 
                                               NATURAL JOIN
                                          (/*ALL THE STUDENTS TOOK PART IN OPEN DAY AFTER MARCH*/
                                           SELECT spersonid
                                           FROM participantin NATURAL JOIN opendays
                                           WHERE o_month > 3)s2))N
WHERE p.personid = N.spersonid;


SELECT DISTINCT companyname, compantstatus, foundationdate 
FROM company
WHERE companyid IN (/*ALL COMPANIES WHO HOST A TOUR*/
                    SELECT c.companyid
                    FROM company c, tourat t
                    WHERE t.companyid = c.companyid); 
                    
                    
SELECT sDegree, COUNT(*)
FROM student
GROUP BY sDegree
HAVING COUNT(*) > 50
ORDER BY COUNT(*) DESC;

                    
SELECT p1.personid, CONCAT(CONCAT(p1.firstname, ' '), p1.lastname) AS NAME1,
       p2.personid, CONCAT(CONCAT(p2.firstname, ' '), p2.lastname) AS NAME2
FROM student s, guide g, consulting c, person p1, person p2
WHERE c.spersonid = s.spersonid and c.gpersonid = g.gpersonid
      and s.spersonid = p1.personid and g.gpersonid = p2.personid
      and p1.firstname LIKE '%y' and p2.firstname LIKE '%y';               
   

                 
SELECT companyid, companyname
FROM company NATURAL JOIN (/*ALL COMPANIRS LOCATED AT THE USA*/
                           SELECT companyid
                           FROM locatedat NATURAL JOIN adress
                           WHERE country = 'USA')A
WHERE EXTRACT(year FROM foundationdate) >= '1970'
ORDER BY companyid;                           
                                              
                    
                    

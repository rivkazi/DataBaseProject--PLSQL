---Q1
/*INSTEAD OF TAKING ALL STUDENTS PARTICIPANTES IN OPEN DAY AFTER MARCH,
WE CHANGED THE MONTH TO BE DEPEND ON A PARAMETEER, THE PARAMETER IS SELECTED FROM A DICTIONARY.
WE REMAIN THE MARCH MONTH TO BE DEFAULTIVE VALUE*/
SELECT p.personid, p.firstname, p.lastname
FROM person0 p, (/*ALL STUDENTS WHO TOOK PART IN BOTH CONSULTING MEETING AND OPEN DAY*/
                 SELECT personid
                 FROM person0
                 WHERE personid IN 
                                    (SELECT personid
                                     FROM (/*ALL THE STUDENTS TOOK CONSULTING MEETING*/
                                           SELECT personid
                                           FROM meeting)s1 
                                               NATURAL JOIN
                                          (/*ALL THE STUDENTS TOOK PART IN OPEN DAY AFTER MARCH*/
                                           SELECT personid
                                           FROM participantin NATURAL JOIN opendays
                                           WHERE o_month > &<NAME = "openDay_month"
                                                             HINT = "SELECT MONTH AS A PARAMETER"
                                                             LIST = "1, JANUAR, 2, FEBRUAR, 3, MARCH,
                                                                     4, APRIL, 5, MAY"
                                                             DESCRIPTION = "TRUE"
                                                             DEFAULT = 3
                                                             TYPE = "STRING">)s2))N
                                                                                          
WHERE p.personid = N.personid;

---Q2
/*INSTEAD OF CONSIDERING USA AS THE COUNTRY,
WE CHANGED THE COUNTRY TO BE DEPEND ON A PARAMETEER, THE PARAMETER IS SELECTED FROM A LIST.
WE CHANGED THE SORTING ORDER TO BE WRITTEN BY PERFIX AND SUFFIX AND TO BE CHOSEN FOR AN ATTRIBUTE*/
SELECT companyid, companyname
FROM company NATURAL JOIN (/*ALL COMPANIRS LOCATED AT THE USA*/
                           SELECT DISTINCT companyid
                           FROM locatedat NATURAL JOIN address0
                           WHERE country = &<NAME = "COUNTRY_NAME"
                           HINT = "SELECT A COUNTRY"
                           LIST = "USA, Israel, Brazil, Germany, Japan"
                           REQUIRED = "TRUE"
                           TYPE = "STRING">)A
WHERE EXTRACT(year FROM foundationdate) >= '1970'
&<NAME = "SORTING_ORDER"
 PREFIX = " ORDER BY "
 LIST = "COMPANYID, COMPANYNAME"
 HINT = "SELECT AN ATTRIBUTE FOR SORTING ORDER"
 SUFFIX = " ASC">; 
                    
---Q3   
/*INSTEAD OF CONSIDERING FOURTH YEAR AS THE ACADEMIC YEAR,
WE CHANGED THE ACADEMIC YEAR TO BE DEPEND ON A PARAMETEER, WE GET IT FROM THE USER,
IF THE USER DOESNT GIVING ANY YEAR, WE FILL THIS WITH Fourth ACADEMIC YEAR
WE ALSO CHANGED THE EXPERIENCE YEARS TO BE DEPENDED ON A CHECKBOX, CHECK FOR 1 YEAR*/                  
SELECT p.personid, p.firstname, p.lastname 
FROM (/*ALL STUDENTS WHO IN THEIR FOURTH ACADEMIC YEAR*/
      SELECT spersonid
      FROM student
      WHERE academicyear = &<NAME = "ACADEMIC_YEAR"
                             HINT = "TYPE THE YEAR AS YOU WANT: First/ Second/ Third/ Fourth"
                             TYPE = "STRING"
                             IFEMPTY = "Fourth">
      --'Fourth'
           INTERSECT
      /*ALL STUDENTS WHO HAS WORK EXPERIENCE*/
      SELECT spersonid
      FROM student
      WHERE workexperience <> &<NAME = "EXPERIENCE_YEARS"
                                HINT = "CHECK FOR 1 YEAR OF EXPERIENCE, OTHERWISE 0 YEARS"
                                TYPE = "STRING"
                                CHECKBOX = "1, 0">)I, person0 p 
WHERE I.spersonid = p.personid;    

---Q4
/*QUERY THAT RETURNS DETAILS OF COMPANY BY CHOSING THEIR NAMES
IT CAN BE A MULTIPLE CHOICES OF NAMES*/
SELECT *
FROM company
WHERE companyid IN (&<NAME = "COMPANY_NAME"
                      LIST = "SELECT DISTINCT companyid, companyname FROM company ORDER BY companyname"
                      HINT = "CHECK THE WANTED COMPANY NAMES"
                      TYPE = "STRING"
                      DESCRIPTION = "TRUE"
                      MULTISELECT = "YES">)












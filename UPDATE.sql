SELECT *
FROM person;

UPDATE person
SET phonenumber = CONCAT(CONCAT((SUBSTR(phonenumber,1,3)),
                                 '-'),
                                (SUBSTR(phonenumber,4,7)));                              
SELECT *
FROM person;                                
                                 

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

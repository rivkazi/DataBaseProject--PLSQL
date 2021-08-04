CREATE OR REPLACE PROCEDURE Main IS
---FIELDS FOR APPLY THE FUNCTION AND PROCEDURES WITHIN THE MAIN
treshold_num_meetings number := 10; --FOR INPUT- TRESHOLD FOR TOP GUIDE PROCEDURE
degree_occupation_result varchar2(300); --FOR OUTPUT- RESULT OF DEGREE OCUPATION FUNCTION
company_tour_result varchar2(300); --FOR OUTPUT- RESULT OF COMPANY TOUR FUNCTION
  
 ---ALL DEGREES BY THEIR NAMES
 CURSOR degrees IS
  SELECT DISTINCT sdegree
  FROM student; 

 ---ALL COMPANIES BY THEIR ID
  CURSOR companies IS
   SELECT companyid
   FROM company
   ORDER BY companyid
   OFFSET 4 ROWS FETCH NEXT 20 ROWS ONLY; --TAKE ONLY THE COMPANIES IN ROWS FROM 5 TILL 25  

BEGIN
--First, The year is about to end, So we want to add a lecture for all senior students and register them to it  
dbms_output.put_line('************************************************'); 
dbms_output.put_line('               Graduate Procedure               '); 
dbms_output.put_line('************************************************'); 
TopGuidesProcedure(treshold_num_meetings); --CALLING THE PROCEDURE WITH THE INPUT VALUE  
dbms_output.put_line('------------------------------------------------'); 

dbms_output.put_line('');
dbms_output.put_line('');

--Second, We want to register all the best guides to a nice tour at 'Diamond Group Company'
dbms_output.put_line('************************************************'); 
dbms_output.put_line('              Top Guides Procedure              ');
dbms_output.put_line('************************************************');  
GraduatesProcedure(); --CALLING THE PROCEDURE 
dbms_output.put_line('------------------------------------------------'); 

dbms_output.put_line('');
dbms_output.put_line('');

--For the report of the end of the year, we want to show some statistics and data
dbms_output.put_line('************************************************'); 
dbms_output.put_line('           Degree Occupation Function           '); 
dbms_output.put_line('************************************************'); 

--CALLING THE FUNCTION FOR EVERY DEGREE NAME FROM THE CURSOR
FOR degree IN degrees
  LOOP --GOT THE RESULT AFTER SENDING THE INPUT AND APPLY
    degree_occupation_result := DegreeOccupation(degree.sdegree);
    dbms_output.put_line(degree_occupation_result);
  END LOOP;
dbms_output.put_line('------------------------------------------------'); 

dbms_output.put_line('');
dbms_output.put_line('');
    
dbms_output.put_line('************************************************'); 
dbms_output.put_line('             Company Tour Function              '); 
dbms_output.put_line('************************************************'); 

--CALLING THE FUNCTION FOR EVERY COMPANY NUMBER FROM THE CURSOR
FOR company IN companies
  LOOP --GOT THE RESULT AFTER SENDING THE INPUT AND APPLY
    company_tour_result := CompanyTour(company.companyid);
    dbms_output.put_line('Company number ' || company.companyid || ': ' || company_tour_result);
  END LOOP;

dbms_output.put_line('------------------------------------------------');   
dbms_output.put_line('');

END;
/

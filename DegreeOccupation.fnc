CREATE OR REPLACE NONEDITIONABLE FUNCTION DegreeOccupation(degree in varchar2) return varchar2 IS
  --FIELDS
  inputDegree varchar2(50) := degree; --INPUT DIELD
  FunctionResult varchar2(300); --RETURN DIELD
  helpParameter number; --FOR HELPING WITH THE CALCULATION LATER
  allStudents number;
  
  ---FIELDS FOR EXCEPTION
  nullInput EXCEPTION;
  PRAGMA EXCEPTION_INIT(nullInput, -9880);
  degreeDoesntExists EXCEPTION;
  PRAGMA EXCEPTION_INIT(degreeDoesntExists, -9881);
  message varchar2(100);
  
  ---ALL DEGREES BY THEIR NAME AND THE NUMBER OF STUDENTS STUDYING IT
  CURSOR degrees IS
  SELECT COUNT(*) AS numStudents
  FROM student
  WHERE sdegree = inputDegree;    
        
  ---RECORD OF A CURSOR
  degree_record degrees%Rowtype;
  
BEGIN
  IF (inputDegree IS NULL) THEN
    message := 'The input parameter came NULL, so there is no specified degree';
    RAISE nullInput; --RAISE EXCEPTION
  END IF;

  --FINDS THE NUMBER OF ALL STUDENTS IN THE UNIIVERSITY
  SELECT COUNT(*) INTO allStudents
  FROM student;
  
  OPEN degrees; --OPENING THE CURSOR
      FETCH degrees INTO degree_record; --FETCHING A RECORD
      IF(degrees%NOTFOUND OR degree_record.numStudents = 0) THEN
      message := 'this degree, named: ' || inputDegree || ' does not exists';
      RAISE degreeDoesntExists; --IF NOT THEN RAISE EXCEPTION
       ELSE 
         SELECT CAST((degree_record.numStudents / allStudents) AS DECIMAL(10,3))INTO helpParameter
         FROM DUAL;
         FunctionResult := 'For this degree, ' || inputDegree ||
                           ', The occupation of students in Popko University is: ' || helpParameter || '%';
        RETURN(FunctionResult); 
      END IF;
  CLOSE degrees;
  
  EXCEPTION
    WHEN nullInput THEN
      dbms_output.put_line(message); 
      RETURN('Exception- null input'); 
      
    WHEN degreeDoesntExists THEN
      dbms_output.put_line(message); 
      RETURN('Exception- degree does not exists');   
  END;
/

CREATE OR REPLACE NONEDITIONABLE PROCEDURE GraduatesProcedure IS
 ---FIELDS FOR ADDING OPENDAY AND GUESTLECTURE
 lectureID number := '50';
 lectureSubject varchar2(30) := 'The Day After Graduation';
 lectureLocation varchar2(20) := 'Popko-50';
 openDayID number := '70';
 openDayParticipant number := 200;
 openDayD number := 1;
 openDayM number := 8;
 openDayH varchar2(10) := '9:30';
 
 ---FIELDS FOR EXCEPTION
 cannotInsertOpenDay EXCEPTION;
 PRAGMA EXCEPTION_INIT(cannotInsertOpenDay, -9876);
 cannotInsertGuestLecture EXCEPTION;
 PRAGMA EXCEPTION_INIT(cannotInsertGuestLecture, -9877);
 message varchar2(30);
 
 ---CONSTANT FIELDS
 graduateYear CONSTANT varchar2(20) := 'Fourth';
 
 ---ALL THE STUDENTS WHO'S GRADUATING(IN THEIR FOURTH ACADEMIC YEAR)
 CURSOR graduatedStudents IS
  SELECT DISTINCT personid, firstName, lastName
  FROM person0 p, student s
  WHERE p.personid = s.spersonid and academicYear = graduateYear;
 
 ---RECORD OF A GRADUETED STUDENT
 GraduetedStudent graduatedStudents%Rowtype;
 
BEGIN
  --TRYING INSERT NEW OPEN DAY
  INSERT INTO OPENDAYS (OPENDAYID, NUMPARTICIPANTS, O_DAY, O_MONTH, O_HOUR)
  VALUES (openDayID, openDayParticipant, openDayD, openDayM, openDayH);
  
  --CHECKING IF IT WENT WELL
  IF(SQL%NOTFOUND) THEN 
   message := 'Couldnt insert the new open day, number: ' || openDayID;
   RAISE cannotInsertOpenDay; --IF NOT THEN RAISE EXCEPTION
  
   ELSE --IF YES THEN TRYING INSERT NEW GUEST LECTURE
      dbms_output.put_line('Open day number ' || openDayID || 'added successfuly');
     INSERT INTO GUESTLECTURES (LECTUREID, OPENDAYID, SUBJECT, LECTURELOCATION)
     VALUES (lectureID, openDayID, lectureSubject, lectureLocation);
     
     --CHECKING IF IT WENT WELL
     IF(SQL%NOTFOUND) THEN
      message := 'Couldnt insert the new guest lecture, number: ' || lectureID;
      RAISE cannotInsertGuestLecture; --IF NOT THEN RAISE EXCEPTION
       
     ELSE --IF YES THEN REGISTER ALL GRADUETED STUDENTS TO THE NEW LECTURE
       dbms_output.put_line('Guest Lecture number ' || lectureID || 'added successfuly');
       IF NOT graduatedStudents%ISOPEN THEN
        OPEN graduatedStudents;
       END IF;
       LOOP --FOR EVERY RECORD IN THE CURSOR
        FETCH graduatedStudents INTO GraduetedStudent; --FETCHING A RECORD
        --FOR REGISTERING THIS STUDENTS, WE NEED TO INSERT TO BOTH INTERESTED ANS PARTICIPANT IN
        INSERT INTO interested
        SELECT GraduetedStudent.personid
        FROM DUAL
        WHERE GraduetedStudent.personid NOT IN (SELECT * FROM INTERESTED);

        INSERT INTO PARTICIPANTIN
        SELECT GraduetedStudent.personid, openDayID
        FROM DUAL 
        WHERE GraduetedStudent.personid NOT IN (SELECT personid FROM PARTICIPANTIN);
        
        --EXIT WHEN THERE ARE NOT RECORDS LEFT
        EXIT WHEN graduatedStudents%NOTFOUND;
       END LOOP;
       dbms_output.put_line('All students added successfuly');
       CLOSE graduatedStudents;
     END IF; 
  END IF;
 
 ---DEALING WITH EXCEPTIONS
 EXCEPTION
  WHEN cannotInsertOpenDay THEN
    dbms_output.put_line(message);  
    
  WHEN cannotInsertGuestLecture THEN
    dbms_output.put_line(message); 
  
  WHEN DUP_VAL_ON_INDEX THEN
     dbms_output.put_line('Unique Constarint Violation'); 
END;
/

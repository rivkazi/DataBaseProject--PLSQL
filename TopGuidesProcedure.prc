CREATE OR REPLACE NONEDITIONABLE PROCEDURE TopGuidesProcedure(treshold in number) IS
---FIELDS FOR ADDING OPENDAY AND GUESTLECTURE
 tourid number := '30';
 companyid number := '95'; --Diamond Group Company
 openDayID number := '72';
 openDayParticipant number := 30;
 openDayD number := 5;
 openDayM number := 8;
 openDayH varchar2(10) := '12:30';
 
 guideCounter number := '0';
 
 ---FIELDS FOR EXCEPTION
 cannotInsertOpenDay EXCEPTION;
 PRAGMA EXCEPTION_INIT(cannotInsertOpenDay, -9878);
 cannotInsertTour EXCEPTION;
 PRAGMA EXCEPTION_INIT(cannotInsertTour, -9879);
 nullInput EXCEPTION;
 PRAGMA EXCEPTION_INIT(nullInput, -9880);
 message varchar2(100);
 
 ---CONSTANT FIELDS
 num_consulting_treshold CONSTANT number := treshold; --the input paramet10
 
 ---ALL GUIDES BY THEIR ID NUMBER AND THE NUMBER OFCONSULTING MEETINGS THE'VE DONE 
 CURSOR guides IS
  SELECT gpersonid, COUNT(c.consultid) AS NUMCONSULTS
  FROM guide g, consulting c
  WHERE g.gpersonid = c.counselorid
  GROUP BY c.counselorid;
 
 ---RECORD OF A GUIDE
 Guide guides%Rowtype;
 
BEGIN
  --CHECKING IF THE INPUT CAME NULL
  IF (treshold IS NULL) THEN
    message := 'The input parameter came NULL, so there is no treshold';
    RAISE nullInput; --RAISE EXCEPTION
  END IF;
    
   --TRYING INSERT NEW OPEN DAY
   INSERT INTO OPENDAYS
   SELECT openDayID, openDayParticipant, openDayD, openDayM, openDayH
   FROM DUAL 
   WHERE openDayID NOT IN (SELECT openDayID FROM OPENDAYS);
  
  --CHECKING IF IT WENT WELL
  IF(SQL%NOTFOUND) THEN 
   message := 'Couldnt insert the new open day, number: ' || openDayID;
   RAISE cannotInsertOpenDay; --IF NOT THEN RAISE EXCEPTION
  
   ELSE --IF YES THEN TRYING INSERT NEW TOUR
      dbms_output.put_line('Open day number ' || openDayID || ' added successfuly');
      INSERT INTO TOURAT
      SELECT tourid, companyid, openDayID
      FROM DUAL 
      WHERE tourid NOT IN (SELECT tourid FROM TOURAT);
     
     --CHECKING IF IT WENT WELL
     IF(SQL%NOTFOUND) THEN
      message := 'Couldnt insert the new tour, number: ' || tourid;
      RAISE cannotInsertTour; --IF NOT THEN RAISE EXCEPTION
       
     ELSE --IF YES THEN REGISTER ALL GRADUETED STUDENTS TO THE NEW LECTURE
       dbms_output.put_line('Tour number ' || tourid || ' added successfuly');
       IF NOT guides%ISOPEN THEN
        OPEN guides;
       END IF;
       LOOP --FOR EVERY RECORD IN THE CURSOR
        FETCH guides INTO Guide; --FETCHING A RECORD
        IF(Guide.NUMCONSULTS > num_consulting_treshold) THEN --ONLY IF IT'S OVER THE TRESHOLD
            --WE NEED TO REGISTER THIS GUIDE TO THIS TOUR, 
             --SO WE NEED TO ADD HIM TO INTERESTED AND PARTICIPAN IN
          INSERT INTO interested
          SELECT Guide.gpersonid
          FROM DUAL
          WHERE Guide.gpersonid NOT IN (SELECT * FROM INTERESTED);

          INSERT INTO PARTICIPANTIN
          SELECT Guide.gpersonid, openDayID
          FROM DUAL 
          WHERE Guide.gpersonid NOT IN (SELECT personid FROM PARTICIPANTIN);
              
          guideCounter := guideCounter + 1;
               
        END IF;
         
        --EXIT WHEN THERE ARE NO RECORDS LEFT
        EXIT WHEN guides%NOTFOUND;
       END LOOP;
       dbms_output.put_line('The Number Of guides found fit to the condition is: ' || guideCounter);
       dbms_output.put_line('They all added successfuly');
       CLOSE guides;
     END IF; 
  END IF;
 
 ---DEALING WITH EXCEPTIONS
 EXCEPTION
  WHEN cannotInsertOpenDay THEN
    dbms_output.put_line(message);  
    
  WHEN cannotInsertTour THEN
    dbms_output.put_line(message); 
    
  WHEN nullInput THEN
  dbms_output.put_line(message); 
  
  WHEN DUP_VAL_ON_INDEX THEN
     dbms_output.put_line('Unique Constarint Violation'); 
  
END;
/

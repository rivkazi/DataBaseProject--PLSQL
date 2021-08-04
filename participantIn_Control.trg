CREATE OR REPLACE TRIGGER participantIn_Control
  BEFORE INSERT
  ON participantin 
  FOR EACH ROW 
 
DECLARE
  -- local variables here
  ControlMessage VARCHAR2(100);
  openDayID number; --for saving the day ID, if exists
  openDayDoesntExists EXCEPTION;
  PRAGMA exception_init(openDayDoesntExists, -20111);
 
  ---ALL OPEN DAYS BY THEIR ID
  CURSOR allOpenDays IS
   SELECT opendayid 
   FROM opendays 
   WHERE opendayid = (:NEW.opendayid);     
        
  ---RECORD OF A OPEN DAY
  openDayRecord allOpenDays%Rowtype;
    
BEGIN  
  
  OPEN allOpenDays; --OPENING THE CURSOR
     FETCH allOpenDays INTO openDayRecord; --FETCHING A RECORD
     IF(allOpenDays%NOTFOUND) THEN
       ControlMessage := 'This open day does not exists';
       RAISE openDayDoesntExists;
    
      ELSE 
        DBMS_OUTPUT.PUT_LINE('This record has been INSERTED');  
     END IF;
   CLOSE allOpenDays;
    
  EXCEPTION
   WHEN openDayDoesntExists THEN
    DBMS_OUTPUT.PUT_LINE(ControlMessage); 
    
END;
/

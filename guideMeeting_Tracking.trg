CREATE OR REPLACE TRIGGER guideMeeting_Tracking
  AFTER INSERT OR DELETE OR UPDATE 
  ON consulting 
  FOR EACH ROW 
    
DECLARE
  --local variables here
  TrackMessage VARCHAR2(100):= 'Dont forget Update the Counselor';
BEGIN
  
  CASE
    WHEN INSERTING THEN
      DBMS_OUTPUT.PUT_LINE('This meeting INSERTED, ' || TrackMessage);
    WHEN DELETING THEN
      DBMS_OUTPUT.PUT_LINE('This meeting DELETED, ' || TrackMessage); 
    WHEN UPDATING THEN
      DBMS_OUTPUT.PUT_LINE('This meeting UPDATED, ' || TrackMessage); 
  END CASE;   
      
END;
/

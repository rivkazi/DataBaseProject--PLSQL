CREATE OR REPLACE NONEDITIONABLE FUNCTION CompanyTour(company_ID in number) return varchar2 IS
  --FIELDS
  inputCompanyID number := company_ID; --INPUT DIELD
  FunctionResult varchar2(50):= ' '; --RETURN DIELD
  
   ---FIELDS FOR EXCEPTION
  nullInput EXCEPTION;
  PRAGMA EXCEPTION_INIT(nullInput, -9880);
  companyDoesntExists EXCEPTION;
  PRAGMA EXCEPTION_INIT(companyDoesntExists, -9881);
  message varchar2(100);
  
  ---ALL TOURS BY THEIR TIME AND THE NUMBER OF THE COMPANY THAT THE TOUR TOOK PLACE AT
  CURSOR CompanyTours IS
  (SELECT companyid, tourid, tourtime
  FROM (SELECT opendayid, tourid, CONCAT(o_day, CONCAT('/', o_month)) AS tourTime
        FROM opendays NATURAL JOIN tourat) NATURAL JOIN tourat 
  WHERE companyid = inputCompanyID);      
        
  ---RECORD OF A TOUR
  CompanyTour CompanyTours%Rowtype;
  
BEGIN
  IF (inputCompanyID IS NULL) THEN
    message := 'The input parameter came NULL, so there is no companyID';
    RAISE nullInput; --RAISE EXCEPTION
  END IF;
  
  OPEN CompanyTours; --OPENING THE CURSOR
      FETCH CompanyTours INTO CompanyTour; --FETCHING A RECORD
      IF(CompanyTours%FOUND) THEN
        FunctionResult := ' This company had a tour number: ' || CompanyTour.tourid ||
                         ' at ' || CompanyTour.tourTime;
        RETURN(FunctionResult); 
        
      ELSE
          message := ' does not exists or there is no tour for it';
          RAISE companyDoesntExists; --IF NOT THEN RAISE EXCEPTION
      END IF;
  CLOSE CompanyTours;
  
  ---DEALING WITH EXCEPTIONS
 EXCEPTION

  WHEN nullInput THEN
    RETURN(message); 
    
  WHEN companyDoesntExists THEN
    RETURN(message);   
END;
/

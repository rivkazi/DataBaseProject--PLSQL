insert into CONSULTING (CONSULTID, COUNSELORID, PERSONID, RECEPTIONTIME, CONTACTEMAIL)
values (500, '733671126', '534714313', '12:00 - 15:00', 'consulting@gmail.com');
commit;

select *
from consulting
where consultID = '500'

update consulting 
set receptionTime = '9:00 - 12:00'
where consultID = '500'

delete consulting
where consultID = '500'

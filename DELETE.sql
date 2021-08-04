SELECT lectureid
FROM guestlectures g, opendays o
WHERE g.opendayid = o.opendayid and o.o_month < '4';

DELETE guestlectures g
WHERE g.lectureid in (SELECT g.lectureid
       FROM guestlectures g, opendays o
       WHERE g.opendayid = o.opendayid and o.o_month< '4');
       
SELECT lectureid
FROM guestlectures g, opendays o
WHERE g.opendayid = o.opendayid and o.o_month < '4'


SELECT tourid, companyname
FROM tourat NATURAL JOIN company
WHERE companyname LIKE 'K%';

DELETE tourat t
WHERE tourid IN (SELECT tourid
                 FROM tourat NATURAL JOIN company
                 WHERE companyname LIKE 'K%');
                 
SELECT tourid, companyname
FROM tourat NATURAL JOIN company
WHERE companyname LIKE 'K%';
                                                                                            

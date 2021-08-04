
[General]
Version=1

[Preferences]
Username=
Password=2660
Database=
DateFormat=dd/mm/yyyy
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=PERSON
Count=1000

[Record]
Name=PERSONID
Type=VARCHAR2
Size=20
Data=[999999999]
Master=

[Record]
Name=FIRSTNAME
Type=VARCHAR2
Size=20
Data=FirstName
Master=

[Record]
Name=LASTNAME
Type=VARCHAR2
Size=20
Data=LastName
Master=

[Record]
Name=BIRTHDATE
Type=DATE
Size=
Data=Random(01/01/1987, 01/01/2002)
Master=

[Record]
Name=PHONENUMBER
Type=VARCHAR2
Size=20
Data='0'[999999999]
Master=

[Record]
Name=EMAIL
Type=VARCHAR2
Size=35
Data=Email
Master=

[Record]
Name=ADRESSID
Type=NUMBER
Size=
Data=List(select ADRESSID from ADRESS)
Master=


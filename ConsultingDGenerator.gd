
[General]
Version=1

[Preferences]
Username=
Password=2987
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=CONSULTING
Count=450

[Record]
Name=CONSULTID
Type=NUMBER
Size=
Data=Sequence(11)
Master=

[Record]
Name=GPERSONID
Type=VARCHAR2
Size=20
Data=List(select GPERSONID from GUIDE)
Master=

[Record]
Name=SPERSONID
Type=VARCHAR2
Size=20
Data=List(select SPERSONID from STUDENT)
Master=

[Record]
Name=RECEPTIONTIME
Type=VARCHAR2
Size=20
Data=List('9:00 - 13:00', '16:00 - 19:00', '12:00 - 15:00')
Master=

[Record]
Name=CONTACTEMAIL
Type=VARCHAR2
Size=35
Data=List('consult@gmail.com', 'mainoffice@gmail.com', 'help@gmail.com') 
Master=


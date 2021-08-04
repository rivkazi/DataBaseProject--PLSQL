
[General]
Version=1

[Preferences]
Username=
Password=2796
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=PARTICIPANTIN
Count=500

[Record]
Name=PERSONID
Type=VARCHAR2
Size=20
Data=List(select PERSONID from PERSON)
Master=

[Record]
Name=OPENDAYID
Type=NUMBER
Size=
Data=List(select OPENDAYID from OPENDAYS)
Master=


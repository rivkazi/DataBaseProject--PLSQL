
[General]
Version=1

[Preferences]
Username=
Password=2325
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=TOURAT
Count=10

[Record]
Name=TOURID
Type=NUMBER
Size=
Data=Sequence(11)
Master=

[Record]
Name=COMPANYID
Type=NUMBER
Size=
Data=List(select COMPANYID from COMPANY)
Master=

[Record]
Name=OPENDAYID
Type=NUMBER
Size=
Data=List(select OPENDAYID from OPENDAYS)
Master=


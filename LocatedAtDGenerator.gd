
[General]
Version=1

[Preferences]
Username=
Password=2116
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=LOCATEDAT
Count=250

[Record]
Name=COMPANYID
Type=NUMBER
Size=
Data=Sequence(11)
Master=

[Record]
Name=ADRESSID
Type=NUMBER
Size=
Data=List(select ADRESSID from ADRESS)
Master=


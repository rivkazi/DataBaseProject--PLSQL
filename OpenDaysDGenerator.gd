
[General]
Version=1

[Preferences]
Username=
Password=2386
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=OPENDAYS
Count=2

[Record]
Name=OPENDAYID
Type=NUMBER
Size=
Data=Sequence(11)
Master=

[Record]
Name=NUMPARTICIPANTS
Type=NUMBER
Size=
Data=List('75', '80', '100', '150', '200', '250')
Master=

[Record]
Name=O_DAY
Type=NUMBER
Size=
Data=Random(1, 31)
Master=

[Record]
Name=O_MONTH
Type=NUMBER
Size=
Data=Random(1, 12)
Master=

[Record]
Name=O_HOUR
Type=VARCHAR2(20)
Size=
Data=Random(9, 21)
Master=


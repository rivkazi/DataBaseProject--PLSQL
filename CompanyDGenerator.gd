
[General]
Version=1

[Preferences]
Username=
Password=2741
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=COMPANY
Count=250

[Record]
Name=COMPANYID
Type=NUMBER
Size=
Data=Sequence(11)
Master=

[Record]
Name=COMPANYNAME
Type=VARCHAR2
Size=40
Data=Company
Master=

[Record]
Name=FOUNDATIONDATE
Type=DATE
Size=
Data=Random(01/01/1920, 01/01/2021)
Master=

[Record]
Name=COMPANTSTATUS
Type=VARCHAR2
Size=20
Data=List('Start-Up', 'Research', 'Software Development', 'Marketing', 'Testing')
Master=


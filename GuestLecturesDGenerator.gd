
[General]
Version=1

[Preferences]
Username=
Password=2539
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=GUESTLECTURES
Count=18

[Record]
Name=LECTUREID
Type=NUMBER
Size=
Data=Sequence(23)
Master=

[Record]
Name=OPENDAYID
Type=NUMBER
Size=
Data=List(select OPENDAYID from OPENDAYS)
Master=

[Record]
Name=SUBJECT
Type=VARCHAR2
Size=30
Data=List('LinkedIn', 'HighTech-Career', 'Resume', 'WorkInterview', 'PreparingToWork', 'LaborMarket', 'CapitalMarket', 'PreparingToTechnicalInterview', 'DigitalMarketing', 'HowToDealStress')
Master=

[Record]
Name=LECTURELOCATION
Type=VARCHAR2
Size=20
Data=List('Popko-2', 'Popko-11', 'Popko-12', 'Popko-13', 'Popko-24', 'Popko-50')
Master=


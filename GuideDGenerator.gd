
[General]
Version=1

[Preferences]
Username=
Password=2251
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=GUIDE
Count=30

[Record]
Name=GPERSONID
Type=VARCHAR2
Size=20
Data=List(select PERSONID from PERSON)
Master=

[Record]
Name=GROLE
Type=VARCHAR2
Size=20
Data=List('Guide', 'Counselor', 'Employment- Oriented', 'Academic Counselor', 'Head Of Department')
Master=

[Record]
Name=EXPERIENCE
Type=NUMBER
Size=
Data=Random(3, 21)
Master=

[Record]
Name=SPECIALIZATION
Type=VARCHAR2
Size=35
Data=List('Emotional Consulting', 'Objective Opinion', 'Academic Consulting', 'Commercial Consulting')
Master=



[General]
Version=1

[Preferences]
Username=
Password=2090
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYS
Name=STUDENT
Count=400

[Record]
Name=SPERSONID
Type=VARCHAR2
Size=20
Data=List(select PERSONID from PERSON)
Master=

[Record]
Name=SDEGREE
Type=VARCHAR2
Size=30
Data=List('Physics', 'Mathematics', 'Computer Science'' Software Engineering', 'Buisness Administration', 'Accounting', 'Bioinformatics', 'Industrial& Management', 'Nursing', 'Pharmacy')
Master=

[Record]
Name=SPECIALIZATION
Type=VARCHAR2
Size=20
Data=List('Data Science', 'Science', 'Society', 'Management', 'Marketing', 'Digital')
Master=

[Record]
Name=ACADEMICYEAR
Type=VARCHAR2
Size=20
Data=List('First', 'Second', 'Third', 'Fourth')
Master=

[Record]
Name=WORKEXPERIENCE
Type=NUMBER
Size=
Data=List('0', '1', '2')
Master=


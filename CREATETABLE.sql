CREATE TABLE adress
(
  adressID INT NOT NULL,
  country VARCHAR2(20) NOT NULL,
  city VARCHAR2(20) NOT NULL,
  street VARCHAR2(30),
  PRIMARY KEY (adressID)
);

CREATE TABLE person
(
  personID VARCHAR2(20) NOT NULL,
  firstName VARCHAR2(20) NOT NULL,
  lastName VARCHAR2(20) NOT NULL,
  birthDate DATE NOT NULL,
  phoneNumber VARCHAR2(20) NOT NULL,
  email VARCHAR2(35) NOT NULL,
  adressID INT NOT NULL,
  PRIMARY KEY (personID),
  FOREIGN KEY (adressID) REFERENCES adress(adressID)
);

CREATE TABLE student
(
  SpersonID VARCHAR2(20) NOT NULL,
  sDegree VARCHAR2(30) NOT NULL,
  specialization VARCHAR2(20) NOT NULL,
  academicYear VARCHAR2(20) NOT NULL,
  workExperience INT NOT NULL,
  PRIMARY KEY (SpersonID),
  FOREIGN KEY (SpersonID) REFERENCES person(personID)
);

CREATE TABLE guide
(
  GpersonID VARCHAR2(20) NOT NULL,
  gRole VARCHAR2(20) NOT NULL,
  experience INT NOT NULL,
  specialization VARCHAR2(35) NOT NULL,
  PRIMARY KEY (GpersonID),
  FOREIGN KEY (GpersonID) REFERENCES person(personID)
);

CREATE TABLE consulting
(
  consultID INT NOT NULL,
  GpersonID VARCHAR2(20) NOT NULL,
  SpersonID VARCHAR2(20) NOT NULL,
  receptionTime VARCHAR2(20) NOT NULL,
  contactEmail VARCHAR2(20) NOT NULL,
  PRIMARY KEY (consultID),
  FOREIGN KEY (GpersonID) REFERENCES guide(GpersonID),
  FOREIGN KEY (SpersonID) REFERENCES student(SpersonID),
  UNIQUE (GpersonID, SpersonID)
);

CREATE TABLE company
(
  companyID INT NOT NULL,
  companyName VARCHAR2(20) NOT NULL,
  foundationDate DATE NOT NULL,
  compantStatus VARCHAR2(20) NOT NULL,
  PRIMARY KEY (companyID)
);

CREATE TABLE locatedAt
(
  companyID INT NOT NULL,
  adressID INT NOT NULL,
  PRIMARY KEY (companyID, adressID),
  FOREIGN KEY (companyID) REFERENCES company(companyID),
  FOREIGN KEY (adressID) REFERENCES adress(adressID)
);

CREATE TABLE openDays
(
  openDayID INT NOT NULL,
  numParticipants INT NOT NULL,
  o_day INT NOT NULL,
  o_month INT NOT NULL,
  o_hour VARCHAR2(20) NOT NULL,
  PRIMARY KEY (openDayID)
);

CREATE TABLE guestLectures
(
  lectureID INT NOT NULL,
  openDayID INT NOT NULL,
  subject VARCHAR2(30) NOT NULL,
  lectureLocation VARCHAR2(20) NOT NULL,
  PRIMARY KEY (lectureID, openDayID),
  FOREIGN KEY (openDayID) REFERENCES openDays(openDayID)
);

CREATE TABLE participantIn
(
  personID VARCHAR2(20) NOT NULL,
  openDayID INT NOT NULL,
  PRIMARY KEY (personID, openDayID),
  FOREIGN KEY (personID) REFERENCES student(SpersonID),
  FOREIGN KEY (openDayID) REFERENCES openDays(openDayID)
);

CREATE TABLE tourAt
(
  tourID INT NOT NULL,
  companyID INT NOT NULL,
  openDayID INT NOT NULL,
  PRIMARY KEY (tourID),
  FOREIGN KEY (companyID) REFERENCES company(companyID),
  FOREIGN KEY (openDayID) REFERENCES openDays(openDayID),
  UNIQUE (companyID, openDayID)
);

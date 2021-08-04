CREATE TABLE address1
(
  addressID INT NOT NULL,
  city varchar2(30) NOT NULL,
  street varchar2(30),
  country varchar2(30) NOT NULL,
  PRIMARY KEY (addressID)
);

CREATE TABLE person1
(
  personID varchar2(9) NOT NULL,
  firstName varchar2(30) NOT NULL,
  lastName varchar2(30) NOT NULL,
  email varchar2(30) NOT NULL,
  birthDate date NOT NULL,
  addressID INT NOT NULL,
  phoneNumber varchar2(30) NOT NULL,
  PRIMARY KEY (personID),
  FOREIGN KEY (addressID) REFERENCES address1(addressID)
);

CREATE TABLE interested1
(
  PersonID_ varchar2(9) NOT NULL,
  PRIMARY KEY (PersonID_),
  FOREIGN KEY (PersonID_) REFERENCES person1(PersonID)
);

CREATE TABLE areaStudy1
(
  areaName varchar2(30) NOT NULL,
  minPsychoGrade INT NOT NULL,
  PRIMARY KEY (areaName)
);

CREATE TABLE bagrutSubject1
(
  bagrutID INT NOT NULL,
  bagrutName varchar2(30) NOT NULL,
  units INT NOT NULL,
  PRIMARY KEY (bagrutID)
);

CREATE TABLE psychometric1
(
  PersonID varchar2(9) NOT NULL,
  psychoDate date NOT NULL,
  psychoGrade INT NOT NULL,
  PRIMARY KEY (psychoDate, PersonID),
  FOREIGN KEY (PersonID) REFERENCES interested1(PersonID_)
);

CREATE TABLE counselor1
(
  PersonID varchar2(9) NOT NULL,
  areaName varchar2(30) NOT NULL,
  licenseNumber INT NOT NULL,
  PRIMARY KEY (PersonID),
  FOREIGN KEY (areaName) REFERENCES areaStudy1(areaName),
  FOREIGN KEY (PersonID) REFERENCES person1(PersonID)
);

CREATE TABLE meeting1
(
  PersonID varchar2(9) NOT NULL,
  counselorID varchar2(9) NOT NULL,
  meetDate Timestamp NOT NULL,
  PRIMARY KEY (meetDate, PersonID, counselorID),
  FOREIGN KEY (PersonID) REFERENCES interested1(PersonID_),
  FOREIGN KEY (counselorID) REFERENCES counselor1(PersonID)
);

CREATE TABLE admissionBagrut1
(
  bagrutID INT NOT NULL,
  areaName varchar2(30) NOT NULL,
  minBagrutGrade INT NOT NULL,
  PRIMARY KEY (areaName, bagrutID),
  FOREIGN KEY (areaName) REFERENCES areaStudy1(areaName),
  FOREIGN KEY (bagrutID) REFERENCES bagrutSubject1(bagrutID)
);

CREATE TABLE interestedOf1
(
  PersonID varchar2(9) NOT NULL,
  areaName varchar2(30) NOT NULL,
  PRIMARY KEY (PersonID, areaName),
  FOREIGN KEY (PersonID) REFERENCES interested1(PersonID_),
  FOREIGN KEY (areaName) REFERENCES areaStudy1(areaName)
);

CREATE TABLE tested1
(
  PersonID varchar2(9) NOT NULL,
  bagrutID INT NOT NULL,
  grade INT NOT NULL,
  PRIMARY KEY (PersonID, bagrutID),
  FOREIGN KEY (PersonID) REFERENCES interested1(PersonID_),
  FOREIGN KEY (bagrutID) REFERENCES bagrutSubject1(bagrutID)
);


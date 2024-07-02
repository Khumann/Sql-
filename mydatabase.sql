CREATE DATABASE mydatabase;

USE mydatabase;

CREATE TABLE Student(
    Std_Id INT(10) NOT NULL,
    Std_Name CHAR(40) NOT NULL,
    Std_Email CHAR(20) NOT NULL,
    Std_Contact INT(13) NOT NULL,
    Std_University CHAR(100) NOT NULL,
    PRIMARY KEY(Std_Id)
);

INSERT INTO Student(Std_Id, Std_Name, Std_Email, Std_Contact, Std_University) VALUES
    ('2738913', 'Alex', 'alex@gmail.com', '9762378902', 'MIT'),
    ('1120492', 'Brian', 'brian@gmail.com', '7804501098', 'Stanford'),
    ('949383', 'Cathy', 'cathy@gmail.com', '7542091018', 'Harvard'),
    ('767692', 'David', 'david@gmail.com', '6782901870', 'Yale'),
    ('88064', 'Eva', 'eva@gmail.com', '8912390987', 'Princeton');

CREATE TABLE Organizer(
    org_Id INT(10) NOT NULL,
    org_Name CHAR(40) NOT NULL,
    org_Email CHAR(20) NOT NULL,
    org_Contact INT(13) NOT NULL,
    org_Department CHAR(40) NOT NULL,
    PRIMARY KEY(org_Id)  
);

INSERT INTO Organizer(org_Id, org_Name, org_Email, org_Contact, org_Department) VALUES
    ('5090923', 'Alpha', 'alpha@gmail.com', '7720987321', 'Recruitment'),
    ('781057', 'Beta', 'beta@gmail.com', '7891307479', 'Sports'),
    ('106913', 'Gamma', 'gamma@gmail.com', '8901601689', 'Finance'),
    ('1942036', 'Delta', 'delta@gmail.com', '9490129910', 'IT'),
    ('834567', 'Epsilon', 'epsilon@gmail.com', '9301015782', 'Teaching');

CREATE TABLE Location(
    loc_Id INT(15) NOT NULL,
    loc_Name CHAR(20) NOT NULL,
    loc_Address TEXT(100) NOT NULL,
    loc_Postcode INT(8) NOT NULL,
    loc_Country CHAR(60) NOT NULL,
    PRIMARY KEY(loc_Id)  
);

INSERT INTO Location(loc_Id, loc_Name, loc_Address, loc_Postcode, loc_Country) VALUES
    ('398178', 'Central Park', '123 Main St', '10001', 'USA'),
    ('981378', 'Union Square', '456 Elm St', '20002', 'Canada'),  
    ('980456', 'Harborview', '789 Oak St', '30003', 'UK'),
    ('9081273', 'Seaside', '101 Pine St', '40004', 'Australia'),
    ('801345', 'Mountainview', '202 Maple St', '50005', 'New Zealand');

CREATE TABLE Event(
    evnt_Id INT(10) NOT NULL,  
    evnt_Name CHAR(30) NOT NULL,
    evnt_Date DATE NOT NULL,    
    evnt_Types TEXT(60) NOT NULL,
    evnt_Status TEXT(60) NOT NULL,
    evnt_loc_Id INT(10) NOT NULL,
    evnt_org_Id INT(10) NOT NULL,
    PRIMARY KEY(evnt_Id),
    KEY(evnt_loc_Id),
    KEY(evnt_org_Id),
    FOREIGN KEY(evnt_loc_Id) REFERENCES Location(loc_Id),
    FOREIGN KEY(evnt_org_Id) REFERENCES Organizer(org_Id)
);

INSERT INTO Event(evnt_Id, evnt_Name, evnt_Date, evnt_Types, evnt_Status, evnt_loc_Id, evnt_org_Id) VALUES
    ('7819', 'Tech Conference', '2024-12-25', 'Technology', 'Scheduled', '398178', '5090923'),
    ('111111', 'Sports Meet', '2024-11-10', 'Sports', 'Scheduled', '981378', '781057'),
    ('89104', 'Cultural Fest', '1991-01-28', 'Culture', 'Completed', '980456', '106913'),
    ('12909', 'Job Fair', '1891-01-12', 'Recruitment', 'Completed', '9081273', '1942036'),
    ('02873', 'Faculty Meeting', '1909-12-25', 'Meeting', 'Completed', '801345', '834567'),
    ('02947', 'Food Festival', '2023-11-30', 'Food', 'Completed', '9081273', '1942036'),
    ('238745', 'Education Seminar', '2025-05-18', 'Education', 'Scheduled', '981378', '781057'),
    ('30927', 'Global Summit', '2000-01-17', 'Summit', 'Completed', '801345', '834567'),
    ('90574', 'Political Debate', '1900-06-19', 'Debate', 'Completed', '980456', '106913'),
    ('79473', 'Music Night', '1823-07-20', 'Music', 'Completed', '9081273', '1942036');

CREATE TABLE Event_Registration(
    event_reg_id INT(10) NOT NULL,
    event_id INT(10) NOT NULL,
    Student_id INT(10) NOT NULL,
    Registration_date DATE NOT NULL,
    Event_Rating INT(10),
    PRIMARY KEY(event_reg_id),
    FOREIGN KEY(Student_id) REFERENCES Student(Std_Id),
    FOREIGN KEY(event_id) REFERENCES Event(evnt_Id)
);

INSERT INTO Event_Registration(event_reg_id, event_id, Student_id, Registration_date, Event_Rating) VALUES
    ('2222222', '7819', '2738913', '2023-10-01', '6'),
    ('3457018', '30927', '2738913', '2023-09-25', '4'),
    ('23678', '111111', '1120492', '2023-08-15', '3'),
    ('29750', '89104', '949383', '1989-10-19', NULL),
    ('56018', '12909', '767692', '1890-10-25', NULL),
    ('09156', '02873', '88064', '1905-05-10', NULL);
```

This script contains the same structure and data as the original, but with different names for clarity and variety.
CREATE TABLE Student (
    Name     VARCHAR2 (25) NOT NULL,
    Student_Number       NUMBER (9)PRIMARY KEY,
    Major VARCHAR2 (4) NOT NULL,
    class NUMBER (2)
    
);
CREATE TABLE Courses (
    Course_Name     VARCHAR2 (25) NOT NULL,
    Course_number     VARCHAR2 (25) PRIMARY KEY,--the last digit is the section number
    Credit_hours        VARCHAR2 (25) NOT NULL,
    Department   VARCHAR2 (5)
 );
 
 CREATE TABLE section (
 Section_identifier     NUMBER(4)   PRIMARY KEY,
 Course_number     VARCHAR2 (25),
 Semester           VARCHAR2 (25),
 Year               VARCHAR2 (2),
 Instructor         VARCHAR2 (25),
 FOREIGN KEY (Course_number) REFERENCES Courses(Course_number)
 );
 

  
  
  CREATE TABLE Grade_Report (
  Section_identifier    NUMBER (4) REFERENCES section(Section_identifier),
  Student_Number       NUMBER (9)  REFERENCES Student(Student_Number),
  Grade                 VARCHAR2(2) 
  );
  
 
  CREATE TABLE Prequisite (
  Course_number     VARCHAR2 (25),
  Prerequisite_number VARCHAR2 (25),
  FOREIGN KEY (Course_number) REFERENCES Courses(Course_number)
  );

INSERT INTO STUDENT (Name, Student_Number, Class, Major) Values ('Test User 1', 1, 1, 'CS');
INSERT INTO STUDENT (Name, Student_Number, Class, Major) Values ('Test User 2', 2, 1, 'CS');
INSERT INTO STUDENT (Name, Student_Number, Class, Major) Values ('Test User 3', 3, 1, 'CS');
INSERT INTO STUDENT (Name, Student_Number, Class, Major) Values ('Test User 4', 4, 2, 'CS');
INSERT INTO STUDENT (Name, Student_Number, Class, Major) Values ('Test User 5', 5, 2, 'CS');
INSERT INTO STUDENT (Name, Student_Number, Class, Major) Values ('Test User 6', 6, 3, 'CS');
INSERT INTO STUDENT (Name, Student_Number, Class, Major) Values ('Test User 7', 7, 2, 'CS');
INSERT INTO STUDENT (Name, Student_Number, Class, Major) Values ('Test User 8', 8, 3, 'CS');
INSERT INTO STUDENT (Name, Student_Number, Class, Major) Values ('Test User 9', 9, 4, 'CS');
INSERT INTO STUDENT (Name, Student_Number, Class, Major) Values ('Test User 10', 10, 4, 'CS');

INSERT INTO COURSES (Course_Name, Course_Number, Credit_Hours, Department) VALUES ('Intro to Computer Science', 'CS1310', '4', 'CS');
INSERT INTO COURSES (Course_Name, Course_Number, Credit_Hours, Department) VALUES ('Data Structures', 'CS3320', '4', 'CS');
INSERT INTO COURSES (Course_Name, Course_Number, Credit_Hours, Department) VALUES ('Discrete Mathematics', 'MATH2410', '3', 'MATH');
INSERT INTO COURSES (Course_Name, Course_Number, Credit_Hours, Department) VALUES ('Database', 'CS3380', '3', 'CS');

INSERT INTO SECTION (Section_Identifier, Course_Number, Semester, Year, Instructor) VALUES (85, 'MATH2410', 'Fall', '07', 'King');
INSERT INTO SECTION (Section_Identifier, Course_Number, Semester, Year, Instructor) VALUES (92, 'CS1310', 'Fall', '07', 'Anderson');
INSERT INTO SECTION (Section_Identifier, Course_Number, Semester, Year, Instructor) VALUES (102, 'CS3320', 'Spring', '08', 'Knuth');
INSERT INTO SECTION (Section_Identifier, Course_Number, Semester, Year, Instructor) VALUES (112, 'MATH2410', 'Fall', '08', 'Chang');
INSERT INTO SECTION (Section_Identifier, Course_Number, Semester, Year, Instructor) VALUES (119, 'CS1310', 'Fall', '08', 'Anderson');
INSERT INTO SECTION (Section_Identifier, Course_Number, Semester, Year, Instructor) VALUES (135, 'CS3380', 'Fall', '08', 'Stone');

INSERT INTO Prequisite (Course_Number, Prerequisite_Number) VALUES ('CS3380', 'CS3320');
INSERT INTO Prequisite (Course_Number, Prerequisite_Number) VALUES ('CS3380', 'MATH2410');
INSERT INTO Prequisite (Course_Number, Prerequisite_Number) VALUES ('CS3320', 'CS1310');

INSERT INTO Grade_Report (Student_Number, Section_Identifier, Grade) VALUES (1, 85, 'A');
INSERT INTO Grade_Report (Student_Number, Section_Identifier, Grade) VALUES (2, 85, 'B');
INSERT INTO Grade_Report (Student_Number, Section_Identifier, Grade) VALUES (2, 92, 'A');
INSERT INTO Grade_Report (Student_Number, Section_Identifier, Grade) VALUES (3, 85, 'C');
INSERT INTO Grade_Report (Student_Number, Section_Identifier, Grade) VALUES (4, 102, 'B');
INSERT INTO Grade_Report (Student_Number, Section_Identifier, Grade) VALUES (5, 102, 'A');
INSERT INTO Grade_Report (Student_Number, Section_Identifier, Grade) VALUES (6, 112, 'A');
INSERT INTO Grade_Report (Student_Number, Section_Identifier, Grade) VALUES (7, 119, 'B');
INSERT INTO Grade_Report (Student_Number, Section_Identifier, Grade) VALUES (8, 119, 'C');
INSERT INTO Grade_Report (Student_Number, Section_Identifier, Grade) VALUES (9, 135, 'C');
INSERT INTO Grade_Report (Student_Number, Section_Identifier, Grade) VALUES (10, 135, 'A');
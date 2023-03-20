
CREATE TABLE Central_Student (
    StudentNo INT NOT NULL,
    StudentName VARCHAR(255) NOT NULL,
    Degree VARCHAR(255),
    GPA DECIMAL(4,2),
    Department VARCHAR(255),
    PRIMARY KEY (StudentNo)
);

CREATE TABLE Central_Professor (
    ProfName VARCHAR(255) NOT NULL,
    EngOffice VARCHAR(255),
    EngPhone VARCHAR(10),
    SciOffice VARCHAR(255),
    SciPhone VARCHAR(10),
    PRIMARY KEY (ProfName)
);

CREATE TABLE Central_Course (
    CourseNo VARCHAR(255) NOT NULL,
    CourseName VARCHAR(255),
    Credits INT,
    Department VARCHAR(255),
    PRIMARY KEY (CourseNo)
);

CREATE TABLE Central_Can_Teach (
    CourseNo VARCHAR(255) NOT NULL,
    ProfName VARCHAR(255) NOT NULL,
    Preference VARCHAR(255),
    Evaluation VARCHAR(255),
    PRIMARY KEY (CourseNo, ProfName),
    FOREIGN KEY (CourseNo) REFERENCES Central_Course(CourseNo),
    FOREIGN KEY (ProfName) REFERENCES Central_Professor(ProfName)
);

CREATE TABLE Central_Teaches (
    CourseNo VARCHAR(255) NOT NULL,
    ProfName VARCHAR(255) NOT NULL,
    Term VARCHAR(255),
    PRIMARY KEY (CourseNo, ProfName),
    FOREIGN KEY (CourseNo) REFERENCES Central_Course(CourseNo),
    FOREIGN KEY (ProfName) REFERENCES Central_Professor(ProfName)
);

CREATE TABLE Central_Enrolled (
    CourseNo VARCHAR(255) NOT NULL,
    ProfName VARCHAR(255) NOT NULL,
    StudentNo INT NOT NULL,
    Status VARCHAR(255),
    PRIMARY KEY (CourseNo, ProfName, StudentNo),
    FOREIGN KEY (CourseNo) REFERENCES Central_Course(CourseNo),
    FOREIGN KEY (ProfName) REFERENCES Central_Professor(ProfName),
    FOREIGN KEY (StudentNo) REFERENCES Central_Student(StudentNo)
);

CREATE TABLE Engineering_Student (
    StudentNo INT NOT NULL,
    StudentName VARCHAR(255) NOT NULL,
    Degree VARCHAR(255),
    GPA DECIMAL(4,2),
    Department VARCHAR(255),
    PRIMARY KEY (StudentNo)
);

CREATE TABLE Engineering_Professor (
    ProfName VARCHAR(255) NOT NULL,
    EngOffice VARCHAR(255),
    EngPhone VARCHAR(10),
    PRIMARY KEY (ProfName)
);

CREATE TABLE Engineering_Course (
    CourseNo VARCHAR(255) NOT NULL,
    CourseName VARCHAR(255),
    Credits INT,
    Department VARCHAR(255),
    PRIMARY KEY (CourseNo)
);

CREATE TABLE Engineering_Can_Teach (
    CourseNo VARCHAR(255) NOT NULL,
    ProfName VARCHAR(255) NOT NULL,
    Preference VARCHAR(255),
    Evaluation VARCHAR(255),
    PRIMARY KEY (CourseNo, ProfName),
    FOREIGN KEY (CourseNo) REFERENCES Central_Course(CourseNo),
    FOREIGN KEY (ProfName) REFERENCES Central_Professor(ProfName)
);

CREATE TABLE Engineering_Teaches (
    CourseNo VARCHAR(255) NOT NULL,
    ProfName VARCHAR(255) NOT NULL,
    Term VARCHAR(255),
    PRIMARY KEY (CourseNo, ProfName),
    FOREIGN KEY (CourseNo) REFERENCES Central_Course(CourseNo),
    FOREIGN KEY (ProfName) REFERENCES Central_Professor(ProfName)
);

CREATE TABLE Engineering_Enrolled (
    CourseNo VARCHAR(255) NOT NULL,
    ProfName VARCHAR(255) NOT NULL,
    StudentNo INT NOT NULL,
    Status VARCHAR(255),
    PRIMARY KEY (CourseNo, ProfName, StudentNo),
    FOREIGN KEY (CourseNo) REFERENCES Central_Course(CourseNo),
    FOREIGN KEY (ProfName) REFERENCES Central_Professor(ProfName),
    FOREIGN KEY (StudentNo) REFERENCES Central_Student(StudentNo)
);

CREATE TABLE Science_Student (
    StudentNo INT NOT NULL,
    StudentName VARCHAR(255) NOT NULL,
    Degree VARCHAR(255),
    GPA DECIMAL(4,2),
    Department VARCHAR(255),
    PRIMARY KEY (StudentNo)
);

CREATE TABLE Science_Professor (
    ProfName VARCHAR(255) NOT NULL,
    SciOffice VARCHAR(255),
    SciPhone VARCHAR(10),
    PRIMARY KEY (ProfName)
);

CREATE TABLE Science_Course (
    CourseNo VARCHAR(255) NOT NULL,
    CourseName VARCHAR(255),
    Credits INT,
    Department VARCHAR(255),
    PRIMARY KEY (CourseNo)
);

CREATE TABLE Science_Can_Teach (
    CourseNo VARCHAR(255) NOT NULL,
    ProfName VARCHAR(255) NOT NULL,
    Preference VARCHAR(255),
    Evaluation VARCHAR(255),
    PRIMARY KEY (CourseNo, ProfName),
    FOREIGN KEY (CourseNo) REFERENCES Central_Course(CourseNo),
    FOREIGN KEY (ProfName) REFERENCES Central_Professor(ProfName)
);

CREATE TABLE Science_Teaches (
    CourseNo VARCHAR(255) NOT NULL,
    ProfName VARCHAR(255) NOT NULL,
    Term VARCHAR(255),
    PRIMARY KEY (CourseNo, ProfName),
    FOREIGN KEY (CourseNo) REFERENCES Central_Course(CourseNo),
    FOREIGN KEY (ProfName) REFERENCES Central_Professor(ProfName)
);

CREATE TABLE Science_Enrolled (
    CourseNo VARCHAR(255) NOT NULL,
    ProfName VARCHAR(255) NOT NULL,
    StudentNo INT NOT NULL,
    Status VARCHAR(255),
    PRIMARY KEY (CourseNo, ProfName, StudentNo),
    FOREIGN KEY (CourseNo) REFERENCES Central_Course(CourseNo),
    FOREIGN KEY (ProfName) REFERENCES Central_Professor(ProfName),
    FOREIGN KEY (StudentNo) REFERENCES Central_Student(StudentNo)
);
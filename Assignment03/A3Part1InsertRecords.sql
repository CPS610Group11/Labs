INSERT INTO Central_Student (StudentNo, StudentName, Degree, GPA, Department) VALUES (1, 'Adam Whittington', 'BSc - Computer Science Co-op', 4.00, 'Science');
INSERT INTO Central_Student (StudentNo, StudentName, Degree, GPA, Department) VALUES (2, 'Test User 1', 'BSc - Chemistry', 4.33, 'Science');
INSERT INTO Central_Student (StudentNo, StudentName, Degree, GPA, Department) VALUES (3, 'Test User 2', 'BSc - Physics', 3.67, 'Science');
INSERT INTO Central_Student (StudentNo, StudentName, Degree, GPA, Department) VALUES (4, 'Test User 3', 'Computer Engineering', 4.00, 'Engineering');

INSERT INTO Central_Professor (ProfName, EngOffice, EngPhone, SciOffice, SciPhone) VALUES ('Test Professor 1', 'ENG203', '1234567890', 'SCI101', '2345678901');
INSERT INTO Central_Professor (ProfName, EngOffice, EngPhone) VALUES ('Test Professor 2', 'ENG204', '0987654321');
INSERT INTO Central_Professor (ProfName, SciOffice, SciPhone) VALUES ('Test Professor 3', 'SCI102', '1098765432');

INSERT INTO Central_Course (CourseNo, CourseName, Credits, Department) VALUES ('101', 'Test Course 1', 2, 'Engineering');
INSERT INTO Central_Course (CourseNo, CourseName, Credits, Department) VALUES ('102', 'Test Course 2', 1, 'Engineering');
INSERT INTO Central_Course (CourseNo, CourseName, Credits, Department) VALUES ('201', 'Test Course 3', 2, 'Science');
INSERT INTO Central_Course (CourseNo, CourseName, Credits, Department) VALUES ('202', 'Test Course 4', 1, 'Science');

INSERT INTO Central_Can_Teach (CourseNo, ProfName, Preference, Evaluation) VALUES ('101', 'Test Professor 1', 'Yes', 'Yes');
INSERT INTO Central_Can_Teach (CourseNo, ProfName, Preference, Evaluation) VALUES ('201', 'Test Professor 1', 'Yes', 'Yes');
INSERT INTO Central_Can_Teach (CourseNo, ProfName, Preference, Evaluation) VALUES ('102', 'Test Professor 2', 'Yes', 'Yes');
INSERT INTO Central_Can_Teach (CourseNo, ProfName, Preference, Evaluation) VALUES ('202', 'Test Professor 3', 'Yes', 'Yes');

INSERT INTO Central_Teaches (CourseNo, ProfName, Term) VALUES (101, 'Test Professor 1', 'Fall 2023');
INSERT INTO Central_Teaches (CourseNo, ProfName, Term) VALUES (202, 'Test Professor 3', 'Winter 2024');

INSERT INTO Central_Enrolled (CourseNo, ProfName, StudentNo, Status) VALUES (101, 'Test Professor 1', 4, 'Passed');
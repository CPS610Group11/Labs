INSERT INTO Central_Student (StudentNo, StudentName, Degree, GPA, DEPARTMENT)
SELECT * FROM Engineering_Student UNION SELECT * FROM Science_Student;

INSERT INTO Central_Professor (ProfName, EngOffice, EngPhone, SciOffice, SciPhone)
SELECT Engineering_Professor.ProfName, EngOffice, EngPhone, SciOffice, SciPhone FROM Engineering_Professor INNER JOIN Science_Professor
ON Engineering_Professor.ProfName = Science_Professor.ProfName;

INSERT INTO Central_Course (CourseNo, CourseName, Credits, Department)
SELECT * FROM Engineering_Course UNION SELECT * FROM Science_Course;

INSERT INTO Central_Can_Teach (CourseNo, ProfName, Preference, Evaluation)
SELECT * FROM Engineering_Can_Teach UNION SELECT * FROM Science_Can_Teach;

INSERT INTO Central_Teaches (CourseNo, ProfName, Term)
SELECT * FROM Engineering_Teaches UNION SELECT * FROM Science_Teaches;

INSERT INTO Central_Enrolled (CourseNo, ProfName, StudentNo, Status)
SELECT * FROM Engineering_Enrolled UNION SELECT * FROM Science_Enrolled;
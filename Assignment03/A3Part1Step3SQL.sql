INSERT INTO Engineering_Student (StudentNo, StudentName, Degree, GPA, Department)
SELECT * FROM Central_Student WHERE Central_Student.Department = 'Engineering';

INSERT INTO Science_Student (StudentNo, StudentName, Degree, GPA, Department)
SELECT * FROM Central_Student WHERE Central_Student.Department = 'Science';

INSERT INTO Engineering_Professor (ProfName, EngOffice, EngPhone)
SELECT ProfName, EngOffice, EngPhone FROM Central_Professor
WHERE Central_Professor.EngOffice IS NOT NULL;

INSERT INTO Science_Professor (ProfName, SciOffice, SciPhone)
SELECT ProfName, SciOffice, SciPhone FROM Central_Professor
WHERE Central_Professor.SciOffice IS NOT NULL;

INSERT INTO Engineering_Course (CourseNo, CourseName, Credits, Department)
SELECT * FROM Central_Course WHERE Central_Course.Department = 'Engineering';

INSERT INTO Science_Course (CourseNo, CourseName, Credits, Department)
SELECT * FROM Central_Course WHERE Central_Course.Department = 'Science';

INSERT INTO Engineering_Can_Teach (CourseNo, ProfName, Preference, Evaluation)
SELECT Central_Can_Teach.CourseNo, ProfName, Preference, Evaluation FROM Central_Can_Teach INNER JOIN Central_Course
ON Central_Can_Teach.CourseNo = Central_Course.CourseNo
WHERE Central_Course.Department = 'Engineering';

INSERT INTO Science_Can_Teach (CourseNo, ProfName, Preference, Evaluation)
SELECT Central_Can_Teach.CourseNo, ProfName, Preference, Evaluation FROM Central_Can_Teach INNER JOIN Central_Course
ON Central_Can_Teach.CourseNo = Central_Course.CourseNo
WHERE Central_Course.Department = 'Science';

INSERT INTO Engineering_Teaches (CourseNo, ProfName, Term)
SELECT Central_Teaches.CourseNo, ProfName, Term FROM Central_Teaches INNER JOIN Central_Course
ON Central_Teaches.CourseNo = Central_Course.CourseNo
WHERE Central_Course.Department = 'Engineering';

INSERT INTO Science_Teaches (CourseNo, ProfName, Term)
SELECT Central_Teaches.CourseNo, ProfName, Term FROM Central_Teaches INNER JOIN Central_Course
ON Central_Teaches.CourseNo = Central_Course.CourseNo
WHERE Central_Course.Department = 'Science';

INSERT INTO Engineering_Enrolled (CourseNo, ProfName, StudentNo, Status)
SELECT Central_Enrolled.CourseNo, ProfName, StudentNo, Status FROM Central_Enrolled INNER JOIN Central_Course
ON Central_Enrolled.CourseNo = Central_Course.CourseNo
WHERE Central_Course.Department = 'Engineering';

INSERT INTO Science_Enrolled (CourseNo, ProfName, StudentNo, Status)
SELECT Central_Enrolled.CourseNo, ProfName, StudentNo, Status FROM Central_Enrolled INNER JOIN Central_Course
ON Central_Enrolled.CourseNo = Central_Course.CourseNo
WHERE Central_Course.Department = 'Science';
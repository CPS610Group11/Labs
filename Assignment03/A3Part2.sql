CREATE TABLE Central_Course_Size (
    CourseNo VARCHAR(255) NOT NULL,
    CapSize INT DEFAULT 30 NOT NULL,
    PRIMARY KEY (CourseNo),
    FOREIGN KEY (CourseNo) REFERENCES Central_Course(CourseNo)
);

INSERT INTO Central_Course_Size VALUES ('101', 30);

SET serveroutput on;
DECLARE
/* Student changing classes */
movingStudent int;
/* Classes size information */
capLimit int;
currentSize int;
BEGIN
/* Select student that wants to change departments such as John*/
SELECT StudentNo INTO movingStudent FROM Central_Student WHERE StudentName = 'Adam Whittington';

/* Finds the class size and class limit of some engineering course such as 203 */
SELECT COUNT(*) INTO currentSize FROM Central_Enrolled WHERE CourseNo = '101';
SELECT CapSize INTO capLimit FROM Central_Course_Size WHERE CourseNo = '101';

IF (currentSize >= caplimit)
THEN
/* do not let the student change departments if course has enough capacity*/
dbms_output.put_line('Course is full');
ELSE
/* drop the student's science courses if leaving the department*/
DELETE FROM Science_Enrolled WHERE StudentNo = movingStudent;
/* move the student from the science database to the engineering database */
DELETE FROM Science_Student WHERE StudentNo = movingStudent;
INSERT INTO Engineering_Student VALUES (movingStudent, 'Adam Whittington', 'Computer Engineering', 4.00, 'Engineering');
/* add the student into some engineering courses */
INSERT INTO Engineering_Enrolled VALUES ('101', 'Test Professor 1', movingStudent, 'Enrolled');
END IF;
dbms_output.put_line('Finished');
END;
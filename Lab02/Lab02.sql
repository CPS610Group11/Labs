-- Add the followings to the tables created in Assignment-1only by using PL/Sql
-- Create a new type named “depart_type” with this schema: Name, Faculty, Building, Phone\

CREATE TYPE depart_type AS OBJECT
(
Name VARCHAR2(20),
Faculty VARCHAR2(20),
Building VARCHAR2(20),
Phone VARCHAR2(20)
);

-- Create a new table named “Professor” with this schema: Name, Emp_id, Email, depart_type
-- First make a type of this schema and then create the table based on that type

CREATE TYPE professor_type AS OBJECT
(
Name VARCHAR2(20),
Emp_id VARCHAR2(20),
Email VARCHAR2(20),
depart_type depart_type
);

CREATE TABLE Professor of professor_type;


-- Insert values in the “Professor” table at least for 5 records

INSERT INTO Professor (Name, Emp_id, Email, depart_type) VALUES ('Soheila Bashardoust Tajali', '1', 'sbtajali@torontomu.ca', depart_type('Computer Science', 'Science', 'ENG', '1234567890'));
INSERT INTO Professor (Name, Emp_id, Email, depart_type) VALUES ('Abdolreza Abhari', '2', 'test2@torontomu.ca', depart_type('Computer Science', 'Science', 'ENG', '9183479238'));
INSERT INTO Professor (Name, Emp_id, Email, depart_type) VALUES ('Sophie Quigley', '3', 'test3@torontomu.ca', depart_type('Computer Science', 'Science', 'ENG', '0239482393'));
INSERT INTO Professor (Name, Emp_id, Email, depart_type) VALUES ('Michelle Delcourt', '4', 'test4@torontomu.ca', depart_type('Mathematics', 'Science', 'ENG', '9374858493'));
INSERT INTO Professor (Name, Emp_id, Email, depart_type) VALUES ('Jelena Misic', '5', 'test5@torontomu.ca', depart_type('Computer Science', 'Science', 'ENG', '3567584945'));

-- Display the whole “Professor” table on the screen

SELECT * FROM Professor;

-- Add a new attribute to the “Professor” table named “Income” and insert proper input values

ALTER TYPE professor_type ADD ATTRIBUTE Income NUMBER(10,2) CASCADE;
UPDATE Professor SET Income = 100000.00 WHERE Emp_id = '1';
UPDATE Professor SET Income = 200000.00 WHERE Emp_id = '2';
UPDATE Professor SET Income = 300000.00 WHERE Emp_id = '3';
UPDATE Professor SET Income = 400000.00 WHERE Emp_id = '4';
UPDATE Professor SET Income = 500000.00 WHERE Emp_id = '5';

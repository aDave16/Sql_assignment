-- 1.Lab 1: Create a new database named school_db and a table called students with the
-- following columns: student_id, student_name, age, class, and address.
-- Lab 2: Insert five records into the students table and retrieve all records using the SELECT
-- statement
create database school_db
use school_db
CREATE TABLE students (
    s_id INT PRIMARY KEY,
    s_name VARCHAR(20),
    age INT,
    class INT,
    address VARCHAR(50),
    teacher_id int
);
INSERT INTO students (s_id, s_name, age, class, address,teacher_id) VALUES
(1, 'Rahul', 15, 10, 'Mumbai',1),
(2, 'Sneha', 14, 9, 'Delhi',2),
(3, 'Arjun', 16, 11, 'Chennai',3),
(4, 'Priya', 15, 10, 'Kolkata',4),
(5, 'Rohan', 17, 12, 'Bengaluru',5);

SELECT * FROM students

-- 2
-- Write SQL queries to retrieve specific columns (student_name and age) from the
-- students table.
SELECT s_name, age FROM students

-- Write SQL queries to retrieve all students whose age is greater than 10.
SELECT * FROM students WHERE age > 10

-- 3
-- Create a table teachers with the following columns: teacher_id (Primary Key),
-- teacher_name (NOT NULL), subject (NOT NULL), and email (UNIQUE).
CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(20) NOT NULL,
    subject VARCHAR(20) NOT NULL,
    email VARCHAR(50) UNIQUE
);
INSERT INTO teachers (teacher_id, teacher_name, subject, email) VALUES
(1, 'Alice Brown', 'Math', 'alice.brown@example.com'),
(2, 'John Smith', 'Science', 'john.smith@example.com'),
(3, 'Maria Davis', 'English', 'maria.davis@example.com'),
(4, 'Peter Wilson', 'History', 'peter.wilson@example.com'),
(5, 'Sara Johnson', 'Computer', 'sara.johnson@example.com');

-- implement a FOREIGN KEY constraint to relate the teacher_id from the
-- teachers table with the students table.
ALTER TABLE students ADD CONSTRAINT fk_teacher FOREIGN KEY (teacher_id)
REFERENCES teachers(teacher_id)

-- 4
--  Create a table courses with columns: course_id, course_name, and
-- course_credits. Set the course_id as the primary key.
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    course_credits INT
);
-- Use the CREATE command to create a database university_db.
create database university_db

-- 5
-- Modify the courses table by adding a column course_duration using the ALTER
-- command.
ALTER TABLE courses ADD course_duration VARCHAR(30)

-- Drop the course_credits column from the courses table
ALTER TABLE courses DROP COLUMN course_credits;

-- 6
-- Drop the teachers table from the school_db database.
DROP TABLE teachers
-- Drop the students table from the school_db database and verify that the table has
-- been removed
DROP TABLE students
SHOW TABLES

-- 7
-- Insert three records into the courses table using the INSERT command.
INSERT INTO courses (course_id, course_name, course_duration)
VALUES
(1, 'Mathematics', '3 months'),
(2, 'Science', '4 months'),
(3, 'Computer Basics', '2 months');

-- Update the course duration of a specific course using the UPDATE command.
UPDATE courses SET course_duration = '5 months' WHERE course_id = 2;

-- Delete a course with a specific course_id from the courses table using the DELETE
-- command.
DELETE FROM courses WHERE course_id = 3

-- 8
-- retrieve all courses from the courses table using the SELECT statement.
SELECT * FROM courses

-- Sort the courses based on course_duration in descending order using ORDER BY.
SELECT * FROM courses ORDER BY course_duration DESC

-- Limit the results of the SELECT query to show only the top two courses using LIMIT.
SELECT * FROM courses LIMIT 2

-- 9
-- Create two new users user1 and user2 and grant user1 permission to SELECT
-- from the courses table.

-- Revoke the INSERT permission from user1 and give it to user2.

-- 10
-- Insert a few rows into the courses table and use COMMIT to save the changes.

-- Insert additional rows, then use ROLLBACK to undo the last insert operation.

-- Create a SAVEPOINT before updating the courses table, and use it to roll back
-- specific changes.

-- 11
use db
-- Perform an INNER JOIN to isplay employees along with their respective departments.
SELECT e_id, e_name,d_name FROM employee INNER JOIN department ON employee.d_id = department.d_id

-- Use a LEFT JOIN to show all departments, even those without employees
SELECT department.d_id, department.d_name, employee.e_id, employee.e_name FROM department
LEFT JOIN employee ON department.d_id = employee.d_id

-- 12
 -- Group employees by department and count the number of employees in each department using GROUP BY.
 SELECT d_id, COUNT(*) AS employee_count FROM employee GROUP BY d_id

 -- Use the AVG aggregate function to find the average salary of employees in each department
 SELECT d_id, AVG(salary) AS average_salary FROM employee GROUP BY d_id

-- 13
-- Write a stored procedure to retrieve all employees from the employees table based on department.
DELIMITER $$
CREATE PROCEDURE GetEmployeesByDepartment(dept_id INT)
BEGIN
    SELECT * FROM employees WHERE d_id = dept_id;
END $$
CALL GetEmployeesByDepartment(2);

-- Write a stored procedure that accepts course_id as input and returns the course details
use school_db
DELIMITER $$
CREATE PROCEDURE GetCourseDetails(c_id INT)
BEGIN
    SELECT *
    FROM courses
    WHERE course_id = c_id;
END $$
CALL GetCourseDetails(1);

-- 14
--  Create a view to show all employees along with their department names.
use db
CREATE VIEW EmployeeDepartmentView as
SELECT employee.e_id, employee.e_name,department.d_name FROM employee INNER JOIN department 
ON employee.d_id = department.d_id

-- Modify the view to exclude employees whose salaries are below $50,000
CREATE OR REPLACE VIEW EmployeeDepartmentView AS
SELECT employee.e_id,employee.e_name,department.d_name FROM employee INNER JOIN department
ON employee.d_id = department.d_id WHERE employee.salary >= 50000

-- 15
-- Create a trigger to automatically log changes to the employees table when a new employee is added.
CREATE TABLE employee_log (emp_id INT,
    msg VARCHAR(50),
    msg_time DATETIME
);
DELIMITER $$
CREATE TRIGGER employee_insert AFTER INSERT ON employee FOR EACH ROW
BEGIN
    INSERT INTO employee_log VALUES (NEW.e_id, 'Employee Added', NOW());
END$$
INSERT INTO employee(e_id,e_name, city, salary) VALUES (101, 'Aarav', 'Delhi', 55000);
select * from employee_log

-- Create a trigger to update the last_modified timestamp whenever an employee record is update
ALTER TABLE employee ADD last_modified DATETIME;
DELIMITER $$
CREATE TRIGGER employee_update BEFORE UPDATE ON employee FOR EACH ROW
BEGIN
    SET NEW.last_modified = NOW();
	INSERT INTO employee_log VALUES (NEW.e_id, 'Employee value updated', NOW());

END$$
UPDATE employee SET salary = 75000 WHERE e_id = 101;
select * from employee_log
drop trigger employee_update




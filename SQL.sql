-- CREATE DATABASE :
CREATE DATABASE college;
USE college;
-- CREATE  TABLE :
CREATE TABLE student (
roll_no INT PRIMARY KEY,
name VARCHAR(50),
department VARCHAR(50),
cgpa FLOAT,
city VARCHAR(50)
);

-- INSERT VALUES :
INSERT INTO student 
(roll_no,name,department,cgpa,city)VALUES
(1,"Shaheer","CSE",9.7,"Rayachoti"),
(2,"Mahesh","CSE",9.0,"Kadapa"),
(3,"Naveen","ECE",9.5,"Rayachoti"),
(4,"Aslam","MECH",8.5,"Sundupalli"),
(5,"Uday","ECE",8.0,"Kadapa");
SELECT * FROM student;
CREATE TABLE Library(
stu_id INT,
books_borrowed INT DEFAULT 0,
books_returned INT DEFAULT 0,
FOREIGN KEY (stu_id) REFERENCES student(roll_no)
ON DELETE CASCADE
ON UPDATE CASCADE
);
INSERT INTO Library
(stu_id,books_borrowed,books_returned)VALUES
(1,3,2),
(2,2,1),
(3,3,3),
(4,1,0),
(5,0,0);
-- SELECT 
SELECT * FROM Library;
SELECT stu_id,books_borrowed FROM Library;
-- WHERE
SELECT * FROM student WHERE city="Kadapa";
SELECT name,department,cgpa,city FROM student WHERE roll_no=4;
SELECT roll_no,name,cgpa FROM student WHERE cgpa>9 AND city="Rayachoti";
SELECT roll_no,name,cgpa FROM student WHERE cgpa>9 OR city="Kadapa";
SELECT roll_no,name,cgpa FROM student WHERE cgpa BETWEEN 8 AND 9;
SELECT roll_no,name,cgpa FROM student WHERE city IN ("Rayachoti","Sundupalli");
SELECT roll_no,name,cgpa FROM student WHERE city NOT IN ("Rayachoti","Sundupalli");
SELECT * FROM student LIMIT 3;
SELECT * FROM student WHERE CGPA>=8 LIMIT 3;
-- ORDER BY
SELECT * FROM student ORDER BY cgpa DESC LIMIT 3;
SELECT * FROM student ORDER BY roll_no DESC;
SELECT roll_no,name FROM student ORDER BY cgpa DESC LIMIT 3;
-- DISTINCT 
SELECT DISTINCT name,cgpa FROM student;
-- AGGREGATE FUNCTIONS
SELECT MIN(cgpa) FROM student;
SELECT COUNT(roll_no) FROM student;
SELECT AVG(cgpa) FROM student;
-- GROUP BY
SELECT city,COUNT(*) FROM student GROUP BY city;
SELECT city,AVG(cgpa) FROM student GROUP BY city ORDER BY AVG(cgpa) DESC;
SELECT city,name,AVG(cgpa) FROM student GROUP BY city,name;
SELECT cgpa,COUNT(*) FROM student GROUP BY cgpa ORDER BY cgpa;
-- HAVING 
SELECT cgpa,name,AVG(cgpa) FROM student GROUP BY CGPA,name  HAVING cgpa>8.5;
SELECT city,COUNT(roll_no) FROM student GROUP BY city HAVING MAX(cgpa)>9;
SELECT city FROM student WHERE cgpa>9 GROUP BY city HAVING MAX(cgpa)ORDER BY city DESC;
-- TABLE RELATED QUERIES(DDL)
SET SQL_SAFE_UPDATES=0;
-- UPDATE
UPDATE student SET cgpa=8.7 WHERE roll_no=5;
SELECT * FROM student;
UPDATE student SET department="MECH" WHERE roll_no=5;
-- DELETE 
CREATE TABLE dept (
id int primary key,
subject varchar(25)
);
INSERT INTO dept 
(id,subject) VALUES
(101,"JAVA"),
(102,"DSA"),
(103,"SQL"),
(104,"ENGLISH"),
(105,"WEBDEV");
SELECT * FROM dept;
CREATE TABLE teacher(
id INT,
name VARCHAR(25),
dept_id INT
/* FOREIGN KEY (dept_id) REFERENCES dept(id)
ON DELETE CASCADE
ON UPDATE CASCADE */
);
INSERT INTO teacher 
(id,name,dept_id) VALUES
(101,"SAJIN",101),
(101,"SAJIN",102),
(102,"SURESH",103),
(103,"CYINTHIYA",104),
(107,"MAHESH",110);
SELECT * FROM teacher;
DROP TABLE teacher;
UPDATE teacher SET id=104,name="Shaheer" WHERE dept_id=102;
UPDATE dept SET id=100 WHERE id=104;
DELETE FROM dept WHERE id=100;
-- TABLE RELATED QUERIES(DML)
SELECT * FROM student;
-- ADD COLUMN
ALTER TABLE student ADD COLUMN age INT NOT NULL DEFAULT 18;
ALTER TABLE student DROP COLUMN age;
-- MODIFY COLUMN
ALTER TABLE student MODIFY age FLOAT ;
DESC student;
-- RENAME COLUMN
ALTER TABLE student CHANGE age Stu_Age INT;
-- RENAME TABLE 
ALTER TABLE student RENAME TO STUDENT_DATA;
-- DELETE COLUMN
ALTER TABLE student_data DROP COLUMN Stu_Age;
-- TRUNCATE
TRUNCATE TABLE student_data;
-- JOINS
CREATE TABLE dept (
id int primary key,
subject varchar(25)
);
INSERT INTO dept 
(id,subject) VALUES
(1,"JAVA"),
(2,"DSA"),
(3,"SQL"),
(4,"ENGLISH"),
(5,"WEBDEV");
CREATE TABLE teacher(
id INT,
name VARCHAR(25),
dept_id INT
);
INSERT INTO teacher 
(id,name,dept_id) VALUES
(101,"SAJIN",1),
(101,"SAJIN",2),
(102,"SURESH",3),
(103,"CYINTHIYA",4),
(107,"MAHESH",6);
-- INNER JOIN
 SELECT * FROM dept  INNER JOIN teacher  ON dept.id=teacher.dept_id;
 DROP TABLE teacher;
 SELECT * FROM teacher;
 -- LEFT JOIN
 SELECT * FROM dept as d LEFT JOIN teacher as t ON d.id=t.dept_id;
 -- RIGHT JOIN
 SELECT * FROM dept as d RIGHT JOIN teacher as t ON d.id=t.dept_id;
 -- FULL JOIN
 SELECT * FROM dept as d LEFT JOIN teacher as t ON d.id=t.dept_id
 UNION
 SELECT * FROM dept as d RIGHT JOIN teacher as t ON d.id=t.dept_id;
 -- LEFT EXCLUSIVE  JOIN
 SELECT * FROM dept LEFT JOIN teacher on dept.id=teacher.dept_id WHERE teacher.dept_id IS NULL; 
 -- RIGHT EXCLUSIVE JOIN
 SELECT * FROM dept RIGHT JOIN teacher on dept.id=teacher.dept_id WHERE dept.id IS NULL; 
 -- SELF JOIN
 CREATE TABLE employee(
 id INT PRIMARY KEY,
 name VARCHAR(25),
 manager_id INT
 );
 INSERT INTO employee
 (id,name,manager_id)VALUES
 (101,"ADAM",103),
 (102,"BOB",104),
 (103,"CASEY",NULL),
 (104,"DONALD",103);
 SELECT * FROM employee;
 SELECT a.name as manager_name,b.name
 FROM employee as a
 JOIN employee as b  ON
 a.id=b.manager_id;
 -- UNIONS
 -- UNION
 SELECT name FROM employee 
 UNION
 SELECT name FROM employee;
 -- UNION ALL
 SELECT name FROM employee 
 UNION ALL
 SELECT name FROM employee;
 -- SUB QUERIES
 SELECT AVG(cgpa) FROM student;
 SELECT name FROM student WHERE cgpa>8.93;
 SELECT name,cgpa FROM student WHERE cgpa >(SELECT AVG(CGPA) FROM STUDENT);
 SELECT roll_no FROM student WHERE roll_no % 2=0;
 SELECT roll_no,name FROM student WHERE roll_no IN (2,4);
 SELECT roll_no,name FROM student WHERE roll_no IN ( SELECT roll_no FROM student WHERE roll_no % 2=0);
  -- VIEWS
  CREATE VIEW VIEW1 AS
  SELECT roll_no,name,cgpa FROM student;
  SELECT * FROM VIEW1;
  SELECT name,cgpa FROM VIEW1 WHERE cgpa>8.5;
  DROP VIEW VIEW1;
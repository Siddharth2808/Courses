CREATE DATABASE assignment03;
USE assignment03;

CREATE TABLE course (
cid VARCHAR(200) PRIMARY KEY,
cname VARCHAR(200),
l INT,
t INT,
p INT,
c INT
);

CREATE TABLE course_coordinator (
cid VARCHAR(200) PRIMARY KEY,
cstart VARCHAR(200),
cend VARCHAR(200),
gsubmission VARCHAR(200),
coordinator VARCHAR(200),
exam_date VARCHAR(200)
);

CREATE TABLE course_eligibility (
cid VARCHAR(200) NOT NULL,
program VARCHAR(200),
batch_year VARCHAR(200),
batch_month VARCHAR(200),
eligibility VARCHAR(200)
);

CREATE TABLE course_instructor (
cid VARCHAR(200),
instructor VARCHAR(200)
);


CREATE TABLE faculty (
dept VARCHAR(200),
instructor VARCHAR(200),
PRIMARY KEY (dept, instructor)
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/course.csv'
 INTO TABLE course 
 FIELDS TERMINATED BY '#'
 LINES TERMINATED BY '\n';
 
 LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/course_coordinator.csv'
 INTO TABLE course_coordinator
 FIELDS TERMINATED BY '#'
 LINES TERMINATED BY '\n';
 
 LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/course_eligibility.csv'
 INTO TABLE course_eligibility
 FIELDS TERMINATED BY '#'
 LINES TERMINATED BY '\n';
 

 LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/course_instructor.csv'
 INTO TABLE course_instructor
 FIELDS TERMINATED BY '#'
 LINES TERMINATED BY '\n';
 
 LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/faculty.csv'
 INTO TABLE faculty
 FIELDS TERMINATED BY '#'
 LINES TERMINATED BY '\n';


select cname,count(cname) 
from course natural join course_eligibility
group by cid;

CREATE TABLE tmp (
    SELECT cid, COUNT(course_instructor.instructor) AS ins_count
    FROM course NATURAL JOIN course_instructor
    GROUP BY cid
);
CREATE TABLE cell (
    SELECT MAX(ins_count) AS cnt FROM tmp
);
CREATE TABLE cids (
    SELECT cid FROM tmp 
    WHERE ins_count IN 
    (SELECT * FROM cell) 
);
SELECT cid, cname, instructor 
FROM course NATURAL JOIN course_instructor
WHERE cid IN 
(SELECT * FROM cids);
DROP TABLES tmp, cell, cids;

SELECT DISTINCT cname, dept 
FROM course NATURAL JOIN course_instructor 
NATURAL JOIN faculty 
WHERE (cid NOT LIKE '%H' AND c<>2*l+t+p) or (cid like '%H' and 2*c<>(2*l+2*t+p));

SELECT cname,coordinator
FROM course
JOIN course_coordinator
ON course.cid=course_coordinator.cid
WHERE (course.cid,coordinator)
NOT IN
(SELECT course.cid,instructor 
FROM course
JOIN course_instructor
ON course.cid=course_instructor.cid);

SELECT course.cname, course_coordinator.gsubmission
FROM course
INNER JOIN course_coordinator ON course.cid=course_coordinator.cid;

select cname,exam_date 
from course natural join course_coordinator
where C <> (2 * l + 2 * t + p)/2;

create table intermediate2(select cid,cname
			   from course natural join course_eligibility
			   group by cid
			   having count(cid)>9);
select cid,cname,instructor 
from intermediate2 natural join course_instructor;
drop table intermediate2;

SELECT faculty.instructor, faculty.dept, course_instructor.cid
FROM faculty
JOIN course_instructor
ON faculty.instructor=course_instructor.instructor;

SELECT dept, instructor FROM faculty
WHERE (dept,instructor) NOT IN 
(SELECT dept,instructor FROM faculty NATURAL JOIN course_instructor)
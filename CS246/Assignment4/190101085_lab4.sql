CREATE DATABASE assignment04;
USE assignment04;

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
instructor VARCHAR(200)
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
 
 
 
 
SELECT C1.cname, course_coordinator.gsubmission 
FROM course AS C1,course_coordinator
WHERE C1.cid IN
(SELECT C2.cid FROM course_coordinator AS C2)
GROUP BY C1.cid; 

SELECT C1.cname, C2.gsubmission 
FROM course AS C1, course_coordinator AS C2
WHERE C1.cid IN
(SELECT C2.cid )
GROUP BY C1.cid;



select cid 
from (
select cid,count(cid) as cnt
from course_eligibility 
where ((program,batch_year,batch_month,eligibility) in (
select program,batch_year,batch_month,eligibility
from course_eligibility
where cid="BT206" 
))
group by cid) as sub2
where cnt=12;





 

CREATE VIEW Question_3 AS
      SELECT cid,gsubmission,coordinator
      FROM course_coordinator;



INSERT INTO 
Question_3 
VALUES ('CS100','28 May 2021','CSE Faculty');
  
  

CREATE VIEW Question_5 AS 
SELECT course_instructor.cid,course_instructor.instructor,course_coordinator.coordinator 
FROM course_instructor,course_coordinator
WHERE course_instructor.cid=course_coordinator.cid;


INSERT INTO Question_5 (cid,instructor)
VALUES ('CS100','CSE FACULTY');

INSERT INTO Question_5 (cid,coordinator)
VALUES ('CS100','CSE FACULTY');



SELECT D2.instructors
FROM (SELECT D1.instructors, min(m) AS mincnt
      FROM (SELECT coordinator AS instructors, COUNT(*) AS m
            FROM course_coordinator
            GROUP BY coordinator

            UNION ALL

            SELECT instructor AS instructors, COUNT(*) AS m
            FROM course_instructor
            GROUP BY instructor
            ) AS D1

      GROUP BY D1.instructors
      HAVING COUNT(*) > 1
      ) AS D2;
   

   
 DELIMITER |
 CREATE TRIGGER testtrig After INSERT ON
	course_eligibility
 FOR EACH ROW
 BEGIN
	SET @count_pg = (
		SELECT count(*) 
		FROM course_eligibility AS e 
		WHERE new.cid=e.cid
	);
 	INSERT INTO new_programs values(new.cid,@count_pg);
 END;
 |
 DELIMITER ;


      

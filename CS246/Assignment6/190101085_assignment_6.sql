CREATE DATABASE assignment06;
USE assignment06;

CREATE TABLE  faculty(
dept VARCHAR(250),
eid VARCHAR(250),
bid VARCHAR(250)
);

LOAD DATA LOCAL INFILE 'C:/Users/SIDDHARTH CHARAN/Downloads/assignment06/assignment06/faculty.csv' 
INTO TABLE faculty FIELDS TERMINATED BY '#'
LINES TERMINATED BY '\n';

WITH RECURSIVE all_bosses(eid,bid) AS(
      (SELECT eid,bid FROM faculty)
      UNION
      ( SELECT R1.eid,R2.bid
         FROM all_bosses AS R1,faculty AS R2
         WHERE R1.bid=R2.eid
	  )
)
SELECT * FROM all_bosses
ORDER BY eid,bid;
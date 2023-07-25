create DATABASE assignment02;
use assignment02;



CREATE TABLE hss_electives (
 `SNo` INT UNIQUE NOT NULL,
 `roll_number` INT,
 `sname` VARCHAR(200) NOT NULL,
 `cid` VARCHAR(200),
 `cname` VARCHAR(200) NOT NULL,
 PRIMARY KEY (roll_number,Cid)
 );
 
 
 LOAD DATA INFILE './hss_electives.csv'
 INTO TABLE hss_electives 
 FIELDS TERMINATED BY ','
 LINES TERMINATED BY '\n'
 IGNORE 1 ROWS;


INSERT INTO hss_electives(sno,roll_number,sname,cid,cname) VALUES (1432, 190205057, 'Vivek Srivastava', 'HS 100', 'Introduction to Discipline');  
INSERT INTO hss_electives(sno,roll_number,sname,cid,cname) VALUES (NULL, 190205058, 'Vivek Sarkar', 'HS 100', 'Introduction to Discipline');
INSERT INTO hss_electives(sno,roll_number,sname,cid,cname) VALUES (575, 170205002, 'Aditya Biala', 'HS 424', 'Economics of Uncertainty and Information');
INSERT INTO hss_electives(sno,roll_number,sname,cid,cname) VALUES (1433, 170206002, NULL, 'HS 424', 'Economics of Uncertainty and Information');
INSERT INTO hss_electives(sno,roll_number,sname,cid,cname) VALUES (1434, 170206002, 'Kamalesh Tripati', 'HS 425', NULL);



UPDATE hss_electives SET sno=NULL WHERE roll_number=170205002;
UPDATE hss_electives SET sno=576 WHERE roll_number=170205002;
UPDATE hss_electives SET roll_number=190102022, cid='HS 113'  WHERE roll_number=170205002;
UPDATE hss_electives SET cname=NULL  WHERE cname='HS 424';
UPDATE hss_electives SET sno=1435, roll_number=180206002, sname='Tripati Kamalesh', cid='HS 526', cname='Advanced Sociology'  WHERE sno=1432;
ALTER TABLE hss_electives DROP PRIMARY KEY;
ALTER TABLE hss_electives ADD CONSTRAINT my_c1 PRIMARY KEY(roll_number);


DELETE FROM hss_electives WHERE cid='HS 429';
DELETE FROM hss_electives WHERE sno=1435;



LOAD DATA INFILE './HS429.csv'
INTO TABLE hss_electives
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';



SELECT cid FROM hss_electives;

SELECT * FROM hss_electives 
WHERE (
	roll_number LIKE "170101%%%" 
	OR roll_number LIKE "190101%%%"
);

SELECT * FROM hss_electives
WHERE (
	roll_number LIKE "19%"
  AND 
	cname <> "Cognitive Psychology"
);

SELECT cid, cname FROM hss_electives GROUP BY cid;

SELECT cid, COUNT(roll_number) FROM hss_electives GROUP BY cid;

SELECT sname FROM hss_electives WHERE cname='Environmental Economics' ORDER BY sname, roll_number;
















 
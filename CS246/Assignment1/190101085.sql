create DATABASE cs245;
use cs245;

CREATE TABLE course (
`S No` INT UNIQUE NOT NULL,
`Department` VARCHAR(200) NOT NULL,
 `Period`  VARCHAR(200) NOT NULL,
 `course Code` VARCHAR(20) PRIMARY KEY,
 `course Name` VARCHAR(200) UNIQUE NOT NULL,
 `L` FLOAT NOT NULL,
 `T` FLOAT NOT NULL,
 `P` FLOAT NOT NULL,
 `C` FLOAT NOT NULL,
 `Course Start Date` DATE NOT NULL,
 `Course End Date` DATE NOT NULL,
 `Grades Submission End Date` DATE NOT NULL,
 `Coordinator Name` VARCHAR(50) NOT NULL,
 `Instructor Name` VARCHAR(50) NOT NULL,
 `Class  Timings` VARCHAR(200) NOT NULL,
 `Exam Date` DATE NOT NULL,
 `Eligibility` VARCHAR(200) NOT NULL 
 );
 CREATE TABLE Student(
 `Roll No` int PRIMARY KEY,
 `Name` VARCHAR(100) NOT NULL
 );
 CREATE TABLE HSSElectivesAllocation(
 `SI. No` INT,
 `Roll No` INT,
 `Name` VARCHAR(100),
 `Course Code` VARCHAR(20),
 `Course Name` VARCHAR(200)
 );
ALTER TABLE  HSSElectivesAllocation
ADD CONSTRAINT PRIMARY KEY (`Roll No`,`Course Code`);

ALTER TABLE  HSSElectivesAllocation
ADD CONSTRAINT UNIQUE (`Course Name`);

ALTER TABLE HSSElectivesAllocation
MODIFY `Course Name` VARCHAR(200) NOT NULL;

ALTER TABLE HSSElectivesAllocation
MODIFY `SI. No` INT UNIQUE NOT NULL;

ALTER TABLE HSSElectivesAllocation
ADD CONSTRAINT FOREIGN KEY(`Roll No`) REFERENCES Student(`Roll No`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE HSSElectivesAllocation
ADD CONSTRAINT FOREIGN KEY(`Course Code`) REFERENCES course(`Course Code`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE HSSElectivesAllocation
ADD CONSTRAINT FOREIGN KEY(`Course Name`) REFERENCES course(`Course Name`);






 
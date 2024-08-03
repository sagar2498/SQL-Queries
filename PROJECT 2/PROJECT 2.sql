
-- Q-1  Create new schema as alumni 
use alumni;
create database alumni;

-- Q-2  Import all .csv files into MySQL

-- steps for importing data  Navigator -> Alumni -> Table -> r click -> Table data import wizard -> Select path -> import

-- Q-3  Run SQL command to see the structure of six tables

DESC college_a_hs;
DESC college_a_se;
DESC college_a_sj;
DESC college_b_hs;
DESC college_b_se;
DESC college_b_sj;

-- Q-6    Perform data cleaning on table College_A_HS and store cleaned data in view College_A_HS_V, Remove null values.

CREATE VIEW College_A_HS_V AS (SELECT * FROM college_a_hs WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND Name IS NOT NULL AND
FatherName IS NOT NULL AND MotherName IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND HSDegree IS NOT NULL AND
EntranceExam IS NOT NULL AND Institute IS NOT NULL AND Location IS NOT NULL);

SELECT * FROM College_A_HS_V;

-- Q-7    Perform data cleaning on table College_A_SE and store cleaned data in view College_A_SE_V, Remove null values.

CREATE VIEW College_A_SE_V AS (SELECT * FROM college_a_se WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND Name IS NOT NULL AND
FatherName IS NOT NULL AND MotherName IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND Organization
IS NOT NULL AND Location IS NOT NULL);

SELECT * FROM College_A_SE_V;

-- Q-8  Perform data cleaning on table College_A_SJ and store cleaned data in view College_A_SJ_V, Remove null values.

CREATE VIEW College_A_SJ_V AS (SELECT * FROM college_a_sj WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND Name IS NOT NULL AND
FatherName IS NOT NULL AND MotherName IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND Organization
IS NOT NULL AND Designation IS NOT NULL AND Location IS NOT NULL);

SELECT * FROM College_A_SJ_V;

-- Q-9  Perform data cleaning on table College_B_HS and store cleaned data in view College_B_HS_V, Remove null values.

CREATE VIEW College_B_HS_V AS (SELECT * FROM college_b_hs WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND Name IS NOT NULL AND
FatherName IS NOT NULL AND MotherName IS NOT NULL AND Branch IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND HSDegree IS NOT NULL AND
EntranceExam IS NOT NULL AND Institute IS NOT NULL AND Location IS NOT NULL);

SELECT * FROM College_B_HS_V;

--  Q-10  Perform data cleaning on table College_B_SE and store cleaned data in view College_B_SE_V, Remove null values.

CREATE VIEW college_b_se_v AS (SELECT * FROM college_b_se WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND Name IS NOT NULL AND
FatherName IS NOT NULL AND MotherName IS NOT NULL AND Branch IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND Organization
IS NOT NULL AND Location IS NOT NULL);

SELECT * FROM College_b_se_v;

-- Q-11  Perform data cleaning on table College_B_SJ and store cleaned data in view College_B_SJ_V, Remove null values.

CREATE VIEW college_b_sj_v AS (SELECT * FROM college_b_sj WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND Name IS NOT NULL AND
FatherName IS NOT NULL AND MotherName IS NOT NULL AND Branch IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND Organization
IS NOT NULL AND Designation IS NOT NULL AND Location IS NOT NULL);

SELECT * FROM college_b_sj_v;

-- Q-12   Make procedure to use string function/s for converting record of Name, FatherName, MotherName into lower case for views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) 

SELECT lower(Name),lower(FatherName),lower(MotherName) FROM
college_a_hs_v;

SELECT lower(Name),lower(FatherName),lower(MotherName) FROM
college_a_se_v;

SELECT lower(Name),lower(FatherName),lower(MotherName) FROM
college_a_sj_v;

SELECT lower(Name),lower(FatherName),lower(MotherName) FROM
college_b_hs_v;

SELECT lower(Name),lower(FatherName),lower(MotherName) FROM
college_b_se_v;

SELECT lower(Name),lower(FatherName),lower(MotherName) FROM
college_b_sj_v;


-- Q-14 Write a query to create procedure get_name_collegeA using the cursor to fetch names of all students from college A.

CREATE PROCEDURE get_name_collegeB 
( INOUT name1 TEXT(40000) ) BEGIN   DECLARE na INT DEFAULT 0;  DECLARE namelist VARCHAR(16000) DEFAULT "";    DECLARE namedetail   CURSOR FOR  SELECT Name FROM college_b_hs   UNION   SELECT Name FROM college_b_se   UNION   SELECT Name FROM college_b_sj;    DECLARE CONTINUE HANDLER   FOR NOT FOUND SET na =1;    OPEN namedetail;    getame :  LOOP  FETCH FROM namedetail INTO namelist;  IF na = 1 THEN  LEAVE getame;  END IF;  SET name1 = CONCAT(namelist,";",name1);    END LOOP getame;  CLOSE namedetail; END
 DELIMITER ;

SET @Name = "";
CALL get_name_collegeB(@Name);
SELECT @Name Name;



-- Q-15  Write a query to create procedure get_name_collegeB using the cursor to fetch names of all students from college B.

SELECT "HigherStudies" PresentStatus,(SELECT COUNT(*) FROM college_a_hs)/
((SELECT COUNT(*) FROM college_a_hs) + (SELECT COUNT(*) FROM college_a_se) + (SELECT COUNT(*) FROM college_a_sj))*100
College_A_Percentage,
(SELECT COUNT(*) FROM college_b_hs)/
((SELECT COUNT(*) FROM college_b_hs) + (SELECT COUNT(*) FROM college_b_se) + (SELECT COUNT(*) FROM college_b_sj))*100
College_B_Percentage
UNION
SELECT "Self Employed" PresentStatus,(SELECT COUNT(*) FROM college_a_se)/
((SELECT COUNT(*) FROM college_a_hs) + (SELECT COUNT(*) FROM college_a_se) + (SELECT COUNT(*) FROM college_a_sj))*100
College_A_Percentage,
(SELECT COUNT(*) FROM college_b_se)/
((SELECT COUNT(*) FROM college_b_hs) + (SELECT COUNT(*) FROM college_b_se) + (SELECT COUNT(*) FROM college_b_sj))*100
College_B_Percentage
UNION
SELECT "Service Job" PresentStatus,(SELECT COUNT(*) FROM college_a_sj)/
((SELECT COUNT(*) FROM college_a_hs) + (SELECT COUNT(*) FROM college_a_se) + (SELECT COUNT(*) FROM college_a_sj))*100
College_A_Percentage,
(SELECT COUNT(*) FROM college_b_sj)/
((SELECT COUNT(*) FROM college_b_hs) + (SELECT COUNT(*) FROM college_b_se) + (SELECT COUNT(*) FROM college_b_sj))*100
College_B_Percentage;

 
 

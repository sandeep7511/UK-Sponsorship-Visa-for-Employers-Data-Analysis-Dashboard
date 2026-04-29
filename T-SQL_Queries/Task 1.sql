-- Table CAS_D01

select * from dbo.CAS_D01

-- Dropping unwanted columns

ALTER TABLE dbo.CAS_D01
DROP COLUMN column7, column8, column9, column10;

-- Table CAS_D02

select * from dbo.CAS_D02

-- Table CoS_D01

select * from dbo.CoS_D01

-- Table CoS_D02

select * from dbo.CoS_D02


-- Removing commas and turning updationg application column data type in all tables

UPDATE CAS_D01
SET Applications = REPLACE(Applications, ',', '');
ALTER TABLE CAS_D01
ALTER COLUMN Applications INT;

UPDATE CAS_D02
SET Applications = REPLACE(Applications, ',', '');
ALTER TABLE CAS_D02
ALTER COLUMN Applications INT;

UPDATE CoS_D01
SET Applications = REPLACE(Applications, ',', '');
ALTER TABLE CoS_D01
ALTER COLUMN Applications INT;

UPDATE CoS_D02
SET Applications = REPLACE(Applications, ',', '');
ALTER TABLE CoS_D02
ALTER COLUMN Applications INT;

-- remove blanks in application column

UPDATE CAS_D01 SET Applications = NULL WHERE Applications = '';
UPDATE CAS_D02 SET Applications = NULL WHERE Applications = '';
UPDATE CoS_D01 SET Applications = NULL WHERE Applications = '';
UPDATE CoS_D02 SET Applications = NULL WHERE Applications = '';


-- Clean Quarter column (extract quarter number)

ALTER TABLE CAS_D01 
ADD QuarterNumber AS CAST(RIGHT(Quarter, 1) AS INT) PERSISTED;

ALTER TABLE CAS_D02 
ADD QuarterNumber AS CAST(RIGHT(Quarter, 1) AS INT) PERSISTED;

ALTER TABLE CoS_D01 
ADD QuarterNumber AS CAST(RIGHT(Quarter, 1) AS INT) PERSISTED;

ALTER TABLE CoS_D02 
ADD QuarterNumber AS CAST(RIGHT(Quarter, 1) AS INT) PERSISTED;



-- Create QuarterSort column

ALTER TABLE CAS_D01 
ADD QuarterSort AS (Year * 10 + CAST(RIGHT(Quarter, 1) AS INT)) PERSISTED;

ALTER TABLE CAS_D02 
ADD QuarterSort AS (Year * 10 + CAST(RIGHT(Quarter, 1) AS INT)) PERSISTED;

ALTER TABLE CoS_D01 
ADD QuarterSort AS (Year * 10 + CAST(RIGHT(Quarter, 1) AS INT)) PERSISTED;

ALTER TABLE CoS_D02 
ADD QuarterSort AS (Year * 10 + CAST(RIGHT(Quarter, 1) AS INT)) PERSISTED;

-- Standardize text formating

-- CAS datasets
UPDATE CAS_D01 SET 
    Type_of_application = LTRIM(RTRIM(Type_of_application)),
    Institution_type_group = LTRIM(RTRIM(Institution_type_group)),
    Institution_type = LTRIM(RTRIM(Institution_type));

UPDATE CAS_D02 SET
    Type_of_application = LTRIM(RTRIM(Type_of_application)),
    Institution_type_group = LTRIM(RTRIM(Institution_type_group)),
    Geographical_region = LTRIM(RTRIM(Geographical_region)),
    Nationality = LTRIM(RTRIM(Nationality));

-- CoS datasets
UPDATE CoS_D01 SET
    Type_of_application = LTRIM(RTRIM(Type_of_application)),
    Category_of_leave = LTRIM(RTRIM(Category_of_leave)),
    Industry = LTRIM(RTRIM(Industry));

UPDATE CoS_D02 SET
    Type_of_application = LTRIM(RTRIM(Type_of_application)),
    Geographical_region = LTRIM(RTRIM(Geographical_region)),
    Nationality = LTRIM(RTRIM(Nationality));


-- Create unified views

-- Study Sponsorship

CREATE OR ALTER VIEW Study_Sponsorship AS
SELECT 
    Year,
    Quarter,
    QuarterNumber,
    QuarterSort,
    Type_of_application,
    Institution_type_group,
    Institution_type,
    NULL AS Geographical_region,
    NULL AS Nationality,
    Applications
FROM CAS_D01

UNION ALL

SELECT 
    Year,
    Quarter,
    QuarterNumber,
    QuarterSort,
    Type_of_application,
    Institution_type_group,
    NULL AS Institution_type,
    Geographical_region,
    Nationality,
    Applications
FROM CAS_D02;


-- Work Sponsorship

CREATE OR ALTER VIEW Work_Sponsorship AS
SELECT 
    Year,
    Quarter,
    QuarterNumber,
    QuarterSort,
    Type_of_application,
    Category_of_leave,
    Industry,
    NULL AS Geographical_region,
    NULL AS Nationality,
    Applications
FROM CoS_D01

UNION ALL

SELECT 
    Year,
    Quarter,
    QuarterNumber,
    QuarterSort,
    Type_of_application,
    NULL AS Category_of_leave,
    NULL AS Industry,
    Geographical_region,
    Nationality,
    Applications
FROM CoS_D02;


-- Backup database

BACKUP DATABASE UK_Immigration
TO DISK = 'E:\KDU\Year 2\Semester 4\Advanced SQL and Cloud Databases\Assignment Task 1\UK_Immigration.bak'
WITH INIT;





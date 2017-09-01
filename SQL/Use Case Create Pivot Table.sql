--/*
--DROP TABLE
IF OBJECT_ID(N'WorkHour') IS NOT NULL
DROP TABLE WorkHour
GO

--CREATE A TABLE 
CREATE table WorkHour(
Name varchar(30),
Week_Day INT,
[Date] date,
[Hour] Float)

--Insert data
INSERT INTO WorkHour VALUES('James', 1, '02/01/2016', 8.0)
INSERT INTO WorkHour VALUES('James', 2, '02/02/2016',8.0)
INSERT INTO WorkHour VALUES('James', 3, '02/03/2016',8.0)
INSERT INTO WorkHour VALUES('James', 4, '02/04/2016',8.0)
INSERT INTO WorkHour VALUES('James', 5, '02/05/2016', 8.0)
INSERT INTO WorkHour VALUES('James', 6, '02/06/2016',4.0)
INSERT INTO WorkHour VALUES('James', 7, '02/07/2016',0.0)
INSERT INTO WorkHour VALUES('James', 1, '02/08/2016',8.0)
INSERT INTO WorkHour VALUES('James', 2, '02/09/2016',8.0)
INSERT INTO WorkHour VALUES('James', 3, '02/10/2016',8.0)
INSERT INTO WorkHour VALUES('James', 4, '02/11/2016',8.0)
INSERT INTO WorkHour VALUES('James', 5, '02/12/2016', 8.0)
INSERT INTO WorkHour VALUES('James', 6, '02/13/2016',4.0)
INSERT INTO WorkHour VALUES('James', 7, '02/14/2016',0.0)
INSERT INTO WorkHour VALUES('Adams', 1, '02/01/2016', 8.0)
INSERT INTO WorkHour VALUES('Adams', 2, '02/02/2016',8.0)
INSERT INTO WorkHour VALUES('Adams', 3, '02/03/2016',8.0)
INSERT INTO WorkHour VALUES('Adams', 4, '02/04/2016',8.0)
INSERT INTO WorkHour VALUES('Adams', 5, '02/05/2016', 8.0)
INSERT INTO WorkHour VALUES('Adams', 6, '02/06/2016',4.0)
INSERT INTO WorkHour VALUES('Adams', 7, '02/07/2016',0.0)
INSERT INTO WorkHour VALUES('Adams', 1, '02/08/2016',0.0)
INSERT INTO WorkHour VALUES('Adams', 2, '02/09/2016',8.0)
INSERT INTO WorkHour VALUES('Adams', 3, '02/10/2016',8.0)
INSERT INTO WorkHour VALUES('Adams', 4, '02/11/2016',8.0)
INSERT INTO WorkHour VALUES('Adams', 5, '02/12/2016',8.0)
INSERT INTO WorkHour VALUES('Adams', 6, '02/13/2016',4.0)
INSERT INTO WorkHour VALUES('Adams', 7, '02/14/2016',8.0)
--*/
--Check data
USE test
GO

SELECT *
FROM WorkHour

--Aggregate data

SELECT Name, Week_Day, SUM([Hour]) TotalHours
FROM WorkHour
GROUP BY Name, Week_Day
ORDER By Name, Week_Day

--Pivot



--Create pivot table with CASE
SELECT Name
, Sum(Monday) AS Monday
, Sum(Tuesday) AS Tuesday
, Sum(Wednesday) AS Wednesday
, Sum(Thursday) AS Thursday
, Sum(Friday) AS Friday
, Sum(Saturday) AS Saturday
, Sum(Sunday) AS Sunday
FROM 
(
SELECT Name
, CASE Week_Day WHEN 1 THEN SUM([Hour])
       ELSE 0
  END AS Monday
, CASE Week_Day WHEN 2 THEN SUM([Hour])
       ELSE 0
  END AS Tuesday
  , CASE Week_Day WHEN 3 THEN SUM([Hour])
       ELSE 0
  END AS Wednesday
, CASE Week_Day WHEN 4 THEN SUM([Hour])
       ELSE 0
  END AS Thursday
  , CASE Week_Day WHEN 5 THEN SUM([Hour])
       ELSE 0
  END AS Friday
, CASE Week_Day WHEN 6 THEN SUM([Hour])
       ELSE 0
  END AS Saturday
  , CASE Week_Day WHEN 7 THEN SUM([Hour])
       ELSE 0
  END AS Sunday
FROM WorkHour
GROUP BY Name, Week_Day) a
GROUP By Name
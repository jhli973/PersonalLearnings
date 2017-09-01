

IF OBJECT_ID('Departments') IS NOT NULL
  DROP TABLE Departments
GO
CREATE TABLE Departments (ID      INT IDENTITY(1,1) PRIMARY KEY,
                            Name_Dep VARCHAR(200))
GO
 
INSERT INTO Departments(Name_Dep) 
VALUES('Vendas'), ('TI'), ('Recursos Humanos')
GO
 
IF OBJECT_ID('Salaries') IS NOT NULL
  DROP TABLE Salaries
GO
CREATE TABLE Salaries (ID      INT IDENTITY(1,1) PRIMARY KEY,
                           ID_Dep  INT,
                           Name    VARCHAR(200),
                           Salary Numeric(18,2))
GO
 
INSERT INTO Salaries (ID_Dep, Name, Salary) 
VALUES(1, 'Fabiano', 2000), (1, 'Amorim', 2500), (1, 'Diego', 9000),
      (2, 'Felipe', 2000), (2, 'Ferreira', 2500), (2, 'Nogare', 11999),
      (3, 'Laerte', 5000), (3, 'Luciano', 23500), (3, 'Zavaschi', 13999)
GO

--write a query to return those employees that receive more than his department’s average.
SELECT * FROM Salaries

SELECT 
*
FROM Salaries a
JOIN (SELECT ID, Name, avg(Salary) OVER(partition by ID_Dep) AS Dep_Avg_Sal
      FROm Salaries) b
	  ON a.Name = b.Name
	  AND a.ID = b.ID
	  AND a.Salary > b.Dep_Avg_Sal

--============================================
--running total
--============================================
IF OBJECT_ID('Sales') IS NOT NULL
  DROP TABLE Sales
GO
 
-- Tabela Sales
CREATE TABLE Sales (Salesdate  Date,
                             Salesamount FLOAT)
GO
 
-- Insere os registros
INSERT INTO Sales VALUES ('20080623',100)
INSERT INTO Sales VALUES ('20080624',-250)
INSERT INTO Sales VALUES ('20080625',380)
INSERT INTO Sales VALUES ('20080626',200)
INSERT INTO Sales VALUES ('20080627',-300)
GO

--Method 1
SELECT Salesdate, Salesamount, (SELECT SUM(Salesamount) FROM Sales
                                WHERE Salesdate <= s.Salesdate) Runningtotal
FROM Sales s

--Method 2
SELECT Salesdate, Salesamount,
       SUM(Salesamount) OVER(ORDER BY Salesdate) AS Runningtotal
FROM Sales	

--=================================================
-- ROW_NUMBER()	, RANK(), DENSE_RANK(), NTILE()
--================================================= 	
IF OBJECT_ID('Tab1') IS NOT NULL
  DROP TABLE Tab1
GO
CREATE TABLE Tab1 (Col1 INT)
GO
 
INSERT INTO Tab1 VALUES(5), (5), (3) , (1)
GO	
---ROW_NUMBER() returns the sequence number of each row 
SELECT Col1, 
       ROW_NUMBER() OVER(ORDER BY Col1 DESC) AS "ROW_NUMBER()"  
FROM Tab1	

-- Rank() returns the rank value with a GAP after a tie
SELECT Col1, 
       RANK() OVER(ORDER BY Col1 DESC) AS "RANK()"  
FROM Tab1
GO
 
-- Dense_Rank() returns the result without a GAP after a tie
SELECT Col1, 
       DENSE_RANK() OVER(ORDER BY Col1 DESC) AS "DENSE_RANK"  
FROM Tab1	

-- NTILE()  distributes the rows within an ordered partition into a specified number of “buckets” 
SELECT Col1, 
       NTILE(3) OVER(ORDER BY Col1 DESC) AS "NTILE(3)"
FROM Tab1 

SELECT Col1, 
       NTILE(2) OVER(ORDER BY Col1 DESC) AS "NTILE(3)"
FROM Tab1 

--The LEAD function is used to read a value from the next row, or the row below the actual row. 
--If the next row doesn’t exist, then NULL is returned.
SELECT Col1, 
       LEAD(Col1) OVER(ORDER BY Col1) AS "LEAD()"   
FROM Tab1 

--but you can change this behavior by specifying a parameter to read N following rows, for instance:
SELECT Col1, 
       LEAD(Col1, 2) OVER(ORDER BY Col1) AS "LEAD()" 
FROM Tab1

--  LAG() returns the row before the actual row
SELECT Col1, 
       LAG(Col1, 2) OVER(ORDER BY Col1) AS "LAG()"   
FROM Tab1

--FIRST_VALUE() and LAST_VALUE() returns the first/last value in a partition window.
SELECT Col1, 
       FIRST_VALUE(Col1) OVER(ORDER BY Col1) AS "FIRST_VALUE()"   
FROM Tab1 

SELECT Col1, 
       LAST_VALUE(Col1) OVER(ORDER BY Col1 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 
	   AS "LAST_VALUE()"   
FROM Tab1

--======================================================
-- PERCENT_RANK, CUME_DIST
--======================================================

--PERCENT_RANK column: (rank() – 1) / (total rows in a query result set or partition – 1)
--CUME_DIST column: (values less than or equal to the current value in the group) / (total row in a query result set or partition)

SELECT [LastName], [FirstName], [SalesQuota], [CountryRegionName]

      ,RANK() OVER (PARTITION BY [CountryRegionName] ORDER BY [SalesQuota]) AS [RANK()]
      ,PERCENT_RANK() OVER (PARTITION BY [CountryRegionName] ORDER BY [SalesQuota]) AS [PERCENT_RANK()]
	  ,CUME_DIST() OVER (PARTITION BY [CountryRegionName] ORDER BY [SalesQuota]) AS [CUME_DIST()]
FROM [AdventureWorks2012].[Sales].[vSalesPerson]
WHERE [SalesQuota] IS NOT NULL

--===================================================
--PERCENTILE_CONT and PERCENTILE_DESC
--===================================================

SELECT TOP 200

[BusinessEntityID], [Rate]
,PERCENTILE_CONT (0.5) WITHIN GROUP (ORDER BY [Rate])
      OVER (PARTITION BY [BusinessEntityID]) AS [PERCENTILE_CONT (0.5)]

,PERCENTILE_DISC (0.5) WITHIN GROUP (ORDER BY [Rate])
      OVER (PARTITION BY [BusinessEntityID]) AS [PERCENTILE_DISC (0.5)]

,CUME_DIST() OVER (PARTITION BY [BusinessEntityID]  ORDER BY [Rate]) AS [CUME_DIST()]

FROM [AdventureWorks2012].[HumanResources].[EmployeePayHistory]
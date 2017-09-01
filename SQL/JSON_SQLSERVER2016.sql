
USE Test
GO

CREATE TABLE [dbo].[ADDRESS](
	[Address1] [varchar](100) NULL,
	[Address2] [varchar](50) NULL,
	[Zip] [varchar](10) NULL,
	[City] [varchar](50) NULL,
	[StateProvince] [varchar](50) NULL,
	[EmployeeID] [int] NULL
) 
GO

CREATE TABLE [dbo].[EMPLOYEES](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NULL,
	[Salary] [int] NULL
) 
GO
INSERT [dbo].[ADDRESS] ([Address1], [Address2], [Zip], [City], [StateProvince], [EmployeeID]) VALUES (N'900 Rockville Pike', N'Suit 10', N'20852', N'Rockville', N'MD', 1)
INSERT [dbo].[ADDRESS] ([Address1], [Address2], [Zip], [City], [StateProvince], [EmployeeID]) VALUES (N'36523 Hancock Road', NULL, N'20854', N'Potomac', N'MD', 2)
INSERT [dbo].[ADDRESS] ([Address1], [Address2], [Zip], [City], [StateProvince], [EmployeeID]) VALUES (N'12435 Fidelity Cir', N'', N'20498', N'Tyson Corner', N'VA', 3)
INSERT [dbo].[ADDRESS] ([Address1], [Address2], [Zip], [City], [StateProvince], [EmployeeID]) VALUES (N'1099 New York Blvd.', N'350', N'21022', N'Capital Hill', N'DC', 4)
GO


INSERT [dbo].[EMPLOYEES] ([ID], [Name], [Salary]) VALUES (1, N'Kristeen', 1420)
INSERT [dbo].[EMPLOYEES] ([ID], [Name], [Salary]) VALUES (2, N'Ashley', 2006)
INSERT [dbo].[EMPLOYEES] ([ID], [Name], [Salary]) VALUES (3, N'Julia', 2210)
INSERT [dbo].[EMPLOYEES] ([ID], [Name], [Salary]) VALUES (4, N'Maria', 3000)

/*====================
  A. FOR JSON
=====================*/

-- USe FOR JSON AUTO mode
SELECT 
	ID, 
	Name,
	Salary 
FROM EMPLOYEES
FOR JSON AUTO
   

-- USe FOR JSON PATH mode to fully control the format 
SELECT 
	E.Name,
	E.Salary, 
	A.Address1 AS [Address.Address1],
	A.Address2 AS [Address.Address2],
	A.City AS [Address.City], 
	A.Zip AS [Address.Zip], 
	A.StateProvince AS [Address.State]
FROM EMPLOYEES E 
JOIN ADDRESS A 
ON E.ID = A.EmployeeID
FOR JSON PATH

SELECT 
	E.Name,
	E.Salary, 
	A.Address1 AS [Address.Address1],
	A.Address2 AS [Address.Address2],
	A.City AS [Address.City], 
	A.Zip AS [Address.Zip], 
	A.StateProvince AS [Address.State]
FROM EMPLOYEES E 
JOIN ADDRESS A 
ON E.ID = A.EmployeeID
FOR JSON PATH, ROOT('EmployeeInfo')


/*================= 
   B. OPENJSON
==================*/

--1. OPENJSON
DECLARE @js1 VARCHAR(4000)
SET @js1 = 
'{
      "Name": "Kristeen",
      "Salary": 1420,
      "Address1": "900 Rockville Pike",
      "Address2": "Suit 10",
      "City": "Rockville",
      "Zip": "20852",
      "StateProvince": "MD"
}'

SELECT * FROM OPENJSON(@js1)


--2.1 OPENJSON with 'WITH' CLAUSE
DECLARE @js2 VARCHAR(4000)
SET @js2 = 
'{
  "EmployeeInfo": [
    {
      "Name": "Kristeen",
      "Salary": 1420,
      "Address1": "900 Rockville Pike",
      "Address2": "Suit 10",
      "City": "Rockville",
      "Zip": "20852",
      "StateProvince": "MD"
    },
    {
      "Name": "Ashley",
      "Salary": 2006,
      "Address1": "36523 Hancock Road",
      "City": "Potomac",
      "Zip": "20854",
      "StateProvince": "MD"
    }
  ]
}'

SELECT * 
FROM OPENJSON(@js2, '$.EmployeeInfo')
WITH ( Name VARCHAR(50) '$.Name',
       Salary INT '$.Salary')

--2.2 OPENJSON with 'WITH' CLAUSE
DECLARE @js3 VARCHAR(400)
SET @js3 = 
'{ "Employee":
     {
      "Name": "Ashley",
      "Salary": 2006,
	  "Address":
		  {
		  "Address1": "36523 Hancock Road",
		  "City": "Potomac",
		  "Zip": "20854",
		  "StateProvince": "MD"
		  }
	  }
}'	

SELECT * 
FROM OPENJSON(@js3, '$.Employee')
WITH ( Name VARCHAR(50) '$.Name',
       Salary INT '$.Salary',
	   State VARCHAR(50) '$.Address.StateProvince')

/*================
  C. JSON_VALUE
=================*/

DECLARE @js4 VARCHAR(400)
SET @js4 = 
'{
      "Name": "Ashley",
      "Salary": 2006,
      "Address1": "36523 Hancock Road",
      "City": "Potomac",
      "Zip": "20854",
      "StateProvince": "MD"
    }'	
SELECT
  JSON_VALUE(@js4, '$.Name') as Name,
  JSON_VALUE(@js4, '$.Salary') as Salary,
  JSON_VALUE(@js4, '$.StateProvince') as [State]

/*================================================
  D. JSON_QUERY  - return JSON object or an array
==================================================*/

DECLARE @js5 VARCHAR(400)
SET @js5 = 
'{
      "Name": "Ashley",
      "Salary": 2006,
	  "Address":
		  {
		   "Address1": "36523 Hancock Road",
		  "City": "Potomac",
		  "Zip": "20854",
		  "StateProvince": "MD"
		  },
	  "Hobbies": ["Computer Game", "Basketball"]
    }'	
SELECT
  JSON_VALUE(@js5, '$.Name') as Name,
  JSON_VALUE(@js5, '$.Salary') as Salary,
  JSON_QUERY(@js5, '$.Hobbies') as Hobbies,
  JSON_QUERY(@js5, '$.Address') as Address

/*==================
  E. JSON_MODIFY
===================*/

DECLARE @info NVARCHAR(100)='{"name":"John","skills":["C#","SQL"]}'
PRINT @info

-- Update name  

SET @info=JSON_MODIFY(@info,'$.name','Mike')
PRINT @info


/*==================*
  F. ISJSON 
===================*/

CREATE TABLE Person (
 Id int IDENTITY PRIMARY KEY NONCLUSTERED,
 FirstName nvarchar(100) NOT NULL, 
 LastName nvarchar(100) NOT NULL,
 InfoJson nvarchar(max)
) 

ALTER TABLE Person
ADD CONSTRAINT [Content should be formatted as JSON]
 CHECK ( ISJSON( InfoJson )> 0 )

INSERT Person VALUES('James', 'Li', N'{}')  
INSERT Person VALUES('Brown', 'Lai', N'{"info":{"Age":29, "social security number": "332-037-0946"}}')


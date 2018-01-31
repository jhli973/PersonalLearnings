--=============================================================================================
-- Dynamic data masking - User only has read permission
-- Should use with other security features such as TDE, Aoways encrypted, Rol-level security
--=============================================================================================
 
IF OBJECT_ID('Salaries') IS NOT NULL
  DROP TABLE Salaries
GO
CREATE TABLE Salaries (ID INT IDENTITY(1,1) PRIMARY KEY,
                       Name VARCHAR(200),
					   Email VARCHAR(100),
					   CellPhone VARCHAR(20),
                       Salary Numeric(18,2))
GO
 
INSERT INTO Salaries (Name, Email, CellPhone, Salary) 
VALUES('Petter Ma', 'pma@gmail.com', '240-666-9999', 2069.22), 
	  ('Fang Wang','fwang2009@hotmail.com', '634-222-2222', 2500),
      ('Jian Feng', 'jfeng@yahoo.com', '640-333-9999', 13999)
GO

-- retrieve the data
SELECT * FROM Salaries

-- 1. Default mask

ALTER TABLE dbo.Salaries
ALTER COLUMN Salary ADD MASKED WITH (FUNCTION = 'default()')

--2. Email mask
ALTER TABLE dbo.Salaries
ALTER COLUMN Email ADD MASKED WITH (FUNCTION = 'email()')

--3. Partial mask
ALTER TABLE dbo.Salaries
ALTER COLUMN CellPhone ADD MASKED WITH (FUNCTION = 'partial(0, "xxx-xxx-", 4)')

--4. DROP mask
ALTER TABLE dbo.Salaries
ALTER COLUMN CellPhone DROP MASKED

--5. Check masked columns

SELECT c.name as Masked_Column,
       t.name as TableName,
	   c.masking_function , 
	   c.is_masked
FROM sys.masked_columns c
JOIN sys.tables t ON c.object_id = t.object_id
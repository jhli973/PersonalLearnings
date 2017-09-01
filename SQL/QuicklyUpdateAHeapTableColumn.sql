/*==========================================================

QUICKLY UPDATE HEAP TABLE -  THE key is to add a primary key

============================================================*/



/*=================================================
ADD a not NULL column , need first make it nULLable
===================================================*/
ALTER TABLE OrderCustomers
ADD ID INT NULL

UPDATE OrderCustomers
SET ID = 0

ALTER TABLE OrderCustomers
ALTER COLUMN ID INT NOT NULL

ALTER TABLE OrderCustomers
DROP COLUMN ID 

/*=========================
-- add an identity column
===========================*/

ALTER TABLE OrderCustomers
ADD ID INT Identity(1,1) 

ALTER TABLE OrderCustomers
ALTER COLUMN ID INT NOT NULL

/*======================
 add a primary key
 =======================*/
 ALTER TABLE OrderCustomers
 ADD PRIMARY KEY (ID)

 /*===========================
 Update columns
 ===========================*/
SELECT COUNT(*) FROM  OrderCustomers   --2560153
SELECT COUNT(*) FROM  SubOrders  -- 893741
UPDATE  A
SET A.OrderID = B.OrderID_New
FROM dbo.OrderCustomers  A
JOIN dbo.SubOrders B
ON A.OrderID = B.OrderID_Original COLLATE SQL_Latin1_General_CP1_CI_AS


UPDATE  A
SET A.ClientIdentifier = B.ClientIdentifier_New
FROM dbo.OrderCustomers  A
JOIN dbo.SubClientID B
ON A.ClientIdentifier = B.ClientIdentifier_Original COLLATE SQL_Latin1_General_CP1_CI_AS

/*============================
 DELETE UN-Identified rows
 ===========================*/
BEGIN TRAN
DELETE FROM dbo.OrderCustomers 
WHERE ClientIdentifier NOT LIKE 'Cl%' OR
      OrderID NOT LIKE 'Or%'
COMMIT TRAN


/*===========================
DROP Primary Key column
===========================*/
ALTER TABLE CDM.OrderCustomers
DROP CONSTRAINT [PK__Encounte__3214EC279042A3C4]

ALTER TABLE CDM.OrderCustomers
DROP COLUMN ID 
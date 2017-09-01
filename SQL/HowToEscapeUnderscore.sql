/*===============================
  How to escape underscore
  =============================*/

SELECT TABLE_NAME,CASE WHEN TABLE_NAME LIKE '%[_]%'  THEN 'livefdb'
			            ELSE 'livendb' 
					END AS DatabaseName
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA  = 'dbo' AND TABLE_TYPE = 'BASE TABLE'

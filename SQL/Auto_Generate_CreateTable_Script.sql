/*
This script can be used as a template for automatically generating 'create table' script. Don't use it untill you have test it
as there are more scenarios to be consider. 
https://www.red-gate.com/simple-talk/sql/t-sql-programming/concatenating-row-values-in-transact-sql/
*/

SELECT 
TABLE_SCHEMA + '.' +TABLE_NAME AS TableName,
'IF OBJECT_ID(''' + TABLE_SCHEMA + '.' +TABLE_NAME +''', ''U'') IS NOT NULL DROP TABLE ' +  TABLE_SCHEMA + '.' +TABLE_NAME +
' CREATE TABLE ' + TABLE_SCHEMA + '.' +TABLE_NAME + ' (' + LEFT(QUERY, LEN(QUERY)-1) + ')' AS Query
FROM (
	SELECT DISTINCT 
	A.TABLE_SCHEMA , A.TABLE_NAME,

	   (SELECT B.COLUMN_NAME + ' ' + B.DATA_TYPE + '' +
		CASE WHEN DATA_TYPE = 'varchar' OR DATA_TYPE = 'nvarchar' THEN '(' + ltrim(str(CHARACTER_MAXImUM_LENGTH)) + ')' 
			 WHEN DATA_TYPE = 'decimal' OR DATA_TYPE = 'numeric' THEN '(' + ltrim(str(NUMERIC_PRECISION)) + ',' + ltrim(str(NUMERIC_SCALE))+ ')' 
			 ELSE '' 
		END + ' ' +
		CASE WHEN IS_NULLABLE = 'NO' THEN 'NOT NULL' 
			 ELSE 'NULL' 
		END + ', '
		FROM INFORMATION_SCHEMA.COLUMNS B
		WHERE B.TABLE_NAME = A.TABLE_NAME
		ORDER BY B.ORDINAL_POSITION
		FOR XML PATH('')) AS QUERY
	FROM INFORMATION_SCHEMA.COLUMNS A 
	INNER JOIN INFORMATION_SCHEMA.TABLES C
		ON A.TABLE_NAME  = C.TABLE_NAME
	WHERE C.TABLE_TYPE = 'BASE TABLE'
	  AND A.TABLE_SCHEMA = 'dbo'
	   ) tbl



--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--   Reading Backup History Information for a Database - Greg Larsen
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--displays the databases that have not been backup up in the last seven days
USE msdb;
GO
SELECT 
sd.name AS database_name, bs.backup_finish_date 
FROM msdb.dbo.backupset bs
RIGHT OUTER JOIN sys.sysdatabases sd
ON bs.database_name = sd.name
WHERE bs.database_name is NULL 
   OR DATEADD(day,-7,getdate()) > bs.backup_finish_date;



-- show the database backups that have been taken for in last 30 days
USE msdb;
GO
SELECT 
CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS server_name, 
bs.database_name, 
bs.backup_start_date, 
bs.backup_finish_date, 
DATEDIFF(mi,bs.backup_finish_date, bs.backup_start_date) AS duration_in_sec,
bs.expiration_date, 
bs.backup_size, 
bmf.logical_device_name, 
bmf.physical_device_name, 
bs.name AS backupset_name, 
bs.description 
FROM msdb.dbo.backupmediafamily bmf
 JOIN msdb.dbo.backupset bs ON bmf.media_set_id = bs.media_set_id 
WHERE (CONVERT(datetime, bs.backup_start_date, 102) >= GETDATE() - 30) 
ORDER BY 
bs.database_name, 
bs.backup_finish_date;
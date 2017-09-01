
--master database

SELECT * FROM sys.event_log
SELECT * FROM sys.database_connection_stats

--USE statement is not supported to switch between databases. Use a new connection to connect to a different database.
--database scope
SELECT * FROM sys.dm_exec_requests

--============================
-- Check current service tier
--============================

SELECT db.name [Database],
ds.edition [Edition],
ds.service_objective [Service_Objective]
FROM sys.database_service_objectives ds
JOIN sys.databases db 
 ON ds.database_id = db.database_id


/*=========================================
-- DTU calculator -- developed by Justin Henriksen
http://dtucalculator.azurewebsites.net  
=========================================*/
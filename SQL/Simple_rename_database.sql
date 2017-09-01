
--The database could not be exclusively locked to perform the operation.

USE [master];
GO
ALTER DATABASE OriginalDatabase SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
EXEC sp_renamedb N'OriginalDatabase', N'NewDatabase'

-- change back to multi_user
ALTER DATABASE NewDatabase
SET MULTI_USER;
GO
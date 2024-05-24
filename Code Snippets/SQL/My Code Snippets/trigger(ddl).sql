use miratrail
go
CREATE TRIGGER eme
ON database
FOR drop_table
AS 
PRINT 'You must disable Trigger "safety" to drop or alter tables!'   
   ROLLBACK; 
go
drop table toys
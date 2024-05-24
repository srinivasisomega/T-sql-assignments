use master
create database miratrail
USE miratrail;
GO
CREATE TABLE toys
    (toyid int PRIMARY KEY NOT NULL,
    toyname varchar(25) NOT NULL,
    Price money NULL,
    about varchar(max) NULL)
GO
INSERT toys(toyid,toyname, Price, about)
    VALUES (1, 'Clamp', 12.48, 'Workbench clamp')
INSERT toys(toyid,toyname, Price, about)
    VALUES (2, 'magic', 20, 'chings')
GO
/*BACKUP DATABASE miraitrail
TO DISK = 'c:\tmp\SQLTestDB.bak'
   WITH FORMAT,
      MEDIANAME = 'SQLServerBackups',
      NAME = 'Full Backup of SQLTestDB';
GO*/


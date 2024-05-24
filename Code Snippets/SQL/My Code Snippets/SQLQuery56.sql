USE EMPID#266;
GO
IF OBJECT_ID('dbo.new_employees1', 'U') IS NOT NULL
    DROP TABLE new_employees1;
GO
CREATE TABLE new_employees1 (
    id_num int IDENTITY(1, 2),
    fname VARCHAR(20),
    minit int,
    lname VARCHAR(30)
);

INSERT new_employees1 (fname, minit, lname)
VALUES ('Karin', 5,'Josephs');

INSERT new_employees1 (fname, minit, lname)
VALUES ('Pirkko', 6,'Koskitalo');
select * from new_employees1;
go
INSERT new_employees1 (fname, minit, lname)
VALUES ('Pirkko','k','lo');

select * from new_employees1;
go
INSERT new_employees1 (fname, minit, lname)
VALUES ('Pirkko', 6,'Koskitalo');
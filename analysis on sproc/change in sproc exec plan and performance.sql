--i want to see whether the excecution plan of a sproc is used even after indexes are created on the base table
drop table employeeji
drop procedure spUpdateEmployeeByID
CREATE TABLE Employeeji
(
ID INT
,Name VARCHAR(50)
,Gender VARCHAR(50)
,DOB DATETIME
,DeptID INT
)
GO



INSERT INTO Employeeji VALUES(1, 'Pranaya', 'Male','1996-02-29 10:53:27.060', 1)
INSERT INTO Employeeji VALUES(2, 'Priyanka', 'Female','1995-05-25 10:53:27.060', 2)
INSERT INTO Employeeji VALUES(3, 'Anurag', 'Male','1995-04-19 10:53:27.060', 2)
INSERT INTO Employeeji VALUES(4, 'Preety', 'Female','1996-03-17 10:53:27.060', 3)
INSERT INTO Employeeji VALUES(5, 'Sambit', 'Male','1997-01-15 10:53:27.060', 1)
INSERT INTO Employeeji VALUES(6, 'Hina', 'Female','1995-07-12 10:53:27.060', 2)
GO
--sproc creation
CREATE PROCEDURE spUpdateEmployeeByID
(
@ID INT, 
@Name VARCHAR(50), 
@Gender VARCHAR(50), @DOB DATETIME, 
@DeptID INT
)
AS
BEGIN
UPDATE Employeeji SET 
    Name = @Name, 
    Gender = @Gender,
    DOB = @DOB, 
    DeptID = @DeptID
WHERE ID = @ID
END
GO
--analysis of sproc with out indexes
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
SET STATISTICS XML ON;
GO
EXEC spUpdateEmployeeByID 3, 'Palak1', 'Female', '1995-06-17 10:53:27.060', 3;
go
/* SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 5 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 5 ms.
Table 'Employeeji'. Scan count 1, logical reads 1, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

(1 row affected)

(1 row affected)

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 80 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 85 ms.

Completion time: 2024-06-06T12:13:47.7880777+05:30*/

--the elapsed times were reduced to 1 ans 2 ms respectively when csproc was called again
go
/*performance of sproc after index creation
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 2 ms.
Table 'Employeeji'. Scan count 1, logical reads 2, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.

(1 row affected)

(1 row affected)

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 2 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 5 ms.

Completion time: 2024-06-06T12:54:51.7339533+05:30*/
/*create insert sproc*/
CREATE PROCEDURE spinsertEmployeeByID
(
@ID INT, 
@Name VARCHAR(50), 
@Gender VARCHAR(50),
@DOB DATETIME, 
@DeptID INT
)
AS
BEGIN
insert into Employeeji 
values(
@ID
,@Name
,@Gender
,@DOB
,@DeptID)
END
GO
--analysis on insert statements without indexes on base tables in sproc
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
SET STATISTICS XML ON;
GO
EXEC spinsertEmployeeByID 7, 'ralak', 'Female', '1984-08-17 10:53:27.060', 3;
go
--sproc creation for deletion 
alter PROCEDURE DeleteEmployeeRecords
    @DeptIDToDelete INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Employeeji
    WHERE ID = @DeptIDToDelete;

    SELECT @@ROWCOUNT AS 'RowsDeleted';
END;
--analysis of delete in sproc
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
SET STATISTICS XML ON;
GO
EXEC DeleteEmployeeRecords @DeptIDToDelete = 7;
select * from Employeeji
/*result:SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 1 ms.
 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.
Table 'Employeeji'. Scan count 1, logical reads 1, physical reads 0, page server reads 0, read-ahead reads 0, page server read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob page server reads 0, lob read-ahead reads 0, lob page server read-ahead reads 0.
 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 2 ms.
 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.
    SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 3 ms.*/
go
create clustered index bbk555 on employeeji(id)
/*conclusion of analysis is such that the excecution plan of stored procedure is not followed after changes made to the table.
and the performance of the stored procedure drops slightly compared to sproc performance before creation of index.*/







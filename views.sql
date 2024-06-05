use EMPID#266
-- Create Department Table
CREATE TABLE Department
(
  ID INT PRIMARY KEY,
  Name VARCHAR(50)
)
GO

-- Populate the Department Table with test data
INSERT INTO Department VALUES(1, 'IT')
INSERT INTO Department VALUES(2, 'HR')
INSERT INTO Department VALUES(3, 'Sales')

-- Create employeesari Table
CREATE TABLE employeesari
(
  ID INT PRIMARY KEY,
  Name VARCHAR(50),
  Gender VARCHAR(50),
  DOB DATETIME,
  Salary DECIMAL(18,2),
  DeptID INT
)
GO

-- Populate the employeesari Table with test data
INSERT INTO employeesari VALUES(1, 'Pranaya', 'Male','1996-02-29 10:53:27.060', 25000, 1)
INSERT INTO employeesari VALUES(2, 'Priyanka', 'Female','1995-05-25 10:53:27.060', 30000, 2)
INSERT INTO employeesari VALUES(3, 'Anurag', 'Male','1995-04-19 10:53:27.060',40000, 2)
INSERT INTO employeesari VALUES(4, 'Preety', 'Female','1996-03-17 10:53:27.060', 35000, 3)
INSERT INTO employeesari VALUES(5, 'Sambit', 'Male','1997-01-15 10:53:27.060', 27000, 1)
INSERT INTO employeesari VALUES(6, 'Hina', 'Female','1995-07-12 10:53:27.060', 33000, 2)
GO
CREATE VIEW vwEmployeesByDepartment
AS
SELECT emp.ID, 
        emp.Name, 
        emp.Salary, 
        CAST(emp.DOB AS Date) AS DOB,
        emp.Gender,
        dept.Name AS DepartmentName
FROM employeesari emp
INNER JOIN Department dept
ON emp.DeptID = dept.ID
go
select * from Employeesari
select * from department dept
select * from vwEmployeesByDepartment
--error when trying to update borth base tables
UPDATE  vwEmployeesByDepartment SET 
        DepartmentName ='HR', 
        Salary = 50000
WHERE Name = 'hina'
--incorrect update row other than pranaya was updated
Update vwEmployeesByDepartment SET DepartmentName ='HR' where Name = 'Pranaya'
--check option
CREATE VIEW vwITDepartmentEmployees1 
AS 
SELECT ID, Name, Gender, DOB, Salary, DeptID 
FROM Employeesari 
WHERE DeptID = 1
--able to insert records whose department id is not 1
INSERT INTO vwITDepartmentEmployees1(ID, Name, Gender, DOB, Salary, DeptID)
VALUES(7, 'Rohit', 'Male','1994-07-24 10:53:27.060', 45000, 2)
--adding check option using alter
ALTER VIEW vwITDepartmentEmployees1 
AS 
SELECT ID, Name, Gender, DOB, Salary, DeptID 
FROM Employeesari 
WHERE DeptID = 1
WITH CHECK OPTION
-- try to insert insert records whose department id is not 1 and failed
INSERT INTO vwITDepartmentEmployees1 (ID, Name, Gender, DOB, Salary, DeptID)
VALUES(8, 'Mahesh', 'Male','1994-07-24 10:53:27.060', 55000, 2);
--encryption
ALTER VIEW vwITDepartmentEmployees1 
WITH ENCRYPTION
AS 
SELECT ID, Name, Gender, DOB, Salary, DeptID 
FROM Employeesari 
WHERE DeptID = 1
WITH CHECK OPTION;
--proving view is encrypted
SELECT id, ctext, text FROM syscomments
WHERE ID = OBJECT_ID('vwITDepartmentEmployees1')
sp_helptext vwITDepartmentEmployees1;
--scemabinding
ALTER VIEW vwITDepartmentEmployees1 
WITH SCHEMABINDING
AS 
SELECT ID, Name, Gender, DOB, sum(Salary) as sum1234, DeptID 
FROM dbo.employeesari 
WHERE DeptID = 1
WITH CHECK OPTION
--views group by
ALTER VIEW vwITDepartmentEmployees1 
WITH SCHEMABINDING
AS 
SELECT ID, Name, sum(Salary) as sum1234
FROM dbo.employeesari 
WHERE DeptID = 1
group by name,id
WITH CHECK OPTION
--
drop table employeesari
--indexes on views
create unique clustered index remoteki on vwITDepartmentEmployees1(id)
a
--analysis on indexed views
set statistics io on;
select * from employeesari
--insert into employeesari
--values (15,'barri','male','2002-06-15',90000.00,9)
select * from vwITDepartmentEmployees1
--partitioning veiws
CREATE TABLE Shipments_Q1 (
Ship_Num INT NOT NULL,
Ship_CountryCode CHAR(3) NOT NULL,
Ship_Date DATETIME NULL,
Ship_Quarter SMALLINT NOT NULL CONSTRAINT CK_Ship_Q1 CHECK (Ship_Quarter = 1),
CONSTRAINT PK_Shipments_Q1 PRIMARY KEY (Ship_Num, Ship_Quarter)
);
GO
CREATE TABLE Shipments_Q2 (
Ship_Num INT NOT NULL,
Ship_CountryCode CHAR(3) NOT NULL,
Ship_Date DATETIME NULL,
Ship_Quarter SMALLINT NOT NULL CONSTRAINT CK_Ship_Q2 CHECK (Ship_Quarter = 2),
CONSTRAINT PK_Shipments_Q2 PRIMARY KEY (Ship_Num, Ship_Quarter)
);
 
GO
CREATE TABLE Shipments_Q3 (
Ship_Num INT NOT NULL,
Ship_CountryCode CHAR(3) NOT NULL,
Ship_Date DATETIME NULL,
Ship_Quarter SMALLINT NOT NULL CONSTRAINT CK_Ship_Q3 CHECK (Ship_Quarter = 3),
CONSTRAINT PK_Shipments_Q3 PRIMARY KEY (Ship_Num, Ship_Quarter)
);
 
GO
CREATE TABLE Shipments_Q4 (
Ship_Num INT NOT NULL,
Ship_CountryCode CHAR(3) NOT NULL,
Ship_Date DATETIME NULL,
Ship_Quarter SMALLINT NOT NULL CONSTRAINT CK_Ship_Q4 CHECK (Ship_Quarter = 4),
CONSTRAINT PK_Shipments_Q4 PRIMARY KEY (Ship_Num, Ship_Quarter)
);
CREATE VIEW DBO.Shipments_Info
WITH SCHEMABINDING
AS
SELECT [Ship_Num],[Ship_CountryCode],[Ship_Date],[Ship_Quarter] FROM DBO.Shipments_Q1
UNION ALL
SELECT [Ship_Num],[Ship_CountryCode],[Ship_Date],[Ship_Quarter] FROM DBO.Shipments_Q2
UNION ALL
SELECT [Ship_Num],[Ship_CountryCode],[Ship_Date],[Ship_Quarter] FROM DBO.Shipments_Q3
UNION ALL
SELECT [Ship_Num],[Ship_CountryCode],[Ship_Date],[Ship_Quarter] FROM DBO.Shipments_Q4;
go
INSERT INTO DBO.Shipments_Info VALUES(1117,'JOR',GETDATE(),1);
INSERT INTO DBO.Shipments_Info VALUES(1118,'JFK',GETDATE(),2);
INSERT INTO DBO.Shipments_Info VALUES(1119,'CAS',GETDATE(),3);
INSERT INTO DBO.Shipments_Info VALUES(1120,'BEY',GETDATE(),4);
--update
update dbo.Shipments_Info 
set Ship_CountryCode='pfk'
where Ship_Quarter=2;
go
SELECT * FROM DBO.Shipments_Q1;
GO
SELECT * FROM DBO.Shipments_Q2;
GO
SELECT * FROM DBO.Shipments_Q3;
GO
SELECT * FROM Shipments_Info;
GO
--instead of triggers
-- Create Department Table
CREATE TABLE Departmentro
(
  ID INT PRIMARY KEY,
  Name VARCHAR(50)
)
GO

-- Populate the Department Table with test data
INSERT INTO Departmentro VALUES(1, 'IT')
INSERT INTO Departmentro VALUES(2, 'HR')
INSERT INTO Departmentro VALUES(3, 'Sales')

-- Create Employee Table
CREATE TABLE Employeero
(
  ID INT PRIMARY KEY,
  Name VARCHAR(50),
  Gender VARCHAR(50),
  DOB DATETIME,
  Salary DECIMAL(18,2),
  DeptID INT
)
GO

-- Populate the Employee Table with test data
INSERT INTO Employeero VALUES(1, 'Pranaya', 'Male','1996-02-29 10:53:27.060', 25000, 1)
INSERT INTO Employeero VALUES(2, 'Priyanka', 'Female','1995-05-25 10:53:27.060', 30000, 2)
INSERT INTO Employeero VALUES(3, 'Anurag', 'Male','1995-04-19 10:53:27.060',40000, 2)
INSERT INTO Employeero VALUES(4, 'Preety', 'Female','1996-03-17 10:53:27.060', 35000, 3)
INSERT INTO Employeero VALUES(5, 'Sambit', 'Male','1997-01-15 10:53:27.060', 27000, 1)
INSERT INTO Employeero VALUES(6, 'Hina', 'Female','1995-07-12 10:53:27.060', 33000, 2)
GO
CREATE VIEW vwEmployeeDetails
AS
SELECT emp.ID, emp.Name, Gender, Salary, dept.Name AS Department
FROM Employeero emp
INNER JOIN Departmentro dept
ON emp.DeptID = dept.ID
--instead of insert
CREATE TRIGGER tr_vwEmployeeDetails_InsteadOfInsert
ON vwEmployeeDetails
INSTEAD OF INSERT
AS
BEGIN
  DECLARE @DepartmenttId int
 
  -- First Check if there is a valid DepartmentId in the Department Table
  -- for the given Department Name
  SELECT @DepartmenttId = dept.ID 
  FROM Departmentro dept
  INNER JOIN INSERTED inst
  on inst.Department = dept.Name
 
  --If the DepartmentId is null then throw an error
  IF(@DepartmenttId is null)
  BEGIN
    RAISERROR('Invalid Department Name. Statement terminated', 16, 1)
    RETURN
  END
 
  -- Finally insert the data into the Employee table
  INSERT INTO Employeero(ID, Name, Gender, Salary, DeptID)
  SELECT ID, Name, Gender, Salary, @DepartmenttId
  FROM INSERTED
End
INSERT INTO vwEmployeeDetails VALUES(7, 'Saroj', 'Male', 50000, 'IT')
--insead of update trigger
CREATE TRIGGER tr_vwEmployeeDetails_InsteadOfUpdate
ON vwEmployeeDetails
INSTEAD OF UPDATE
AS
BEGIN
-- if EmployeeId is updated
IF(UPDATE(ID))
BEGIN
RAISERROR('Id cannot be changed', 16, 1)
RETURN
END
-- If Department Name is updated
IF(UPDATE(Department)) 
BEGIN
DECLARE @DepartmentID INT
SELECT @DepartmentID = dept.ID
FROM Departmentro dept
INNER JOIN
INSERTED inst
ON dept.Name = inst.Department
IF(@DepartmentID is NULL )
BEGIN
RAISERROR('Invalid Department Name', 16, 1)
RETURN
END
UPDATE Employeero set DeptID = @DepartmentID
FROM INSERTED
INNER JOIN
Employeero
on Employeero.ID = inserted.ID
End
-- If gender is updated
IF(UPDATE(Gender))
BEGIN
UPDATE Employeero SET Gender = inserted.Gender
FROM INSERTED
INNER JOIN Employeero
ON Employeero.ID = INSERTED.ID
END
 
  -- If Salary is updated
IF(UPDATE(Salary))
BEGIN
UPDATE Employeero SET Salary = inserted.Salary
FROM INSERTED
INNER JOIN Employeero
ON Employeero.ID = INSERTED.ID
END

  -- If Name is updated
IF(UPDATE(Name))
BEGIN
UPDATE Employeero
SET Name = inserted.Name
FROM INSERTED
INNER JOIN Employeero
ON Employeero.ID = INSERTED.ID
END
END
UPDATE vwEmployeeDetails  
SET Name = 'Preety',
  Gender = 'Female',
  Salary = 44000,
  Department = 'Sales'
WHERE Id = 1
select * from vwEmployeeDetails
 
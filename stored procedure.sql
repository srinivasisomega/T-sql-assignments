use EMPID#266
drop table employeeji
CREATE TABLE Employeeji
(
ID INT PRIMARY KEY
,Name VARCHAR(50)
,Gender VARCHAR(50)
,DOB DATETIME
,DeptID INT
)
GO

-- Populate the Employee Table with test data
INSERT INTO Employeeji VALUES(1, 'Pranaya', 'Male','1996-02-29 10:53:27.060', 1)
INSERT INTO Employeeji VALUES(2, 'Priyanka', 'Female','1995-05-25 10:53:27.060', 2)
INSERT INTO Employeeji VALUES(3, 'Anurag', 'Male','1995-04-19 10:53:27.060', 2)
INSERT INTO Employeeji VALUES(4, 'Preety', 'Female','1996-03-17 10:53:27.060', 3)
INSERT INTO Employeeji VALUES(5, 'Sambit', 'Male','1997-01-15 10:53:27.060', 1)
INSERT INTO Employeeji VALUES(6, 'Hina', 'Female','1995-07-12 10:53:27.060', 2)
GO
CREATE PROCEDURE spGetEmployee
AS
BEGIN
Select Name
, Gender
, DOB 
from Employeeji
END
-- To Execute the Procedure
EXEC spGetEmployee
sp_helptext spGetEmployee
ALTER PROCEDURE spGetEmployee
AS
BEGIN
  SELECT Name, Gender, DOB 
  FROM Employeeji 
  ORDER BY Name
END
-- To change the procedure name from spGetEmployee to spGetEmployee1
-- Use sp_rename system defined stored procedure
EXEC sp_rename 'spGetEmployee', 'spGetEmployee1'
Drop proc spGetEmployee1
--two types of parameters
create PROCEDURE spAddTwoNumbers(@no1 INT, @no2 INT)
AS
BEGIN
  DECLARE @Result INT
  SET @Result = @no1 + @no2
  PRINT 'RESULT IS: '+ CAST(@Result AS VARCHAR)
END
GO
-- Calling the procedure:
EXECUTE spAddTwoNumbers 10, 20
-- OR 
EXECUTE spAddTwoNumbers @no1=10, @no2=20
-- OR calling the procedure by declaring two variables as shown below
DECLARE @no1 INT, @no2 INt
SET @no1 = 10
SET @no2 = 20
EXECUTE spAddTwoNumbers @no1, @no2
--for updating table data
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
-- Executing the Procedure
-- If you are not specifying the Parameter Names then the order is important
EXECUTE spUpdateEmployeeByID 3, 'Palak', 'Female', '1994-06-17 10:53:27.060', 3
-- If you are specifying the Parameter Names then order is not mandatory
EXECUTE spUpdateEmployeeByID @ID =3, @Gender = 'Female', @DOB = '1994-06-17 10:53:27.060', @DeptID = 3, @Name = 'Palak'
--output parameter
CREATE PROCEDURE spGetResult
  @No1 INT,
  @No2 INT,
  @Result INT OUTPUT
AS
BEGIN
  SET @Result = @No1 + @No2
END
DECLARE @Result INT
EXECUTE spGetResult 10, 20, @Result OUT
PRINT @Result
--output
CREATE PROCEDURE spGetEmployeeCountByGender
@Gender VARCHAR(30),
@EmployeeCount INT OUTPUT
AS
BEGIN
SELECT @EmployeeCount = COUNT(ID)
FROM Employeeji
WHERe Gender = @Gender
END
create index krik_1000 on employeeji(deptID)
DECLARE @EmployeeTotal INT
EXECUTE spGetEmployeeCountByGender 'Male', @EmployeeTotal OUTPUT
PRINT @EmployeeTotal
--proof that when output is not mentioned out put parameter is null
DECLARE @EmployeeTotal INT
EXECUTE spGetEmployeeCountByGender'Male', @EmployeeTotal
IF (@EmployeeTotal IS NULL)
  PRINT '@EmployeeTotal IS NULL'
ELSE
  PRINT '@EmployeeTotal IS NOT NULL'
  --when parameters are jumbled not allowed
DECLARE @EmployeeTotal INT
EXECUTE spGetEmployeeCountByGender @EmployeeTotal OUTPUT, 'Male'
PRINT @EmployeeTotal
--sproc with default parameters
CREATE PROCEDURE spAddNumber(@No1 INT= 100, @No2 INT)
AS
BEGIN
  DECLARE @Result INT
  SET @Result = @No1 + @No2
  PRINT 'The SUM of the 2 Numbers is: '+ CAST(@Result AS VARCHAR)
END
-- Executing the above procedure:
EXEC spAddNumber 3200, 25
EXEC spAddNumber @No1=200, @No2=25
EXEC spAddNumber @No1=DEFAULT, @No2=25
EXEC spAddNumber @No2=25

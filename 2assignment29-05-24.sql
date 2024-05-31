use EMPID#266
/*1)Select all departments in all locations where the Total Salary of a Department is Greater than twice the Average Salary for the department.
And max basic for the department is at least thrice the Min basic for the department*/
drop table employee;
drop table departments;
create table departments(
did int,
departmentname varchar(20),
branch varchar(20),
constraint pkreftemp primary key(did)
)
create table employee(
eid int,
ename varchar(20),
did int,
salary money,
constraint pkrefidtemp primary key(eid),
constraint reftemp foreign key(did) references departments(did))
go
INSERT INTO departments (did, departmentname, branch) 
VALUES 
(1, 'Sales', 'New York'),
(2, 'Marketing', 'Los Angeles'),
(3, 'Finance', 'Chicago'),
(4, 'Human Resources', 'Houston'),
(5, 'IT', 'San Francisco'),
(6, 'Operations', 'Dallas'),
(7, 'Sales', 'Los Angeles'),
(8, 'Marketing', 'Chicago'),
(9, 'Finance', 'Houston'),
(10, 'Human Resources', 'San Francisco'),
(11, 'IT', 'Dallas'),
(12, 'Operations', 'Boston');
go
INSERT INTO employee (eid, ename, did, salary)
VALUES
(1, 'John Doe', 1, 60000.00),
(2, 'Jane Smith', 2, 65000.00),
(3, 'Michael Johnson', 3, 70000.00),
(4, 'Emily Davis', 4, 55000.00),
(5, 'Chris Wilson', 5, 75000.00),
(6, 'Amanda Martinez', 6, 62000.00),
(7, 'David Anderson', 7, 68000.00),
(8, 'Sarah Taylor', 8, 58000.00),
(9, 'Kevin Brown', 9, 63000.00),
(10, 'Jessica Rodriguez', 10, 71000.00),
(11, 'Daniel Lee', 11, 59000.00),
(12, 'Megan Garcia', 12, 67000.00),
(13, 'Ryan Hernandez', 1, 73000.00),
(14, 'Lauren Nguyen', 2, 60000.00),
(15, 'Jason Perez', 3, 64000.00),
(16, 'Rachel Martinez', 4, 68000.00),
(17, 'Matthew Lewis', 5, 72000.00),
(18, 'Kimberly Taylor', 6, 57000.00),
(19, 'Andrew Hall', 7, 77000.00),
(20, 'Jennifer Allen', 8, 64000.00),
(21, 'Eric Scott', 9, 70000.00),
(22, 'Olivia King', 10, 60000.00),
(23, 'Brandon Wright', 11, 65000.00),
(24, 'Stephanie Hill', 12, 72000.00),
(25, 'Justin Green', 1, 60000.00),
(26, 'Hannah Adams', 2, 69000.00),
(27, 'Tyler Baker', 3, 74000.00),
(28, 'Alexis Ross', 4, 61000.00),
(29, 'Nicholas Campbell', 5, 65000.00),
(30, 'Samantha Mitchell', 6, 69000.00),
(31, 'Joshua Gonzalez', 7, 73000.00),
(32, 'Brittany Rodriguez', 8, 58000.00),
(33, 'Austin Carter', 9, 79000.00),
(34, 'Kayla Flores', 10, 66000.00),
(35, 'Jose Ward', 11, 71000.00),
(36, 'Taylor Murphy', 12, 61000.00),
(37, 'Madison Rivera', 1, 67000.00),
(38, 'Christopher Wood', 2, 73000.00),
(39, 'Victoria Cooper', 3, 62000.00),
(40, 'Gabriel Diaz', 4, 71000.00),
(41, 'Natalie Richardson', 5, 75000.00),
(42, 'Dylan Evans', 6, 62000.00),
(43, 'Jordan Stewart', 7, 66000.00),
(44, 'Amber Morris', 8, 70000.00),
(45, 'Cody James', 9, 74000.00),
(46, 'Lindsey Bell', 10, 59000.00),
(47, 'Zachary Phillips', 11, 80000.00),
(48, 'Rebecca Russell', 12, 67000.00);
go
insert into employee values
(50,'rsdeddy',3,15000)
go;
select d.departmentname,d.branch,sum(e.salary),avg(e.salary)
from departments as d 
join employee as e 
on e.did=d.did
group by d.departmentname,d.branch
having sum(e.salary)>2*avg(e.salary) and 3*min(e.salary)<=max(e.salary)
select * from departments
select * from employee order by did;
/*2)As per the companies rule if an employee has put up service of 1 Year 3 Months and 15 days in office, Then She/he would be eligible for a Bonus.
the Bonus would be Paid on the first of the Next month after which a person has attained eligibility. Find out the eligibility date for all the employees. 
And also find out the age of the Employee On the date of Payment of the First bonus. Display the Age in Years, Months, and Days.
Also Display the weekday Name, week of the year, Day of the year and week of the month of the date on which the person has attained the eligibility*/
CREATE TABLE Employees2 (
EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
BirthDate DATE NOT NULL,
HireDate DATE NOT NULL
);
INSERT INTO Employees2 (FirstName, LastName, BirthDate, HireDate)
VALUES
('John', 'Doe', '1990-01-01', '2018-01-01'),
('Jane', 'Smith', '1992-06-15', '2019-03-01'),
('Bob', 'Johnson', '1985-11-20', '2017-06-01'),
('Alice', 'Williams', '1995-02-28', '2020-01-15'),
('Mike', 'Brown', '1980-08-10', '2016-09-01');
--plese refer to my age calculation function query file from my repository for details on how agecal function works url'https://github.com/srinivasisomega/T-sql-assignments'
WITH EmployeeData AS (
SELECT 
EmployeeID,
HireDate,
DATEADD(day, 15, DATEADD(month, 3, DATEADD(year, 1, HireDate))) AS EligibilityDate,
DATEDIFF(day, HireDate, DATEADD(day, 15, DATEADD(month, 3, DATEADD(year, 1, HireDate)))) AS DaysOfService
FROM 
Employees2
)
SELECT 
e.EmployeeID,
e.HireDate,
ed.EligibilityDate,
ed.DaysOfService,
DATEADD(day, 1, EOMONTH(ed.EligibilityDate)) AS BonusPaymentDate,
Age = dbo.agecal(e.BirthDate, DATEADD(day, 1, EOMONTH(ed.EligibilityDate))),
DATENAME(weekday, ed.EligibilityDate) AS EligibilityWeekday,
DATEPART(week, ed.EligibilityDate) AS EligibilityWeekOfYear,
DATEPART(dayofyear, ed.EligibilityDate) AS EligibilityDayOfYear,
DATEPART(week, ed.EligibilityDate) - DATEPART(week, DATEADD(month, DATEDIFF(month, 0, ed.EligibilityDate), 0)) + 1 AS EligibilityWeekOfMonth
FROM 
Employees2 e
INNER JOIN EmployeeData ed ON e.EmployeeID = ed.EmployeeID
WHERE 
ed.DaysOfService >= 455;
/*3. Company Has decided to Pay a bonus to all its employees. The criteria is as follows
1. Service Type 1. Employee Type 1. Minimum service is 10. Minimum service left should be 15 Years. Retirement age will be 60 Years
2. Service Type 1. Employee Type 2. Minimum service is 12. Minimum service left should be 14 Years . Retirement age will be 55
Years
3. Service Type 1. Employee Type 3. Minimum service is 12. Minimum service left should be 12 Years . Retirement age will be 55
Years
3. for Service Type 2,3,4 Minimum Service should Be 15 and Minimum service left should be 20 Years . Retirement age will be 65
Years
Write a query to find out the employees who are eligible for the bonus.*/
drop table bonus
CREATE TABLE empking (
id INT,
name VARCHAR(50),
servicetype VARCHAR(20),
employeetype VARCHAR(20),
dob DATE,
doj DATE,
CONSTRAINT chk_servicetype CHECK (servicetype IN ('Service Type 1', 'Service Type 2', 'Service Type 3', 'Service Type 4')),
CONSTRAINT chk_employeetype CHECK (employeetype IN ('Employee Type 1', 'Employee Type 2', 'Employee Type 3'))
);
INSERT INTO empking(id, name, servicetype, employeetype, dob, doj)
VALUES
(1, 'John_Doe_ST1_ET1', 'Service Type 1', 'Employee Type 1', '1994-05-30', '2000-01-01'),
(2, 'Jane_Smith_ST1_ET1', 'Service Type 1', 'Employee Type 1', '1989-10-15', '2020-06-15'),
(3, 'Michael_Johnson_ST1_ET2', 'Service Type 1', 'Employee Type 2', '2000-02-20', '2000-01-01'),
(4, 'Emily_Brown_ST1_ET2', 'Service Type 1', 'Employee Type 2', '1984-07-12', '2005-06-15'),
(5, 'Daniel_Wilson_ST1_ET3', 'Service Type 1', 'Employee Type 3', '2009-09-10', '2011-01-01'),
(6, 'Olivia_Miller_ST1_ET3', 'Service Type 1', 'Employee Type 3', '1994-12-25', '2005-06-15'),
(7, 'William_Taylor_ST2_ET1', 'Service Type 2', 'Employee Type 1', '1959-05-20', '2000-01-01'),
(8, 'Sophia_Anderson_ST2_ET1', 'Service Type 2', 'Employee Type 1', '1964-08-12', '2005-06-15'),
(9, 'David_Thomas_ST2_ET2', 'Service Type 2', 'Employee Type 2', '1954-02-10', '2000-01-01'),
(10, 'Isabella_Jackson_ST2_ET2', 'Service Type 2', 'Employee Type 2', '1959-07-25', '2005-06-15'),
(11, 'James_Martin_ST2_ET3', 'Service Type 2', 'Employee Type 3', '1954-09-30', '2000-01-01'),
(12, 'Mia_White_ST2_ET3', 'Service Type 2', 'Employee Type 3', '1959-12-15', '2005-06-15'),
(13, 'Ethan_Hall_ST3_ET1', 'Service Type 3', 'Employee Type 1', '1959-05-20', '2000-01-01'),
(14, 'Ava_Clark_ST3_ET1', 'Service Type 3', 'Employee Type 1', '1964-08-12', '2005-06-15'),
(15, 'Noah_Allen_ST3_ET2', 'Service Type 3', 'Employee Type 2', '1954-02-10', '2000-01-01'),
(16, 'Charlotte_Adams_ST3_ET2', 'Service Type 3', 'Employee Type 2', '1959-07-25', '2005-06-15'),
(17, 'Liam_Wright_ST3_ET3', 'Service Type 3', 'Employee Type 3', '1954-09-30', '2000-01-01'),
(18, 'Amelia_Harris_ST3_ET3', 'Service Type 3', 'Employee Type 3', '1959-12-15', '2005-06-15'),
(19, 'ameliaportiagamera','Service Type 3','Employee Type 3','2003-06-06','2020-08-15');
go
WITH EligibleEmployees AS (
SELECT name, servicetype, employeetype, dob, doj,
DATEDIFF(YEAR, dob, GETDATE()) AS age,
DATEDIFF(YEAR, doj, GETDATE()) AS years_of_service
FROM empking
)
SELECT name,age
FROM EligibleEmployees
WHERE (servicetype = 'Service Type 1' AND ((employeetype = 'Employee Type 1' AND years_of_service >= 10 AND (60 - ABS(age)) >= 15) OR
(employeetype = 'Employee Type 2' AND years_of_service >= 12 AND (55 - ABS(age)) >= 14) OR
(employeetype = 'Employee Type 3' AND years_of_service >= 12 AND (55 - ABS(age)) >= 12)))OR
(servicetype IN ('Service Type 2', 'Service Type 3', 'Service Type 4') AND years_of_service >= 15 AND (65 - ABS(age)) >= 20);
go
/*4.write a query to Get Max, Min and Average age of employees, service of employees by service Type , Service Status for each Centre(display in years and Months)*/
alter table employees alter column Service_Type varchar(50) 
alter table employees alter column  Service_status varchar(50)
CREATE TABLE centers (
    Center_ID INT PRIMARY KEY,
    Center_Name VARCHAR(30)
);

CREATE TABLE employees (
    Employee_ID INT PRIMARY KEY,
    Center_ID INT,
    Date_of_Birth DATE,
    Service_Type VARCHAR(10),
    Service_Status VARCHAR(20),
    FOREIGN KEY (Center_ID) REFERENCES centers(Center_ID)
);

INSERT INTO centers (Center_ID, Center_Name) VALUES
(1, 'hyderabad'),
(2, 'bangalore'),
(3, 'mumbai');

INSERT INTO employees (Employee_ID, Center_ID, Date_of_Birth, Service_Type, Service_Status) VALUES
(1, 1, '1990-05-15', 'delivery', 'Active'),
(2, 1, '1985-10-20', 'hr', 'Inactive'),
(3, 2, '1982-03-10', 'delivery', 'Active'),
(4, 2, '1995-07-05', 'hr', 'Inactive'),
(5, 3, '1978-12-25', 'delivery', 'Active'),
(6, 3, '1992-06-06','hr','Inactive');
go;
SELECT 
isnull(c.Center_Name,'center_total') as center,isnull(e.Service_Type,'service_total') as servicetype,
isnull(e.Service_Status,'status_total') as status1,
MAX(DATEDIFF(YEAR, e.Date_of_Birth, GETDATE())) AS Max_Age_Years,
MIN(DATEDIFF(YEAR, e.Date_of_Birth, GETDATE())) AS Min_Age_Years,
CONCAT(
CAST(MAX(DATEDIFF(YEAR, e.Date_of_Birth, GETDATE())) AS NVARCHAR(10)), ' years ',
CAST(MAX(DATEDIFF(MONTH, e.Date_of_Birth, GETDATE()) % 12) AS NVARCHAR(10)), ' months'
) AS Max_Age,
CONCAT(
CAST(MIN(DATEDIFF(YEAR, e.Date_of_Birth, GETDATE())) AS NVARCHAR(10)), ' years ',
CAST(MIN(DATEDIFF(MONTH, e.Date_of_Birth, GETDATE()) % 12) AS NVARCHAR(10)), ' months'
) AS Min_Age,
CONCAT(
CAST(ROUND(AVG(DATEDIFF(YEAR, e.Date_of_Birth, GETDATE())), 2) AS NVARCHAR(10)), ' years ',
CAST(ROUND(AVG(DATEDIFF(MONTH, e.Date_of_Birth, GETDATE()) % 12.0), 2) AS NVARCHAR(10)), ' months'
) AS Avg_Age
   
FROM 
employees e
JOIN 
centers c ON e.Center_ID = c.Center_ID
GROUP BY 
cube(c.Center_Name, e.Service_Type, e.Service_Status);
/*having (c.Center_Name in ('center_total')  AND e.Service_Type in ('service_total') )
    OR (c.Center_Name in ('center_total') and e.Service_Status in ( 'status_total') )
    OR (e.Service_Type in ('status_total') AND e.Service_Status in ('service_total'));*/
go

/*5)Write a query to list out all the employees where any of the words (Excluding Initials) in the Name starts and ends with the same
character. (Assume there are not more than 5 words in any name )*/
drop table employeename
create table employeename(
name varchar(30))
insert into employeename VALUES ('A. Anna'),
('A. Alan'),
('A. Alice'),
('A. Aaron'),
('Ella'),
('Ethan'),
('Emma'),
('G.Ganag'),
('n.Evan'),
('Ava'),
('A. Alex');
SELECT name
FROM employeename
WHERE(
(CHARINDEX(' ', TRIM(name)) > 0 AND LEFT(TRIM(name), 1) = RIGHT(TRIM(name), 1))
OR 
(CHARINDEX(' ', TRIM(name)) = 0 AND LEN(TRIM(name)) > 1 AND LEFT(TRIM(name), 1) = RIGHT(TRIM(name), 1))
);

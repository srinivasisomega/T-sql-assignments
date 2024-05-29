use EMPID#266
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
select d.departmentname,d.branch,sum(e.salary),avg(e.salary)
from departments as d 
join employee as e 
on e.did=d.did
group by d.departmentname,d.branch
having sum(e.salary)>2*avg(e.salary) and 3*min(e.salary)<=max(e.salary)
select * from departments
select * from employee order by did;

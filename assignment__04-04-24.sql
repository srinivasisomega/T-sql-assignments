/*Employee Management System:
Consider three tables: employees, departments, and salaries.
 
employees table: employee_id, employee_name, department_id, hire_date
departments table: department_id, department_name
salaries table: employee_id, salary_amount, salary_date
Write a SQL query to retrieve the names of employees along with their department names and the latest salary amount.*/
create table employees266(
eid int primary key(eid)
,ename varchar(20),
did int
,hiredate date,
constraint fk66 foreign key(did) references departments2(did) );
go
create table departments2(
did int primary key(did)
,dname varchar(20));
go
create table salaries2(
eid int
,salary money
,sal_date date
,constraint fk661 foreign key(eid) references employees266(eid));
go
insert into employees266 values(3,'srinivas',2,'2024-03-15')
insert into departments2 values(2,'hpt')
insert into salaries2 values
(3,100000,'2024-05-30')
,(3,90000,'2024-06-03')
WITH RankedSalaries AS (
SELECT
e.ename
,d.dname
,s.salary,
DATEDIFF(DAY, s.sal_date, GETDATE()) AS late
,ROW_NUMBER() OVER (PARTITION BY e.eid ORDER BY s.sal_date DESC) AS rn
FROM
employees266 AS e 
JOIN 
departments2 AS d ON e.did = d.did 
JOIN 
salaries2 AS s ON e.eid = s.eid 
)
SELECT 
ename
,dname
,salary
FROM 
RankedSalaries
WHERE 
rn = 1;
/*Product Inventory:
You have tables products, categories, and orders. 
products table: product_id, product_name, category_id, price
categories table: category_id, category_name
orders table: order_id, product_id, quantity, order_date
Write a SQL query to find out the total revenue generated from each category in the last month.*/
-- Create Categories table
CREATE TABLE Categories (
category_id INT PRIMARY KEY
,category_name VARCHAR(100)
);
INSERT INTO Categories (category_id, category_name) VALUES 
(1, 'Electronics')
,(2, 'Clothing')
,(3, 'Books');
go
CREATE TABLE Products (
product_id INT PRIMARY KEY
,product_name VARCHAR(100)
,category_id INT
,price DECIMAL(10, 2)
,FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
go
-- Insert sample records into Products table
INSERT INTO Products (product_id, product_name, category_id, price) VALUES 
(1, 'Laptop', 1, 999.99),
(2, 'T-shirt', 2, 19.99),
(3, 'Headphones', 1, 49.99),
(4, 'Jeans', 2, 29.99),
(5, 'Novel', 3, 12.99);
go
CREATE TABLE Orders (
order_id INT PRIMARY KEY
,product_id INT
,quantity INT
,order_date DATE
,FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
go
-- Insert sample records into Orders table
INSERT INTO Orders (order_id, product_id, quantity, order_date) VALUES 
(1, 1, 2, '2024-06-01')
,(2, 2, 3, '2024-06-02')
,(3, 3, 1, '2024-06-03')
,(4, 4, 2, '2024-06-04')
,(5, 5, 1, '2024-06-05');
go
--queries to view tables
select * from Products
select * from Orders
select * from Categories
go
--main query
select sum(o.quantity*p.price) as revenpro
,c.category_name as cat 
from Categories as c
join
Products as p
on c.category_id=p.category_id
join Orders as o 
on p.product_id=o.product_id
where datediff(month,o.order_date,getdate())=1
group by c.category_name
go
--the dates inserted were in june i updated them to dates in may
UPDATE Orders
SET order_date = DATEADD(MONTH, -1, order_date)
WHERE MONTH(order_date) = 6;
/*Library Management System:
You're dealing with books, authors, and borrowers tables. 
books table: book_id, book_title, author_id, publication_date
authors table: author_id, author_name, author_country
borrowers table: borrower_id, book_id, borrower_name, borrow_date, return_date
Write a SQL query to list all books along with their authors and the borrowers who borrowed them, including the borrow and return dates.*/
-- Create authors table
CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100),
    author_country VARCHAR(100)
);
go
-- Insert values into authors table
INSERT INTO authors (author_id, author_name, author_country) VALUES
(1, 'J.K. Rowling', 'United Kingdom'),
(2, 'George R.R. Martin', 'United States'),
(3, 'Haruki Murakami', 'Japan');
go
-- Create books table
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    book_title VARCHAR(255),
    author_id INT,
    publication_date DATE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);
go
-- Insert values into books table
INSERT INTO books (book_id, book_title, author_id, publication_date) VALUES
(1, 'Harry Potter and the Philosopher''s Stone', 1, '1997-06-26'),
(2, 'A Game of Thrones', 2, '1996-08-06'),
(3, 'Norwegian Wood', 3, '1987-09-01');
go
-- Create borrowers table
CREATE TABLE borrowers (
    borrower_id INT PRIMARY KEY,
    book_id INT,
    borrower_name VARCHAR(100),
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
go
-- Insert values into borrowers table
INSERT INTO borrowers (borrower_id, book_id, borrower_name, borrow_date, return_date) VALUES
(1, 1, 'John Doe', '2023-05-15', '2023-06-15'),
(2, 2, 'Jane Smith', '2022-10-20', '2022-11-20'),
(3, 3, 'Michael Johnson', '2023-03-10', '2023-04-10');
go
-- Insert additional values into books table
INSERT INTO books (book_id, book_title, author_id, publication_date) VALUES
(4, 'Harry Potter and the Chamber of Secrets', 1, '1998-07-02'),
(5, 'Harry Potter and the Prisoner of Azkaban', 1, '1999-07-08'),
(6, 'A Clash of Kings', 2, '1998-11-16'),
(7, 'A Storm of Swords', 2, '2000-08-08'),
(8, 'Kafka on the Shore', 3, '2002-09-12'),
(9, '1Q84', 3, '2009-05-29');
go
-- Insert additional values into borrowers table
INSERT INTO borrowers (borrower_id, book_id, borrower_name, borrow_date, return_date) VALUES
(4, 1, 'Emily Johnson', '2023-08-10', '2023-09-10'),
(5, 2, 'David Brown', '2023-01-05', '2023-02-05'),
(6, 3, 'Sophia Lee', '2022-12-20', '2023-01-20'),
(7, 4, 'Daniel Wilson', '2023-09-25', '2023-10-25'),
(8, 5, 'Olivia Martinez', '2022-11-30', '2022-12-30'),
(9, 6, 'James Taylor', '2023-06-15', '2023-07-15');
go

-- Select query to display all data from the three tables
SELECT * FROM authors;
SELECT * FROM books;
SELECT * FROM borrowers;
select a.author_name
,b.book_title
,bo.borrower_name
,bo.borrow_date
,bo.return_date
from authors as a
join
books as b 
on a.author_id=b.author_id
join
borrowers as bo
on b.book_id=bo.book_id
/*University Enrollment:
There are tables students, courses, enrollments, and grades. 
students table: student_id, student_name, student_major
courses table: course_id, course_name, course_department
enrollments table: enrollment_id, student_id, course_id, enrollment_date
grades table: grade_id, enrollment_id, grade_value
Write a SQL query to calculate the average grade for each course.*/
CREATE TABLE studentki (
  student_id INT PRIMARY KEY,
  student_name VARCHAR(255),
  student_major VARCHAR(255)
);

CREATE TABLE courses (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(255),
  course_department VARCHAR(255)
);

CREATE TABLE enrollments (
  enrollment_id INT PRIMARY KEY,
  student_id INT,
  course_id INT,
  enrollment_date DATE,
  FOREIGN KEY (student_id) REFERENCES studentki(student_id),
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE grades (
  grade_id INT PRIMARY KEY,
  enrollment_id INT,
  grade_value DECIMAL(3,2),
  FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);
go
INSERT INTO studentki (student_id, student_name, student_major)
VALUES (1, 'John Doe', 'Computer Science'),
       (2, 'Jane Smith', 'Mathematics'),
       (3, 'Mike Johnson', 'Physics'),
       (4, 'Alice Williams', 'Biology'),
       (5, 'Bob Brown', 'Chemistry');

INSERT INTO courses (course_id, course_name, course_department)
VALUES (1, 'Calculus I', 'Mathematics'),
       (2, 'Introduction to Computer Science', 'Computer Science'),
       (3, 'Introduction to Physics', 'Physics'),
       (4, 'Introduction to Biology', 'Biology'),
       (5, 'Introduction to Chemistry', 'Chemistry');

INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date)
VALUES (1, 1, 1, '2024-06-01'),
       (2, 1, 2, '2024-06-01'),
       (3, 2, 1, '2024-06-01'),
       (4, 3, 3, '2024-06-01'),
       (5, 4, 4, '2024-06-01'),
       (6, 5, 5, '2024-06-01'),
       (7, 1, 2, '2024-09-01'),
       (8, 2, 1, '2024-09-01'),
       (9, 3, 3, '2024-09-01'),
       (10, 4, 4, '2024-09-01'),
       (11, 5, 5, '2024-09-01');

INSERT INTO grades (grade_id, enrollment_id, grade_value)
VALUES (1, 1, 3.5),
       (2, 2, 4.0),
       (3, 3, 3.0),
       (4, 4, 2.5),
       (5, 5, 3.0),
       (6, 7, 3.8),
       (7, 8, 3.2),
       (8, 9, 2.8),
       (9, 10, 3.5),
       (10, 11, 3.2);
go
select* from courses
select * from enrollments
select * from grades
select c.course_name,avg(g.grade_value) as average_grade
from studentki as s
join
enrollments as e
on s.student_id=e.student_id
join
courses as c
on c.course_id=e.course_id
join
grades as g
on e.enrollment_id=g.enrollment_id
group by c.course_name 
/*E-commerce Analysis:
You have tables customers, orders, and products. 
customers table: customer_id, customer_name, customer_country
orders table: order_id, customer_id, product_id, order_date, order_quantity
products table: product_id, product_name, product_price
Write a SQL query to find out the total revenue generated from customers in each country.*/
-- Create tables
drop table orderki
drop table customers
drop table productki
-- Create tables
-- Create tables
CREATE TABLE customersi (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(255),
  customer_country VARCHAR(255)
);

CREATE TABLE orderki (
  order_id INT PRIMARY KEY,
  customer_id INT,
  product_id INT,
  order_date DATE,
  order_quantity INT,
  FOREIGN KEY (customer_id) REFERENCES customersi(customer_id),
  FOREIGN KEY (product_id) REFERENCES productki(product_id)
);

CREATE TABLE productki (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(255),
  product_price DECIMAL(10, 2)
);

-- Insert records
INSERT INTO customersi(customer_id, customer_name, customer_country)
VALUES
  (3001, 'Brad Guzan', 'London'),
  (3002, 'Nick Rimando', 'New York'),
  (3003, 'Jozy Altidor', 'Moscow'),
  (3004, 'Fabian Johnson', 'Paris'),
  (3005, 'Graham Zusi', 'California'),
  (3007, 'Brad Davis', 'New York'),
  (3008, 'Julian Green', 'London'),
  (3009, 'Geoff Cameron', 'Berlin');

INSERT INTO orderki(order_id, customer_id, product_id, order_date, order_quantity)
VALUES
  (70001, 3005, 5001, '2012-10-05', 1),
  (70002, 3002, 5001, '2012-10-05', 1),
  (70003, 3009, 5003, '2012-10-10', 1),
  (70004, 3009, 5003, '2012-08-17', 1),
  (70005, 3007, 5001, '2012-07-27', 1),
  (70007, 3005, 5002, '2012-09-10', 1),
  (70008, 3002, 5001, '2012-09-10', 1),
  (70009, 3001, 5005, '2012-09-10', 1),
  (70010, 3004, 5006, '2012-10-10', 1),
  (70011, 3008, 5002, '2012-06-27', 1),
  (70012, 3008, 5002, '2012-06-27', 1),
  (70013, 3003, 5007, '2012-04-25', 1);

INSERT INTO productki(product_id, product_name, product_price)
VALUES
  (5001, 'Product 1', 100.00),
  (5002, 'Product 2', 200.00),
  (5003, 'Product 3', 300.00),
  (5004, 'Product 4', 400.00),
  (5005, 'Product 5', 500.00),
  (5006, 'Product 6', 600.00),
  (5007, 'Product 7', 700.00);
select c.customer_country,sum(o.order_quantity*p.product_price) as total_revenue 
from customersi as c
join
orderki as o
on c.customer_id=o.customer_id
join
productki as p
on o.product_id=p.product_id
group by c.customer_country;
--1st question 
WITH RankedSalaries AS (
SELECT
e.ename
,d.dname
,s.salary,
DATEDIFF(DAY, s.sal_date, GETDATE()) AS late
,ROW_NUMBER() OVER (PARTITION BY e.eid ORDER BY s.sal_date DESC) AS rn
FROM
employees266 AS e 
JOIN 
departments2 AS d ON e.did = d.did 
JOIN 
salaries2 AS s ON e.eid = s.eid 
)
SELECT 
ename
,dname
,salary
FROM 
RankedSalaries
WHERE 
rn = 1;
--2nd question
select sum(o.quantity*p.price) as revenpro
,c.category_name as cat 
from Categories as c
join
Products as p
on c.category_id=p.category_id
join Orders as o 
on p.product_id=o.product_id
where datediff(month,o.order_date,getdate())=1
group by c.category_name
go
--3rd question
select a.author_name
,b.book_title
,bo.borrower_name
,bo.borrow_date
,bo.return_date
from authors as a
join
books as b 
on a.author_id=b.author_id
join
borrowers as bo
on b.book_id=bo.book_id;
go;
--4th question
select c.course_name,avg(g.grade_value) as average_grade
from studentki as s
join
enrollments as e
on s.student_id=e.student_id
join
courses as c
on c.course_id=e.course_id
join
grades as g
on e.enrollment_id=g.enrollment_id
group by c.course_name;
go
--5th question
select c.customer_country,sum(o.order_quantity*p.product_price) as total_revenue 
from customersi as c
join
orderki as o
on c.customer_id=o.customer_id
join
productki as p
on o.product_id=p.product_id
group by c.customer_country;
go

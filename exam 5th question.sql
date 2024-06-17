use EMPID#266;
select * from emp_department
create table emp_department(
dpt_code int
, dpt_name varchar(20)
, dpt_allotment int
,  primary key(dpt_code))
insert into emp_department values
( 57,'IT',65000),
(63,'Finance',15000),
(47,'HR', 240000),
(27,'RD', 55000),
(89,'QC',75000)
create table emp_details(
emp_idno int,
emp_fname varchar(20),
emp_lname varchar(20),
emp_dept int,
primary key(emp_idno),
foreign key(emp_dept) references emp_department(dpt_code))
insert into emp_details values
(127323,'Michale','Robbin',57)
,(526689,'Carlos','Snares',63),
(843795, 'Enric', 'Dosio', 57),
(328717, 'Jhon', 'Snares', 63),
(444527, 'Joseph', 'Dosni', 47),
(659831, 'Zanifer', 'Emily', 47),
(847674, 'Kuleswar', 'Sitaraman', 57),
(748681, 'Henrey', 'Gabriel', 47),
(555935, 'Alex', 'Manuel', 57),
(539569, 'George', 'Mardy', 27),
(733843, 'Mario', 'Saule', 63),
(631548, 'Alan', 'Snappy', 27),
(839139, 'Maria', 'Foster', 57);
--8)1st method
with second_lowest 
as
(select top(1) dpt_code 
from emp_department
where dpt_allotment > (select top(1) dpt_allotment from emp_department order by dpt_allotment)
order by dpt_allotment)
select e.emp_fname, e.emp_lname from 
emp_details as e
join
second_lowest as s
on
e.emp_dept =s.dpt_code
where e.emp_dept = s.dpt_code
--8)2nd method
with cte as(
select *,
dense_rank() OVER (order by dpt_allotment) as dept_rank 
from emp_department 
)
SELECT 
    e.emp_fname,
    e.emp_lname
FROM 
    emp_details e
JOIN 
    cte c ON e.emp_dept = c.dpt_code
WHERE 
    dept_rank = 2;
--2nd q
drop table city
drop table country
create table city(id int,name varchar(25),ccode varchar(3) foreign key references country(ccode),pop int);
create table country(ccode varchar(3) primary key,continent varchar(20));
-- Inserting data into the city table
INSERT INTO city (id, name, ccode, pop) VALUES
    (1, 'New York', 'USA', 8175133),
    (2, 'Los Angeles', 'USA', 3792621),
    (3, 'London', 'GBR', 8787892),
    (4, 'Paris', 'FRA', 2140526),
    (5, 'Tokyo', 'JPN', 9273000),
    (6, 'Beijing', 'CHN', 21540000),
    (7, 'Sydney', 'AUS', 5312160),
    (8, 'Rio de Janeiro', 'BRA', 6320446),
    (9, 'Cairo', 'EGY', 9500000),
    (10, 'Mumbai', 'IND', 12442373);
INSERT INTO country (ccode, continent) VALUES
    ('USA', 'North America'),
    ('GBR', 'Europe'),
    ('FRA', 'Europe'),
    ('JPN', 'Asia'),
    ('CHN', 'Asia'),
    ('AUS', 'Australia'),
    ('BRA', 'South America'),
    ('EGY', 'Africa'),
    ('IND', 'Asia');
	go
--2)1 method
select c.continent,round(avg(ci.pop),2)
from country as c
join
city as ci
on
c.ccode = ci.ccode
group by c.continent
go

--7)1)method
with emp as(
select (purch_amt+1000) as req from Orders;
)
select orderdate,sum(purch_amt) as alls from Orders as o join emp as e group by Orderdate having alls>e.req;
go
--2nd)
SELECT a.ord_date, SUM(a.purch_amt) AS total_purch_amt
FROM orders AS a
GROUP BY a.ord_date
HAVING SUM(a.purch_amt) >
    (SELECT 1000.00 + MAX(b.purch_amt)
     FROM orders AS b
     WHERE a.ord_date = b.ord_date);
--6)1st method
SELECT m.hacker_id, h.name, SUM(m.score) AS total_score
FROM (
    SELECT hacker_id, challenge_id, MAX(score) AS score
    FROM Submissions
    GROUP BY hacker_id, challenge_id
) AS m
JOIN Hackers AS h ON m.hacker_id = h.hacker_id
GROUP BY m.hacker_id, h.name
HAVING SUM(m.score) > 0
ORDER BY total_score DESC, m.hacker_id;
go
--2)method
WITH MaxScores AS (
    SELECT hacker_id, challenge_id, MAX(score) AS max_score
    FROM Submissions
    GROUP BY hacker_id, challenge_id
)
SELECT m.hacker_id, h.name, SUM(m.max_score) AS total_score
FROM MaxScores AS m
JOIN Hackers AS h ON m.hacker_id = h.hacker_id
GROUP BY m.hacker_id, h.name
HAVING SUM(m.max_score) > 0
ORDER BY total_score DESC, m.hacker_id;
go
--5)1)method
SELECT
w.id AS id,
wp.age AS age,
w.coins_needed AS coins_needed,
w.power AS power
FROM
Wands w
JOIN
WandProperties wp ON w.code = wp.code
WHERE
wp.is_evil = 0  
ORDER BY
w.power DESC,  
wp.age DESC; 
go
--5)2)method
WITH SortedWands AS (
    SELECT
w.id AS id
,wp.age AS age,
w.coins_needed AS coins_needed,
w.power AS power,
ROW_NUMBER() OVER (ORDER BY w.power DESC, wp.age DESC) AS row_num
FROM
Wands w
JOIN
WandProperties wp ON w.code = wp.code
WHERE
wp.is_evil = 0  
)
SELECT
id,
age,
coins_needed,
power
FROM
SortedWands
ORDER BY
row_num;
go
--3)1st method
select 
    case 
        when g.grade < 8 then 'null'
        else s.name 
    end as name,
    g.grade,
    s.marks
from students s
join grades g
on s.marks between g.min_mark and g.max_mark
order by 
    g.grade desc,
    case 
        when g.grade >= 8 then s.name
        else null
    end asc,
    case
        when g.grade < 8 then s.marks
        else null
    end asc;
 go
 --3)2ndmethod
with studentgrades as (
    select 
        s.name,
        g.grade,
        s.marks,
        case 
            when g.grade < 8 then 'null'
            else s.name 
        end as display_name
    from students s
    join grades g
    on s.marks between g.min_mark and g.max_mark
)
select display_name as name, grade, marks from studentgrades
order by grade desc,
    case 
        when grade >= 8 then display_name
        else null
    end asc,
    case
        when grade < 8 then marks
        else null
    end asc;
 go
 --4)1stmethod
CREATE TABLE Hackertable (
    hacker_id INTEGER PRIMARY KEY,
    name VARCHAR(50)
);
 
INSERT INTO Hackertable (hacker_id, name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');
 
CREATE TABLE Difficultytable (
    challenge_id INTEGER PRIMARY KEY,
    difficulty_level INTEGER
);
 
INSERT INTO Difficultytable (challenge_id, difficulty_level) VALUES
(101, 5),
(102, 3),
(103, 7),
(104, 2);
 
CREATE TABLE Submissions (
    submission_id INTEGER PRIMARY KEY,
    hacker_id INTEGER,
    challenge_id INTEGER,
    score INTEGER
);
 
INSERT INTO Submissions (submission_id, hacker_id, challenge_id, score) VALUES
(1, 1, 101, 5),
(2, 1, 102, 3),
(3, 1, 103, 7),
(4, 2, 101, 5),
(5, 2, 102, 3),
(6, 3, 101, 5),
(7, 3, 103, 7),
(8, 3, 104, 2),
(9, 4, 101, 5),
(10, 4, 102, 3),
(11, 4, 103, 7);
go
 
WITH FullScoreCounts AS (
    SELECT hacker_id, COUNT(DISTINCT s.challenge_id) AS num_full_scores
    FROM Submissions s
    JOIN Difficultytable d ON s.challenge_id = d.challenge_id
    WHERE s.score = d.difficulty_level
    GROUP BY hacker_id
    HAVING COUNT(DISTINCT s.challenge_id) > 1
)
 
SELECT h.hacker_id, h.name
FROM Hackertable h
JOIN FullScoreCounts f ON h.hacker_id = f.hacker_id
ORDER BY f.num_full_scores DESC, h.hacker_id ASC;
 go
 --4)2nd method
SELECT h.hacker_id, h.name
FROM Hackertable h
JOIN (
    SELECT s.hacker_id, COUNT(DISTINCT s.challenge_id) AS num_full_scores
    FROM Submissions s
    JOIN Difficultytable d ON s.challenge_id = d.challenge_id
    WHERE s.score = d.difficulty_level
    GROUP BY s.hacker_id
    HAVING COUNT(DISTINCT s.challenge_id) > 1
) AS full_scores ON h.hacker_id = full_scores.hacker_id
ORDER BY full_scores.num_full_scores DESC, h.hacker_id ASC;
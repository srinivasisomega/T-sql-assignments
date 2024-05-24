CREATE TABLE PEACE2(
marge1 int,
paage varchar(20),
nani money,
bile numeric(4));
go
insert into peace2 
values(2,'manny',52,4444),(123, 'John Doe', 1000.50, 1234.67),
(456, 'Jane Smith', 2500.75, 987.32),
(789, 'Michael Johnson', 500.25, 345.78),
(321, 'Emily Davis', 1500.00, 678.90),
(654, 'David Brown', 2000.35, 234.56),
(987, 'Sarah Wilson', 3000.60, 789.12),
(135, 'Chris Miller', 1800.25, 456.78),
(246, 'Jessica Taylor', 2200.75, 567.89),
(579, 'Ryan Anderson', 2800.90, 890.12),
(813, 'Amanda Martinez', 3500.00, 123.45),
(642, 'Matthew Hernandez', 4000.25, 678.90),
(975, 'Ashley Gonzalez', 2750.50, 901.23),
(318, 'Andrew Perez', 3200.75, 234.56),
(864, 'Emma Rivera', 4100.35, 789.01),
(291, 'Joshua Lee', 3800.60, 345.67),
(537, 'Olivia White', 2000.25, 901.23),
(426, 'Daniel Scott', 2900.75, 456.78),
(759, 'Lauren Green', 3100.90, 567.89),
(183, 'Nicholas Hall', 2700.00, 890.12),
(624, 'Sophia Adams', 4200.25, 123.45),
(957, 'Grace Clark', 3600.50, 678.90),
(372, 'Brandon Baker', 2400.75, 901.23),
(681, 'Taylor Allen', 2950.35, 234.56),
(294, 'Hannah King', 3300.60, 789.01),
(483, 'Jacob Wright', 3700.25, 345.67),
(726, 'Madison Nelson', 2250.75, 901.23),
(519, 'Ethan Carter', 3900.90, 456.78),
(837, 'Victoria Mitchell', 4000.00, 567.89),
(162, 'Christopher Perez', 4150.25, 890.12),
(345, 'Natalie Roberts', 3800.50, 123.45),
(978, 'Kayla Turner', 3350.75, 678.90),
(213, 'Tyler Phillips', 2600.35, 901.23),
(456, 'Samantha Campbell', 2950.60, 234.56),
(789, 'Logan Evans', 3700.25, 789.01),
(234, 'Isabella Martinez', 3400.60, 345.67),
(567, 'William Hernandez', 4200.75, 901.23),
(891, 'Chloe Young', 3150.35, 456.78),
(123, 'Megan Adams', 4050.90, 567.89),
(456, 'Justin Turner', 4300.00, 890.12),
(789, 'Abigail Garcia', 3950.25, 123.45),
(234, 'Austin Harris', 3800.50, 678.90),
(567, 'Rachel Cooper', 3650.75, 901.23),
(890, 'Kevin Rodriguez', 3200.35, 234.56),
(567, 'Alexis Parker', 4000.60, 789.01),
(234, 'Benjamin Morris', 3700.25, 345.67),
(891, 'Sydney Turner', 4400.75, 901.23),
(123, 'Joseph Thompson', 3350.35, 456.78),
(456, 'Grace Flores', 4100.90, 567.89);
create index mine on peace2(bile)
go
select * from PEACE2
order by bile desc
select bile from PEACE2
UPDATE PEACE2
SET paage = 'drags', nani = 366.39, bile=450
WHERE bile<=400;
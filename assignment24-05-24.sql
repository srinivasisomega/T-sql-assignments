use EMPID#266
drop function get_num
CREATE FUNCTION get_num
(@strAlphaNumeric VARCHAR(256))
RETURNS VARCHAR(256)
AS
BEGIN
DECLARE @intAlpha INT
SET @intAlpha = PATINDEX('%[^0-9]%', @strAlphaNumeric)
BEGIN
WHILE @intAlpha > 0
BEGIN
SET @strAlphaNumeric = STUFF(@strAlphaNumeric, @intAlpha, 1, '' )
SET @intAlpha = PATINDEX('%[^0-9]%', @strAlphaNumeric )
END
END
RETURN ISNULL(@strAlphaNumeric,0)
END
GO
SELECT get_num('asdf1234a1s2d3f4@@@')
go
-- Using substring
DECLARE @Ans VARCHAR(100) = 'A1B2C3D4E5F6'

DECLARE @Nv VARCHAR(100) = ''

DECLARE @p INT = 1
WHILE @p <= LEN(@Ans)
BEGIN
DECLARE @currentChar CHAR(1) = SUBSTRING(@Ans, @p, 1)
IF @currentChar BETWEEN '0' AND '9'
BEGIN
SET @Nv = @Nv + @currentChar
END
SET @p = @p + 1
END
SELECT @Nv AS NumericValues
--2)2. Write a script to calculate age based on the Input DOB
DECLARE @dob DATE = '2003-06-06'
DECLARE @curda DATE = GETDATE()
SELECT FLOOR(DATEDIFF(year, @dob, @curda)) AS Age
--if you want the exact age till decimals
DECLARE @diff INT = DATEDIFF(day, @dob, @curda)
DECLARE @years INT = @diff / 365
DECLARE @remainingDays INT = @diff % 365
DECLARE @age FLOAT = @years + (@remainingDays / 365.0)
SELECT @age AS Age
--3)  Create a column in a table and that should throw an error when we do SELECT * or SELECT of that column. If we select other columns then we should see results
--method 1 creating a calculated column which is not logical(zero throw error)
create table erothrow(
emo_id int,
srido varchar(20),
error as (emo_id/0))
insert into erothrow values(1,'vvsvsv'),(2,'esbdbdddb');
select*from erothrow;
select emo_id,srido from erothrow

--Display Calendar Table based on the input year.
DECLARE @StartDate date = '20240101';
DECLARE @enddate date = DATEADD(DAY, -1, DATEADD(YEAR, 1, @StartDate));
WITH das(n) AS 
(
  SELECT 0 UNION ALL SELECT n + 1 FROM das
  WHERE n < DATEDIFF(DAY, @StartDate, @enddate)
),
sequendateadd(d) AS 
(
  SELECT DATEADD(DAY, n, @StartDate) FROM das
),
src AS
(
  SELECT
    theDate         = CONVERT(date,d),
	TheDayOfYear    = cast(DATEPART(DAYOFYEAR, d)as varchar)+'-'+cast(datepart(DAYOFYEAR,@enddate)AS varchar),
    TheDay          = cast(DATEPART(DAY,d)as varchar)+'-'+cast(datepart(day,eomonth(d))as varchar),
    TheDayName      = DATENAME(WEEKDAY,   d),
    TheWeek         = cast(DATEPART(WEEK,d)as varchar)+'-'+cast(DATEPART(WEEK,@enddate) as varchar),
    TheDayOfWeek    = cast(DATEPART(WEEKDAY,d)as varchar)+' - 7',
    TheMonth        = cast(DATEPART(MONTH,d)as varchar)+'-'+cast(DATEPART(month,@enddate) as varchar),
    TheMonthName    = DATENAME(MONTH,d),
    TheQuarter      = DATEPART(Quarter,d),
    TheYear         = DATEPART(YEAR,d),
    TheFirstOfMonth = DATEFROMPARTS(YEAR(d), MONTH(d), 1),
    TheLastOfYear   = DATEFROMPARTS(YEAR(d), 12, 31)
  FROM sequendateadd
)

SELECT * FROM src
  ORDER BY theDate
  OPTION (MAXRECURSION 0);
go
--Display Emp and Manager Hierarchies based on the input till the topmost hierarchy.
CREATE TABLE company(
empid int primary key(empid),
empname varchar(20),
manager int)
insert into company values
(1,'srinivas',null),
(2,'ritvik',1),
(3,'vijay',1),
(4,'purandhar',1),
(5,'puneeth',10),
(6,'rolo',2),
(7,'golo',2),
(8,'milo',3),
(9,'ragini',6),
(10,'puraa',9);
with cte as(
select e.empid,e.empname,cast('ceo'as varchar(20)) as managername,1 as emplevel
from company as e where manager is NULL
UNION ALL
SELECT e.empid,e.empname,m.empname as managername,(Emplevel+1) as hierarchylevel
from company as e
inner join cte m on m.empid=e.manager)
select * from cte order by emplevel
select * from company;

drop table company
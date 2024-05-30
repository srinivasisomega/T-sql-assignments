--trail 1
DECLARE @dob DATE = '1985-11-20'
DECLARE @curda DATE = '2017-06-01'
DECLARE @diff INT = DATEDIFF(MONTH, @dob, @curda)
declare @year int =@diff/12
declare @year1 int =@diff%12
declare @year2 int =@diff%12-1
declare @tempdateyear date=dateadd(year,@year,@dob)
declare @months date=DATEadd(MONTH,@year2, @tempdateyear)
DECLARE @diff2 INT = DATEDIFF(DAY, @months, @curda)
declare @tmonthfirst date= datefromparts(year(@months),month(@months),01)
select @diff m ,@year m1,@tempdateyear m2,@year2 s1,@months s2,@tmonthfirst s3,@diff2
--end of trail1
--creating a function for trail 1
create function age_cal4(
@dob date,
@curda DATE)
returns varchar(20)
as
begin
DECLARE @diff INT = DATEDIFF(MONTH, @dob, @curda)
declare @year int =@diff/12
declare @year1 int =@diff%12
declare @year2 int =abs(@diff%12-1)
declare @tempdateyear date=dateadd(year,@year,@dob)
declare @months date=DATEadd(MONTH,@year2, @tempdateyear)
DECLARE @diff2 INT = DATEDIFF(DAY, @months, @curda)
return cast(@year as varchar(20))+' years '+cast(@year2 as varchar(20))+' months '+cast(@diff2 as varchar(20))+' days.'
end
--end of trail function
-- actual function used in assignment
CREATE FUNCTION agecal(
    @dob DATE,
    @curda DATE
)
RETURNS VARCHAR(100)
AS
BEGIN
DECLARE @years INT,@months INT,@days INT,@tmpdate DATE;
SET @tmpdate = @dob;
SET @years = DATEDIFF(yy, @tmpdate, @curda) - 
CASE 
WHEN (MONTH(@dob) > MONTH(@curda)) OR (MONTH(@dob) = MONTH(@curda) AND DAY(@dob) > DAY(@curda)) 
THEN 1 
ELSE 0 
END;
SET @tmpdate = DATEADD(yy, @years, @tmpdate)
SET @months = DATEDIFF(m, @tmpdate, @curda) - 
CASE WHEN DAY(@dob) > DAY(@curda) THEN 1 ELSE 0 END;
SET @tmpdate = DATEADD(m, @months, @tmpdate);
SET @days = DATEDIFF(d, @tmpdate, @curda);
RETURN CAST(@years AS VARCHAR(10)) + ' years ' + CAST(@months AS VARCHAR(10)) + ' months ' + CAST(@days AS VARCHAR(10)) + ' days';
END;

select dbo.agecal ('1985-11-20','2017-06-01')
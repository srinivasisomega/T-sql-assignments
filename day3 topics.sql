use EMPID#266
select salary,upper(firstname),lower(email),len(firstname) as lony,len(salary)as pal,DATALENGTH(salary) as val  from sampletable;
CREATE TABLE wages  
(  
    emp_id        TINYINT   IDENTITY,  
    hourly_wage   DECIMAL   NULL,  
    salary        DECIMAL   NULL,  
    commission    DECIMAL   NULL,  
    num_sales     TINYINT   NULL  
);  
go
INSERT wages (hourly_wage, salary, commission, num_sales)  
VALUES  
    (10.00, NULL, NULL, NULL),  
    (20.00, NULL, NULL, NULL),  
    (30.00, NULL, NULL, NULL),  
    (40.00, NULL, NULL, NULL),  
    (NULL, 10000.00, NULL, NULL),  
    (NULL, 20000.00, NULL, NULL),  
    (NULL, 30000.00, NULL, NULL),  
    (NULL, 40000.00, NULL, NULL),  
    (NULL, NULL, 15000, 3),  
    (NULL, NULL, 25000, 2),  
    (NULL, NULL, 20000, 6),  
    (NULL, NULL, 14000, 4)
SELECT floor(CAST(COALESCE(hourly_wage * 40 * 52,   
   salary,   
   commission * num_sales) AS money)) AS 'Total Salary'   
FROM dbo.wages  
ORDER BY 'Total Salary';  

SELECT CAST(COALESCE(hourly_wage * 40 * 52,   
   abs(salary),   
   commission * num_sales) AS money) AS 'Total Salary'   
FROM dbo.wages  
ORDER BY 'Total Salary';  
GO
update wages
set salary=20000.00, commission=15000.75
where salary= -20000.00 or commission=15000;
select * from wages
SELECT CEILING($123.45), CEILING($-123.45), CEILING($0.0);
GO
SELECT FLOOR(123.45), FLOOR(-123.45), FLOOR($123.45); 
select ISNUMERIC(Age), ISNUMERIC(PhoneNumber) from SampleTable;
SELECT ASCII('P') AS [ASCII], ASCII('æ') AS [Extended_ASCII];
SELECT NCHAR(80) AS [CHARACTER], NCHAR(195) AS [CHARACTER];
DECLARE @string_to_trim VARCHAR(60);
SET @string_to_trim = '     Five spaces are at the beginning of this string.';
SELECT
    @string_to_trim AS 'Original string',
    LTRIM(@string_to_trim) AS 'Without spaces';
SELECT CONCAT(firstname,lastname,age) AS Result
FROM SampleTable;
GO
DECLARE @string_to_trim VARCHAR(60);  
SET @string_to_trim = 'Four spaces are after the period in this sentence.    ';  
SELECT @string_to_trim + ' Next string.',RTRIM(@string_to_trim) + ' Next string.';  
GO
DECLARE @document VARCHAR(64);  
SELECT @document = 'Reflectors are vital safety' +  
                   ' components of your bicycle.';  
SELECT CHARINDEX('vital', @document, 5);  
GO
SELECT FORMAT( joindate, 'dd/MM/yyyy', 'en-US' ) AS 'Date'  
       ,FORMAT(phonenumber,'###-##-####') AS 'Custom Number'
	   from sample
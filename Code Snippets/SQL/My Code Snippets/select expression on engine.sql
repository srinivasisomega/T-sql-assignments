use EMPID#266
SELECT cast(enginename as varchar) + ' is ' + cast(isnull(engineage,'0') as varchar) + ' years old, it weighs as int ' + cast(engineweight as varchar) AS [describe the engine]
FROM engine;
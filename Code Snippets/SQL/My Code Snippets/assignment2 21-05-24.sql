use EMPID#266
select top 0 * into new_engine from engine;
go
select * from new_engine
create table engine_2 LIKE engine;
use EMPID#266
select * from toys
SELECT toy_id FROM toys where toy_id>5 order by rolls;
create index ramulu on toys(rolls);
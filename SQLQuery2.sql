use EMPID#266
CREATE TABLE PEACE(
marge int,
paage varchar,
nani money,
bile numeric(4))
go
INSERT into PEACE values(1,'a',35,2234);
go
select*from peace
UPDATE PEACE
SET marge = 3, nani = 36
WHERE bile=2234;
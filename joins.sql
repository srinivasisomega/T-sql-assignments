use EMPID#266
drop table m1
drop table m2
create table m1(
id int,mmid int,
constraint minjo primary key(id))
create table m2(
mmid int, mmna varchar(10), mn int, 
constraint pinjo foreign key(mmid) references m1(id))
insert into m1 values(
1,3),(2,1),(3,2)
insert into m2 values(
1,'ra'),(2,'p'),(3,'g')
select* from m1  join m2 on m1.id=m2.mmid 
select* from m1,m2
where m1.id=m2.mmid;
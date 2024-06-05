create table a1(id int,name varchar(10));
insert into a1 values(1,'a');
insert into a1 values(2,'b');
insert into a1 values(3,'c');
insert into a1 values(4,'d');
insert into a1 values(5,'e');
insert into a1 values(6,'f');
create table a2(id int,name varchar(10),age int);
insert into a2 values(1,'aa',20);
insert into a2 values(2,'bb',20);
insert into a2 values(3,'cc',20);
insert into a2 values(4,'cc',21);
insert into a2 values(5,'cc',22);
insert into a2 values(6,'cc',23);

alter view a_view
with schemabinding 
as 
select a1.id,a2.age from dbo.a1 join dbo.a2 on a1.id=a2.id;

create unique clustered index ck2 on a_view (id);
select * from a_view;
create nonclustered index gg on a_view (age);
select * from a_view where age=22;
exec sp_helptext 'a_view'
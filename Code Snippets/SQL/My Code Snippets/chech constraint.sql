create table engine(
engineid varchar(24) unique not null,
enginename varchar(24) not null,
engineweight int not null,
engineage int not null,
enginebuild varchar(10),
primary key(engineid),
check(enginebuild in ('casted','welded'))
);
insert into engine values('#2314d6','yamahav8',200,3,'casted')
insert into engine values('#2314d9','yamahav8',200,3,'casted')
insert into engine values('#2314d610','yamahav8',200,3,'casted')
insert into engine values('#2314d11','yamahav8',200,3,'casted')
insert into engine values('#2314d12','yamahav8',200,3,'casted')
insert into engine values('#2314d13','yamahav8',200,3,'casted')

go
insert into engine values('#2314d7','yamahav8',200,10,'mined')
ALTER TABLE engine
ADD CONSTRAINT df_age
DEFAULT 1 FOR engineage;
alter table engine
alter column engineage int 
alter table engine add price int;
alter table engine add constraint  foreign key(Price) references toys.toy_id;
insert into engine values('#2314d8','yamahav8',200,default,'welded')
select enginename+' is '+engineage+' years old, it weighs '+engineweight as [describe the engine] from engine
select * from engine;
select * from toys;
alter table engine add constraint FK foreign key (price) references toys(toy_id);

update engine set price=2 where enginebuild ='welded';

select e.enginename, t.price from engine as e join toys as t  on (e.price =t.toy_id);
select * from engine;
select * from toys;






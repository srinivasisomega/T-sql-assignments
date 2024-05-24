insert into toys values(3,'DinoExplorer',19.99,'Embark on a prehistoric adv');
insert into toys values(4,'Magical Unicorn',39.99,'Enter a world of enchantment with the Magical Unicorn plush toy featuring rainbow mane and sparkling wings');
insert into toys values(5,'BuildIt!',24.99,'BuildIt! is the ultimate construction set for budding archit endless creative possibilities');
insert into toys values(6,'Space Odyssey',34.99,'Blast off into the cosmos with the Space Odyssey playset castronaut figures, and a lunar rover');
insert into toys values(7,'Princess Palace',59.99,'The Princess Palace is a majestic castle fit for royalty fecret chambers for magical adventures');
go
update toys set toyname = 'pistol'
where toyid = 1
go
alter table toys add qt int ;
exec sp_rename 'toys.toyid','toy_id','COLUMN'
alter table toys drop column qt
alter table toys alter column toyname varchar(max)


select*from bdo.toys.indexes;
go
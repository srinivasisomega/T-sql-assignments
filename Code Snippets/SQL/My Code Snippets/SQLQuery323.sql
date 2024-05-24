select * from sys.indexes where type_desc = 'clustered';
go
create table gor(rem int, kem varchar(25), dam numeric(20));
insert gor values(2,'glld',1242453656),(3,'bhari',13232554453);
use master
select allocated_page_file_id as [FileID],allocated_page_page_id as [PageID],page_type_desc,extent_page_id/8 as ExtentID,

is_mixed_page_allocation,extent_page_id as [First Page in Extent],extent_page_id+7 as [LastPage in Extent],is_allocated From 

sys.dm_db_database_page_allocations(db_id(),object_id('dbo.heaptable1'),null,null,'detailed')  order by allocated_page_page_id
begin
declare @spl nvarchar(max)
set @spl='CREATE TABLE engine1 AS CLONE OF engine;'
EXEC sp_executesql @spl;
end
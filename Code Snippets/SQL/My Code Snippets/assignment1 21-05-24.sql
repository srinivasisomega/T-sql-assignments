Use EMPID#266;
DECLARE @TableName NVARCHAR(128) = 'toys'
DECLARE @NewTableName NVARCHAR(128) = @TableName
DECLARE @Counter INT = 1
DECLARE @SQL560 NVARCHAR(MAX)

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = @TableName)
BEGIN
    CREATE TABLE toys (
        id INT PRIMARY KEY,
        name NVARCHAR(50),
        price DECIMAL(10, 2)
    );
END
ELSE
BEGIN
    
    WHILE EXISTS (SELECT * FROM sys.tables WHERE name = @NewTableName)
    BEGIN
        SET @NewTableName = @TableName + '_' + CAST(@Counter AS NVARCHAR(10))
        SET @Counter = @Counter + 1
    END

    SET @SQL560 = 'CREATE TABLE ' + QUOTENAME(@NewTableName) + ' (
                    id INT PRIMARY KEY,
                    name NVARCHAR(50),
                    price DECIMAL(10, 2)
                );'
    
    EXEC sp_executesql @SQL;
END
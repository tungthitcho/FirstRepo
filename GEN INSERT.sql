declare @TableName sysname = 'T_Post'
declare @Result varchar(max) = 'INSERT INTO ' + @TableName + '
		('

select @Result = @Result + '
		  ' + ColumnName + ','
from
(
    select 
        replace(col.name, ' ', '_') ColumnName,
        column_id ColumnId       
    from sys.columns col
        join sys.types typ on
            col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
    where object_id = object_id(@TableName) AND col.is_identity = 0 
) t
order by ColumnId

set @Result = @Result  + '
        )
		VALUES
		('
select @Result = @Result + '
		  @' + ColumnName + ','
from
(
    select 
        replace(col.name, ' ', '_') ColumnName,
        column_id ColumnId       
    from sys.columns col
        join sys.types typ on
            col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
    where object_id = object_id(@TableName) AND col.is_identity = 0
) t
order by ColumnId

set @Result = @Result  + '
        )'
print @Result
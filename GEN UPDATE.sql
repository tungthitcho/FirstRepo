declare @TableName sysname = 'T_ShoppingCartDetail'
declare @Result varchar(max) = 'UPDATE ' + @TableName + '
SET		'

select @Result = @Result + '' + ColumnName + ' = @' + ColumnName + '
		,'
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
print @Result
-- Разделение таблицы

CREATE PROCEDURE ApartTable
@Table_name nvarchar(50)
AS
BEGIN
DECLARE @f_name1 nvarchar(60), @f_name2 nvarchar(60), @filename1 nvarchar(200), @filename2 nvarchar(200), @temp_table_name nvarchar(60)
SET @f_name1 = @Table_name + '_1'
SET @f_name2 = @Table_name + '_2'
SET @filename1 = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\' + @f_name1 + '.ndf'
SET @filename2 = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\' + @f_name2 +  '.ndf'
SET @temp_table_name = @Table_name + '_temp'

ALTER DATABASE DBMS_admin
ADD FILEGROUP @f_name1;
ALTER DATABASE DBMS_admin
ADD FILEGROUP @f_name2;

ALTER DATABASE DBMS_admin
ADD FILE
(
NAME = @f_name1,
FILENAME = @filename1
) TO FILEGROUP @f_name1;

ALTER DATABASE DBMS_admin
ADD FILE
(
NAME = @f_name2,
FILENAME = @filename2
) TO FILEGROUP @f_name2;

CREATE PARTITION FUNCTION my_pf(bit)
AS
RANGE LEFT
FOR VALUES (0)

CREATE PARTITION SCHEME my_ps
AS PARTITION my_pf
TO (@f_name1, @f_name2)

CREATE TABLE @temp_table_name (id int, text_field text, part_id bit)
ON my_ps(part_id);

INSERT INTO @temp_table_name SELECT * FROM @Table_name;


DROP TABLE @Table_name;

EXEC sp_rename @temp_table_name @Table_name;

END
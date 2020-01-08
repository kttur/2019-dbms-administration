-- Восстановление БД из файла с указанием даты

CREATE PROCEDURE DBRestore
@DB_name nvarchar(100), @Date nvarchar(50), @Full bit = 1
AS
BEGIN
	DECLARE @b_path nvarchar(200)
	SET @b_path = 'd:\db_backup\' + @DB_name + '_' + @Date
	IF @Full = 0
		BEGIN
		SET @b_path = @b_path + '_diff.bak'
		RESTORE DATABASE @DB_name
		FROM
		DISK = @b_path
		WITH RECOVERY;
		END
	ELSE
		BEGIN
		SET @b_path = @b_path + '_full.bak'
		RESTORE DATABASE @DB_name
		FROM
		DISK = @b_path
		WITH NORECOVERY;
		END
END
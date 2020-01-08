-- Создание бэкапа БД
-- При Full = 0 -- разностная копия, иначе -- полная

CREATE PROCEDURE DBBackup
@DB_name nvarchar(100), @Full bit = 1
AS
BEGIN
	DECLARE @b_path nvarchar(200)
	SET @b_path = 'd:\db_backup\' + @DB_name + '_' + FORMAT(CURRENT_TIMESTAMP, N'yyyy-mm-ddTHH.mm.ss')
	IF @Full = 0
		BEGIN
		SET @b_path = @b_path + '_diff.bak'
		BACKUP DATABASE @DB_name
		TO
		DISK = @b_path
		WITH DIFFERENTIAL, INIT;
		END
	ELSE
		BEGIN
		SET @b_path = @b_path + '_full.bak'
		BACKUP DATABASE @DB_name
		TO
		DISK = @b_path
		WITH INIT;
		END
END
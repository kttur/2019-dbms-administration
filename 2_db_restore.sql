-- Восстановление БД из файла с указанием даты

CREATE PROCEDURE DBRestore
@Date datetime, @Full bit = 1
AS
BEGIN
	DECLARE @b_path VARCHAR(100)
	SET @b_path = 'd:\db_backup\dbms_admin_' + FORMAT(@Date, N'yyyy-mm-ddTHH.mm.ss')
	IF @Full = 0
		BEGIN
		SET @b_path = @b_path + '_diff.bak'
		PRINT @b_path
		RESTORE DATABASE DBMS_Admin
		FROM
		DISK = @b_path
		WITH RECOVERY;
		END
	ELSE
		BEGIN
		SET @b_path = @b_path + '_full.bak'
		PRINT @b_path
		RESTORE DATABASE DBMS_Admin
		FROM
		DISK = @b_path
		WITH NORECOVERY;
		END
END
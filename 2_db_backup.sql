-- Создание бэкапа БД
-- При Full = 0 -- разностная копия, иначе -- полная

CREATE PROCEDURE DBBackup
@Full bit = 1
AS
BEGIN
	DECLARE @b_path VARCHAR(100)
	SET @b_path = 'd:\db_backup\dbms_admin_' + FORMAT(CURRENT_TIMESTAMP, N'yyyy-mm-ddTHH.mm.ss')
	IF @Full = 0
		BEGIN
		SET @b_path = @b_path + '_diff.bak'
		BACKUP DATABASE DBMS_Admin
		TO
		DISK = @b_path
		WITH DIFFERENTIAL, INIT;
		END
	ELSE
		BEGIN
		SET @b_path = @b_path + '_full.bak'
		BACKUP DATABASE DBMS_Admin
		TO
		DISK = @b_path
		WITH INIT;
		END
END
-- Создание бэкапа БД
-- При Full = 0 -- разностная копия, иначе -- полная

CREATE PROCEDURE DBBackup
@Full bit = 1
AS
BEGIN
	IF @Full = 0
		BACKUP DATABASE DBMS_Admin
		TO
		DISK = 'd:\db_backup\dbms_admin.bak'
		WITH DIFFERENTIAL, INIT;
	ELSE
		BACKUP DATABASE DBMS_Admin
		TO
		DISK = 'd:\db_backup\dbms_admin.bak'
		WITH INIT;
END
-- Создание бэкапа БД
-- При Full = 0 -- полная, иначе -- разностная

CREATE PROCEDURE DBBackup
@Full bit = 0
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
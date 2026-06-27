-- RESPALDOS PERIÓDICOS Y VERIFICACIÓN DE INTEGRIDAD

USE SeguridadBD;
GO

-- 1. VERIFICACIÓN DE INTEGRIDAD DE DATOS (DBCC CHECKDB)
-- Evalúa la consistencia física y lógica de todas las páginas del clúster antes del respaldo
DBCC CHECKDB ('SeguridadBD') WITH NO_INFOMSGS, ALL_ERRORMSGS;
GO

-- 2. RESPALDOS PERIÓDICOS 
-- Configuración para ejecutar la copia de seguridad completa (Full Backup)
USE master;
GO
BACKUP DATABASE SeguridadBD
TO DISK = 'C:\Audit\SeguridadBD_Full.bak'
WITH FORMAT, MEDIANAME = 'SQLServerBackups', NAME = 'Full Backup de SeguridadBD', COMPRESSION;
GO

-- Copia de seguridad del Log de Transacciones (Diferencial / Log periódico)
BACKUP LOG SeguridadBD
TO DISK = 'C:\Audit\SeguridadBD_Log.trn'
WITH NOFORMAT, NOINIT, NAME = 'Log Backup de SeguridadBD', SKIP, NOREWIND, NOUNLOAD, COMPRESSION;
GO
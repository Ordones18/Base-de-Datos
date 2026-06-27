
--RECUPERACIÓN DE DATOS DESDE EL RESPALDO

USE master;
GO

--  Restauración de la base de datos desde el respaldo completo (Full Backup)
RESTORE DATABASE SeguridadBD
FROM DISK = 'C:\Audit\SeguridadBD_Full.bak'
WITH 
    REPLACE,                      -- Sobrescribe la base de datos existente
    STATS = 10,                   -- Muestra el progreso cada 10%
    RECOVERY;                     -- Deja la base de datos operativa inmediatamente
GO

-- Verificación de integridad post-restauración
PRINT '>> VERIFICACIÓN POST-RESTAURACIÓN: Ejecutando DBCC CHECKDB...';
DBCC CHECKDB ('SeguridadBD') WITH NO_INFOMSGS, ALL_ERRORMSGS;
GO

-- Confirmación del estado final de los datos recuperados
USE SeguridadBD;
GO
SELECT COUNT(*) AS [Total Registros DESPUÉS de la recuperación] FROM CLIENTES;
GO

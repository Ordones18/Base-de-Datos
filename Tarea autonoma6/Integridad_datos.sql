
-- VERIFICACIÓN DE INTEGRIDAD DE DATOS 

USE SeguridadBD;
GO

-- visualización de DBCC
SET NOCOUNT ON;
GO

-- Ejecución de la auditoría de consistencia en las páginas de almacenamiento
DBCC CHECKDB ('SeguridadBD') 
WITH 
    NO_INFOMSGS,      -- Suprime los mensajes informativos redundantes
    ALL_ERRORMSGS;    -- Fuerza la visualización de la totalidad de errores si existiese corrupción
GO

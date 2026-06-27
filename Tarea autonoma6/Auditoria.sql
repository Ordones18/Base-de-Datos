-- CONFIGURACIÓN CENTRAL  DE AUDITORÍA
USE master; 
GO

-- Crear el contenedor principal de auditoría apuntando a un directorio físico
CREATE SERVER AUDIT AuditoriaSeguridadBD
TO FILE (FILEPATH = 'C:\Audit\') 
WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE);
GO

-- Por defecto el recolector se inicializa en estado inactivo; se procede a su encendido
ALTER SERVER AUDIT AuditoriaSeguridadBD WITH (STATE = ON);
GO

-- ESPECIFICACIONES DE EVENTOS EN SEGURIDADBD

USE SeguridadBD;
GO

-- Crear la especificación de auditoría de eventos a nivel de objetos de datos
CREATE DATABASE AUDIT SPECIFICATION AuditClientesSeguridad
FOR SERVER AUDIT AuditoriaSeguridadBD
ADD (SELECT, INSERT ON OBJECT::dbo.CLIENTES BY public) -- Monitorea consultas e inserciones de todos los roles
WITH (STATE = ON); -- Activación inmediata de la directiva de vigilancia
GO
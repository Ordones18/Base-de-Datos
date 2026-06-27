-- SIMULACIÓN DE ACCIONES OPERATIVAS Y ANÁLISIS  DEL LOG

USE SeguridadBD;
GO

-- Ejecución de consultas de prueba para activar los disparadores del recolector
SELECT nombre, ruc_cedula FROM CLIENTES;
INSERT INTO CLIENTES (nombre, ruc_cedula, ciudad) VALUES ('Compañía de Prueba Audit', '0601112223', 'Quito');
GO

-- Consulta sobre los archivos de log físicos generados en el almacenamiento
SELECT 
    event_time AS [Fecha y Hora],
    session_server_principal_name AS [Usuario SQL],
    host_name AS [Computadora Origen],
    statement AS [Código Ejecutado Exactamente]
FROM sys.fn_get_audit_file ('C:\Audit\*', default, default);
GO
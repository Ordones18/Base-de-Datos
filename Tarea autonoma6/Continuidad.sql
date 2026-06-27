-- VALIDACIÓN DE CONTINUIDAD DEL SERVICIO Y OPERATIVIDAD

USE SeguridadBD;
GO

-- Confirmación de la integridad de los datos recuperados
SELECT 
    COUNT(*) AS [Total Registros en CLIENTES],
    COUNT(DISTINCT ciudad) AS [Ciudades Representadas],
    MIN(cliente_id) AS [ID Mínimo],
    MAX(cliente_id) AS [ID Máximo]
FROM CLIENTES;
GO

-- Verificación de la integridad referencial con otras tablas
SELECT 
    (SELECT COUNT(*) FROM CLIENTES) AS [Total CLIENTES],
    (SELECT COUNT(*) FROM PRODUCTOS) AS [Total PRODUCTOS],
    (SELECT COUNT(*) FROM VENTAS) AS [Total VENTAS];
GO

-- Consulta de muestra para validar la disponibilidad de datos
SELECT TOP 10 
    cliente_id,
    nombre,
    ruc_cedula,
    ciudad
FROM CLIENTES
ORDER BY cliente_id;
GO

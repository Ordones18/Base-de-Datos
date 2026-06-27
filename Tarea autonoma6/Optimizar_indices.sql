-- SIMULACIÓN DE CARGA MASIVA E INDUCCIÓN DE FRAGMENTACIÓN REAL

USE SeguridadBD;
GO

-- Inserción masiva de registros utilizando un bucle iterativo 
SET NOCOUNT ON;
DECLARE @contador INT = 1;
WHILE @contador <= 5000
BEGIN
    INSERT INTO CLIENTES (nombre, ruc_cedula, ciudad)
    VALUES (
        'Cliente Corporativo Nro ' + CAST(@contador AS VARCHAR(10)),
        '06' + RIGHT('000000000' + CAST(@contador AS VARCHAR(10)), 9) + '001',
        CASE WHEN @contador % 2 = 0 THEN 'Quito' ELSE 'Riobamba' END
    );
    SET @contador = @contador + 1;
END;
PRINT '>> ÉXITO: 5000 registros insertados de forma masiva.';
GO

--  Provocar fragmentación real eliminando registros de forma intercalada 
DELETE FROM CLIENTES WHERE cliente_id % 3 = 0;
PRINT '>> ÉXITO: Estructura indexada fragmentada mediante borrado intercalado.';
GO

-- DIAGNÓSTICO DE SALUD MÉTRICA Y MEDICIÓN DEL PORCENTAJE

USE SeguridadBD;
GO

-- Consulta técnica para medir el nivel exacto de fragmentación en las tablas
SELECT 
    OBJECT_NAME(object_id) AS [Tabla],
    index_id AS [ID_Indice],
    avg_fragmentation_in_percent AS [Porcentaje Fragmentación],
    page_count AS [Total Páginas Ocupadas]
FROM sys.dm_db_index_physical_stats (DB_ID('SeguridadBD'), OBJECT_ID('CLIENTES'), NULL, NULL, 'DETAILED');
GO


--  RESTAURACIÓN A 0% 
USE SeguridadBD;
GO

-- Aplicación del comando definitivo según la regla de decisión (Si la fragmentación superó el 30%)
ALTER INDEX ALL ON CLIENTES REBUILD;
PRINT '>> ÉXITO: Mantenimiento mayor ejecutado de forma contigua en el disco.';
GO

-- Ejecutar nuevamente el script de diagnóstico para comprobar el retorno al 0%
SELECT 
    OBJECT_NAME(object_id) AS [Tabla],
    index_id AS [ID_Indice],
    avg_fragmentation_in_percent AS [Porcentaje Fragmentación],
    page_count AS [Total Páginas Ocupadas]
FROM sys.dm_db_index_physical_stats (DB_ID('SeguridadBD'), OBJECT_ID('CLIENTES'), NULL, NULL, 'DETAILED');
GO
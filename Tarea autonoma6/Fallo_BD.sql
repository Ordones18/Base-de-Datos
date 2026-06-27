-- SIMULACIÓN DE FALLO - ELIMINACIÓN MASIVA DE REGISTROS

USE SeguridadBD;
GO

-- 1. Verificar el número total de registros antes del incidente
SELECT COUNT(*) AS [Total Registros ANTES del incidente] FROM CLIENTES;
GO

-- 2. Ejecutar eliminación masiva simulando un fallo humano o ataque
-- Esta operación elimina aproximadamente el 40% de los registros
DELETE FROM CLIENTES 
WHERE cliente_id BETWEEN 1000 AND 3000;
PRINT '>> SIMULACIÓN DE FALLO: Se eliminaron registros críticos de CLIENTES.';
GO

-- 3. Verificar el estado de la tabla después del incidente
SELECT COUNT(*) AS [Total Registros DESPUÉS del incidente] FROM CLIENTES;
GO

-- 4. Confirmar la pérdida de datos específicos (clientes que ya no existen)
SELECT COUNT(*) AS [Registros Perdidos] 
FROM CLIENTES 
WHERE cliente_id BETWEEN 1000 AND 3000;
GO
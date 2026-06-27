--VERIFICACIÓN DE PRIVILEGIOS
USE SeguridadBD;
GO

-- EVALUACIÓN USUARIO_VENTAS
EXECUTE AS USER = 'usuario_ventas';
GO

-- Prueba 1: Lectura permitida en clientes 
SELECT * FROM CLIENTES;

-- Prueba 2: Inserción permitida en clientes 
INSERT INTO CLIENTES (nombre, ruc_cedula, ciudad) VALUES ('Chocolate Filón de Oro', '0609876543', 'Riobamba');

-- Prueba 3: Intento de actualización no autorizado 
UPDATE CLIENTES SET ciudad = 'Ambato' WHERE nombre = 'Corporación Oro Cacao';

-- Prueba 4: Intento de consulta en tabla fuera de rol 
SELECT * FROM PRODUCTOS;
GO

REVERT; -- Restablecer privilegios del administrador principal
GO

-- EVALUACIÓN DEL CONTEXTO: USUARIO_FINANZAS (Sin privilegios asignados)
EXECUTE AS USER = 'usuario_finanzas';
GO

-- Prueba 5: Intento de lectura sin permisos (Debe ser RECHAZADO por el motor)
SELECT * FROM CLIENTES;
GO

REVERT; -- Restablecer privilegios del administrador principal
GO
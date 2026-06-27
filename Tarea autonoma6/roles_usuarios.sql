-- CONFIGURACIÓN DE ROLES DE BASE DE DATOS Y PERMISOS
USE SeguridadBD;
GO

-- Crear los roles para la base de datos SeguridadBD
CREATE ROLE rol_ventas;
CREATE ROLE rol_admin;
GO

-- Asignación restrictiva de privilegios 
GRANT SELECT, INSERT ON CLIENTES TO rol_ventas;
GO

-- Asignación de control, administración y mantenimiento total al rol administrativo
GRANT CONTROL ON DATABASE::SeguridadBD TO rol_admin;
GO
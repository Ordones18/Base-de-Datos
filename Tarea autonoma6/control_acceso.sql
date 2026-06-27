
--  CREACIÓN DE LOGINS, USUARIOS Y CONFIGURACIÓN DE ACCESOS

-- Ejecución para el aprovisionamiento de credenciales del servidor
USE master;
GO
CREATE LOGIN login_ventas WITH PASSWORD = 'VentasPassword2026!';
CREATE LOGIN login_finanzas WITH PASSWORD = 'FinanzasPassword2026!';
GO

-- Retorno a la base de datos de trabajo para el mapeo de usuarios 
USE SeguridadBD;
GO
CREATE USER usuario_ventas FOR LOGIN login_ventas;
CREATE USER usuario_finanzas FOR LOGIN login_finanzas;
GO

-- Vinculación de los usuarios a sus correspondientes perfiles 
ALTER ROLE rol_ventas ADD MEMBER usuario_ventas;
GO
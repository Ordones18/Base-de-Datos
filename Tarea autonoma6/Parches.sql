-- VERIFICACIÓN DE CUMPLIMIENTO DE PARCHES DE SEGURIDAD

USE SeguridadBD;
GO

-- Consulta técnica para auditar la versión, arquitectura y nivel de compilación activa
SELECT 
    SERVERPROPERTY('ProductVersion') AS [Versión del Producto],
    SERVERPROPERTY('ProductLevel') AS [Nivel de Service Pack / CU],
    SERVERPROPERTY('Edition') AS [Edición del Motor Relacional],
    @@VERSION AS [Detalle Literal de Compilación del Sistema Operativo];
GO
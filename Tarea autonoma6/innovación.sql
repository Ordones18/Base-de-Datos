
-- PLUS INNOVADOR - ESTRUCTURAS DE GOBERNANZA Y ALERTAS
USE SeguridadBD;
GO
-- abla de Políticas de Retención de Datos (Cumplimiento LOPDP / ISO 27001)
CREATE TABLE POLITICAS_RETENCION (
    politica_id INT IDENTITY(1,1) PRIMARY KEY,
    tabla_afectada VARCHAR(50) NOT NULL,
    tiempo_retencion_meses INT NOT NULL,
    nivel_criticidad VARCHAR(20) CHECK (nivel_criticidad IN ('Alto', 'Medio', 'Bajo')),
    fecha_implementacion DATE DEFAULT GETDATE(),
    responsable_politica VARCHAR(100) DEFAULT 'DBA_Principal'
);
GO

-- Tabla de Alertas de Seguridad e Incidentes (Monitoreo Proactivo / IDS)
CREATE TABLE ALERTAS_SEGURIDAD (
    alerta_id INT IDENTITY(1,1) PRIMARY KEY,
    fecha_alerta DATETIME DEFAULT GETDATE(),
    usuario_sospechoso VARCHAR(100),
    tipo_incidente VARCHAR(50), 
    descripcion_detallada VARCHAR(max),
    estado_alerta VARCHAR(20) DEFAULT 'Pendiente' CHECK (estado_alerta IN ('Pendiente', 'En Revisión', 'Mitigado'))
);
GO
-- Inserción de la política regulatoria de retención para la auditoría de clientes
INSERT INTO POLITICAS_RETENCION (tabla_afectada, tiempo_retencion_meses, nivel_criticidad)
VALUES ('Tabla_Auditoria_Clientes', 24, 'Alto');
GO

SELECT * FROM POLITICAS_RETENCION;
SELECT * FROM ALERTAS_SEGURIDAD;
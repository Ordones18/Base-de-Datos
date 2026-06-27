
--  CREACIÓN DE LA BASE DE DATOS Y ESTRUCTURA
CREATE DATABASE SeguridadBD;
GO

USE SeguridadBD;
GO

-- Creación de la tabla CLIENTES
CREATE TABLE CLIENTES (
    cliente_id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ruc_cedula VARCHAR(15) NOT NULL UNIQUE,
    ciudad VARCHAR(50),
    estado_logico BIT DEFAULT 1
);
GO

-- Creación de la tabla PRODUCTOS
CREATE TABLE PRODUCTOS (
    producto_id INT IDENTITY(1,1) PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock INT NOT NULL CHECK (stock >= 0)
);
GO

-- Creación de la tabla VENTAS
CREATE TABLE VENTAS (
    venta_id INT IDENTITY(1,1) PRIMARY KEY,
    cliente_id INT FOREIGN KEY REFERENCES CLIENTES(cliente_id),
    producto_id INT FOREIGN KEY REFERENCES PRODUCTOS(producto_id),
    cantidad INT NOT NULL CHECK (cantidad > 0),
    fecha_venta DATETIME DEFAULT GETDATE()
);
GO

-- Inserción de datos de prueba 
INSERT INTO CLIENTES (nombre, ruc_cedula, ciudad) VALUES 
('Corporación Oro Cacao', '1792345678001', 'Quito'),
('Distribuidora Chimborazo', '0601234567', 'Riobamba');

INSERT INTO PRODUCTOS (nombre_producto, precio, stock) VALUES 
('Refinadora de Cacao Industrial', 2499.00, 10),
('Molino de Cacao Artesanal', 899.00, 45);
GO

SELECT * FROM CLIENTES
SELECT * FROM PRODUCTOS
SELECT * FROM VENTAS
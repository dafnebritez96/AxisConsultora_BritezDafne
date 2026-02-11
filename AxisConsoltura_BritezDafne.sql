-- ==========================================
-- CREACION BASE DE DATOS
-- ==========================================

CREATE DATABASE IF NOT EXISTS axis_consultora;
USE axis_consultora;

-- ==========================================
-- TABLA: Departamento
-- ==========================================

CREATE TABLE Departamento (
    id_departamento INT AUTO_INCREMENT,
    nombre_departamento VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_departamento),
    UNIQUE (nombre_departamento)
);

-- ==========================================
-- TABLA: Puesto
-- ==========================================

CREATE TABLE Puesto (
    id_puesto INT AUTO_INCREMENT,
    nombre_puesto VARCHAR(100) NOT NULL,
    sueldo_base DECIMAL(10,2) NOT NULL,
    id_departamento INT NOT NULL,
    PRIMARY KEY (id_puesto),
    FOREIGN KEY (id_departamento)
        REFERENCES Departamento(id_departamento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ==========================================
-- TABLA: Empleado
-- ==========================================

CREATE TABLE Empleado (
    id_empleado INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    id_puesto INT NOT NULL,
    PRIMARY KEY (id_empleado),
    FOREIGN KEY (id_puesto)
        REFERENCES Puesto(id_puesto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ==========================================
-- TABLA: Cliente
-- ==========================================

CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT,
    razon_social VARCHAR(150) NOT NULL,
    rubro VARCHAR(100),
    cuit VARCHAR(20) NOT NULL,
    email VARCHAR(150),
    PRIMARY KEY (id_cliente),
    UNIQUE (cuit)
);

-- ==========================================
-- TABLA: Asignacion
-- ==========================================

CREATE TABLE Asignacion (
    id_asignacion INT AUTO_INCREMENT,
    id_empleado INT NOT NULL,
    id_cliente INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    PRIMARY KEY (id_asignacion),
    FOREIGN KEY (id_empleado)
        REFERENCES Empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Índices para optimizar búsquedas
CREATE INDEX idx_asignacion_empleado ON Asignacion(id_empleado);
CREATE INDEX idx_asignacion_cliente ON Asignacion(id_cliente);

-- ==========================================
-- TABLA: Ingreso
-- ==========================================

CREATE TABLE Ingreso (
    id_ingreso INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    fecha_ingreso DATE NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    descripcion VARCHAR(200),
    PRIMARY KEY (id_ingreso),
    FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Índice para optimizar consultas por cliente
CREATE INDEX idx_ingreso_cliente ON Ingreso(id_cliente);
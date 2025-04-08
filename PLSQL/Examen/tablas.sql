CREATE TABLE departamento (
    id NUMBER(10) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    localidad VARCHAR2(100) NOT NULL
);

CREATE TABLE empleado (
    id NUMBER(10) PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    apellidos VARCHAR2(100) NOT NULL,
    puesto VARCHAR2(50) NOT NULL,
    direccion VARCHAR2(200),
    id_depa NUMBER(10) NOT NULL,
    sueldo NUMBER(10,2) NOT NULL,
    CONSTRAINT fk_empleado_departamento FOREIGN KEY (id_depa) REFERENCES departamento(id)
);

-- Insercion de datos de Departamento
INSERT INTO departamento VALUES (1, 'Recursos Humanos', 'Madrid');
INSERT INTO departamento VALUES (2, 'Tecnología', 'Barcelona');
INSERT INTO departamento VALUES (3, 'Ventas', 'Valencia');

-- Insercion de datos de Empleado
INSERT INTO empleado (id, nombre, apellidos, puesto, direccion, id_depa, sueldo) 
VALUES (1, 'Ana', 'García López', 'Analista RH', 'Calle Mayor 5, Madrid', 1, 2850.50);

INSERT INTO empleado (id, nombre, apellidos, puesto, direccion, id_depa, sueldo) 
VALUES (2, 'Carlos', 'Martínez Soler', 'Desarrollador Senior', 'Avenida Diagonal 200, Barcelona', 2, 4200.00);

INSERT INTO empleado (id, nombre, apellidos, puesto, id_depa, sueldo) 
VALUES (3, 'Laura', 'Sánchez Ruiz', 'Gerente de Ventas', 3, 3750.75);

INSERT INTO empleado (id, nombre, apellidos, puesto, direccion, id_depa, sueldo) 
VALUES (4, 'Pedro', 'Jiménez Mora', 'Soporte Técnico', 'Calle Colón 12, Valencia', 2, 2450.90);

INSERT INTO empleado (id, nombre, apellidos, puesto, direccion, id_depa, sueldo) 
VALUES (5, 'Marta', 'Pérez Gil', 'Reclutador', 'Gran Vía 30, Madrid', 1, 2650.00);

INSERT INTO empleado (id, nombre, apellidos, puesto, id_depa, sueldo) 
VALUES (6, 'Javier', 'Romero Navarro', 'Desarrollador Junior', 2, 2100.00);

INSERT INTO empleado (id, nombre, apellidos, puesto, direccion, id_depa, sueldo) 
VALUES (7, 'Lucía', 'Fernández Castro', 'Asistente de Ventas', 'Calle del Mar 8, Valencia', 3, 1950.60);

INSERT INTO empleado (id, nombre, apellidos, puesto, direccion, id_depa, sueldo) 
VALUES (8, 'Sergio', 'Díaz Mendoza', 'Asistente RH', 'Paseo de la Castellana 45, Madrid', 1, 2300.75);

INSERT INTO empleado (id, nombre, apellidos, puesto, direccion, id_depa, sueldo) 
VALUES (9, 'Elena', 'Ruiz Torres', 'Project Manager', 'Rambla de Catalunya 15, Barcelona', 2, 3850.00);

INSERT INTO empleado (id, nombre, apellidos, puesto, id_depa, sueldo) 
VALUES (10, 'Diego', 'Gómez Serrano', 'Especialista en Marketing', 3, 2750.40);



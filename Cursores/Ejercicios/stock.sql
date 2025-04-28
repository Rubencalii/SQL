CREATE TABLE almacen(
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    direccion VARCHAR(150) NOT NULL
);

CREATE TABLE producto(
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    precio NUMBER(7, 2) NOT NULL
);

CREATE TABLE stock(
    id_alm NUMBER,
    id_prod NUMBER,
    cantidad NUMBER(6),
    CONSTRAINT pk_stock PRIMARY KEY(id_alm, id_prod),
    CONSTRAINT fk_stock_alm FOREIGN KEY(id_alm) REFERENCES almacen(id),
    CONSTRAINT fk_stock_prod FOREIGN KEY(id_prod) REFERENCES producto(id)
);

-- Inserciones para ALMACEN
INSERT INTO almacen VALUES (1, 'Almacén Central', 'Av. Principal 123');
INSERT INTO almacen VALUES (2, 'Almacén Norte', 'Calle Norte 456');
INSERT INTO almacen VALUES (3, 'Almacén Sur', 'Carrera Sur 789');
INSERT INTO almacen VALUES (4, 'Almacén Este', 'Diagonal Este 321');
INSERT INTO almacen VALUES (5, 'Almacén Oeste', 'Transversal Oeste 654');

-- Inserciones para PRODUCTO
INSERT INTO producto VALUES (1, 'Laptop Gamer', 1500.00);
INSERT INTO producto VALUES (2, 'Smartphone Pro', 800.50);
INSERT INTO producto VALUES (3, 'Tablet HD', 300.75);
INSERT INTO producto VALUES (4, 'Monitor 24"', 250.99);
INSERT INTO producto VALUES (5, 'Teclado Mecánico', 120.25);

-- Inserciones para STOCK
INSERT INTO stock VALUES (1, 1, 50);
INSERT INTO stock VALUES (1, 2, 120);
INSERT INTO stock VALUES (1, 3, 75);
INSERT INTO stock VALUES (1, 4, 200);
INSERT INTO stock VALUES (1, 5, 90);
INSERT INTO stock VALUES (2, 1, 30);
INSERT INTO stock VALUES (2, 2, 80);
INSERT INTO stock VALUES (2, 3, 45);
INSERT INTO stock VALUES (2, 4, 150);
INSERT INTO stock VALUES (2, 5, 60);
INSERT INTO stock VALUES (3, 1, 20);
INSERT INTO stock VALUES (3, 2, 50);
INSERT INTO stock VALUES (3, 3, 30);
INSERT INTO stock VALUES (3, 4, 100);
INSERT INTO stock VALUES (3, 5, 40);
INSERT INTO stock VALUES (4, 1, 40);
INSERT INTO stock VALUES (4, 2, 100);
INSERT INTO stock VALUES (4, 3, 60);
INSERT INTO stock VALUES (4, 4, 180);
INSERT INTO stock VALUES (4, 5, 75);
INSERT INTO stock VALUES (5, 1, 10);
INSERT INTO stock VALUES (5, 2, 30);
INSERT INTO stock VALUES (5, 3, 20);
INSERT INTO stock VALUES (5, 4, 80);
INSERT INTO stock VALUES (5, 5, 25);
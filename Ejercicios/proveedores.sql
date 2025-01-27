CREATE TABLE proveedores {
    p NUMBER (1) PRIMARY KEY,
    pNombre VARCHAR2(15) UNIQUE NOT NULL,
    categoria NUMBER(2) NOT NULL,
    ciudad VARCHAR2(25)NOT NULL,
};
CREATE TABLE componentes{
    c NUMBER(1) PRIMARY KEY,
    cNombre VARCHAR2(10) UNIQUE NOT NULL,
    color VARCHAR2(15)NOT NULL,
    peso NUMBER(3)UNIQUE NOT NULL ,
    ciudad VARCHAR2(25) NOT NULL,
}; 
CREATE TABLE articulos{
    t NUMBER(1) PRIMARY KEY,
    tNombre VARCHAR2(25)  UNIQUE NOT NULL,
    ciudad VARCHAR(25) NOT NULL,
};
CREATE TABLE envios {
    p NUMBER (1) PRIMARY KEY,
    c NUMBER(1) PRIMARY KEY,
    t NUMBER(1) PRIMARY KEY,
    cantidad NUMBER(3) UNIQUE NOT NULL,
};

INSERT INTO proveedores(p , pNombre, categoria, ciudad) VALUES
    ('p1','Carlos','20','Sevilla');
INSERT INTO proveedores(p , pNombre, categoria, ciudad) VALUES
    ('p2','Juan','10','Madrid');
INSERT INTO proveedores(p , pNombre, categoria, ciudad) VALUES
    ('p3','Jose','30','Sevilla');
INSERT INTO proveedores(p , pNombre, categoria, ciudad) VALUES
    ('p4','Insa','20','Sevilla');
INSERT INTO proveedores(p , pNombre, categoria, ciudad) VALUES
    ('p5','Eva','30','Caceres');

INSERT INTO componentes(c, cNombre, color, peso, ciudad) VALUES
    ('c1', 'X3A', 'Rojo', '12', 'Sevilla');
INSERT INTO componentes(c, cNombre, color, peso, ciudad) VALUES
    ('c2', 'B85', 'Verde', '17', 'Madrid');
INSERT INTO componentes(c, cNombre, color, peso, ciudad) VALUES
    ('c3', 'C4B', 'Azul', '17', 'Malaga');
INSERT INTO componentes(c, cNombre, color, peso, ciudad) VALUES
    ('c4', 'C4B', 'Rojo', '14', 'Sevilla');
INSERT INTO componentes(c, cNombre, color, peso, ciudad) VALUES
    ('c5', 'VT8', 'Azul', '12', 'Madrid');
INSERT INTO componentes(c, cNombre, color, peso, ciudad) VALUES
    ('c6', 'C30', 'Rojo', '19', 'Sevilla');

INSERT INTO articulos(t, tNombre, ciudad) VALUES
    ('t1', 'Clasificadora', 'Madrid');
INSERT INTO articulos(t, tNombre, ciudad) VALUES
    ('t2', 'Perforadora', 'Malaga');
INSERT INTO articulos(t, tNombre, ciudad) VALUES
    ('t3', 'Lectura', 'Caceres');
INSERT INTO articulos(t, tNombre, ciudad) VALUES
    ('t4', 'Consola', 'Caceres');
INSERT INTO articulos(t, tNombre, ciudad) VALUES
    ('t5', 'Mezcladora', 'Sevilla');
INSERT INTO articulos(t, tNombre, ciudad) VALUES
    ('t6', 'Terminal', 'Barcelona');
INSERT INTO articulos(t, tNombre, ciudad) VALUES
    ('t7', 'Cinta', 'Sevilla');

INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p1', 'c1', 't1', '200');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p1', 'c1', 't4', '700');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p2', 'c3', 't1', '400');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p2', 'c3', 't2', '200');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p2', 'c3', 't3', '200');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p2', 'c3', 't4', '500');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p2', 'c3', 't5', '600');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p2', 'c3', 't6', '400');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p2', 'c3', 't7', '800');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p2', 'c5', 't2', '100');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p3', 'c3', 't1', '200');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p3', 'c4', 't2', '500');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p4', 'c6', 't3', '300');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p4', 'c6', 't7', '300');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p5', 'c2', 't2', '200');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p5', 'c2', 't4', '100');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p5', 'c5', 't4', '500');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p5', 'c5', 't7', '100');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p5', 'c6', 't2', '200');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p5', 'c1', 't4', '100');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p5', 'c3', 't4', '200');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p5', 'c4', 't4', '800');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p5', 'c5', 't5', '400');
INSERT INTO envios(p, c, t, cantidad) VALUES
    ('p5', 'c6', 't4', '500');


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

//1
SELECT articulos, proveedores FROM ciudad WHERE ciudad='Caceres'

//2
SELECT articulos,envios From t WHERE t='t1'

//3
SELECT DISTINCT COLOR, CIUDAD FROM componentes;

//4
SELECT codigo, ciudad FROM articulos WHERE ciudad LIKE '%D' OR ciudad LIKE '%E%'

//5
SELECT p.codigo_proveedor FROM proveedores p JOIN suministro s ON p.codigo_proveedor = s.codigo_proveedor
    JOIN articulos a ON s.codigo_articulo = a.codigo_articulo WHERE a.codigo_articulo = 'T1'
        AND s.codigo_componente = 'C1';

//6
SELECT *
FROM componentes c JOIN proveedores p ON c.codigo_proveedor = p.codigo_proveedor
        WHERE p.ciudad LIKE 'M%';

//7
SELECT a.TNOMBRE FROM articulos a JOIN suministro s ON a.codigo_articulo = s.codigo_articulo
    WHERE s.codigo_proveedor = 'P1' ORDER BY a.TNOMBRE;

//8
SELECT DISTINCT s.codigo_componente FROM suministro s JOIN articulos a 
    ON s.codigo_articulo = a.codigo_articulo JOIN proveedores p 
       ON s.codigo_proveedor = p.codigo_proveedor WHERE p.ciudad = 'MADRID';

//9
SELECT DISTINCT p.codigo_proveedor FROM proveedores p JOIN suministro s ON p.codigo_proveedor = s.codigo_proveedor
    JOIN articulos a ON s.codigo_articulo = a.codigo_articulo WHERE (p.ciudad = 'SEVILLA' 
        OR p.ciudad = 'MADRID')AND s.codigo_componente = 'ROJO';

//10
SELECT s.codigo_componente FROM suministro s WHERE s.codigo_articulo IN (
    SELECT a.codigo_articulo FROM articulos a JOIN proveedores p 
         ON a.codigo_proveedor = p.codigo_proveedor WHERE p.ciudad = 'SEVILLA')
            AND s.codigo_proveedor IN (SELECT codigo_proveedor 
                FROM proveedores WHERE ciudad = 'SEVILLA');

//11
SELECT DISTINCT a.codigo_articulo FROM articulos a JOIN suministro s ON a.codigo_articulo = s.codigo_articulo
    WHERE s.codigo_componente IN ( SELECT codigo_componente
        FROM suministro WHERE codigo_proveedor = 'P1');

//12
SELECT p.ciudad AS ciudad_proveedor, s.codigo_componente, a.ciudad AS ciudad_articulo
    FROM suministro s JOIN proveedores p ON s.codigo_proveedor = p.codigo_proveedor
        JOIN articulos a ON s.codigo_articulo = a.codigo_articulo;

//13
SELECT p.ciudad AS ciudad_proveedor, s.codigo_componente, a.ciudad AS ciudad_articulo
    FROM suministro s JOIN proveedores p ON s.codigo_proveedor = p.codigo_proveedor
        JOIN articulos a ON s.codigo_articulo = a.codigo_articulo WHERE p.ciudad != a.ciudad;

//14
SELECT s.* FROM suministro s JOIN articulos a 
    ON s.codigo_articulo = a.codigo_articulo WHERE a.TNOMBRE LIKE '%ora';

//15
SELECT DISTINCT a.codigo_articulo FROM articulos a JOIN suministro s 
    ON a.codigo_articulo = s.codigo_articulo JOIN proveedores p 
        ON s.codigo_proveedor = p.codigo_proveedor WHERE p.ciudad != 'MADRID' AND p.ciudad != a.ciudad;

//16
SELECT s.codigo_componente FROM suministro s WHERE s.codigo_articulo = 'T2'
    AND s.codigo_proveedor = 'P2';

//17
SELECT s.* FROM suministro s JOIN componentes c 
    ON s.codigo_componente = c.codigo_componente WHERE c.color != 'ROJO';

//18
SELECT DISTINCT s.codigo_proveedor FROM suministro s 
    WHERE s.codigo_articulo = 'T3' AND s.cantidad > 250;
//19

SELECT p.codigo_proveedor FROM proveedores p WHERE p.categoria > 20
  AND p.ciudad = 'SEVILLA';
//20

SELECT s.* FROM suministro s JOIN componentes c 
    ON s.codigo_componente = c.codigo_componente WHERE c.peso > 15 
        AND s.cantidad < 200;
//21

SELECT DISTINCT c.color FROM suministro s JOIN componentes c 
ON s.codigo_componente = c.codigo_componente WHERE s.codigo_proveedor = 'P1';

//22
SELECT DISTINCT c.peso FROM suministro s JOIN componentes c 
    ON s.codigo_componente = c.codigo_componente JOIN proveedores p 
        ON s.codigo_proveedor = p.codigo_proveedor WHERE p.nombre = 'JUAN';

//23
SELECT s.*, p.ciudad FROM suministro s JOIN proveedores p 
    ON s.codigo_proveedor = p.codigo_proveedor JOIN articulos a ON s.codigo_articulo = a.codigo_articulo
        JOIN componentes c ON s.codigo_componente = c.codigo_componente 
            WHERE p.ciudad = a.ciudad AND p.ciudad = c.ciudad;

//24
SELECT s.cantidad, p.categoria FROM suministro s JOIN articulos a 
    ON s.codigo_articulo = a.codigo_articulo JOIN proveedores p  
        ON s.codigo_proveedor = p.codigo_proveedor WHERE a.ciudad = 'MÁLAGA';
        
//25
SELECT p.nombre FROM proveedores p WHERE p.codigo_proveedor NOT IN (
    SELECT s.codigo_proveedor FROM suministro s JOIN componentes c 
        ON s.codigo_componente = c.codigo_componente WHERE c.nombre LIKE '%4%'
);
//26
ALTER TABLE proveedores ADD COLUMN edad INT;

//27
ALTER TABLE suministro ADD COLUMN fecha_envio DATE, ADD COLUMN precio DECIMAL(10, 2);

//28
ALTER TABLE componentes RENAME COLUMN CNOMBRE TO nombre_componentes;

//29
ALTER TABLE articulos MODIFY COLUMN TNOMBRE VARCHAR(100);

//30
UPDATE proveedores SET ciudad = 'CACERES'WHERE nombre = 'JUAN';

//31
UPDATE proveedores SET categoria = categoria + 10 WHERE nombre = 'EVA';

//32
DELETE FROM suministro WHERE codigo_proveedor = 
    (SELECT codigo_proveedor FROM proveedores WHERE nombre = 'INMA');

//33
DELETE FROM proveedores WHERE ciudad = 'SEVILLA';

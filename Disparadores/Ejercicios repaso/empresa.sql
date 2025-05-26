-- Creaci�n de tablas
CREATE TABLE CLIENTES (
    CODIGO NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(100),
    TELEFONO VARCHAR2(15)
);

CREATE TABLE PROVEEDORES (
    CODIGO NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(100),
    TELEFONO VARCHAR2(15)
);

CREATE TABLE PRODUCTOS (
    CODIGO NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(100),
    PRECIO NUMBER(10,2),
    COD_PROVEEDOR NUMBER,
    FOREIGN KEY (COD_PROVEEDOR) REFERENCES PROVEEDORES(CODIGO)
);

CREATE TABLE STOCK (
    CODIGO NUMBER PRIMARY KEY,
    CANTIDAD NUMBER,
    FOREIGN KEY (CODIGO) REFERENCES PRODUCTOS(CODIGO)
);

CREATE TABLE COMPRAS (
    COD_CLIENTE NUMBER,
    COD_PRODUCTO NUMBER,
    FECHA DATE,
    CANTIDAD NUMBER,
    PAGADO VARCHAR2(2),
    FOREIGN KEY (COD_CLIENTE) REFERENCES CLIENTES(CODIGO),
    FOREIGN KEY (COD_PRODUCTO) REFERENCES PRODUCTOS(CODIGO)
);

-- Inserci�n de datos
INSERT INTO CLIENTES VALUES (1, 'Ram�n Torres', '111111111');
INSERT INTO CLIENTES VALUES (2, 'Mar�a L�pez', '222222222');
INSERT INTO CLIENTES VALUES (3, 'Paloma Ruiz', '333333333');
INSERT INTO CLIENTES VALUES (4, 'Isabel Perea', '444444444');
INSERT INTO CLIENTES VALUES (5, 'Luisa Mar�n', '555555555');
INSERT INTO CLIENTES VALUES (6, 'Pedro Macias', '666666666');
INSERT INTO CLIENTES VALUES (7, 'Teresa Vilchez', '777777777');
INSERT INTO CLIENTES VALUES (8, 'Ricardo Mu�oz', '888888888');
INSERT INTO CLIENTES VALUES (9, 'Muriel Mina', '999999999');

INSERT INTO PROVEEDORES VALUES (1, 'Putis SA', '101010101');
INSERT INTO PROVEEDORES VALUES (2, 'Distribuciones SL', '202020202');
INSERT INTO PROVEEDORES VALUES (3, 'Frutas SA', '303030303');
INSERT INTO PROVEEDORES VALUES (4, 'Frutas Rocio SL', '404040404');

INSERT INTO PRODUCTOS VALUES (1, 'melon', 0.6, 4);
INSERT INTO PRODUCTOS VALUES (2, 'sandia', 0.7, 3);
INSERT INTO PRODUCTOS VALUES (3, 'manzana', 1.2, 3);
INSERT INTO PRODUCTOS VALUES (4, 'tomate', 1.5, 2);
INSERT INTO PRODUCTOS VALUES (5, 'papaya', 0.3, 2);
INSERT INTO PRODUCTOS VALUES (6, 'patata', 0.1, 2);

INSERT INTO STOCK VALUES (1, 100);
INSERT INTO STOCK VALUES (2, 150);
INSERT INTO STOCK VALUES (3, 75);
INSERT INTO STOCK VALUES (4, 89);
INSERT INTO STOCK VALUES (5, 128);
INSERT INTO STOCK VALUES (6, 35);

INSERT INTO COMPRAS VALUES (1, 1, '21/05/2025', 2, 'SI');
INSERT INTO COMPRAS VALUES (1, 3, '15/05/2025', 3, 'SI');
INSERT INTO COMPRAS VALUES (1, 4, '10/05/2025', 1, 'NO');
INSERT INTO COMPRAS VALUES (2, 3, '12/05/2025', 5, 'NO');
INSERT INTO COMPRAS VALUES (2, 5, '13/05/2025', 8, 'SI');
INSERT INTO COMPRAS VALUES (3, 1, '22/05/2025', 5, 'NO');
INSERT INTO COMPRAS VALUES (3, 4, '05/05/2025', 3, 'NO');
INSERT INTO COMPRAS VALUES (4, 4, '13/05/2025', 5, 'SI');
INSERT INTO COMPRAS VALUES (5, 3, '10/05/2025', 3, 'NO');
INSERT INTO COMPRAS VALUES (5, 6, '10/05/2025', 6, 'NO');
INSERT INTO COMPRAS VALUES (5, 1, '13/05/2025', 2, 'SI');
INSERT INTO COMPRAS VALUES (4, 3, '11/05/2025', 5, 'NO');
INSERT INTO COMPRAS VALUES (9, 6, '12/05/2025', 4, 'SI');
INSERT INTO COMPRAS VALUES (3, 6, '15/05/2025', 6, 'NO');
INSERT INTO COMPRAS VALUES (4, 4, '20/05/2025', 2, 'SI');
INSERT INTO COMPRAS VALUES (3, 4, '21/05/2025', 1, 'NO');
INSERT INTO COMPRAS VALUES (4, 4, '22/05/2025', 4, 'SI');
INSERT INTO COMPRAS VALUES (9, 1, '15/05/2025', 5, 'NO');
INSERT INTO COMPRAS VALUES (9, 1, '13/05/2025', 1, 'SI');
INSERT INTO COMPRAS VALUES (7, 3, '12/05/2025', 2, 'NO');
INSERT INTO COMPRAS VALUES (2, 5, '11/05/2025', 1, 'NO');
INSERT INTO COMPRAS VALUES (6, 4, '22/05/2025', 9, 'SI');

/* Ejercicio 1*/
/* Crear  un  disparador  que  controle  la  inserción  de productos.  Si  se  inserta  un 
producto con un precio inferior a 0.5€/kilo dar un aviso de que el precio es muy 
bajo.  Además,  independientemente  del  precio  se  deberá  dar  un  aviso  de  que  es 
necesario introducir también el stock.*/

DELIMITER $$

CREATE OR REPLACE TRIGGER trg_control_insert_producto
BEFORE INSERT ON PRODUCTOS
FOR EACH ROW
BEGIN
    -- Comprobar si el precio es menor de 0.5€/kg
    IF :NEW.PRECIO < 0.5 THEN
        raise_application_error(-20001, 'El precio del producto es muy bajo.');
    END IF;

    -- Aviso obligatorio sobre el stock 
    raise_application_error(-20002, 'Debe introducir también el stock del producto en la tabla STOCK.');
END;


/* Ejercicio 2*/
/* Crear un disparador que cada vez que se inserte una compra actualice el stock del 
producto comprado. Además si el stock del producto baja de 15 kilos el disparador 
dará  un  aviso  de  que  hay  poco  stock  y  hay  que  avisar  al  proveedor.  Para  ello 
deberá mostrar los datos del proveedor al que hay que llamar.*/

CREATE OR REPLACE TRIGGER trg_actualizar_stock
AFTER INSERT ON COMPRAS
FOR EACH ROW
DECLARE
    v_stock_actual NUMBER;
    v_nombre_proveedor PROVEEDORES.NOMBRE%TYPE;
    v_telefono_proveedor PROVEEDORES.TELEFONO%TYPE;
BEGIN
    -- Actualizar el stock del producto restando la cantidad comprada
    UPDATE STOCK
    SET CANTIDAD = CANTIDAD - :NEW.CANTIDAD
    WHERE CODIGO = :NEW.COD_PRODUCTO;

    -- Obtener el nuevo stock del producto
    SELECT CANTIDAD INTO v_stock_actual
    FROM STOCK
    WHERE CODIGO = :NEW.COD_PRODUCTO;

    -- Si el stock baja de 15, obtener datos del proveedor y dar aviso
    IF v_stock_actual < 15 THEN
        SELECT P.NOMBRE, P.TELEFONO
        INTO v_nombre_proveedor, v_telefono_proveedor
        FROM PROVEEDORES P
        JOIN PRODUCTOS PR ON P.CODIGO = PR.COD_PROVEEDOR
        WHERE PR.CODIGO = :NEW.COD_PRODUCTO;

        -- Generar mensaje de advertencia
        raise_application_error(-20001,
            ' Stock bajo: ' || v_stock_actual ||
            ' kg restantes, contactar con proveedor: ' || v_nombre_proveedor ||
            ', Tel: ' || v_telefono_proveedor);
    END IF;
END;

/* Ejercico 3*/
/* Crear un procedimiento almacenado que reciba el nombre de un cliente y muestre 
por  pantalla  una  factura  con  los  pedidos  que  aún  no  ha  pagado.  Se  le  mostrará  el 
precio total de cada compra. Los resultados deben mostrarse ordenados por fecha 
de compra.*/

CREATE OR REPLACE PROCEDURE mostrar_factura_cliente(p_nombre_cliente IN VARCHAR2) IS
    CURSOR c_factura IS
        SELECT 
            C.FECHA,P.NOMBRE AS NOMBRE_PRODUCTO,C.CANTIDAD,PR.PRECIO,(C.CANTIDAD * PR.PRECIO) AS TOTAL
        FROM CLIENTES CL
        JOIN COMPRAS C ON CL.CODIGO = C.COD_CLIENTE
        JOIN PRODUCTOS PR ON C.COD_PRODUCTO = PR.CODIGO
        JOIN PRODUCTOS P ON PR.CODIGO = P.CODIGO
        WHERE CL.NOMBRE = p_nombre_cliente
          AND C.PAGADO = 'NO'
        ORDER BY C.FECHA;

BEGIN
    DBMS_OUTPUT.PUT_LINE('FACTURA PARA: ' || p_nombre_cliente);
    DBMS_OUTPUT.PUT_LINE('FECHA      | PRODUCTO   | CANT | PRECIO | TOTAL');

    FOR r IN c_factura LOOP
        DBMS_OUTPUT.PUT_LINE(
            TO_CHAR(r.FECHA, 'DD/MM/YYYY') || ' | ' ||
            RPAD(r.NOMBRE_PRODUCTO, 10) || ' | ' ||
            LPAD(r.CANTIDAD, 4) || ' | ' ||
            LPAD(TO_CHAR(r.PRECIO, '999.99'), 6) || ' | ' ||
            LPAD(TO_CHAR(r.TOTAL, '9999.99'), 7)
        );
    END LOOP;
END;

/* Ejercicio 4*/
/* Crear  un  procedimiento  almacenado  que  reciba  una  fecha  y  muestre  las  compras 
que  se  hicieron  en  esa  fecha.  El  procedimiento  mostrará  las  compras  agrupadas 
por  clientes.  De  esta  forma  para  cada  cliente  mostrará  todas  las  compras  con  el 
precio total de dicha compra y al final el dinero que el cliente debe, es decir sólo de 
las compras que no haya pagado.*/

CREATE OR REPLACE PROCEDURE mostrar_compras_por_fecha(p_fecha IN DATE) IS
    CURSOR c_clientes IS
        SELECT DISTINCT CL.CODIGO, CL.NOMBRE
        FROM CLIENTES CL
        JOIN COMPRAS C ON CL.CODIGO = C.COD_CLIENTE
        WHERE C.FECHA = p_fecha;

    CURSOR c_compras(p_cod_cliente NUMBER) IS
        SELECT 
            P.NOMBRE AS PRODUCTO,
            C.CANTIDAD,
            PR.PRECIO,
            (C.CANTIDAD * PR.PRECIO) AS TOTAL,
            C.PAGADO
        FROM COMPRAS C
        JOIN PRODUCTOS PR ON C.COD_PRODUCTO = PR.CODIGO
        JOIN PRODUCTOS P ON PR.CODIGO = P.CODIGO
        WHERE C.COD_CLIENTE = p_cod_cliente
          AND C.FECHA = p_fecha;

    v_total_deuda NUMBER := 0;

BEGIN
    DBMS_OUTPUT.PUT_LINE('COMPRAS REALIZADAS EL: ' || TO_CHAR(p_fecha, 'DD/MM/YYYY'));
    DBMS_OUTPUT.PUT_LINE('========================================================');

    FOR cli IN c_clientes LOOP
        DBMS_OUTPUT.PUT_LINE('CLIENTE: ' || cli.NOMBRE);
        DBMS_OUTPUT.PUT_LINE('PRODUCTO  | CANT | PRECIO | TOTAL | PAGADO');

        v_total_deuda := 0;

        FOR compra IN c_compras(cli.CODIGO) LOOP
            DBMS_OUTPUT.PUT_LINE(
                RPAD(compra.PRODUCTO, 10) || ' | ' ||
                LPAD(compra.CANTIDAD, 4) || ' | ' ||
                LPAD(TO_CHAR(compra.PRECIO, '999.99'), 6) || ' | ' ||
                LPAD(TO_CHAR(compra.TOTAL, '9999.99'), 7) || ' | ' ||
                RPAD(compra.PAGADO, 6)
            );

            IF compra.PAGADO = 'NO' THEN
                v_total_deuda := v_total_deuda + compra.TOTAL;
            END IF;
        END LOOP;

        DBMS_OUTPUT.PUT_LINE('>>> TOTAL ADEUDADO POR EL CLIENTE: ' || TO_CHAR(v_total_deuda, '9999.99'));
        DBMS_OUTPUT.PUT_LINE(CHR(10));
    END LOOP;
END;

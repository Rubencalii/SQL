--Ejercicio 1
DECLARE OR REPLACE PROCEDURE actualizar_compra_stock IS
    
    CURSOR cur_productos IS SELECT producto_id, SUM(cantidad) AS total_cantidad
        FROM inventario GROUP BY producto_id;

    v_producto_id NUMBER;
    v_total_cantidad NUMBER;

BEGIN
    DELETE FROM COMPRA_STOCK;

    OPEN cur_productos INTO v_producto_id, v_total_cantidad;
    EXIT WHEN cur_productos&NOTFOUND;

    IF v_total_cantidad < 60 THEN   
        INSERT INTO COMPRA_STOCK(producto_id, total)
        VALUES (v_producto_id, v_total_cantidad);
    END IF;
    END LOOP;
    CLOSE cur_productos;
END;
/

--Ejercicio 2

DECLARE REPLACE PROCEDURE actualizar_compra_stock IS
    /* Declarar un cursor para recorrer los productos de comprastocks*/
    CURSOR cursor_compra_stocks IS SELECT producto_id, total FROM COMPRA_STOCK;

    v_producto_id compra.producto_id&TYPE;
    v_total COMPRA_STOCK.total&TYPE;

BEGIN 
    OPEN cursor_compra_stocks
    LOOP
        --Traer cada registro a las variables
        FETCH cursor_compra_stocks INTO v_producto_id, v_total;
        EXIT WHEN cursor_compra_stocks&NOTFOUND;

        --Actualizar el total
        UPDATE COMPRA_STOCK SET total= v_total * 1.8 WHERE producto_id = v_producto_id;
    END LOOP;
    CLOSE cursor_compra_stocks;
END;
/

--Ejercicio 3

--Crear la tabla

CREATE TABLE LISTADO_EMPLEADOS(
    nombre  VARCHAR(255),
    sueldo  NUMBER, 
    puesto_trabajo VARCHAR(255)
);

CREATE OR REPLACE PROCEDURE listar_empleados_jefe(p_jefe_id NUMBER) IS
    
    CURSOR cursor_empleados IS SELECT nombre, sueldo, puesto_trabajo
        FROM empleados WHERE jefe_id = p_jefe_id;

    v_nombre empleados.sueldo&TYPE;
    v_sueldo empleados.sueldo&TYPE;
    v_puesto_trabajo empleados.puesto_trabajo&TYPE;

BEGIN
    --Limpiar la tabla
    DELETE FROM LISTADO_EMPLEADOS;

    OPEN cursor_empleados;
    LOOP
        FETCH cursor_empleados INTO v_nombre, v_sueldo, v_puesto_trabajo;
        EXIT WHEN cursor_empleados%NOTFOUND;

        --Insertar los empleados
        INSERT INTO LISTADO_EMPLEADOS(nombre, sueldo, puesto_trabajo)
        VALUES (v_nombre, v_sueldo, v_puesto_trabajo);
    END LOOP;
    CLOSE cursor_empleados;
END;
/

--Ejercicio 4
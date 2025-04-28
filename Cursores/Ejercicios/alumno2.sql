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

-Ejercicio 2
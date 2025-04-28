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
CREATE OR REPLACE PROCEDURE mostrar_datos_cliente IS
    v_dni_cliente VARCHAR2(15);
    v_nombre_cliente VARCHAR2(100);
    v_apellidos_cliente VARCHAR2(100);
    v_direccion_cliente VARCHAR2(255);
    v_telefono_cliente VARCHAR2(15);
    v_codigo_pedido NUMBER;
    v_fecha_pedido DATE;
    v_fecha_entrega DATE;
    v_estado_pedido VARCHAR2(20);
    v_importe_pedido NUMBER;
    v_total_importe NUMBER := 0;

    CURSOR c_pedidos IS
        SELECT p.codigo_pedido, p.fecha_pedido, p.fecha_entrega, p.estado, p.importe_total
        FROM Pedidos p
        WHERE p.dni_cliente = v_dni_cliente
        ORDER BY p.fecha_pedido;

BEGIN
    -- Solicitar el DNI del cliente
    DBMS_OUTPUT.PUT_LINE('Ingrese el DNI del cliente:');
    -- Aquí se puede utilizar alguna forma de capturar el DNI
        v_dni_cliente := '12345678A';  

    -- Obtener los datos del cliente
    SELECT c.nombre, c.apellidos, c.direccion, c.telefono
    INTO v_nombre_cliente, v_apellidos_cliente, v_direccion_cliente, v_telefono_cliente
    FROM Clientes c
    WHERE c.dni_cliente = v_dni_cliente;

    -- Mostrar los datos del cliente
    DBMS_OUTPUT.PUT_LINE('Datos del Cliente:');
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre_cliente || ' ' || v_apellidos_cliente);
    DBMS_OUTPUT.PUT_LINE('Dirección: ' || v_direccion_cliente);
    DBMS_OUTPUT.PUT_LINE('Teléfono: ' || v_telefono_cliente);

    -- Verificar si existen pedidos para el cliente
    OPEN c_pedidos;
    LOOP
        FETCH c_pedidos INTO v_codigo_pedido, v_fecha_pedido, v_fecha_entrega, v_estado_pedido, v_importe_pedido;
        EXIT WHEN c_pedidos%NOTFOUND;

        -- Mostrar los pedidos
        DBMS_OUTPUT.PUT_LINE('Pedido: ' || v_codigo_pedido || ' | Fecha: ' || v_fecha_pedido || ' | Estado: ' || v_estado_pedido || ' | Importe: ' || v_importe_pedido);

        -- Sumar los importes de los pedidos
        v_total_importe := v_total_importe + v_importe_pedido;
    END LOOP;
    CLOSE c_pedidos;

    -- Mostrar el total de los importes
    DBMS_OUTPUT.PUT_LINE('Total de los importes de los pedidos: ' || v_total_importe);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: No se encontraron datos para el cliente con DNI: ' || v_dni_cliente);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
END mostrar_datos_cliente;


/*Segundo paso*/


CREATE OR REPLACE PROCEDURE comprobar_consistencia_pedidos IS
    v_precio_comision NUMBER;
    v_importe_total NUMBER;
    v_importe_pedido NUMBER;
    v_num_modificaciones NUMBER := 0;

BEGIN
    -- Verificar consistencia de los datos de los pedidos
    FOR pedido IN (SELECT p.codigo_pedido
                   FROM Pedidos p
                   WHERE p.estado IN ('REST', 'RUTA', 'ENTREGADO')) LOOP

        -- Calcular el precio total con comisión para los platos de este pedido
        SELECT SUM(c.precio + c.comision)
        INTO v_importe_total
        FROM Contiene c
        WHERE c.codigo_pedido = pedido.codigo_pedido;

        -- Verificar y actualizar el precio con comisión en la tabla Contiene
        FOR plato IN (SELECT c.precio + c.comision AS precio_con_comision
                      FROM Contiene WHERE c.codigo_pedido = pedido.codigo_pedido) LOOP
            -- Actualizar precio con comisión
            UPDATE Contiene
            SET precio_con_comision = plato.precio_con_comision
            WHERE codigo_pedido = pedido.codigo_pedido;
            v_num_modificaciones := v_num_modificaciones + 1;
        END LOOP;

        -- Verificar y actualizar el importe total en la tabla Pedidos
        SELECT p.importe_total
        INTO v_importe_pedido
        FROM Pedidos p
        WHERE p.codigo_pedido = pedido.codigo_pedido;

        IF v_importe_pedido != v_importe_total THEN
            UPDATE Pedidos
            SET importe_total = v_importe_total
            WHERE codigo_pedido = pedido.codigo_pedido;
            v_num_modificaciones := v_num_modificaciones + 1;
        END IF;

    END LOOP;

    -- Mostrar el resultado
    IF v_num_modificaciones > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Número de modificaciones: ' || v_num_modificaciones);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ningún cambio en los datos');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
END comprobar_consistencia_pedidos;

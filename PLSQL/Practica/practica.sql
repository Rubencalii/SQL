CREATE TABLE restaurantes(
    codigo_restaurante NUMBER PRIMARY KEY,
    nombre VARCHAR2(100),
    direccion VARCHAR2(100),
    horario LOB,
    areas_cobertura VARCHAR2(100)
);

CREATE TABLE platos(
    codigo_plato NUMBER PRIMARY KEY
    nombre VARCHAR2(100),
    descripcion VARCHAR2(100),
    precio NUMBER(10, 2),
    comision NUMBER(5, 2),
    categoria VARCHAR2(100),
    codigo_restaurante NUMBER,
    
    FOREIGN KEY (codigo_restaurante) REFERENCES Restaurantes(codigo_restaurante)
);

CREATE TABLE clientes (
    dni VARCHAR2(20) PRIMARY KEY,
    nombre VARCHAR2(100),
    apellidos VARCHAR2(100),
    direccion VARCHAR2(255),
    telefono VARCHAR2(20),
    usuario VARCHAR2(50),
    contrasena VARCHAR2(50)
);

CREATE TABLE pedidos(
    codigo_pedido NUMBER PRIMARY KEY,
    dni_cliente VARCCHAR2(100),
    fecha DATE NOT NULL,
    fecha_entrega DATE,
    estado VARCHAR(100) CHECK (estado IN('Resetear', 'Cancelar', 'Entregado', 'Rechazar', 'Ruta')),
    importe_total NUMBER(10, 2),
    codigo_cupon VARCHAR(10),
    
    CONSTRAINT fk_cliente FOREIGN KEY(dni_cliente) REFERENCES CLIENTE(dni)
);

CREATE TABLE contiene(
    codigo_pedido NUMBER REFERENCES pedidos(codigo_pedido),
    codigo_plato NUMBER REFERENCES platos(codigo_plato),
    unidades NUMBER NOT NULL,
    precio_comision NUMBER(10, 2)NOT NULL,
    PRIMARY KEY (codigo_pedido, codigo_plato)
);

CREATE TABLE cupones(
    codigo_cupon VARCHAR2(10) PRIMARY KEY,
    fecha_caducidad DATE NOT NULL,
    descuento NUMBER(5, 2) NOT NULL
);


CREATE OR replace PROCEDURE comprobar_consistencia_pedidos IS
    v_codigo_pedido PEDIDOS.codigo_pedido%TYPE;
    v_precio_comision CONTIENE.precio_comision%TYPE;
    v_importe_calculado NUMBER;
    v_filas_actualizadas NUMBER := 0;
    v_filas_actualizadas_contiene NUMBER := 0;
    
BEGIN
    FOR r IN (SELECT p.codigo_perdido, SUM (c.precio_comision) AS total_comision
        FROM pedidos p JOIN contiene c ON p.codigo_pedido = c.codigo_pedido
            GROUP BYE p.codigo_pedido) LOOP
            
    /*Verificar el importe total*/
    
    v_codigo_pedido := r.codigo_pedido;
    v_importe_calculado := r.total_comision;
    
    /*Obtener el importe almacenado en la tabla pedidos*/
    
    SELECT importe_total INTO v_importe_total FROM pedidos
        WHERE codigo_pedido = v_codigo_pedido;
        
    /*Si el importe no coincide con el almacenamiento*/
    
    IF v_importe_calculado != v_importe_total THEN 
        UPDATE pedidos SET importe_total = v_importe_calculado
            WHERE codigo_pedido = v_codigo_pedido;
                v_filas_actualizadas := v_filas_actualizadas + 1;
    END IF;
    
    /*Actualizar si es necesario*/

    UPDATE CONTIENE SET precio_comision = v_precio_comision
        WHERE codigo_pedido = r.codigo_pedido;
        v_filas_actualizadas_contiene := v_filas_actualizadas_contiene + 1;
    END LOOP;

    IF v_filas_actualizadas = 0 AND v_filas_actualizadas_contiene = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ningun cambio en los datos.');
    ELSE 
        DBMS_OUTPUT.PUT_LINE(('Filas modificadas en Pedidos'); || v_filas_actualizadas);
        DBMS_OUTPUT.PUT_LINE(('Filas modificadas en Contiene.'); || v_filas_actualizadas_contiene);
    END IF;

    EXCEPTION 

    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END comprobar_consistencia_pedidos;
    /
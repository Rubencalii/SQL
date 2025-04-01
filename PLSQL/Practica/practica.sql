CREATE TABLE clientes (
  dni VARCHAR2(20) PRIMARY KEY,
  nombre VARCHAR2(100),
  apellidos VARCHAR2(100),
  direccion VARCHAR2(200),
  telefono VARCHAR2(20)
);

CREATE TABLE restaurantes (
  codigo_restaurante NUMBER PRIMARY KEY,
  nombre VARCHAR2(100),
  direccion VARCHAR2(200),
  horario VARCHAR2(200),
  areas_cobertura VARCHAR2(500)
);

CREATE TABLE platos (
  codigo_plato NUMBER PRIMARY KEY,
  nombre VARCHAR2(100),
  descripcion VARCHAR2(500),
  precio NUMBER,
  comision NUMBER,
  codigo_restaurante NUMBER,
  FOREIGN KEY (codigo_restaurante) REFERENCES restaurantes(codigo_restaurante)
);

CREATE TABLE pedidos (
  codigo_pedido NUMBER PRIMARY KEY,
  dni_cliente VARCHAR2(20),
  fecha_pedido DATE,
  fecha_entrega DATE,
  estado VARCHAR2(20),
  importe_total NUMBER,
  FOREIGN KEY (dni_cliente) REFERENCES clientes(dni)
);

CREATE TABLE contiene (
  codigo_pedido NUMBER,
  codigo_plato NUMBER,
  precio_plato NUMBER,
  precio_comision NUMBER,
  cantidad NUMBER,
  PRIMARY KEY (codigo_pedido, codigo_plato),
  FOREIGN KEY (codigo_pedido) REFERENCES pedidos(codigo_pedido),
  FOREIGN KEY (codigo_plato) REFERENCES platos(codigo_plato)
);

CREATE TABLE cupones_descuento (
  codigo_cupon VARCHAR2(20) PRIMARY KEY,
  fecha_caducidad DATE,
  porcentaje_descuento NUMBER
);

CREATE OR REPLACE PROCEDURE obtener_datos_cliente(p_dni IN VARCHAR2) IS
  v_nombre_cliente VARCHAR2(100);
  v_apellidos_cliente VARCHAR2(100);
  v_direccion_cliente VARCHAR2(200);
  v_telefono_cliente VARCHAR2(20);
  v_total_importe NUMBER := 0;
  
  CURSOR c_pedidos IS
    SELECT p.codigo_pedido, p.fecha_pedido, p.fecha_entrega, p.estado, p.importe_total
        FROM pedidos p WHERE p.dni_cliente = p_dni ORDER BY p.fecha_pedido;

  v_codigo_pedido pedidos.codigo_pedido%TYPE;
  v_fecha_pedido pedidos.fecha_pedido%TYPE;
  v_fecha_entrega pedidos.fecha_entrega%TYPE;
  v_estado pedidos.estado%TYPE;
  v_importe_total pedidos.importe_total%TYPE;

BEGIN
  /* Obtención de datos del cliente */
  SELECT c.nombre, c.apellidos, c.direccion, c.telefono
    INTO v_nombre_cliente, v_apellidos_cliente, v_direccion_cliente, v_telefono_cliente
        FROM clientes c WHERE c.dni = p_dni;

  /* Mostrar los datos del cliente*/
  DBMS_OUTPUT.PUT_LINE('Datos del Cliente:');
  DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre_cliente);
  DBMS_OUTPUT.PUT_LINE('Apellidos: ' || v_apellidos_cliente);
  DBMS_OUTPUT.PUT_LINE('Dirección: ' || v_direccion_cliente);
  DBMS_OUTPUT.PUT_LINE('Teléfono: ' || v_telefono_cliente);

  /* Mostrar los pedidos del cliente */
  DBMS_OUTPUT.PUT_LINE('Pedidos Realizados:');
  FOR pedido IN c_pedidos LOOP
    DBMS_OUTPUT.PUT_LINE('Código de Pedido: ' || pedido.codigo_pedido);
    DBMS_OUTPUT.PUT_LINE('Fecha del Pedido: ' || pedido.fecha_pedido);
    DBMS_OUTPUT.PUT_LINE('Fecha de Entrega: ' || pedido.fecha_entrega);
    DBMS_OUTPUT.PUT_LINE('Estado: ' || pedido.estado);
    DBMS_OUTPUT.PUT_LINE('Importe: ' || pedido.importe_total);
    v_total_importe := v_total_importe + pedido.importe_total;
  END LOOP;

  /* Mostrar el total de los pedidos */
  DBMS_OUTPUT.PUT_LINE('Total de los Pedidos: ' || v_total_importe);
  
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Error: No se encontró cliente con el DNI ' || p_dni);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
END obtener_datos_cliente;
/

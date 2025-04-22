CREATE TABLE cliente (
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

-- Tabla trabajador
CREATE TABLE trabajador (
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    sueldo NUMBER(10,2) NOT NULL
);

-- Tabla tratamiento
CREATE TABLE tratamiento (
    id NUMBER PRIMARY KEY,
    descripcion VARCHAR2(200),
    precio NUMBER(10,2) NOT NULL
);

-- Tabla cita
CREATE TABLE cita (
    id_cli NUMBER NOT NULL,
    id_tra NUMBER NOT NULL,
    id_trat NUMBER NOT NULL,
    fecha DATE NOT NULL,
    PRIMARY KEY (id_cli, id_tra, id_trat, fecha),
    FOREIGN KEY (id_cli) REFERENCES cliente(id),
    FOREIGN KEY (id_tra) REFERENCES trabajador(id),
    FOREIGN KEY (id_trat) REFERENCES tratamiento(id)
);

-- Clientes
INSERT INTO cliente (id, nombre) VALUES (1, 'Laura Méndez');
INSERT INTO cliente (id, nombre) VALUES (2, 'Carlos Ruiz');
INSERT INTO cliente (id, nombre) VALUES (3, 'Ana Torres');
INSERT INTO cliente (id, nombre) VALUES (4, 'Javier López');
INSERT INTO cliente (id, nombre) VALUES (5, 'Sofía García');

-- Trabajadores
INSERT INTO trabajador (id, nombre, sueldo) VALUES (101, 'Marcos Pérez', 2850.00);
INSERT INTO trabajador (id, nombre, sueldo) VALUES (102, 'Clara Díaz', 1750.50);
INSERT INTO trabajador (id, nombre, sueldo) VALUES (103, 'Elena Vargas', 2950.75);
INSERT INTO trabajador (id, nombre, sueldo) VALUES (104, 'Pedro Gómez', 1550.00);
INSERT INTO trabajador (id, nombre, sueldo) VALUES (105, 'Marta Rojas', 1850.00);

-- Tratamientos
INSERT INTO tratamiento (id, descripcion, precio) VALUES (10, 'Limpieza dental', 50.00);
INSERT INTO tratamiento (id, descripcion, precio) VALUES (20, 'Empaste composite', 85.50);
INSERT INTO tratamiento (id, descripcion, precio) VALUES (30, 'Ortodoncia inicial', 1200.00);
INSERT INTO tratamiento (id, descripcion, precio) VALUES (40, 'Blanqueamiento', 150.00);
INSERT INTO tratamiento (id, descripcion, precio) VALUES (50, 'Extracción muela', 200.00);

-- Citas
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (1, 101, 10, DATE '2024-03-01');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (2, 103, 30, DATE '2024-03-02');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (3, 105, 10, DATE '2024-03-03');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (4, 101, 20, DATE '2024-03-04');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (5, 103, 40, DATE '2024-03-05');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (1, 102, 50, DATE '2024-03-06');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (2, 105, 10, DATE '2024-03-07');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (3, 101, 30, DATE '2024-03-08');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (4, 103, 40, DATE '2024-03-09');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (5, 102, 20, DATE '2024-03-10');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (1, 105, 50, DATE '2024-03-11');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (2, 101, 10, DATE '2024-03-12');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (3, 103, 20, DATE '2024-03-13');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (4, 105, 30, DATE '2024-03-14');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (5, 101, 40, DATE '2024-03-15');

--Ejercicio 1
DECLARE

    CURSOR cur_trab IS SELECT nombre, sueldo + (COUNT (id_tra)*4) FROM trabajador
                            LEFT JOIN cita ON id_tra=id GROUP BY nombre, sueldo;
    nom trabajador.nombre%TYPE;
    total NUMBER(7,2);

BEGIN
    OPEN cur_trab;
    
    LOOP
        FETCH cur_trab INTO nom, total;
        EXIT WHEN cur_trab%NOTFOUND;
        
        DBMS_OUTPUT.put_line('El trabajador '||nom||' tiene sueldo '||total);
    END LOOP;
    CLOSE cur_trab;

END;

--Ejercicio 2

DECLARE
    
    CURSOR cur_citas IS SELECT cita FROM citas WHERE id_cli = p_cliente_id;
    
    v_fecha_cita cita.fecha%TYPE;
    v_total_citas NUMBER := 0;

BEGIN 

    --Solicitar al usuario el ID del cliente
    v_cliente_idid_cli := &Introduzca_ID_Cliente;
    DBMS_OUTPUT.PUT_LINE('Citas del cliente: '|| v_cliente_id);

    --Abrir y recorrer el cursor
    OPEN cur_citas(v_cliente_id);
    LOOP 
        FETCH cur_citas INTO v_fecha_cita;
        EXIT WHEN cur_citas%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('- '|| v_fecha_cita);
        v_total_citas := v_total_citas + 1 ;
    END LOOP;
    CLOSE cur_citas;
        DBMS_OUTPUT.PUT_LINE('Tiene un total de: '|| v_total_citas || ' de citas.');
END;

--Ejercicio 3

DECLARE

    CURSOR cur_cliente IS
        SELECT id_cli, nombre 
        FROM cita;
    v_cliente cur_cliente%ROWTYPE;

    CURSOR citas_cursor (p_idCliente NUMBER) IS
        SELECT fecha
        FROM cita
        WHERE id_cli = p_idCliente;
    v_fechaCita cita.fechaCita%TYPE;
    v_contador_citas NUMBER;

BEGIN

    OPEN cur_cliente;
    LOOP
        FETCH cur_cliente INTO v_cliente;
        EXIT WHEN cur_cliente%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Citas de: ' || v_cliente.nombre); 
        v_contador_citas := 0;
        OPEN citas_cursor(v_cliente.id_cli);
        LOOP
        FETCH citas_cursor INTO v_fechaCita;
        EXIT WHEN citas_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('- ' || v_fechaCita);
        v_contador_citas := v_contador_citas + 1;
        END LOOP;
        CLOSE citas_cursor;
        DBMS_OUTPUT.PUT_LINE('Tiene un total de ' || v_contador_citas || ' citas.');
        DBMS_OUTPUT.PUT_LINE(''); 
        
    END LOOP;
    CLOSE cur_cliente;
END;
/
DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE trabajador CASCADE CONSTRAINTS;
DROP TABLE tratamiento CASCADE CONSTRAINTS;
DROP TABLE cita CASCADE CONSTRAINTS;

CREATE TABLE cliente(
    id INT PRIMARY KEY,
    nombre VARCHAR2(20),
    apellidos VARCHAR2(50)
);

CREATE TABLE trabajador(
    id INT PRIMARY KEY,
    nombre VARCHAR2(20),
    apellidos VARCHAR2(50)
);

CREATE TABLE tratamiento(
    id INT PRIMARY KEY,
    nombre VARCHAR2(20),
    precio number(5,2)
);

CREATE TABLE cita(
    id_cli INT,
    id_tra INT,
    id_trat INT,
    fecha DATE,
    duracion NUMBER(4),
    
    CONSTRAINT pk_cita PRIMARY KEY (id_cli, id_tra, id_trat, fecha),
    CONSTRAINT fk_cli FOREIGN KEY (id_cli) REFERENCES cliente(id),
    CONSTRAINT fk_tra FOREIGN KEY (id_tra) REFERENCES trabajador(id),
    CONSTRAINT fk_trat FOREIGN KEY (id_trat) REFERENCES tratamiento(id)
);

INSERT INTO cliente VALUES (1, 'Ana', 'Morales');
INSERT INTO cliente VALUES (2, 'Pilar', 'Jimenez');
INSERT INTO cliente VALUES (3, 'Juan', 'P�rez');
INSERT INTO cliente VALUES (4, 'Luis', 'L�pez');
INSERT INTO cliente VALUES (5, 'Manu', 'Garc�a');

INSERT INTO trabajador VALUES (1, 'Paloma', 'Cuesta');
INSERT INTO trabajador VALUES (2, 'Bel�n', 'L�pez');
INSERT INTO trabajador VALUES (3, 'Emilio', 'Delgado');

INSERT INTO tratamiento VALUES (1, 'Corte', 15);
INSERT INTO tratamiento VALUES (2, 'Tinte', 20.5);
INSERT INTO tratamiento VALUES (3, 'Lavado', 6.5);
INSERT INTO tratamiento VALUES (4, 'Peinado', 8.25);
INSERT INTO tratamiento VALUES (5, 'Mechas', 25.75);

INSERT INTO cita VALUES (3, 1, 2, '27-03-2024', 100);
INSERT INTO cita VALUES (3, 1, 2, '13-03-2024', 35);
INSERT INTO cita VALUES (3, 1, 4, '25-03-2024', 40);
INSERT INTO cita VALUES (3, 1, 3, '30-03-2024', 10);
INSERT INTO cita VALUES (3, 1, 4, '23-03-2024', 30);
INSERT INTO cita VALUES (3, 1, 5, '23-03-2024', 110);
INSERT INTO cita VALUES (3, 1, 1, '17-03-2024', 35);
INSERT INTO cita VALUES (1, 1, 2, '01-03-2024', 35);
INSERT INTO cita VALUES (2, 1, 3, '01-03-2024', 85);
INSERT INTO cita VALUES (5, 3, 2, '12-03-2024', 35);
INSERT INTO cita VALUES (4, 3, 2, '15-03-2024', 45);
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (5, 2, 4, '25-03-2024');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (2, 2, 5, '27-03-2024');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (3, 3, 2, '30-03-2024');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (4, 2, 1, '17-03-2024');
INSERT INTO cita (id_cli, id_tra, id_trat, fecha) VALUES (4, 3, 3, '13-03-2024');

/*Ejercicio 1: */

DECLARE
    CURSOR c_fechas IS
        SELECT DISTINCT fecha FROM cita ORDER BY fecha;

    v_fecha DATE;

    CURSOR c_citas(p_fecha DATE) IS
        SELECT cli.nombre, tra.nombre, trat.nombre, NVL(c.duracion, 0), trat.precio
        FROM cita c
        JOIN cliente cli ON c.id_cli = cli.id
        JOIN trabajador tra ON c.id_tra = tra.id
        JOIN tratamiento trat ON c.id_trat = trat.id
        WHERE c.fecha = p_fecha;

    v_nom_cli VARCHAR2(20);
    v_nom_tra VARCHAR2(20);
    v_trat VARCHAR2(20);
    v_duracion NUMBER;
    v_precio NUMBER(5,2);

BEGIN
    OPEN c_fechas;
    FETCH c_fechas INTO v_fecha;

    WHILE c_fechas%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE('Mostrando las citas del ' || TO_CHAR(v_fecha, 'DD/MM/YY'));

        OPEN c_citas(v_fecha);
        FETCH c_citas INTO v_nom_cli, v_nom_tra, v_trat, v_duracion, v_precio;

        WHILE c_citas%FOUND LOOP
            DBMS_OUTPUT.PUT_LINE('Cliente: ' || v_nom_cli ||
                                 ' Trabajador: ' || v_nom_tra ||
                                 ' Tratamiento: ' || v_trat ||
                                 ' Duracion: ' || v_duracion ||
                                 ' Precio: ' || TO_CHAR(v_precio, 'FM9990.00') || '€');
            FETCH c_citas INTO v_nom_cli, v_nom_tra, v_trat, v_duracion, v_precio;
        END LOOP;

        CLOSE c_citas;
        FETCH c_fechas INTO v_fecha;
    END LOOP;
    CLOSE c_fechas;
END;

/*Ejercicio 2:*/


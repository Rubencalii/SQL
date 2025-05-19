CREATE TABLE L_EDITORIAL (
    COD_EDITORIAL VARCHAR2(7) PRIMARY KEY,
    NOMBRE_ED VARCHAR2(30) NOT NULL CHECK (NOMBRE_ED = UPPER(NOMBRE_ED)),
    DIRECCION_ED VARCHAR2(40),
    LOCALIDAD_ED VARCHAR2(35),
    COD_POSTAL_ED NUMBER(5),
    PROVINCIA_ED VARCHAR2(30),
    TELEFONO_ED NUMBER(9),
    FAX_ED NUMBER(9),
    EMAIL_ED VARCHAR2(50)
);

CREATE TABLE L_MATERIA (
    COD_MATERIA VARCHAR2(4) PRIMARY KEY,
    DES_MATERIA VARCHAR2(30) NOT NULL CHECK (DES_MATERIA = UPPER(DES_MATERIA))
);

CREATE TABLE L_PERSONA (
    DNI VARCHAR2(9) PRIMARY KEY,
    NOMBRE_PER VARCHAR2(40) NOT NULL CHECK (NOMBRE_PER = UPPER(NOMBRE_PER)),
    DIRECCION_PER VARCHAR2(40),
    LOCALIDAD_PER VARCHAR2(35),
    COD_POSTAL_PER NUMBER(5),
    PROVINCIA_PER VARCHAR2(30),
    TELEFONO_PER NUMBER(9),
    FAX_PER NUMBER(9),
    EMAIL_PER VARCHAR2(50),
    CARNET NUMBER(5)
);

CREATE TABLE L_LIBRO (
    COD_LIBRO VARCHAR2(5) PRIMARY KEY,
    TITULO VARCHAR2(50),
    ANIO_PUBLIC VARCHAR2(4),
    NRO_PAG NUMBER(5) CHECK (NRO_PAG < 50000),
    TRADUCTOR VARCHAR2(60),
    IDIOMA VARCHAR2(15),
    NRO_COPIAS NUMBER(2) CHECK (NRO_COPIAS BETWEEN 1 AND 10),
    COD_EDITORIAL VARCHAR2(7),
    AUTOR VARCHAR2(70) NOT NULL,
    PRECIO_LIBRO NUMBER(6),
    CONSTRAINT fk_libro_editorial FOREIGN KEY (COD_EDITORIAL) REFERENCES L_EDITORIAL(COD_EDITORIAL)
);

CREATE TABLE L_LIBRO_MATERIA (
    COD_LIBRO VARCHAR2(5),
    COD_MATERIA VARCHAR2(4),
    CONSTRAINT pk_libro_materia PRIMARY KEY (COD_LIBRO, COD_MATERIA),
    CONSTRAINT fk_libro_materia_libro FOREIGN KEY (COD_LIBRO) REFERENCES L_LIBRO(COD_LIBRO),
    CONSTRAINT fk_libro_materia_materia FOREIGN KEY (COD_MATERIA) REFERENCES L_MATERIA(COD_MATERIA)
);

CREATE TABLE L_PRESTAMO (
    DNI VARCHAR2(9),
    COD_LIBRO VARCHAR2(5),
    FECHA_SALIDA DATE,
    FECHA_ENTREGA DATE,
    DEVUELTO CHAR(1) CHECK (DEVUELTO IN ('S', 'N')),
    CONSTRAINT pk_prestamo PRIMARY KEY (DNI, COD_LIBRO, FECHA_SALIDA),
    CONSTRAINT fk_prestamo_persona FOREIGN KEY (DNI) REFERENCES L_PERSONA(DNI),
    CONSTRAINT fk_prestamo_libro FOREIGN KEY (COD_LIBRO) REFERENCES L_LIBRO(COD_LIBRO)
);

-- Inserción en L_EDITORIAL
INSERT INTO L_EDITORIAL VALUES ('ED001', 'EDITORIAL PLANETA', 'Calle Falsa 123', 'Barcelona', 08001, 'Barcelona', 934567890, 934567891, 'contacto@planeta.com');
INSERT INTO L_EDITORIAL VALUES ('ED002', 'ALFAGUARA', 'Avenida Real 45', 'Madrid', 28013, 'Madrid', 915555555, 915555556, 'info@alfaguara.es');

-- Inserción en L_MATERIA
INSERT INTO L_MATERIA VALUES ('MAT1', 'LITERATURA');
INSERT INTO L_MATERIA VALUES ('MAT2', 'CIENCIA FICCIÓN');

-- Inserción en L_PERSONA
INSERT INTO L_PERSONA VALUES ('12345678A', 'MARÍA LÓPEZ', 'Calle Sol 5', 'Sevilla', 41001, 'Sevilla', 955123456, 955123457, 'maria@email.com', 10001);
INSERT INTO L_PERSONA VALUES ('98765432B', 'JUAN GARCÍA', 'Plaza Mayor 7', 'Valencia', 46002, 'Valencia', 963987654, 963987655, 'juan@email.com', 10002);
INSERT INTO L_PERSONA VALUES ('11223344B', 'ANA MARTÍNEZ', 'Calle Gran Vía 22', 'Madrid', 28013, 'Madrid', 914455667, 914455668, 'ana@email.com', 10003);
INSERT INTO L_PERSONA VALUES ('55667788C', 'CARLOS SÁNCHEZ', 'Paseo de Gracia 100', 'Barcelona', 08008, 'Barcelona', 936600112, 936600113, 'carlos@email.com', 10004);

-- Inserción en L_LIBRO
INSERT INTO L_LIBRO VALUES ('L001', 'EL QUIJOTE', '1605', 863, 'MIGUEL DE CERVANTES', 'ESPAÑOL', 5, 'ED001', 'MIGUEL DE CERVANTES', 2990);
INSERT INTO L_LIBRO VALUES ('L002', '1984', '1949', 328, 'RAFAEL ABELLA', 'ESPAÑOL', 8, 'ED002', 'GEORGE ORWELL', 2499);
INSERT INTO L_LIBRO VALUES ('L003', 'CIEN AÑOS DE SOLEDAD', '1967', 471, 'GREGORY RABASSA', 'ESPAÑOL', 7, 'ED001', 'GABRIEL GARCÍA MÁRQUEZ', 3499);
INSERT INTO L_LIBRO VALUES ('L004', 'LA SOMBRA DEL VIENTO', '2001', 563, '-', 'ESPAÑOL', 4, 'ED002', 'CARLOS RUIZ ZAFÓN', 4199);

-- Inserción en L_LIBRO_MATERIA (relación libro-materia)
INSERT INTO L_LIBRO_MATERIA VALUES ('L001', 'MAT1');
INSERT INTO L_LIBRO_MATERIA VALUES ('L002', 'MAT2');
INSERT INTO L_LIBRO_MATERIA VALUES ('L003', 'MAT1');
INSERT INTO L_LIBRO_MATERIA VALUES ('L004', 'MAT2');

-- Inserción en L_PRESTAMO
INSERT INTO L_PRESTAMO VALUES ('12345678A', 'L001', '10/05/2025', '17/05/2025', 'S');
INSERT INTO L_PRESTAMO VALUES ('98765432B', 'L002', '05/05/2025', '13/05/2025', 'N');
INSERT INTO L_PRESTAMO VALUES ('11223344B', 'L003', '01/05/2025', '08/05/2025','N');
INSERT INTO L_PRESTAMO VALUES ('11223344B', 'L004', '06/05/2025', '14/05/2025', 'S');
INSERT INTO L_PRESTAMO VALUES ('11223344B', 'L002', '28/04/2025', '05/05/2025', 'N');

/* Ejercicio 1 */

DECLARE

    v_dni VARCHAR(10):= ('123456789A');
    v_nombre L_PERSONA.nombre&TYPE;
    v_contador_multa NUMBER;
    v_contador_ok NUMBER;
    v_multa_total NUMBER;
    v_dias_fuera NUMBER;
    v_precio NUMBER;
    
    CURSOR cur_libro IS SELECT fecha_prestamo, fecha_libro FROM L_PRESTAMO WHERE dni = v_dni;
    
    
BEGIN
OPEN cur_libro
    LOOP
        -- Verificar persona existente.
            SELECT persona INTO v_nombre FROM L_PERSONA WHERE dni = v_dni;
                EXCEPTION WHEN NOT_DATA_FOUND THEN  DBMS_OUTPUT.PUTLINE('No existe ese DNI');
                
        -- Revisar si tiene libros prestados.
        
        IF NOT 
            cur_libro&ISOPEN THEN OPEN c_libros;
        END IF
        
        IF 
            cur_libro%NOTFOUND THEN   DBMS_OUTPUT.PUTLINE('No tiene libros prestados.');
                RETURN
        END IF;
        -- Recorrer libros prestados
        FOR libro IN cur_libro LOOP
            v_dias_fuera := SYSDATE - libro.fecha_prestamo;
            v_libro := libro.fecha_libro;
        IF 
            v_dias_fuera > 15 THEN v_contador_multa := v_contador_multa +1;
            v_multa_total := v_multa_total + 10 + (v_dias_fuera - 15) * 0.5 + (v_precio * 0,01);
        ELSE
            v_contador_ok := v_contador_ok + 1;
        END IF;
    END LOOP;
CLOSE cur_libro;

    -- Mostrar los datos.
    
    DBMS_OUTPUT.PUTLINE('Libros con multas: ' || v_contador_multas);
    DBMS_OUTPUT.PUTLINE('Libros sin multas: ' || v_contador_ok);
    DBMS_OUTPUT.PUTLINE('Total de multas: ' || v_multa_total);
    
END;

/* Ejercicio 2 */

DECLARE

    CURSOR

BEGIN
    
    OPEN 
    LOOP
    
    END LOOP;
    CLOSE ;
    
END;

/* Ejercicio 3 */

CREATE OR REPLACE lectores(
   fecha1 IN DATE,
   fecha2 IN DATE
);

   v_fecha_ini DATE;
   v_fecha_fin DATE;
   v_contador INTEGER := 0;
   CURSOR c_lectores IS SELECT cod_lector FROM prestamos WHERE fecha_salida BETWEEN v_fecha_ini AND v_fecha_fin GROUP BY cod_lecto
   
BEGIN

    -- Para intercambiar si la fecha es mayor o no.
   IF fecha1 <= fecha2 THEN
      v_fecha_ini := fecha1;
      v_fecha_fin := fecha2;
   ELSE
      v_fecha_ini := fecha2;
      v_fecha_fin := fecha1;
   END IF;
   
    -- Borrar la tabla de multas y no_multas
   DELETE FROM multas;
   DELETE FROM no_multas;
    
    
   FOR lector IN c_lectores LOOP
      v_contador := v_contador + 1;

      IF (SELECT 1 FROM sanciones WHERE cod_lector = lector.cod_lector) THEN
         INSERT INTO multas (dni, cod_libro, fecha, salida)SELECT dni, cod_libro, fecha, salida FROM sanciones WHERE cod_lector = lector.cod_lector;
      ELSE
         INSERT INTO no_multas (dni, cod_libro, fecha, salida) SELECT dni, cod_libro, fecha, salida FROM prestamos WHERE cod_lector = lector.cod_lector;
      END IF;
   END LOOP;
   
    -- Mostrar datos.
   IF v_contador = 0 THEN
      DBMS_OUTPUT.PUT_LINE('NO HAY LECTORES ENTRE LAS FECHAS');
   END IF;

   IF NOT (SELECT 1 FROM multas) THEN
      DBMS_OUTPUT.PUT_LINE('NO HAY MULTAS');
   END IF;

   IF NOT (SELECT 1 FROM no_multas) THEN
      DBMS_OUTPUT.PUT_LINE('NO HAY LECTORES SIN MULTA');
   END IF;
END;


































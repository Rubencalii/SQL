CREATE TABLE puesto_trabajo(
    id NUMBER(2) PRIMARY KEY,
    nombre VARCHAR2(50)
);

CREATE TABLE empleados(
    id NUMBER(10) PRIMARY KEY,
    nombre VARCHAR2(100),
    sueldo NUMBER(7),
    puesto_trabajo NUMBER(2),
    CONSTRAINT fk_pt FOREIGN KEY (puesto_trabajo) REFERENCES puesto_trabajo(id)
);

CREATE TABLE depto(
    id_jefe NUMBER(10),
    id_emp NUMBER(10),
    CONSTRAINT pk_dept PRIMARY KEY (id_jefe, id_emp),
    CONSTRAINT fk_emp_jf FOREIGN KEY (id_jefe) REFERENCES empleados(id),
    CONSTRAINT fk_emp FOREIGN KEY (id_emp) REFERENCES empleados(id)
);

INSERT INTO puesto_trabajo (id, nombre) VALUES (1, 'Jefe');
INSERT INTO puesto_trabajo (id, nombre) VALUES (2, 'Gerente');
INSERT INTO puesto_trabajo (id, nombre) VALUES (3, 'Analista');
INSERT INTO puesto_trabajo (id, nombre) VALUES (4, 'Desarrollador');
INSERT INTO puesto_trabajo (id, nombre) VALUES (5, 'Asistente');

INSERT INTO empleados (id, nombre, sueldo, puesto_trabajo) VALUES (1, 'Ana López', 100000, 1);
INSERT INTO empleados (id, nombre, sueldo, puesto_trabajo) VALUES (2, 'Carlos Ruiz', 100000, 1);
INSERT INTO empleados (id, nombre, sueldo, puesto_trabajo) VALUES (3, 'Marta Vidal', 100000, 1);

BEGIN
  FOR i IN 4..50 LOOP
    INSERT INTO empleados (id, nombre, sueldo, puesto_trabajo)
    VALUES (
      i,
      'Empleado ' || i,
      CASE MOD(i-4,4)
        WHEN 0 THEN 20000  -- Gerente
        WHEN 1 THEN 155000  -- Analista
        WHEN 2 THEN 10000  -- Desarrollador
        WHEN 3 THEN 5000  -- Asistente
      END,
      MOD(i-4,4) + 2
    );
  END LOOP;
  COMMIT;
END;

BEGIN
  -- Jefe 1 (empleados 4-19)
  FOR i IN 4..19 LOOP
    INSERT INTO depto (id_jefe, id_emp) VALUES (1, i);
  END LOOP;
  
  -- Jefe 2 (empleados 20-35)
  FOR i IN 20..35 LOOP
    INSERT INTO depto (id_jefe, id_emp) VALUES (2, i);
  END LOOP;
  
  -- Jefe 3 (empleados 36-50)
  FOR i IN 36..50 LOOP
    INSERT INTO depto (id_jefe, id_emp) VALUES (3, i);
  END LOOP;
  
  COMMIT;
END;
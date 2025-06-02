
CREATE TABLE empleados (
  id INT PRIMARY KEY,
  nombre VARCHAR(100),
  salario DECIMAL(10,2),
  departamento_id INT
);


CREATE TABLE departamentos (
  id INT PRIMARY KEY,
  nombre VARCHAR(100),
  total_salarios DECIMAL(10,2)
);


CREATE TABLE cambios_salario (
  id INT AUTO_INCREMENT PRIMARY KEY,
  empleado_id INT,
  salario_antiguo DECIMAL(10,2),
  salario_nuevo DECIMAL(10,2),
  fecha_cambio DATETIME
);


CREATE TABLE empleados_borrados (
  id INT,
  nombre VARCHAR(100),
  salario DECIMAL(10,2),
  fecha_borrado DATETIME
);

-- Trigger 1: No permitir salario menor a 1000
DELIMITER //
CREATE TRIGGER comprobar_salario
BEFORE INSERT ON empleados FOR EACH ROW
BEGIN
  IF NEW.salario < 1000 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El salario debe ser mayor o igual a 1000';
  END IF;
END;
//
DELIMITER ;

-- Trigger 2: Registrar cambios de salario
DELIMITER //
CREATE TRIGGER log_cambio_salario
BEFORE UPDATE ON empleados FOR EACH ROW
BEGIN
  IF OLD.salario <> NEW.salario THEN
    INSERT INTO cambios_salario (empleado_id, salario_antiguo, salario_nuevo, fecha_cambio)
    VALUES (OLD.id, OLD.salario, NEW.salario, NOW());
  END IF;
END;
//
DELIMITER ;

-- Trigger 3: Actualizar total de salarios por departamento
DELIMITER //
CREATE TRIGGER actualizar_total_salarios
AFTER UPDATE ON empleados FOR EACH ROW
BEGIN
  IF OLD.salario <> NEW.salario THEN
    UPDATE departamentos
    SET total_salarios = total_salarios - OLD.salario + NEW.salario
    WHERE id = NEW.departamento_id;
  END IF;
END;
//
DELIMITER ;

-- Trigger 4: Guardar datos del empleado eliminado
DELIMITER //
CREATE TRIGGER log_borrado_empleado
BEFORE DELETE ON empleados FOR EACH ROW
BEGIN
  INSERT INTO empleados_borrados (id, nombre, salario, fecha_borrado)
  VALUES (OLD.id, OLD.nombre, OLD.salario, NOW());
END;
//


---------------------
--- Ejercicio 1:
---------------------

DECLARE
    v_numeros := 2; --
BEGIN
    DBSM.output.put_line('Los Numeros pares del 1 al 50: ');
        while v_numeros <= 50  LOOP
           DBMS_OUTPUT.PUT_LINE(v_numero);
           v_numero += v_numero + 2; --
        END LOOP;
END;
/
   
---------------------
--- Ejercicio 2:
---------------------

BEGIN

DECLARE

EXCEPTION

END;
/

---------------------
--- Ejercicio 3:
---------------------   
DECLARE
  v_existe_empleado BOOLEAN := FALSE;
BEGIN
  --Verificar si el empleado existe 
  SELECT TRUE
  INTO v_existe_empleado FROM empleados WHERE num_empleado = p_num_empleado;

  IF v_existe_empleado THEN
    --Eliminar al empleado  
    DELETE FROM empleados
    WHERE num_empleado = p_num_empleado;
    DBMS_OUTPUT.PUT_LINE('Empleado con número ' || p_num_empleado || ' borrado.');
    
  ELSE
    DBMS_OUTPUT.PUT_LINE('No existe ningún empleado con el número ' || p_num_empleado || '.');
  END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No se encontro el empleado con numero ' || p_num_empleado || ' maal.');
    ROLLBACK;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al borrar el empleado con numero ' || p_num_empleado || ': ' || SQLERRM);
    ROLLBACK;
END;
/

---------------------
--- Ejercicio 4:
---------------------

DECLARE
    p_dept_no IN departamentos.dept_no%TYPE,
    p_nueva_localidad IN departamentos.loc%TYPE
    v_nombre_departamento departamentos.dname%TYPE;
    v_localidad_anterior departamentos.loc%TYPE;
BEGIN
    --Verificar si el departamento existe
    SELECT dname, loc
    INTO v_nombre_departamento, v_localidad_anterior FROM departamentos WHERE dept_no = p_dept_no;

    --Actualizar la localidad de los departamentos
    UPDATE departamentos SET loc = p_nueva_localidad WHERE dept_no = p_dept_no;

    --Visualizar la informacion del departamento modificado
    DBMS_OUTPUT.PUT_LINE('Departamento modificado:');
    DBMS_OUTPUT.PUT_LINE('Número de Departamento: ' || p_dept_no);
    DBMS_OUTPUT.PUT_LINE('Nombre del Departamento: ' || v_nombre_departamento);
    DBMS_OUTPUT.PUT_LINE('Localidad Anterior: ' || v_localidad_anterior);
    DBMS_OUTPUT.PUT_LINE('Nueva Localidad: ' || p_nueva_localidad);
    

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error no existe ningún departamento con el número ' || p_dept_no);
        
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al modificar la localidad del departamento ' || p_dept_no || ': ' || SQLERRM);
       
END;
/

---------------------
--- Ejercicio 5:
---------------------

BEGIN

DECLARE

EXCEPTION

END;
/

---------------------
--- Ejercicio 6:
---------------------

DECLARE
  v_num_departamento_ant empleados.departamento%TYPE := &introducir_departamento_actual;
  v_num_departamento_nue departamentos.dept_no%TYPE := &introducir_nuevo_departamento;
  v_contador_empleados NUMBER;
  v_existe_departamento BOOLEAN := FALSE;
BEGIN
  --Contar  el numero de emppleado en el depaartamento 
  SELECT COUNT(*)
  INTO v_contador_empleados FROM empleados WHERE departamento = v_num_departamento_ant;

  --Comprabar si el numero de empleados es igual o menor a 4
  IF v_contador_empleados <= 4 THEN
    DBMS_OUTPUT.PUT_LINE('Pocos empleados del departamento' || v_num_departamento_ant || ' (' || v_contador_empleados || ') no se ha cambiado nada');
  ELSE
  
    --Comprobar si el nuevo número de departamento existe en la tabla departamentos
    
    SELECT TRUE INTO v_existe_departamento FROM departamentos WHERE dept_no = v_num_departamento_nue;

    IF v_existe_departamento THEN
      --Actualizar el numero de empleados en el departamento
      UPDATE empleados
        SET departamento = v_num_departamento_nue WHERE departamento = v_num_departamento_ant;

      DBMS_OUTPUT.PUT_LINE('Se ha actualizado ' || SQL%ROWCOUNT || ' empleados del departamento ' || v_num_departamento_ant || ' aal departamento ' || v_num_departamento_nue || '.');
    ELSE
      DBMS_OUTPUT.PUT_LINE('El numero numero de empleados' || v_num_departamento_nue || 'no existe laa tabla departamentos, no se a cambiado nada');
    END IF
  END IF;
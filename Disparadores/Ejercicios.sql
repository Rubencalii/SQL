-- Ejercicio 1

-- Primero creamos la función que se ejecutará al insertar
CREATE OR REPLACE FUNCTION aviso_insercion_dueno()
RETURNS trigger AS $$
BEGIN
    RAISE NOTICE '% % con DNI % tiene % años. Insertado correctamente.',
        NEW.nombre, NEW.apellido, NEW.dni, NEW.edad;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Ahora creamos el trigger que llama a la función
CREATE TRIGGER trigger_aviso_insercion_dueno
AFTER INSERT ON dueno
FOR EACH ROW
EXECUTE FUNCTION aviso_insercion_dueno();

--Ejercicio 2 

CREATE OR REPLACE FUNCTION aviso_borrado_mascota()
RETURNS trigger AS $$
DECLARE
    nombre_dueno TEXT;
    nombre_raza TEXT;
BEGIN
    SELECT nombre || ' ' || apellido INTO nombre_dueno
    FROM dueno
    WHERE id_dueno = OLD.id_dueno;

    SELECT nombre_raza INTO nombre_raza
    FROM raza
    WHERE id_raza = OLD.id_raza;

    RAISE NOTICE 'Mascota: %, Raza: %, Dueño: %',
        OLD.nombre, nombre_raza, nombre_dueno;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_borrado_mascota
BEFORE DELETE ON mascota
FOR EACH ROW
EXECUTE FUNCTION aviso_borrado_mascota();

-- Ejercicio 3 

CREATE OR REPLACE FUNCTION aviso_cambio_nombre_mascota()
RETURNS trigger AS $$
BEGIN
    IF OLD.nombre <> NEW.nombre THEN
        RAISE NOTICE 'La mascota llamada % pasa a llamarse %',
            OLD.nombre, NEW.nombre;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_cambio_nombre_mascota
BEFORE UPDATE ON mascota
FOR EACH ROW
EXECUTE FUNCTION aviso_cambio_nombre_mascota();

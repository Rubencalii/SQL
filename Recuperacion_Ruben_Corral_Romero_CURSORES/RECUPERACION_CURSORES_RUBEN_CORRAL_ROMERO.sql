/*Ejercicio 2*/

CREATE OR REPLACE PROCEDURE actualizar_patrocinio (v_cif CLUB.CIF%TYPE) IS
    v_existe NUMBER := 0;
    v_partidos NUMBER := 0;
    v_dif NUMBER;
    V_ASISTENTES NUMBER := 0;

BEGIN
    -- Comprobar si el club existe
    SELECT COUNT(*) INTO v_existe FROM Club WHERE CIF = v_cif;

    IF v_existe = 0 THEN
        DBMS_OUTPUT.PUT_LINE('El club no existe.');
        RETURN;
    END IF;

    -- Recorrer partidos donde participa el club
    FOR partido IN (
        SELECT * FROM Enfrenta
        WHERE cif_local = v_cif OR cif_visitante = v_cif
    ) LOOP
        v_partidos := v_partidos + 1;

        IF partido.cif_local = v_cif THEN
            -- Club como local
            IF partido.goles_local > partido.goles_visitante THEN
                v_dif := partido.goles_local - partido.goles_visitante;
                UPDATE Financia SET cantidad = cantidad + (v_dif * 200)
                WHERE cif_club = v_cif;
            END IF;

        ELSIF partido.cif_visitante = v_cif THEN
            -- Club como visitante
            IF partido.goles_visitante > partido.goles_local THEN
                UPDATE Financia SET cantidad = cantidad + 100
                WHERE cif_club = v_cif;
            ELSIF partido.goles_visitante = partido.goles_local THEN
                UPDATE Financia SET cantidad = cantidad + 50
                WHERE cif_club = v_cif;
            END IF;
        END IF;
    END LOOP;

    IF v_partidos = 0 THEN
        DBMS_OUTPUT.PUT_LINE('El club no ha participado en ningún partido.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Patrocinio actualizado perfectamente.');
    END IF;
END;
/

/*Ejercicio 1*/

CREATE OR REPLACE PROCEDURE actualizar_patrocinio (v_cif CLUB.CIF%TYPE) IS
    v_existe NUMBER := 0;
    v_partidos NUMBER := 0;
    v_dif NUMBER;
BEGIN
    -- Comprobar si el club existe
     SELECT COUNT(*) INTO v_existe FROM Club WHERE CIF = v_cif; 
    IF v_existe = 0 THEN
        DBMS_OUTPUT.PUT_LINE('El club no existe.');
        RETURN;
    END IF;
    
    -- Cursor apra recorrer los partidos del club
        FOR partido IN (
        SELECT asistentes FROM Enfrenta
        WHERE cif_local = v_cif OR cif_visitante = v_cif
    ) LOOP
        v_partidos := v_partidos + 1;
        
        IF v_asistentes BETWEEN 1 AND 3 THEN
            UPDATE Club SET socios = socios + 10 WHERE CIF = v_cif;
        ELSIF v_asistentes > 3 THEN
            UPDATE Club SET socios = socios + 100 WHERE CIF = v_cif;
        END IF;
    END LOOP;
    IF v_partidos = 0 THEN 
        DBMS_OUTPUT.PUT_LINE('El club no ha jugado en ningún partido.');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Socios actualizado perfectamente.');
    END IF;
END;
/
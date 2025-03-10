CREATE TABLE salas(
    S INT PRIMARY KEY,
    nombre VARCHAR(100),
    Capacidad INT,
    Filas INT
);

CREATE TABLE peliculas (
    p INT PRIMARY KEY,
    nombre VARCHAR(100),
    calificacion DECIMAL(2, 1),
    nacionalidad VARCHAR(50)
);

CREATE TABLE proyecciones (
    Sala INT,
    Pelicula INT,
    Hora TIME,
    Ocupacion INT,
    PRIMARY KEY (Sala, Pelicula, Hora),
    FOREIGN KEY (Sala) REFERENCES SALAS(S),
    FOREIGN KEY (Pelicula) REFERENCES PELICULAS(P)
);

//Insertar los siguientes datos
INSERT INTO salas VALUES('S1', 'Africa', '125', '10');
    ('S2', 'America', '225', '24');
    ('S3', 'Europa', '136', '14');
    ('S4', 'Asia', '85', '7');
    ('S5', 'Oceania', '100', '10');
    ('S6', 'Antartida', '150', '15');
    ('S7', 'Atlantida', '300', '30');
    
INSERT INTO peliculas VALUES ('P1', 'Minios: el origen de Gru', 'TP', 'EEUU');
    ('P2', 'Black Panther: Wakandaforever', '18', 'EEUU');
    ('P3', 'Ast�rix y Ob�lix: el reino medio', '7', 'Francia');
    ('P4', 'El autor', 'NULL', 'Espa�a');
    ('P5', 'Perfectos desconocidos', '18', 'Espa�a');
    ('P6', 'ResidentEvil', '18', 'NULL');
    ('P7', 'Tadeo Jones 3', 'TP', 'Espa�a');
    ('P8', 'Eiffel', '7', 'Francia');
    ('P9', 'Pu�ales por la espalda 2', '18', 'EEUU');
    ('P10', 'La abuela', 'NULL', 'Espa�a');
    
INSERT INTO PROYECCIONES (Sala, Pelicula, Hora, Ocupacion) VALUES 
    ('S1', 'P1', '12:00', 75),
    ('S1', 'P1', '18:00', 84),
    ('S1', 'P2', '23:00', 100),
    ('S2', 'P3', '12:00', 89),
    ('S2', 'P3', '18:00', 104),
    ('S2', 'P3', '23:00', 200),
    ('S3', 'P2', '17:00', 100),
    ('S3', 'P2', '20:00', 120),
    ('S4', 'P4', '12:00', 14),
    ('S4', 'P4', '17:00', 60),
    ('S4', 'P4', '20:00', 78),
    ('S4', 'P6', '23:00', 80),
    ('S1', 'P1', '23:00', 35),
    ('S5', 'P4', '20:00', 16),
    ('S3', 'P4', '12:00', 25),
    ('S5', 'P1', '12:00', 100),
    ('S5', 'P8', '12:00', 152),
    ('S5', 'P4', '13:00', 250),
    ('S6', 'P2', '20:00', 120),
    ('S6', 'P10', '23:00', 68),
    ('S6', 'P9', '23:00', 50),
    ('S4', 'P8', '12:00', 36);

//Realiza las consultas

/*4.35*/

UPDATE SALAS SET Planta = 'Planta Baja' WHERE S IN (1, 2, 3);  

UPDATE SALAS SET Planta = 'Planta 1' WHERE S IN (4, 5, 6);  

/*4.36*/

ALTER TABLE SALASMODIFY Capacidad DECIMAL(5, 2);

/*4.39*/



/*4.43*/

SELECT P.nacionalidad FROM PELICULAS P JOIN PROYECCIONES PJ 
    ON P.P = PJ.Pelicula GROUP BY P.nacionalidad 
        HAVING SUM(PJ.Ocupacion * 10) > 2000;

/*4.1*/

SELECT nombre FROM peliculas;

/*4.2*/

SELECT calificacion FROM peliculas;

/*4.3*/

SELECT * FROM peliculas WHERE calificacion = '';

/*4.4*/

SELECT * FROM salas WHERE capacidad DESC;

/*4.5*/

SELECT * FROM SALAS WHERE S NOT IN (SELECT DISTINCT Sala FROM PROYECCIONES);

/*4.6*/

SELECT S.nombre AS Sala, P.nombre AS Pelicula, P.calificacion, P.nacionalidad
    FROM SALAS S JOIN PROYECCIONES PR ON S.S = PR.Sala JOIN PELICULAS P ON PR.Pelicula = P.P;
    
/*4.7*/

SELECT Hora, SUM(Ocupacion) AS TotalEntradasVendidas 
    FROM PROYECCIONES GROUP BY Hora;
    
/*4.8*/

SELECT PELICULAS.nombre FROM PELICULAS LEFT JOIN PROYECCIONES 
    ON PELICULAS.P = PROYECCIONES.Pelicula WHERE PROYECCIONES.Pelicula IS NULL;
    
/*4.9*/

SELECT nacionalidad, COUNT(*) AS TotalPeliculas FROM PELICULAS
    WHERE P IN (SELECT Pelicula FROM PROYECCIONES)GROUP BY nacionalidad
        ORDER BY TotalPeliculas DESC LIMIT 1;
        
/*4.10*/

SELECT S.* FROM SALAS S JOIN PROYECCIONES PR ON S.S = PR.Sala JOIN PELICULAS P ON PR.Pelicula = P.P
    WHERE P.nombre IN ('Emoji: la pel�cula', 'Spiderman') GROUP BY S.S HAVING COUNT(DISTINCT P.nombre) = 2;
    
/*4.11*/

SELECT * FROM PELICULAS  WHERE calificacion IN ('7', '18');

/*4.12*/

SELECT PR.*, P.nombre AS Pelicula, P.calificacion FROM PROYECCIONES PR
    JOIN PELICULAS P ON PR.Pelicula = P.P WHERE P.calificacion = 'TP';
    
/*4.13*/

SELECT P.nacionalidad, P.nombre AS Pelicula, PR.Hora FROM PELICULAS P
    JOIN PROYECCIONES PR ON P.P = PR.Pelicula ORDER BY P.nacionalidad, P.nombre, PR.Hora;

/*4.14*/

SELECT PELICULAS.nombre FROM PELICULAS JOIN PROYECCIONES 
    ON PELICULAS.P = PROYECCIONES.Pelicula WHERE PROYECCIONES.Hora BETWEEN '00:00' AND '12:00';

/*4.15*/



/*4.16*/

SELECT Sala, MAX(Ocupacion) AS MaxOcupacion FROM PROYECCIONES 
    WHERE Hora = '23:00' GROUP BY Sala ORDER BY MaxOcupacion DESC LIMIT 1;
    
/*4.17*/

SELECT P.nombre AS Pelicula, PR.Hora, MAX(PR.Ocupacion) AS Ocupacion_Maxima FROM PROYECCIONES PR
    JOIN PELICULAS P ON PR.Pelicula = P.P GROUP BY P.nombre, PR.Hora 
        ORDER BY Ocupacion_Maxima DESC LIMIT 1;
        
/*4.18*/

SELECT S.nombre AS Sala, P.nombre AS Pelicula, MIN(PR.Ocupacion) AS Menor_Ocupacion FROM SALAS S
    JOIN PROYECCIONES PR ON S.S = PR.Sala JOIN PELICULAS P ON PR.Pelicula = P.P 
        GROUP BY S.nombre ORDER BY Menor_Ocupacion ASC;


DECLARE 

    nom_sala VARCHAR(30);
    cap_sala sala.capacidad%TYPE;
    
BEGIN

    SELECT nombre, capacidad INTO nom_sala, cap_sala FROM sala WHERE s='s3';
    
    DBMS_OUTPUT.put_line('Nombre de la sala 3: '||nom_sala);
    DBMS_OUTPUT.put_line('Capacidad de la sala: '||cap_sala);
    
END;

/*Ejercicio 1: Pedir al usuario un numero y ver si el numero es positivo o negativo*/

DECLARE
    num NUMBER;
BEGIN
    -- Asigna un valor a la variable num
    num := &numero;  

    -- Verifica si el número es positivo o negativo
    IF (num > 0) THEN
        DBMS_OUTPUT.PUT_LINE('El número es positivo.');
    ELSIF (num < 0) THEN
        DBMS_OUTPUT.PUT_LINE('El número es negativo.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El número es cero.');
    END IF;
END;


/*Ejercicio 2: Pedir al usuario la edad y si es mayor de edad o no */

DECLARE 
    edad NUMBER;

BEGIN 
    --Asignar un valor a la variable edad;
    edad := &edad

    --Verificar si es mayor de edad o no 
     IF (edad >= 18) THEN
        DBMS_OUTPUT.PUT_LINE('Eres mayor de edad.');
    ELSIF
        DBMS_OUTPUT.PUT_LINE('Eres menor de edad.');
    END IF; 
END;

/*Ejercicio 3: Comprobar si la sala 4 esta llena para la pelicula p4 a las 20.00*/

DECLARE 

    v_num_asientos_totales NUMBER;
    v_num_asientos_ocupados NUMBER;
BEGIN 
    -- Obtener el número total de asientos en la sala 4
    
    SELECT num_asientos
    INTO num_asientos_totales
    FROM salas
    WHERE id_sala = 4;


    SELECT * FROM 
    INTO num_asientos_ocupados FROM reservas r JOIN peliculas p ON r.id_pelicula = p.id_pelicula
        WHERE r.id_sala = 4 AND p.nombre_pelicula = 'P4' AND r.hora = TO_TIMESTAMP('20:00', 'HH24:MI');

    --Monstrar si la sala esta ocupada o no

    IF (num_asientos_ocupados  >= v_num_asientos_totales)
         DBMS_OUTPUT.PUT_LINE('La sala 4 esta llena la pelicula P4 de las 20.00');
    ELSIF
         DBMS_OUTPUT.PUT_LINE('La sala 4 no está llena para la película P4 a las 20:00.'); 
/*Ejercicio 4: Comprobar si quedan mas de 100 entradas para ver "Asterix y Oberlix: el reino medio" a las 18.00*/

DECLARE
    v_nombre_pelicula VARCHAR2(25);
    v_hora TIME;
    v_num_asientos_totales NUMBER;
    v_num_asientos_reservados NUMBER;
BEGIN
    -- Pedir al usuario el nombre de la película
    v_nombre_pelicula := '&nombre_pelicula';  

    -- Pedir al usuario la hora de la película
    v_hora := TO_TIMESTAMP('&hora', 'HH24:MI');  

    -- Obtener el número total de asientos de la sala correspondiente
    SELECT num_asientos
    INTO v_num_asientos_totales
    FROM salas s
    JOIN peliculas p ON s.id_sala = p.id_sala
    WHERE p.nombre_pelicula = v_nombre_pelicula
    AND p.hora = v_hora;

    -- Contar los asientos reservados para la película y la hora especificada
    SELECT NVL(SUM(num_asientos_reservados), 0)
    INTO v_num_asientos_reservados
    FROM reservas r
    JOIN peliculas p ON r.id_pelicula = p.id_pelicula
    WHERE p.nombre_pelicula = v_nombre_pelicula
    AND r.hora = v_hora;

    -- Verificar si quedan más de 10 entradas disponibles
    IF (v_num_asientos_totales - v_num_asientos_reservados) > 10 THEN
        DBMS_OUTPUT.PUT_LINE('Quedan más de 10 entradas disponibles para "' || v_nombre_pelicula || '" a las ' || TO_CHAR(v_hora, 'HH24:MI') || '.');
    ELSIF
        DBMS_OUTPUT.PUT_LINE('No quedan más de 10 entradas disponibles para "' || v_nombre_pelicula || '" a las ' || TO_CHAR(v_hora, 'HH24:MI') || '.');
    END IF;
END;

/*Ejercicio 5: Pedir al usuario un nombre de pelicula y comprobar si hay aun entradas disponibles para esa pelicula a la hora que el usuario desee.El usuario debera indicar cuantas entradas quiere comprar. En caso que haya entradas, el bloque se le vendera a 6,5 euros. En caso contrario le indicara al usuraio que eliga otra hora*/

DECLARE
    -- Variables para almacenar los datos ingresados por el usuario
    v_nombre_pelicula  VARCHAR2(100);
    v_hora             VARCHAR2(5);
    v_entradas_solicitadas NUMBER;
    v_entradas_disponibles NUMBER;

    -- Variables de precio
    v_precio_entrada   NUMBER := 6.5;
    v_total_a_pagar    NUMBER;

BEGIN
    -- Solicitar los datos al usuario
    DBMS_OUTPUT.PUT_LINE('Introduce el nombre de la película:');
    -- Simulación de entrada de usuario (esto dependerá del entorno de ejecución)
    v_nombre_pelicula := 'El Señor de los Anillos'; 

    DBMS_OUTPUT.PUT_LINE('Introduce la hora de la película (formato HH24:MI):');
    -- Simulación de entrada de usuario (esto dependerá del entorno de ejecución)
    v_hora := '18:30';  

    DBMS_OUTPUT.PUT_LINE('Introduce la cantidad de entradas que deseas comprar:');
    -- Simulación de entrada de usuario (esto dependerá del entorno de ejecución)
    v_entradas_solicitadas := 3; 

    -- Consulta para obtener las entradas disponibles para la película y hora especificadas
    SELECT entradas_disponibles
    INTO v_entradas_disponibles
    FROM funciones
    WHERE nombre_pelicula = v_nombre_pelicula
      AND hora = v_hora;

    -- Comprobar si hay suficientes entradas
    IF v_entradas_disponibles >= v_entradas_solicitadas THEN
        -- Calcular el total a pagar
        v_total_a_pagar := v_entradas_solicitadas * v_precio_entrada;
        -- Vender las entradas (actualizar el número de entradas disponibles)
        UPDATE funciones
        SET entradas_disponibles = entradas_disponibles - v_entradas_solicitadas
        WHERE nombre_pelicula = v_nombre_pelicula
          AND hora = v_hora;
        
        DBMS_OUTPUT.PUT_LINE('Entradas vendidas con éxito.');
        DBMS_OUTPUT.PUT_LINE('Total a pagar: ' || v_total_a_pagar || ' euros.');
    ELSE
        -- Si no hay suficientes entradas
        DBMS_OUTPUT.PUT_LINE('Lo siento, no hay suficientes entradas disponibles para la hora indicada.');
        DBMS_OUTPUT.PUT_LINE('Por favor, elija otra hora.');
    END IF;

END;
/
/*Ejercicio 6: Escribir un bloque PL/SQL tal que el usuario dara dos nombres de salas y el bloque le indicara que sala es mas grande, inidcando ademas la diferencia entra una sala y la otra*/

DECLARE
    -- Variables para almacenar los nombres de las salas
    v_sala1 VARCHAR2(100);
    v_sala2 VARCHAR2(100);
    
    -- Variables para almacenar el tamaño de las salas
    v_tamano_sala1 NUMBER;
    v_tamano_sala2 NUMBER;

    -- Variable para almacenar la diferencia de tamaño
    v_diferencia NUMBER;
    
BEGIN
    -- Solicitar los datos al usuario (simulación)
    DBMS_OUTPUT.PUT_LINE('Introduce el nombre de la primera sala:');
    -- Simulación de la entrada del usuario
    v_sala1 := 'Sala A';  
    
    DBMS_OUTPUT.PUT_LINE('Introduce el nombre de la segunda sala:');
    -- Simulación de la entrada del usuario
    v_sala2 := 'Sala B';  
    
    -- Obtener los tamaños de las salas desde la base de datos
    SELECT tamano_sala
    INTO v_tamano_sala1
    FROM salas
    WHERE nombre_sala = v_sala1;
    
    SELECT tamano_sala
    INTO v_tamano_sala2
    FROM salas
    WHERE nombre_sala = v_sala2;

    -- Calcular la diferencia de tamaño
    v_diferencia := ABS(v_tamano_sala1 - v_tamano_sala2);
    
    -- Comparar el tamaño de las salas y mostrar el resultado
    IF v_tamano_sala1 > v_tamano_sala2 THEN
        DBMS_OUTPUT.PUT_LINE('La sala ' || v_sala1 || ' es más grande que la sala ' || v_sala2 || '.');
        DBMS_OUTPUT.PUT_LINE('La diferencia de tamaño es de ' || v_diferencia || ' unidades.');
    ELSIF v_tamano_sala1 < v_tamano_sala2 THEN
        DBMS_OUTPUT.PUT_LINE('La sala ' || v_sala2 || ' es más grande que la sala ' || v_sala1 || '.');
        DBMS_OUTPUT.PUT_LINE('La diferencia de tamaño es de ' || v_diferencia || ' unidades.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ambas salas tienen el mismo tamaño.');
    END IF;

END;
/


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
    ('P3', 'Astérix y Obélix: el reino medio', '7', 'Francia');
    ('P4', 'El autor', 'NULL', 'España');
    ('P5', 'Perfectos desconocidos', '18', 'España');
    ('P6', 'ResidentEvil', '18', 'NULL');
    ('P7', 'Tadeo Jones 3', 'TP', 'España');
    ('P8', 'Eiffel', '7', 'Francia');
    ('P9', 'Puñales por la espalda 2', '18', 'EEUU');
    ('P10', 'La abuela', 'NULL', 'España');
    
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
    WHERE P.nombre IN ('Emoji: la película', 'Spiderman') GROUP BY S.S HAVING COUNT(DISTINCT P.nombre) = 2;
    
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
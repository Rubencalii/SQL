CREATE TABLE carrera (
    gpid VARCHAR2(4) PRIMARY KEY,  
    gp VARCHAR2(30) UNIQUE NOT NULL,                        
    fech_carrrera DATE CHECK (fech_carrrera > '2024-02-29') AND (fech_carrrera < '2024-12-08'),
    ubicacion VARCHAR2(25)
);

CREATE TABLE piloto (
    id_piloto NUMBER PRIMARY KEY,
    nombre VARCHAR2(25) UNIQUE NOT NULL,
    equipo VARCHAR2(25)
);

CREATE TABLE car_pos_piloto (
    gpid VARCHAR2(4),
    pid NUMBER,
    puntos NUMBER,  
    
    CONSTRAINT car_pos_piloto_pk PRIMARY KEY (gpid, pid),
    CONSTRAINT fk_gpid FOREIGN KEY (gpid) REFERENCES carrera (gpid),
    CONSTRAINT fk_pid FOREIGN KEY (pid) REFERENCES piloto (id_piloto)
);

/* Insertar informacion */

/* Carrera */
INSERT INTO carrera(gpid, gp, fech_carrrera, ubicacion) VALUES 
    ('GP01', 'Gran Premio de Bahrein','2024-03-02', 'Sakhir');
INSERT INTO carrera(gpid, gp, fech_carrrera, ubicacion) VALUES 
    ('GP02', 'Gran Premio de Arabia Saudita', '2024-03-09', 'Yeda');
INSERT INTO carrera(gpid, gp, fech_carrrera, ubicacion) VALUES 
    ('GP03', 'Gran Premio de Australia', '2024-03-24', 'Melbourne');
INSERT INTO carrera(gpid, gp, fech_carrrera, ubicacion) VALUES 
    ('GP04', 'Gran Premio de Japon','2024-04-07', 'Suzuka');
INSERT INTO carrera(gpid, gp, fech_carrrera, ubicacion) VALUES 
    ('GP05', 'Gran Premio de China','2024-04-21', 'Shanghai');

/* Piloto */
INSERT INTO piloto(id_piloto, nombre, equipo) VALUES
    (1, 'Max Verstappen', 'Red Bull');
INSERT INTO piloto(id_piloto, nombre, equipo) VALUES
    (2, 'Sergio Perez', 'Red Bull');
INSERT INTO piloto(id_piloto, nombre, equipo) VALUES
    (3, 'Lewis Hamilton', 'Mercedes');
INSERT INTO piloto(id_piloto, nombre, equipo) VALUES
    (4, 'George Rusell', 'Mercedes');
INSERT INTO piloto(id_piloto, nombre, equipo) VALUES
    (5, 'Charles Leclerc', 'Ferrari');
INSERT INTO piloto(id_piloto, nombre, equipo) VALUES
    (6, 'Carlos Sainz', 'Ferrari');
INSERT INTO piloto(id_piloto, nombre, equipo) VALUES    
    (7, 'Lando Norris', 'McLaren');
INSERT INTO piloto(id_piloto, nombre, equipo) VALUES    
    (8, 'Oscar Piastri', 'McLaren');
INSERT INTO piloto(id_piloto, nombre, equipo) VALUES    
    (9, 'Fernando Alonso', 'Aston Martin');
INSERT INTO piloto(id_piloto, nombre, equipo) VALUES    
    (10, 'Lance Stroll', 'Aston Martin');

/* car_pos_piloto */
INSERT INTO car_pos_piloto(gpid, pid, puntos) VALUES 
    ('GP01', 1, 25);
INSERT INTO car_pos_piloto(gpid, pid, puntos) VALUES 
    ('GP01', 2, 18);
INSERT INTO car_pos_piloto(gpid, pid, puntos) VALUES 
    ('GP01', 6, 15);
INSERT INTO car_pos_piloto(gpid, pid, puntos) VALUES 
    ('GP02', 1, 25);
INSERT INTO car_pos_piloto(gpid, pid, puntos) VALUES 
    ('GP02', 5, 18);
INSERT INTO car_pos_piloto(gpid, pid, puntos) VALUES 
    ('GP02', 3, 15);
INSERT INTO car_pos_piloto(gpid, pid, puntos) VALUES 
    ('GP03', 6, 25);
INSERT INTO car_pos_piloto(gpid, pid, puntos) VALUES 
    ('GP03', 5, 18);
INSERT INTO car_pos_piloto(gpid, pid, puntos) VALUES 
    ('GP03', 1, 15);
INSERT INTO car_pos_piloto(gpid, pid, puntos) VALUES 
    ('GP04', 1, 25);
INSERT INTO car_pos_piloto(gpid, pid, puntos) VALUES 
    ('GP04', 6, 18);
INSERT INTO car_pos_piloto(gpid, pid, puntos) VALUES 
    ('GP04', 4, 15);
INSERT INTO car_pos_piloto(gpid, pid, puntos) VALUES 
    ('GP05', 1, 25);
INSERT INTO car_pos_piloto(gpid, pid, puntos) VALUES 
    ('GP05', 7, 18);
INSERT INTO car_pos_piloto(gpid, pid, puntos) VALUES 
    ('GP05', 9, 15);

/*Consultas*/

--1

ALTER TABLE piloto ADD nacionalidad VARCHAR2(3) 
    CHECK (nacionalidad IN ('ESP', 'GBR', 'NED', 'FRA', 'MEX', 'MON', 'CAN', 'AUS'));
    
    INSERT INTO piloto VALUES (1, 'Max Verstappen', 'Red Bull', 'NED');
    INSERT INTO piloto VALUES (2, 'Sergio Perez', 'Red Bull', 'MEX');
    INSERT INTO piloto VALUES (3, 'Lewis Hamilton', 'Mercedes', 'GBR');
    INSERT INTO piloto VALUES (4, 'George Rusell', 'Mercedes', 'GBR');
    INSERT INTO piloto VALUES (5, 'Charles Leclerc', 'Ferrari', 'MON');
    INSERT INTO piloto VALUES (6, 'Carlos Sainz', 'Ferrari', 'ESP');
    INSERT INTO piloto VALUES (7, 'Lando Norris', 'McLaren', 'GRB');
    INSERT INTO piloto VALUES (8, 'Oscar Piastri', 'McLaren', 'AUS');
    INSERT INTO piloto VALUES (9, 'Fernando Alonso', 'Aston Martin', 'ESP');
    INSERT INTO piloto VALUES (10, 'Lance Stroll', 'Aston Martin', 'CAN');

--2 

SELECT p.nombre, SUM(cp.puntos) AS total_puntos FROM car_pos_piloto cp
    JOIN piloto p ON cp.pid = p.id_piloto WHERE p.nacionalidad = 'ESP'
        GROUP BY p.nombre ORDER BY total_puntos DESC;

--3 

UPDATE car_pos_piloto SET puntos = 19 WHERE gpid = 'GP02' AND pid = 5;

--4    
    
SELECT p.equipo, SUM(cp.puntos) AS total_puntos FROM car_pos_piloto cp
    JOIN piloto p ON cp.pid = p.id_piloto GROUP BY p.equipo
        ORDER BY total_puntos DESC;
        
--10 

SELECT p.nombre, SUM(cp.puntos) AS total_puntos FROM car_pos_piloto cp
    JOIN piloto p ON cp.pid = p.id_piloto GROUP BY p.nombre
        ORDER BY total_puntos DESC;
        
--12 

ALTER TABLE carrera
RENAME COLUMN gp TO nombre;


ALTER TABLE carrera
ADD CONSTRAINT chk_nombre CHECK (nombre LIKE 'Gran Premio de%');



    
    
    
    
    
    
    
    
    
    
    
    
    
    
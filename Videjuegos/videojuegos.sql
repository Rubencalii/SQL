CREATE TABLE videojuegos (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Titulo VARCHAR(50) NOT NULL,
    PEGI CHAR(3) CHECK (PEGI IN ('+3', '+7', '+12', '+16', '+18')),
    ID_desarrolladora INT,
    FOREIGN KEY (ID_desarrolladora) REFERENCES Desarrolladores(ID)
);
CREATE TABLE consolas (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(25) NOT NULL,
    ID_Fabricante INT,
    FechaLanzamiento DATE,
    Generación INT NOT NULL CHECK (Generación > 0 AND Generación < 10),
    FOREIGN KEY (ID_Fabricante) REFERENCES Desarrolladores(ID)
);
CREATE TABLE lanzamientos (
    ID INT,
    ID_Consola INT,
    FechaLanzamiento DATE,
    PRIMARY KEY (ID_Juego, ID_Consola),
    FOREIGN KEY (ID_Juego) REFERENCES Videojuegos(ID),
    FOREIGN KEY (ID_Consola) REFERENCES Consolas(ID)
);
CREATE TABLE Generos (
    ID_genero INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(25) NOT NULL
);
CREATE TABLE juego_genero (
    ID_juego INT,
    ID_genero INT,
    PRIMARY KEY (ID_juego, ID_genero),
    FOREIGN KEY (ID_juego) REFERENCES Videojuegos(ID),
    FOREIGN KEY (ID_genero) REFERENCES Generos(ID)
);
CREATE TABLE desarrolladores (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50) NOT NULL,
    PaisOrig en VARCHAR(50) NOT NULL,
    AñoFundacion INT
);

--VALORES DE LA TABLA--

--VIDEOJUEGOS--

INSERT INTO videojuegos(ID_videojuegos, Titulo, PEGI, ID_desarrolladora) VALUES
    (1, 'Cyberpunk 2077', '+18' , 1);
INSERT INTO videojuegos(ID_videojuegos, Titulo, PEGI, ID_desarrolladora) VALUES
    (2, 'The Legend of Zeld Breath of the Wild', '+12' ,2 );
INSERT INTO videojuegos(ID_videojuegos, Titulo, PEGI, ID_desarrolladora) VALUES
    (3, 'Red Dead Redemption 2', '+18' ,3 );
INSERT INTO videojuegos(ID_videojuegos, Titulo, PEGI, ID_desarrolladora) VALUES
    (4, 'Minecraft', '+7' ,4);
INSERT INTO videojuegos(ID_videojuegos, Titulo, PEGI, ID_desarrolladora) VALUES
    (5, 'Spyro the Dragon','+3'  ,6);

--lANZAMIENTO--

INSERT INTO lanzamientos(ID_Juego, ID_Consola, FechaLanzamiento) VALUES 
    (1 , 2 , '10/12/2020');
INSERT INTO lanzamientos(ID_Juego, ID_Consola, FechaLanzamiento) VALUES 
    (1 , 3 , '1 3 14/02/2022');
INSERT INTO lanzamientos(ID_Juego, ID_Consola, FechaLanzamiento) VALUES 
    (1 , 4 , '14/02/2022');
INSERT INTO lanzamientos(ID_Juego, ID_Consola, FechaLanzamiento) VALUES 
    (2 , 5 , '03/03/2017');
INSERT INTO lanzamientos(ID_Juego, ID_Consola, FechaLanzamiento) VALUES 
    (3 , 2 , '26/10/2018');
INSERT INTO lanzamientos(ID_Juego, ID_Consola, FechaLanzamiento) VALUES 
    (4 , 2 , '04/09/2014');
INSERT INTO lanzamientos(ID_Juego, ID_Consola, FechaLanzamiento) VALUES 
    (4 , 5 , '12/05/2017');
INSERT INTO lanzamientos(ID_Juego, ID_Consola, FechaLanzamiento) VALUES 
    (5 , 1 , '09/09/1998');

--CONSOLA--

INSERT INTO consolas (Nombre, ID_Fabricante, FechaLanzamiento, Generación)VALUES
    ('PlayStation 5', 3, '1994-12-03', 5),
INSERT INTO consolas (Nombre, ID_Fabricante, FechaLanzamiento, Generación)VALUES
    ('PlayStation 4', 5, '2013-11-15', 8),
INSERT INTO consolas (Nombre, ID_Fabricante, FechaLanzamiento, Generación)VALUES
    ('PlayStation 5', 5, '2020-11-12', 9),
INSERT INTO consolas (Nombre, ID_Fabricante, FechaLanzamiento, Generación)VALUES
    ('XBOX Series X', 7, '2020-11-10', 9),
INSERT INTO consolas (Nombre, ID_Fabricante, FechaLanzamiento, Generación)VALUES
    ('Nintendo Switch', 2, '2017-03-03', 8);

--GENERO--

INSERT INTO Generos (ID, Nombre)VALUES
    (1, 'RPG'),
INSERT INTO Generos (ID, Nombre)VALUES
    (2, 'Aventura'),
INSERT INTO Generos (ID, Nombre)VALUES
    (3, 'Acción'),
INSERT INTO Generos (ID, Nombre)VALUES
    (4, 'Sandbox'),
INSERT INTO Generos (ID, Nombre)VALUES
    (5, '3rd Person Shooter');

--Juego_Genero--

INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (1, 1),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (1, 3),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (1, 5),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (2, 2),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (2, 3),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (3, 3),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (3, 4),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (3, 5),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (4, 4),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (5, 2),
INSERT INTO Juego_Genero (ID_juego, ID_genero)VALUES
    (5, 3);

--Desarrolladores--

INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AñoFundación)VALUES
    (1, 'CD Projekt Red', 'Polonia', 1994),
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AñoFundación)VALUES
    (2, 'Nintendo EPD', 'Japón', 1889),
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AñoFundación)VALUES
    (3, 'Rockstar Games', 'Estados Unidos', 1998),
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AñoFundación)VALUES
    (4, 'Mojang Studios', 'Suecia', 2009),
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AñoFundación)VALUES
    (5, 'Sony Interactive', 'Japón', 1993),
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AñoFundación)VALUES
    (6, 'Insomniac Games', 'Estados Unidos', 1994),
INSERT INTO Desarrolladoras (ID, Nombre, PaisOrigen, AñoFundación)VALUES
    (7, 'Microsoft', 'Estados Unidos', 1975);

--Consultas--
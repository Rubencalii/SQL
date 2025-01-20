//Repaso y Segundo 2 trimestre
/*
CREATE TABLE coche(
    matricula varchar2(10) PRIMARY KEY,
    modelo varchar2(15),
    marca varchar2(15),
    color varchar2(15) NOT NULL
);

CREATE TABLE persona(
    ID_persona numeric(3)CHECK(id_persona >= 0) PRIMARY KEY,
    nombre varchar(25) NOT NULL,
    telefono numeric(10) UNIQUE
);

CREATE TABLE dueños(
    matricula VARCHAR2(3),
    persona numeric(3),
    f_inicio DATE NOT NULL,
    f_fin DATE,
    CONSTRAINT pk_dueños PRIMARY KEY (matricula, persona),
    CONSTRAINT pk_dueños_coches FOREIGN KEY (matricula) REFERENCES coches(matricula),
    CONSTRAINT pk_dueños_persona FOREIGN KEY (persona) REFERENCES persona(ID_persona)
);

INSERT INTO coche VALUES ('111AAA','Civic','Honda','Rojo');   
     ('2222BBB', 'Accord', 'Honda', 'Azul');
     ('3333CCC', 'Carmy', 'Toyota', 'Verde');
     ('4444DDD', 'Corolla', 'Toyota', 'Negro');
     ('5555EEE', 'Fusion', 'Ford', 'Rojo');
     ('6666FFF', 'Mustang', 'Ford', 'Negro');
     ('7777GGG', 'Carmy', 'Toyota', 'Verde');
     ('8888HHH', 'Alejandro', 'Toyota', 'Verde');
     ('9999III', 'Molero', 'Toyota', 'Verde');
     ('1010JJJ', 'Alex', 'Toyota', 'Verde');

INSERT into persona Values ('1', 'Juan Perez', '66123456')
    ('2', 'Maria Rodriguez', '655432189');
    ('3', 'Carlos Lopez', '699876543');
    ('4', 'Ana Martinez', '6687123456');
    ('5', 'Pedro Garcia', '688987654');

INSERT into duños Values ('111AAA', '1', '01/01/2023', '15/05/2023')
    ('2222BBB', 2, '10/05/2022', '28/02/2023')
    ('3333CCC', 3, '15/12/2022', '20/09/2023')
    ('4444DDD', 4, '05/03/2023', NULL)
    ('5555EEE', 5, '20/08/2022', '10/01/2023')
    ('6666FFF', 1, '01/04/2023', NULL)
    ('17777GGG', 2, '25/06/2022', '18/04/2023')
    ('8888HHH', 3, '30/11/2022', '12/07/2023')
    ('9999III', 4, '10/02/2023', NULL)
    ('1010JJJ', 5, '15/09/2022', '22/03/2023')
    ('111AAA', 2, '20/05/2023', NULL)
    ('2222BBB', 3, '10/03/2023', NULL)
    ('3333CCC', 4, '05/10/2023', '08/11/2023')
    ('4444DDD', 5, '20/01/2023', '08/11/2023')
    ('5555EEE', 1, '15/04/2023', NULL)

--Tabla de una sola tabla--

--SELECT lo que buscas, FROM donde estas, WHERE lo que tiene que hacer para que salgas la opcion por ejemplo solo sale el telefono del nombre Juan Perez, Distinct distinto, cuando hay NULL delante tiene que ir IS, order by ordenarlo por ..... ASC de A,Z y DESC de Z,A ,

SELECT nombre FROM persona;
SELECT telefono FROM persona WHERE nombre='Juan Perez';
SELECT persona FROM dueños WHERE matricula='1111AAA' AND f_fin IS NULL;
SELECT  Distinct color FROM coche WHERE marca='Honda'
Select marca, modelo From coche ORDER BY marca; 

--Consultas con varias tablas--

SELECT nombre, matricula FROM dueños, persona
WHERE dueños.persona= ID_persona AND f_fin IS NULL;

SELECT matricula, f_ini FROM dueños, persona
WHERE persona=ID AND nombre='Carlos Lopez';

SELECT f_ini FROM dueños, coche
WHERE dueños.matricula=coche.matricula AND color='Rojo';

SELECT color FROM persona, dueños, coches
WHERE persona.id=persona AND dueños.matricula=coche.matricula AND nombre='Ana Martinez' AND f_fin IS NULL;

SELECT nombre FROM coche, dueños, personaWHERE persona.id=persona AND dueños.matricula=coche.matricula
AND color='Negro' AND modelo='Mustang' AND marca='Ford' ORDER BY f_ini;

--Modificaciones de datos--

UPDATE persona SET nombre='Ana M. Martinez' WHERE nombre='Ana Martinez';
UPDATE coche SET color='Oscuro' WHERE color='Negro';
UPDATE dueños SET f_fin='25-03-2023' WHERE f_fin IS NULL;
DELETE FROM dueño WHERE matricula='1111AAA';
DELETE FROM dueños WHERE f_ini='15/04/2023';
DELETE FROM dueños;

*/

CREATE TABLE pokemon (
    ID  numeric(3)CHECK(ID >= 0) PRIMARY KEY,
    Nombre Varchar2(30),
    Altura numeric(5,1),
    Peso numeric(4,1),
    Categoria VARCHAR2(25), 
    Habilidad VARCHAR2(25),
);

CREATE TABLE tipo (
    ID_tipo numeric(3)CHECK(ID_tipo >= 0) PRIMARY KEY,
    nombre VARCHAR(20)
),

CREATE TABLE pokedex (
    ID  numeric(3)CHECK(ID >= 0) PRIMARY KEY,
    ID_tipo numeric(3)CHECK(ID_tipo >= 0) PRIMARY KEY,
),
INSERT into pokemon Values ('1','Bulbasaur','0,7','6,9','Semilla','Espesura');
    ('2','Charmander','0,6','8,5','Lagarto','Mar Llamas');
    ('3','Squirtle','0,5','9','Tortuguita','Torrente');
    ('4','Pikachu','0,4','6','Raton','Electricidad estatica');
    ('5','Jigglypuff','0,5','5,5','Globo','Cura');
    ('6','Gengar','1,5','40,5','Sombra','Levitacion');
    ('7','Onix','8,8','210','Serpiente de roca','Cabeza de roca');
    ('8','Machamp','1,6','130','Super poder','Guts');
    ('9','Lapras','2,5','220','Transporte','Absorbe Agua');
    ('10','Snorlax','2,1','460','Formilon','Impasible');

INSERT into tipo VALUES ('1','Planta');
    ('2','Fuego');
    ('3','Agua');
    ('4','Electrico');
    ('5','Normal');
    ('6','Fantasma');
    ('7','Roca');
    ('8','Lucha');
    ('9','Hielo');
    ('10','Veneno');
INSERT into pokedex VALUES ('1','1');
    ('2','2');
    ('3','3');
    ('4','4');
    ('5','5');
    ('6','6');
    ('7','7');
    ('8','8');
    ('9','3');
    ('9','9');
    ('10','5');
    ('6','10');

SELECT Nombre, Habilidad WHERE Peso >= '100';
SELECT pokemon WHERE Habilidad='Levitacion';
SELECT Nombre, Categoria Where Categoria='Raton';
SELECT Nombre WHERE Peso =<'1.5';
SELECT Nombre WHERE ID_tipo='3';
SELECT tipo WHERE Peso>50 AND Peso<100;
SELECT Nombre WHERE Categoria='Semilla' AND Categoria='Lagarto';
SELECT Peso ORDER BY ASC;
SELECT Peso ORDER BY DESC;
SELECT Tipos WHERE Nombre ='Lapras';
SELECT pokemon ORDER BY ASC;
SELECT pokemon WHERE tipo='Electrico','Normal','Fantasma','Roca','Lucha','Hielo','Veneno';
UPDATE tipo SET='1','Planta','Veneno'

CREATE TABLE Ataques(
    ID_ataque numeric(3)CHECK(ID >= 0) PRIMARY KEY,
    Nombre VARCHAR2(25),
    Tipo_ID numeric(3),
    Potencia numeric(3),
    Presicion numeric(3),
    PP numeric(3),
    Categoria VARCHAR2(20),
);
CREATE TABLE pokemon_ataques (
    ID_pokemon numeric(3)CHECK(ID >= 0) PRIMARY KEY,
    ataque_ID numeric(3),
    nivel numeric(3),
    metodo VARCHAR(15),
), 

INSERT into Ataques VALUES ('1','Lanzallamas','2','90','100','15','Especial');
    ('2','Rayo','3','90','100','15','Especial');
    ('3','Terremoto','4','100','100','10','Fisico',);
    ('4','Danza espada','1','NULL','100','20','Estado',);
    ('5','Surf','3','90','100','15','Especial',);
    ('6','Placaje','1','40','100','35','Fisico',);
    ('7','Rugido','1','NULL','100','20','Estado',);
    ('8','Puño Hielo','5','75','100','15','Fisico',);

INSERT into pokemon_ataques ('2','1','24','Nivel');
    ('2','4','NULL','MT/MO');
    ('3','6','1','Nivel');
    ('3','8','NULL','MT/MO');
    ('3','5','NULL','MT/MO');
    ('4','2','36','Nivel');
    ('4','5','NULL','MT/MO');
    ('4','6','10','Nivel');
    ('4','1','50','Nivel');
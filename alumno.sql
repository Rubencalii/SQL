//Repaso y Segundo 2 trimestre

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


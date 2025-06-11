CREATE TABLE Club(
    CIF CHAR(9) PRIMARY KEY,
    Nombre VARCHAR(40) NOT NULL UNIQUE,
    Sede VARCHAR(30) NOT NULL,
    Num_Socios INTEGER NOT NULL,
    CONSTRAINT NumSociosPositivos CHECK (Num_Socios >= 0)
);

CREATE TABLE Patrocinador(
    CIF CHAR(9) PRIMARY KEY,
    NomPat VARCHAR(20) NOT NULL,
    Rama VARCHAR(20) NOT NULL,
    Eslogan VARCHAR(30) NOT NULL
);

CREATE TABLE Jugador(
    NIF CHAR(9) PRIMARY KEY,
    Altura DECIMAL(3,2) NOT NULL CHECK (Altura > 0),
    CIF CHAR(9) NOT NULL REFERENCES Club(CIF)
);

CREATE TABLE Financia(
    CIF_P CHAR(9) NOT NULL REFERENCES Patrocinador(CIF),
    CIF_C CHAR(9) NOT NULL REFERENCES Club(CIF),
    Cantidad DECIMAL(10,2) NOT NULL CHECK (Cantidad > 0),
    CONSTRAINT PKFinancia PRIMARY KEY (CIF_P, CIF_C)
);

INSERT INTO Club VALUES ('A12345678', 'Real Madrid CF', 'Madrid', 85000);
INSERT INTO Club VALUES ('B98765432', 'FC Barcelona', 'Barcelona', 77000);
INSERT INTO Club VALUES ('C55555555', 'Atlético de Madrid', 'Madrid', 45000);

INSERT INTO Patrocinador VALUES ('P11111111', 'Nike', 'Deportes', 'Just Do It');
INSERT INTO Patrocinador VALUES ('P22222222', 'Emirates', 'Aerolíneas', 'Hello Tomorrow');
INSERT INTO Patrocinador VALUES ('P33333333', 'Spotify', 'Música', 'Music for Everyone');

INSERT INTO Jugador VALUES ('12345678A', 1.89, 'A12345678');
INSERT INTO Jugador VALUES ('23456789B', 1.75, 'A12345678');
INSERT INTO Jugador VALUES ('34567891C', 1.85, 'B98765432');
INSERT INTO Jugador VALUES ('45678912D', 1.82, 'C55555555');

INSERT INTO Financia VALUES ('P11111111', 'A12345678', 5000000.00);
INSERT INTO Financia VALUES ('P22222222', 'A12345678', 3000000.00);
INSERT INTO Financia VALUES ('P33333333', 'B98765432', 4500000.00);
INSERT INTO Financia VALUES ('P11111111', 'C55555555', 2000000.00);

/* Ejercicio 1*/

CREATE OR REPLACE TRIGGER trg_mod_club
AFTER DELETE OR UPDATE ON Club  FOR EACH ROW
DECLARE
BEGIN
  IF DELETING THEN
    INSERT INTO RegistroModificaciones (Modificacion)
    VALUES ('Borrando');
  ELSIF UPDATING THEN
    INSERT INTO RegistroModificaciones (Modificacion)
    VALUES ('Actualizando');
  END IF;
END;

/* Ejercicio 2*/

CREATE OR REPLACE TRIGGER trg_borrar_club
BEFORE DELETE ON Club FOR EACH ROW WHEN (OLD.Num_Socios < 1000)
DECLARE
BEGIN
  INSERT INTO RegistroBorrados (CIF, NumeroSocios)
  VALUES (:OLD.CIF, :OLD.Num_Socios);
END;

/* Ejercicio 3*/

CREATE OR REPLACE TRIGGERS trg_mod_financia BEFORE 
UPDATE OF Cantidad ON Financia FOR EACH ROW
DECLARE
    v_num_jugadores = INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_num_jugadores FROM jugador WHEN CIF = OLD.CIF_C;
        IF v_num_jugadores > 2 THEN :NEW.Cantidad := NEW.Cantidad * 1.25;
        ELSE :NEW.Cantidad := :OLD.Cantidad;
END IF;
END;

/* Ejercicio 4*/

CREATE OR REPLACE TRIGGER trg_club_sospechoso
BEFORE INSERT ON Club FOR EACH ROW
DECLARE
  v_promedio NUMBER;
BEGIN
  -- Calcular el promedio de socios existente
  SELECT AVG(Num_Socios)
  INTO v_promedio
  FROM Club;

  -- Si el promedio es NULL 
  IF v_promedio IS NULL THEN
    v_promedio := 0;
  END IF;

  -- Comparar con el nuevo número de socios
  IF :NEW.Num_Socios >= v_promedio * 2 THEN
    INSERT INTO ClubesSospechosos (CIF, Promedio)
    VALUES (:NEW.CIF, ROUND(v_promedio));
  END IF;
END;

/* Ejercicio 5*/

CREATE OR REPLACE TRIGGER trg_financia_doble
AFTER UPDATE OF Cantidad ON Financia FOR EACH ROW
DECLARE
BEGIN
  IF :NEW.Cantidad > (:OLD.Cantidad * 2) THEN
    UPDATE Patrocinador
        SET Eslogan = 'Financiación extrema'
    WHERE CIF = :OLD.CIF_P;
  END IF;
END;

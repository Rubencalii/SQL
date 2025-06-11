CREATE TABLE Club (
    CIF VARCHAR2(10) PRIMARY KEY,
    Nombre VARCHAR2(50) NOT NULL,
    Sede VARCHAR2(100),
    Num_socios NUMBER
);

CREATE TABLE Persona (
    NIF VARCHAR2(10) PRIMARY KEY,
    Nombre VARCHAR2(50) NOT NULL
);

CREATE TABLE Arbitro (
    NIF VARCHAR2(10) PRIMARY KEY,
    Colegio VARCHAR2(50) NOT NULL,
    Fecha_colegiatura DATE NOT NULL,
    CONSTRAINT fk_arbitro_persona FOREIGN KEY (NIF) 
        REFERENCES Persona(NIF) ON DELETE CASCADE
);

CREATE TABLE Enfrenta (
    CIF_local VARCHAR2(10) NOT NULL,
    CIF_visitante VARCHAR2(10) NOT NULL,
    GolesLocal NUMBER NOT NULL,
    GolesVisitante NUMBER NOT NULL,
    Fecha DATE NOT NULL,
    NIF_arbitro VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_enfrenta PRIMARY KEY (CIF_local, CIF_visitante),
    CONSTRAINT fk_local_club FOREIGN KEY (CIF_local) 
        REFERENCES Club(CIF) ON DELETE CASCADE,
    CONSTRAINT fk_visitante_club FOREIGN KEY (CIF_visitante) 
        REFERENCES Club(CIF) ON DELETE CASCADE,
    CONSTRAINT fk_arbitro FOREIGN KEY (NIF_arbitro) 
        REFERENCES Arbitro(NIF) ON DELETE CASCADE
);

CREATE TABLE Asiste (
    NIF VARCHAR2(10) NOT NULL,
    CIF_local VARCHAR2(10) NOT NULL,
    CIF_visitante VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_asiste PRIMARY KEY (NIF, CIF_local, CIF_visitante),
    CONSTRAINT fk_asiste_persona FOREIGN KEY (NIF) 
        REFERENCES Persona(NIF) ON DELETE CASCADE,
    CONSTRAINT fk_asiste_enfrenta FOREIGN KEY (CIF_local, CIF_visitante) 
        REFERENCES Enfrenta(CIF_local, CIF_visitante) ON DELETE CASCADE
);

CREATE TABLE Patrocinador (
    CIF VARCHAR2(10) PRIMARY KEY,
    NomPat VARCHAR2(50) NOT NULL,
    Rama VARCHAR2(50) NOT NULL,
    Eslogan VARCHAR2(100)
);

CREATE TABLE Financia (
    CIF_P VARCHAR2(10) NOT NULL,
    CIF_C VARCHAR2(10) NOT NULL,
    Cantidad NUMBER(10,2) NOT NULL,
    CONSTRAINT pk_financia PRIMARY KEY (CIF_P, CIF_C),
    CONSTRAINT fk_financia_patrocinador FOREIGN KEY (CIF_P)
        REFERENCES Patrocinador(CIF) ON DELETE CASCADE,
    CONSTRAINT fk_financia_club FOREIGN KEY (CIF_C)
        REFERENCES Club(CIF) ON DELETE CASCADE
);

INSERT INTO Club VALUES ('A111', 'Real Madrid', 'Madrid', 90000);
INSERT INTO Club VALUES ('B222', 'FC Barcelona', 'Barcelona', 85000);
INSERT INTO Club VALUES ('C333', 'Atl�tico Madrid', 'Madrid', 70000);
INSERT INTO Club VALUES ('D444', 'Valencia CF', 'Valencia', 45000);

INSERT INTO Persona VALUES ('111A', 'Carlos Velasco');
INSERT INTO Persona VALUES ('222B', 'Antonio Mateu');
INSERT INTO Persona VALUES ('333C', 'Jos� S�nchez');
INSERT INTO Persona VALUES ('444D', 'Jes�s Gil');
INSERT INTO Persona VALUES ('555E', 'Mar�a P�rez');
INSERT INTO Persona VALUES ('666F', 'Luis Garc�a');
INSERT INTO Persona VALUES ('777G', 'Ana L�pez');
INSERT INTO Persona VALUES ('888H', 'David Ruiz');
INSERT INTO Persona VALUES ('999I', 'Sof�a Mart�n');
INSERT INTO Persona VALUES ('000J', 'Pablo Torres');

INSERT INTO Arbitro VALUES ('111A', 'Madrid', '2010-05-15');
INSERT INTO Arbitro VALUES ('222B', 'Barcelona', '2012-08-22');
INSERT INTO Arbitro VALUES ('333C', 'Madrid', '2015-03-10');
INSERT INTO Arbitro VALUES ('444D', 'Valencia', '2018-11-30');

INSERT INTO Enfrenta VALUES ('A111', 'B222', 3, 1, '2023-09-10', '111A');
INSERT INTO Enfrenta VALUES ('C333', 'D444', 2, 2, '2023-09-10', '222B');

INSERT INTO Enfrenta VALUES ('B222', 'C333', 1, 0, '2023-09-17', '333C');
INSERT INTO Enfrenta VALUES ('D444', 'A111', 0, 4, '2023-09-17', '444D');

INSERT INTO Enfrenta VALUES ('A111', 'C333', 2, 1, '2023-09-24', '111A');
INSERT INTO Enfrenta VALUES ('B222', 'D444', 3, 0, '2023-09-24', '222B');

INSERT INTO Enfrenta VALUES ('D444', 'B222', 1, 1, '2023-10-01', '333C');
INSERT INTO Enfrenta VALUES ('C333', 'A111', 0, 0, '2023-10-01', '444D');

INSERT INTO Enfrenta VALUES ('B222', 'A111', 2, 2, '2023-10-08', '111A');
INSERT INTO Enfrenta VALUES ('D444', 'C333', 1, 3, '2023-10-08', '222B');

INSERT INTO Enfrenta VALUES ('C333', 'B222', 2, 2, '2023-10-15', '333C');
INSERT INTO Enfrenta VALUES ('A111', 'D444', 3, 1, '2023-10-15', '444D');

INSERT INTO Asiste VALUES ('555E', 'A111', 'B222');

INSERT INTO Asiste VALUES ('555E', 'C333', 'D444');
INSERT INTO Asiste VALUES ('666F', 'C333', 'D444');
INSERT INTO Asiste VALUES ('999I', 'C333', 'D444');

INSERT INTO Asiste VALUES ('555E', 'D444', 'A111');
INSERT INTO Asiste VALUES ('666F', 'D444', 'A111');

INSERT INTO Asiste VALUES ('555E', 'A111', 'C333');
INSERT INTO Asiste VALUES ('666F', 'A111', 'C333');
INSERT INTO Asiste VALUES ('999I', 'A111', 'C333');
INSERT INTO Asiste VALUES ('000J', 'A111', 'C333');

INSERT INTO Asiste VALUES ('777G', 'B222', 'D444');
INSERT INTO Asiste VALUES ('888H', 'B222', 'D444');
INSERT INTO Asiste VALUES ('999I', 'B222', 'D444');

INSERT INTO Asiste VALUES ('555E', 'D444', 'B222');

INSERT INTO Asiste VALUES ('555E', 'B222', 'A111');
INSERT INTO Asiste VALUES ('666F', 'B222', 'A111');
INSERT INTO Asiste VALUES ('777G', 'B222', 'A111');
INSERT INTO Asiste VALUES ('888H', 'B222', 'A111');

INSERT INTO Asiste VALUES ('555E', 'D444', 'C333');
INSERT INTO Asiste VALUES ('666F', 'D444', 'C333');

INSERT INTO Asiste VALUES ('555E', 'C333', 'B222');
INSERT INTO Asiste VALUES ('666F', 'C333', 'B222');
INSERT INTO Asiste VALUES ('777G', 'C333', 'B222');
INSERT INTO Asiste VALUES ('888H', 'C333', 'B222');

INSERT INTO Patrocinador VALUES ('P001', 'Nike', 'Deportes', 'Just Do It');
INSERT INTO Patrocinador VALUES ('P002', 'Adidas', 'Deportes', 'Impossible is Nothing');
INSERT INTO Patrocinador VALUES ('P003', 'Fly Emirates', 'Aerol�neas', 'Hello Tomorrow');
INSERT INTO Patrocinador VALUES ('P004', 'Pepsi', 'Bebidas', 'Live For Now');
INSERT INTO Patrocinador VALUES ('P005', 'Santander', 'Banca', 'Contigo, el futuro es Santander');

INSERT INTO Financia VALUES ('P001', 'A111', 5000000);
INSERT INTO Financia VALUES ('P001', 'B222', 4500000);
INSERT INTO Financia VALUES ('P001', 'C333', 3000000);
INSERT INTO Financia VALUES ('P001', 'D444', 1500000);

INSERT INTO Financia VALUES ('P002', 'B222', 7000000);
INSERT INTO Financia VALUES ('P002', 'C333', 4000000);

INSERT INTO Financia VALUES ('P003', 'A111', 8000000);
INSERT INTO Financia VALUES ('P003', 'D444', 2000000);
INSERT INTO Financia VALUES ('P003', 'B222', 3500000);

INSERT INTO Financia VALUES ('P004', 'A111', 2500000);
INSERT INTO Financia VALUES ('P004', 'D444', 1800000);

INSERT INTO Financia VALUES ('P005', 'A111', 4200000);
INSERT INTO Financia VALUES ('P005', 'B222', 3800000);
INSERT INTO Financia VALUES ('P005', 'C333', 3200000);
INSERT INTO Financia VALUES ('P005', 'D444', 2900000);

/*Triggers */

/*Ejercicio 1*/

-- Alterar tabla club
ALTER TABLE Club ADD(PJ NUMBER DEFAULT 0)
ALTER TABLE Club ADD(PG NUMBER DEFAULT 0)
ALTER TABLE Club ADD(PE NUMBER DEFAULT 0)
ALTER TABLE Club ADD(PP NUMBER DEFAULT 0)

CREATE OR REPLACE TRIGGER trg_actualiza_partidos 
AFTER INSERT ON enfrenta FOR EACH ROW
DECLARE
    -- Partidos jugados
    UPDATE Club SET PJ = PJ + 1
        WHERE CIF = :NEW.CIF_local;
    UPDATE Club SET PJ = PJ + 1
        WHERE CIF F= :NEW.CIF_visitante;
    
    -- Ganados, empatados, perdidos
    IF :NEW.GolesLocal > :NEW.GolesVisitante THEN
        UPDATE Club SET PG = PG + 1
            WHERE CIF = NEW.CIF_local;
        UPDATE Club SET PP = pp + 1
            WHERE CIF = NEW.CIF_visitante;
    ELSIF :NEW.GolesLocal < :NEW.GolesVisitante THEN
        UPDATE Club SET PG = PG + 1
            WHERE CIF = :NEW.CIF_local;
    ELSE
        UPDATE Club SET PE = PE + 1
            WHERE CIF = NEW.CIF_local;
        UPDATE Club SET PE = PE + 1
            WHERE CIF = :NEW.CIF_visitante;
    END IF;
END;

/*Ejercicio 2*/

CREATE OR REPLACE TRIGGER trg_validar_arbitro
BEFORE UPDATE OF NIF_arbitro ON Enfrenta FOR EACCH ROW
DECLARE
    v_sede CLUB.Sede%TYPE;
    v_colegio Arbitro.Colegio&TYPE;
BEGIN
    SELECT Sede INTO v_sede FROM Club 
    WHERE CIF = :OLD.CIF_local;
    
    SELECT Colegio INTO v_colegio FROM Arbitro 
    WHERE NIF = :NEW.NIF_arbitro;
    
    IF v_sede <> v_colegio THEN
    DBMS_OUTPUT.PUT_LINE(-20001, 'El arbitro debe ser del mismo colegio que la sede del club local')
    END IF
END;

/*Ejercicio 3 */

-- Crear la tabla intentos_patrocinio

CREATE TABLE intentos_patrocinio(
    id NUMBER PRIMARY KEY,
    fecha_intento DATE DEFAULT SYSDATE,
    motivo VARCHAR2(100)
);

CREATE OR REPLACE TRIGGER trg_limite_patrocinadores
BEFORE INSET ON Financia FOR EACH ROW
DECLARE
    v_total NUMBER;
    v_id NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_total 
    FROM Financia WHERE CIF_C = :NEW.CIF_C;
    
    IF v_total >= 4 THEN 
        SELECT NVL(MAX(id), 0) + + 1 
        INTO v_id FROM intentos_patrocinio;
        
        INSERT INTO intentos_patrocinio(id, motivo)
        VALUES(v_id, 'Demasiados patrocinadores para el club');
        DBMS_OUTPUT.PUT_LINE(-20002, 'No se puede tener mas de 4 patrocinadores por club');
    END IF;
END;



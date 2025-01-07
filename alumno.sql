//Practica  2 trimestre

CREATE TABLE coche{
    matricula varchar(10);
    modelo varchar(15);
    marca varchar(15);
    color varchar(15);
}
CREATE TABLE persona{
    ID_persona numeric(3,0);
    nombre varchar(25);
    telefono numeric(10);
}
CREATE TABLE dueños{
    matricula int matricula_coche;
    persona date ID_persona;
    f_inicio numeric(8);
    f_fin numeric(8);
}
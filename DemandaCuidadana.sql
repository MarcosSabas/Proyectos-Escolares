CREATE DATABASE DemandaCiudadana 
ON 
PRIMARY 
(
NAME = DemandaCiudadana_Data, 
FILENAME='D:\Data\DemandaCiudadana_Data.mdf', 
SIZE =10MB,
MAXSIZE = 40MB, 
FILEGROWTH = 5MB 
),
FILEGROUP DemandaCiudadana_FG1 
(
name = DemandaCiudadana_Data_FG1, 
FILENAME='D:\Data\DemandaCiudadana_Data_FG1.ndf', 
SIZE = 10MB, 
MAXSIZE = 40MB, 
FILEGROWTH = 5MB
) 
LOG ON 
(
NAME = DemandaCiudadana_Log, 
FILENAME='D:\Data\DemandaCiudadana_Log.ldf', 
SIZE = 5MB, 
MAXSIZE = 40MB, 
FILEGROWTH = 5MB
);

create table Dependencia 
( 
id_dependencia INT PRIMARY KEY IDENTITY(1,1), 
unid_adm NVARCHAR(50), 
puesto_adm NVARCHAR(50), 
direccion NVARCHAR(50), 
area NVARCHAR(50)
);

CREATE TABLE procedencia 
( 
id_procedencia INT PRIMARY KEY IDENTITY(1,1), 
preceden_dia NVARCHAR(100) 
);

CREATE TABLE servidor_publico 
(
id_servidorpublico INT PRIMARY KEY IDENTITY(1,1), 
servidor_titular NVARCHAR(100), 
nombre NVARCHAR(100), 
dependencia NVARCHAR(100), 
cargo NVARCHAR(100), 
domicilio NVARCHAR(200), 
telefono NVARCHAR(20)
);

CREATE TABLE tiempo 
(
id_tiempo INT PRIMARY KEY IDENTITY(1,1), 
tiempo_respuesta NVARCHAR(50) 
);

CREATE TABLE tipo_apoyo 
( 
id_apoyo INT PRIMARY KEY IDENTITY(1,1), 
tiemporrespuesta NVARCHAR(50), 
titularedadmn NVARCHAR(100) 
);

CREATE TABLE estatus_demanda 
(
id_estatusdemanda INT PRIMARY KEY IDENTITY(1,1), 
opc_statusdep NVARCHAR(50) 
);

CREATE TABLE prioridad 
(
id_prioridad INT PRIMARY KEY IDENTITY(1,1), 
priori_dad NVARCHAR(50) 
);

CREATE TABLE colonia 
(
id_colonia INT PRIMARY KEY IDENTITY(1,1), 
nombre NVARCHAR(100) 
);

CREATE TABLE sub_apoyo 
(
id_subapoyo INT PRIMARY KEY IDENTITY(1,1), 
nombre NVARCHAR(100) 
);

CREATE TABLE tipo_usuario 
( 
id_tipousuario INT PRIMARY KEY IDENTITY(1,1), 
tipouser NVARCHAR(50) 
);

create table usuario 
(
id_usuario int identity (1,1) not null constraint pk_clave primary key, 
nombre_usuario nvarchar (50) not null, 
apellido1 nvarchar(50) not null, 
apellido2 nvarchar(50), 
email nvarchar(50) 
not null, 
telefono nvarchar(15), 
contraseña nvarchar(50), 
tipousuario int, 
respuesta nvarchar(50),
estatus nvarchar(50), 
foreign key (tipousuario) references tipo_usuario (id_tipousuario)
);

CREATE TABLE DemandaCiudadana ( 
id_demandaciudadana int primary key identity (1,1), 
usuario int, 
subapoyo int, 
tipoapoyo int, 
colonia int, 
tiempo int, 
tipousuario int, 
dependencia int, 
estatusdemanda int, 
prioridad int, 
procedencia int, 
servidorpublico int, 
foreign key (usuario) references usuario (id_usuario), 
foreign key (subapoyo) references sub_apoyo (id_subapoyo), 
foreign key (tipoapoyo) references tipo_apoyo (id_apoyo), 
foreign key (colonia) references colonia (id_colonia), 
foreign key (tiempo) references tiempo (id_tiempo), 
foreign key (tipousuario) references tipo_usuario (id_tipousuario), 
foreign key (dependencia) references dependencia (id_dependencia), 
foreign key (estatusdemanda) references estatus_demanda (id_estatusdemanda), 
foreign key (prioridad) references prioridad (id_prioridad), 
foreign key (procedencia) references procedencia (id_procedencia), 
foreign key (servidorpublico) references servidor_publico (id_servidorpublico)
);
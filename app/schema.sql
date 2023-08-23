CREATE DATABASE IF NOT EXISTS promanager;
USE promanager;

CREATE TABLE IF NOT EXISTS proyecto(
    ID_proyecto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL DEFAULT 'not_named',
    descripcion TINYTEXT,
    es_publico BOOLEAN NOT NULL DEFAULT false,
    activo BOOLEAN NOT NULL DEFAULT true,
    presupuesto INT NOT NULL DEFAULT -1,
    fecha_inicio DATE NOT NULL DEFAULT (CURRENT_DATE()),
    fecha_finalizacion DATE NOT NULL DEFAULT '1000-01-01'
);

CREATE TABLE IF NOT EXISTS usuario(
    ID_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL DEFAULT 'no_name',
    apellido VARCHAR(60) NOT NULL DEFAULT 'no_surname',
    mail VARCHAR(320) UNIQUE NOT NULL,
    contraseña VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS prefijo_telefono (
    ID_prefijo INT AUTO_INCREMENT PRIMARY KEY,
    prefijo VARCHAR(8) UNIQUE NOT NULL,
    pais VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS numero_telefono (
    ID_telefono INT AUTO_INCREMENT PRIMARY KEY,
    ID_usuario INT NOT NULL,
    ID_prefijo INT NOT NULL,
    telefono VARCHAR(30),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(ID_usuario),
    FOREIGN KEY (ID_prefijo) REFERENCES prefijo_telefono(ID_prefijo)
);

CREATE TABLE IF NOT EXISTS roles_proyecto (
    ID_rol_proyecto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS detalle_proyecto(
    ID_detalle_proyecto INT AUTO_INCREMENT PRIMARY KEY,
    ID_proyecto INT NOT NULL,    /*FORANEA*/
    ID_usuario INT NOT NULL, /*FORANEA*/
    rol INT NOT NULL, /*FORANEA*/
    fecha_inicio_participacion DATE NOT NULL DEFAULT (CURRENT_DATE()),
    fecha_baja DATE NOT NULL DEFAULT '1000-01-01', 
    suspendido BOOLEAN NOT NULL DEFAULT false,
    FOREIGN KEY (ID_proyecto) REFERENCES proyecto(ID_proyecto),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(ID_usuario),
    FOREIGN KEY (rol) REFERENCES roles_proyecto(ID_rol_proyecto),
    CONSTRAINT integrante_proyecto UNIQUE (ID_proyecto, ID_usuario)
);

CREATE TABLE IF NOT EXISTS equipo(
    ID_equipo INT AUTO_INCREMENT PRIMARY KEY,
    ID_proyecto INT NOT NULL,    /*FORANEA*/
    nombre VARCHAR(60) NOT NULL DEFAULT 'not_named',
    fecha_creacion DATE NOT NULL DEFAULT (CURRENT_DATE()),
    FOREIGN KEY (ID_proyecto) REFERENCES proyecto(ID_proyecto)
);

CREATE TABLE IF NOT EXISTS roles_equipo (
    ID_rol_equipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS detalle_equipo(
    ID_detalle_equipo INT AUTO_INCREMENT PRIMARY KEY,
    ID_equipo INT NOT NULL,  /*FORANEA*/
    ID_usuario INT NOT NULL, /*FORANEA*/
    rol INT NOT NULL,
    fecha_inicio_participacion DATE NOT NULL DEFAULT (CURRENT_DATE()),
    fecha_baja DATE NOT NULL DEFAULT '1000-01-01',
    suspendido BOOLEAN NOT NULL DEFAULT false,
    FOREIGN KEY (ID_equipo) REFERENCES equipo(ID_equipo),
    FOREIGN KEY (ID_usuario) REFERENCES usuario(ID_usuario),
    FOREIGN KEY (rol) REFERENCES roles_equipo(ID_rol_equipo),
    CONSTRAINT integrante_equipo UNIQUE (ID_equipo, ID_usuario)
);

CREATE TABLE IF NOT EXISTS estado(
    ID_estado INT AUTO_INCREMENT PRIMARY KEY,
    nombre_estado VARCHAR(25) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS hito(
    ID_hito INT AUTO_INCREMENT PRIMARY KEY,
    ID_proyecto INT NOT NULL,    /*FORANEA*/
    nombre VARCHAR(60) NOT NULL DEFAULT 'not_named',
    estado INT NOT NULL,
    descripcion TINYTEXT,
    progreso DECIMAL(4,2) NOT NULL DEFAULT 0,
    fecha_creacion DATE NOT NULL DEFAULT (CURRENT_DATE()),
    fecha_limite DATE NOT NULL DEFAULT '1000-01-01',
    fecha_finalizacion DATE NOT NULL DEFAULT '1000-01-01',
    FOREIGN KEY (ID_proyecto) REFERENCES proyecto(ID_proyecto),
    FOREIGN KEY (estado) REFERENCES estado(ID_estado)
);

CREATE TABLE IF NOT EXISTS ticket(
    ID_ticket INT AUTO_INCREMENT PRIMARY KEY,
    ID_hito INT NOT NULL,    /*FORANEA*/
    ID_usuario INT NOT NULL, /*FORANEA*/
    nombre VARCHAR(60) NOT NULL DEFAULT 'not_named',
    estado INT NOT NULL,
    descripcion TINYTEXT,
    fecha_creacion DATE NOT NULL DEFAULT (CURRENT_DATE()),
    fecha_asignacion DATE NOT NULL DEFAULT '1000-01-01',
    fecha_limite DATE NOT NULL DEFAULT '1000-01-01',
    fecha_finalizacion DATE NOT NULL DEFAULT '1000-01-01',
    FOREIGN KEY (ID_usuario) REFERENCES usuario(ID_usuario),
    FOREIGN KEY (ID_hito) REFERENCES hito(ID_hito),
    FOREIGN KEY (estado) REFERENCES estado(ID_estado)
);

CREATE TABLE IF NOT EXISTS unidad_trabajo(
    ID_unidad_trabajo INT AUTO_INCREMENT PRIMARY KEY,
    ID_proyecto INT NOT NULL, /*FORANEA*/
    ID_equipo INT NOT NULL,  /*FORANEA*/
    ID_hito INT NOT NULL,    /*FORANEA*/
    fecha_creacion DATE NOT NULL DEFAULT (CURRENT_DATE()),
    fecha_asignacion DATE NOT NULL DEFAULT '1000-01-01',
    fecha_limite DATE NOT NULL DEFAULT '1000-01-01',
    fecha_finalizacion DATE NOT NULL DEFAULT '1000-01-01',
    FOREIGN KEY (ID_proyecto) REFERENCES proyecto(ID_proyecto),
    FOREIGN KEY (ID_equipo) REFERENCES equipo(ID_equipo),
    FOREIGN KEY (ID_hito) REFERENCES hito(ID_hito),
    CONSTRAINT unidad_equipo_hito UNIQUE (ID_equipo, ID_hito)
);
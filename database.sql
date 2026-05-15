CREATE TABLE raza (
    id_raza SERIAL PRIMARY KEY,
    nombre_raza VARCHAR(50) NOT NULL,
    id_especie INT NOT NULL,
    
    CONSTRAINT fk_raza_especie
        FOREIGN KEY (id_especie)
        REFERENCES especie(id_especie)
);
CREATE TABLE ciudad (
    id_ciudad SERIAL PRIMARY KEY,
    nombre_ciudad VARCHAR(100) NOT NULL,
    codigo_ubigeo VARCHAR(10)
);
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    dni VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(255),
    id_ciudad INT NOT NULL,

    CONSTRAINT fk_cliente_ciudad
        FOREIGN KEY (id_ciudad)
        REFERENCES ciudad(id_ciudad)
);
CREATE TABLE especie (
    id_especie SERIAL PRIMARY KEY,
    nombre_especie VARCHAR(50) NOT NULL,
    descripcion TEXT
);

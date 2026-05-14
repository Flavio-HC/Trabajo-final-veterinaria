CREATE TABLE raza (
    id_raza SERIAL PRIMARY KEY,
    nombre_raza VARCHAR(50) NOT NULL,
    id_especie INT NOT NULL,
    
    CONSTRAINT fk_raza_especie
        FOREIGN KEY (id_especie)
        REFERENCES especie(id_especie)
);

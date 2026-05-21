INSERT INTO especie (nombre_especie, descripcion) VALUES
('Perro', 'Caninos domésticos'),
('Gato', 'Felinos domésticos'),
('Conejo', 'Mamíferos pequeños'),
('Ave', 'Aves domésticas'),
('Hamster', 'Roedores pequeños');

INSERT INTO raza (nombre_raza, id_especie) VALUES
('Labrador', 1),
('Pastor Alemán', 1),
('Siamés', 2),
('Persa', 2),
('Conejo Enano', 3);
INSERT INTO ciudad (nombre_ciudad, codigo_ubigeo) VALUES
('Arequipa', '040101'),('Lima', '150101'),('Cusco', '080101'),('Tacna', '230101'),('Trujillo', '130101');
INSERT INTO cliente (dni, nombre, apellidos, telefono, direccion, id_ciudad) VALUES
('12345678', 'Juan', 'Pérez', '987654321', 'Av. Perú 123', 1) , ('23456789', 'Lucía', 'Gómez', '987654322', 'Calle Lima 456', 2) , ('34567890', 'Pedro', 'Ramírez', '987654323', 'Jr. Sol 789', 3) , ('45678901', 'María', 'Fernández', '987654324', 'Av. Grau 321', 4) , ('56789012', 'José', 'Torres', '987654325', 'Calle Norte 654', 5);

INSERT INTO mascota (nombre, fecha_nacimiento, genero, estado, id_cliente, id_raza) VALUES
('Max', '2021-05-10', 'Macho', 'Activo', 1, 1), ('Luna', '2020-03-15', 'Hembra', 'Activo', 2, 3), ('Rocky', '2019-07-20', 'Macho', 'En tratamiento', 3, 2), ('Mishi', '2022-01-11', 'Hembra', 'Activo', 4, 4), ('Bunny', '2023-02-18', 'Macho', 'Activo', 5, 5);

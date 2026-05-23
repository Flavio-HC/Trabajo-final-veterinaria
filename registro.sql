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

-TABLA VETERINARIO
INSERT INTO veterinario (nombre, colegiatura, especialidad, turno) VALUES
('Carlos Gomez', 'COL001', 'Cirugía', 'Mañana'),
('Pedro Torres', 'COL002', 'Dermatología', 'Tarde'),
('Luis Ramos', 'COL003', 'Odontología', 'Noche'),
('Maria Paredes', 'COL004', 'Medicina General', 'Mañana'),
('Jose Quispe', 'COL005', 'Cardiología', 'Tarde')
-TABLA MEDICAMENTO
INSERT INTO medicamento (nombre, stock, precio_unitario, fecha_vencimiento) VALUES
('Paracetamol Vet', 50, 12.50, '2027-01-10'),
('Antibiótico Can', 30, 25.00, '2026-12-15'),
('Vitaminas Pet', 100, 8.90, '2028-05-20'),
('Vacuna Triple', 40, 45.00, '2027-08-11'),
('Desparasitante', 60, 15.75, '2026-11-30');
-TABLA SERVICIO
INSERT INTO servicio (nombre, precio, descripcion) VALUES
('Baño', 50.00, 'Baño y limpieza'),
('Vacunación', 50.00, 'Aplicación de vacunas'),
('Consulta General', 50.00, 'Chequeo médico'),
('Cirugía', 250.00, 'Intervención quirurgica'),
('Desparasitación', 50.00, 'Control de parásitos');

INSERT INTO cita (fecha, hora, estado, motivo, id_mascota, id_veterinario) VALUES
('2026-05-25', '09:00:00', 'Programada', 'Vacunación anual de Max', 1, 4),
('2026-05-25', '10:30:00', 'Programada', 'Revisión dermatológica de Luna', 2, 2),
('2026-05-26', '11:00:00', 'Atendida', 'Dolor en la pata de Rocky', 3, 1),
('2026-05-26', '15:00:00', 'Programada', 'Chequeo general de Mishi', 4, 4),
('2026-05-27', '16:30:00', 'Programada', 'Desparasitación de Bunny', 5, 5);

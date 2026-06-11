-- INDICES PARA EL SISTEMA DE GESTION VETERINARIA
-- 1.Indice para busqueda rapida por DNI
-- Justificacion: Permite encontrar clientes rapidamente por su documento
CREATE INDEX idx_cliente_dni ON cliente(dni);

-- 2.Indice para listar mascotas de un cliente
-- Justificacion: Optimiza la consulta que muestra todas las mascotas de un dueño
CREATE INDEX idx_mascota_id_cliente ON mascota(id_cliente);

-- 3.Indice para el historial clinico (JOIN con cita)
-- Justificacion: Mejora la velocidad al buscar citas de una mascota especifica.
CREATE INDEX idx_cita_id_mascota ON cita(id_mascota);

-- 4.Indice para el historial clinico (JOIN con consulta).
-- Justificacion: Optimiza la relacion entre citas y consultas
CREATE INDEX idx_consulta_id_cita ON consulta(id_cita);

-- 5.Indice para el historial clinico (JOIN con diagnostico)
-- Justificacion: Acelera la obtencion de diagnosticos por consulta
CREATE INDEX idx_diagnostico_id_consulta ON diagnostico(id_consulta);

-- 6.Indice para reportes mensuales por fecha
-- Justificacion: Filtra rapidamente citas por rango de fechas (reportes).
CREATE INDEX idx_cita_fecha ON cita(fecha);

-- 7.Indice para verificar pagos pendientes
-- Justificacion: Permitee consultar rapido si un cliente tiene deudas
CREATE INDEX idx_pago_id_cliente ON pago(id_cliente);

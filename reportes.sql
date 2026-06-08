-- REPORTE 1
-- Veterinarios con cantidad de citas atendidas
SELECT
    v.nombre,
    v.especialidad,
    COUNT(c.id_cita) AS total_citas
FROM veterinario v
INNER JOIN cita c
ON v.id_veterinario = c.id_veterinario
GROUP BY v.id_veterinario, v.nombre, v.especialidad
HAVING COUNT(c.id_cita) >= 1
ORDER BY total_citas DESC;

-- REPORTE 2
-- Cantidad de clientes registrados por ciudad
SELECT
    ci.nombre_ciudad,
    COUNT(cl.id_cliente) AS total_clientes
FROM ciudad ci
INNER JOIN cliente cl
    ON ci.id_ciudad = cl.id_ciudad
GROUP BY ci.id_ciudad, ci.nombre_ciudad
HAVING COUNT(cl.id_cliente) >= 1
ORDER BY total_clientes DESC;

-- REPORTE 3
-- Cantidad de mascotas agrupadas por especie
SELECT
    e.nombre_especie,
    COUNT(m.id_mascota) AS total_mascotas
FROM especie e
INNER JOIN raza r
    ON e.id_especie = r.id_especie
INNER JOIN mascota m
    ON r.id_raza = m.id_raza
GROUP BY e.id_especie, e.nombre_especie
HAVING COUNT(m.id_mascota) >= 1
ORDER BY total_mascotas DESC;

-- REPORTE 4
-- Cantidad de diagnósticos según gravedad
SELECT
    gravedad,
    COUNT(id_diagnostico) AS total_diagnosticos
FROM diagnostico
GROUP BY gravedad
HAVING COUNT(id_diagnostico) >= 1
ORDER BY total_diagnosticos DESC;

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

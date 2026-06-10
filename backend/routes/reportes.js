const express = require('express');
const router = express.Router();
const pool = require('../db');

router.get('/veterinarios', async (req, res) => {

    const query = `
        SELECT
            v.nombre,
            v.especialidad,
            COUNT(c.id_cita) AS total_citas
        FROM veterinario v
        JOIN cita c
            ON v.id_veterinario = c.id_veterinario
        GROUP BY v.id_veterinario, v.nombre, v.especialidad
        HAVING COUNT(c.id_cita) >= 1
        ORDER BY total_citas DESC;
    `;

    try {
        const result = await pool.query(query);
        res.json(result.rows);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error al obtener reporte' });
    }
});

router.get('/clientes-ciudad', async (req, res) => {

    const query = `
        SELECT
            ci.nombre_ciudad,
            COUNT(cl.id_cliente) AS total_clientes
        FROM ciudad ci
        INNER JOIN cliente cl
            ON ci.id_ciudad = cl.id_ciudad
        GROUP BY ci.id_ciudad, ci.nombre_ciudad
        HAVING COUNT(cl.id_cliente) >= 1
        ORDER BY total_clientes DESC;
    `;

    try {
        const result = await pool.query(query);
        res.json(result.rows);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error al obtener reporte' });
    }
});

module.exports = router;

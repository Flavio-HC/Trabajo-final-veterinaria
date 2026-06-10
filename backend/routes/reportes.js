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

module.exports = router;

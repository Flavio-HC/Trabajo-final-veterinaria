const express = require('express');
const router = express.Router();
const pool = require('../db');
const { Parser } = require('json2csv');

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
        res.status(500).json({ error: error.message });
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

router.get('/mascotas-especie', async (req, res) => {

    const query = `
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
    `;

    try {
        const result = await pool.query(query);
        res.json(result.rows);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error al obtener reporte' });
    }
});

router.get('/diagnosticos-gravedad', async (req, res) => {

    const query = `
        SELECT
            gravedad,
            COUNT(id_diagnostico) AS total_diagnosticos
        FROM diagnostico
        GROUP BY gravedad
        HAVING COUNT(id_diagnostico) >= 1
        ORDER BY total_diagnosticos DESC;
    `;

    try {
        const result = await pool.query(query);
        res.json(result.rows);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error al obtener reporte' });
    }
});

router.get('/veterinarios-csv', async (req, res) => {

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

        const parser = new Parser();
        const csv = parser.parse(result.rows);

        res.header('Content-Type', 'text/csv');
        res.attachment('reporte_veterinarios.csv');

        return res.send(csv);

    } catch (error) {
        console.error(error);
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;

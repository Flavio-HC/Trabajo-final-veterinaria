const express = require('express');
const router = express.Router();
const pool = require('../db');
 
// 

router.post('/consulta-completa', async (req, res) => {
    const {
        fecha_cita,
        hora_cita,
        motivo,
        id_mascota,
        id_veterinario,
       
        constantes,
        observaciones,
        
        descripcion_diagnostico,
        gravedad,
     
        descripcion_tratamiento,
        duracion_tratamiento
    } = req.body;
 
    const client = await pool.connect();
 
    try {
        await client.query('BEGIN');
 
        const citaResult = await client.query(
            `INSERT INTO cita (fecha, hora, estado, motivo, id_mascota, id_veterinario)
             VALUES ($1, $2, 'Completada', $3, $4, $5)
             RETURNING id_cita`,
            [fecha_cita, hora_cita, motivo, id_mascota, id_veterinario]
        );
        const id_cita = citaResult.rows[0].id_cita;
 
        const consultaResult = await client.query(
            `INSERT INTO consulta (fecha, constantes, observaciones, id_cita)
             VALUES ($1, $2, $3, $4)
             RETURNING id_consulta`,
            [fecha_cita, constantes, observaciones, id_cita]
        );
        const id_consulta = consultaResult.rows[0].id_consulta;
 
        const diagnosticoResult = await client.query(
            `INSERT INTO diagnostico (descripcion, gravedad, fecha, id_consulta)
             VALUES ($1, $2, $3, $4)
             RETURNING id_diagnostico`,
            [descripcion_diagnostico, gravedad, fecha_cita, id_consulta]
        );
        const id_diagnostico = diagnosticoResult.rows[0].id_diagnostico;
 
        await client.query(
            `INSERT INTO tratamiento (descripcion, duracion, estado, id_diagnostico)
             VALUES ($1, $2, 'En curso', $3)`,
            [descripcion_tratamiento, duracion_tratamiento, id_diagnostico]
        );
 
        await client.query('COMMIT');
 
        res.status(201).json({
            mensaje: 'Consulta completa registrada exitosamente',
            id_cita,
            id_consulta,
            id_diagnostico
        });
 
    } catch (error) {
        await client.query('ROLLBACK');
        console.error(error);
        res.status(500).json({ error: error.message });
    } finally {
        client.release();
    }
});
 
// 

router.put('/cita/:id/estado', async (req, res) => {
    const { id } = req.params;
    const { estado, constantes, observaciones } = req.body;
 
    const estadosValidos = ['Agendada', 'Completada', 'Cancelada', 'En Espera'];
    if (!estadosValidos.includes(estado)) {
        return res.status(400).json({ error: `Estado inválido. Debe ser uno de: ${estadosValidos.join(', ')}` });
    }
 
    const client = await pool.connect();
 
    try {
        await client.query('BEGIN');
 
        const citaExiste = await client.query(
            `SELECT c.id_cita, c.fecha, m.nombre AS nombre_mascota
             FROM cita c
             JOIN mascota m ON c.id_mascota = m.id_mascota
             WHERE c.id_cita = $1`,
            [id]
        );
 
        if (citaExiste.rows.length === 0) {
            await client.query('ROLLBACK');
            return res.status(404).json({ error: 'Cita no encontrada' });
        }
 
        const cita = citaExiste.rows[0];
 
        await client.query(
            `UPDATE cita SET estado = $1 WHERE id_cita = $2`,
            [estado, id]
        );
 
        let id_consulta = null;
 
        if (estado === 'Completada') {
            const consultaResult = await client.query(
                `INSERT INTO consulta (fecha, constantes, observaciones, id_cita)
                 VALUES ($1, $2, $3, $4)
                 RETURNING id_consulta`,
                [cita.fecha, constantes || null, observaciones || null, id]
            );
            id_consulta = consultaResult.rows[0].id_consulta;
        }
 
        await client.query('COMMIT');
 
        res.json({
            mensaje: `Estado de cita actualizado a '${estado}'`,
            id_cita: parseInt(id),
            mascota: cita.nombre_mascota,
            id_consulta
        });
 
    } catch (error) {
        await client.query('ROLLBACK');
        console.error(error);
        res.status(500).json({ error: error.message });
    } finally {
        client.release();
    }
});
 
// 

router.delete('/mascota/:id', async (req, res) => {
    const { id } = req.params;
 
    const client = await pool.connect();
 
    try {
        await client.query('BEGIN');
 
        const mascotaExiste = await client.query(
            `SELECT id_mascota, nombre FROM mascota WHERE id_mascota = $1`,
            [id]
        );
 
        if (mascotaExiste.rows.length === 0) {
            await client.query('ROLLBACK');
            return res.status(404).json({ error: 'Mascota no encontrada' });
        }
        const nombre_mascota = mascotaExiste.rows[0].nombre;
 
        const consultas = await client.query(
            `SELECT co.id_consulta
             FROM consulta co
             JOIN cita ci ON co.id_cita = ci.id_cita
             WHERE ci.id_mascota = $1`,
            [id]
        );
 
        const idsConsultas = consultas.rows.map(r => r.id_consulta);
 
        if (idsConsultas.length > 0) {
            const diagnosticos = await client.query(
                `SELECT id_diagnostico FROM diagnostico WHERE id_consulta = ANY($1)`,
                [idsConsultas]
            );
            const idsDiagnosticos = diagnosticos.rows.map(r => r.id_diagnostico);
 
            if (idsDiagnosticos.length > 0) {
                await client.query(
                    `DELETE FROM receta WHERE id_tratamiento IN (
                        SELECT id_tratamiento FROM tratamiento WHERE id_diagnostico = ANY($1)
                    )`,
                    [idsDiagnosticos]
                );
                await client.query(
                    `DELETE FROM tratamiento WHERE id_diagnostico = ANY($1)`,
                    [idsDiagnosticos]
                );
                await client.query(
                    `DELETE FROM diagnostico WHERE id_consulta = ANY($1)`,
                    [idsConsultas]
                );
            }
            await client.query(
                `DELETE FROM det_cons_serv WHERE id_consulta = ANY($1)`,
                [idsConsultas]
            );
 
            await client.query(
                `DELETE FROM detalle_pago WHERE id_consulta = ANY($1)`,
                [idsConsultas]
            );
 
            await client.query(
                `DELETE FROM consulta WHERE id_consulta = ANY($1)`,
                [idsConsultas]
            );
        }
 
        await client.query(`DELETE FROM cita WHERE id_mascota = $1`, [id]);
 
        await client.query(`DELETE FROM mascota WHERE id_mascota = $1`, [id]);
 
        await client.query('COMMIT');
 
        res.json({
            mensaje: `Mascota '${nombre_mascota}' y todos sus registros eliminados correctamente`,
            id_mascota: parseInt(id)
        });
 
    } catch (error) {
        await client.query('ROLLBACK');
        console.error(error);
        res.status(500).json({ error: error.message });
    } finally {
        client.release();
    }
});
module.exports = router;
 
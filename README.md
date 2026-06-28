# Trabajo-final-veterinaria
Github Trabajo para base de datos.

--- 

#**Integrantes**

- Flavio Hancco Chaiña (Flavio-HC)
- Jhossue Jheremy Miguel Miguel Garcia (imoshu)
- Gadiel González Pamo(Ultrones09)
- Julio Gómez Vilca (ggarux)

Se trabajaron 16 entidades en el proyecto

---

# Tecnologías utilizadas

- Node.js
- Express
- PostgreSQL
- pg (node-postgres)
- Git + GitHub

---

# Instalación del proyecto

## 1. Clonar repositorio
git clone <URL-del-repo>

## 2. Entrar al proyecto
cd backend

## 3. Instalar dependencias
npm install

## 4. Crear base de datos
CREATE DATABASE veterinaria;

## 5. Ejecutar script SQL
psql -U postgres -d veterinaria -f database.sql

## 6. Iniciar servidor
npm start

---
# Endpoints del Sistema

## Reportes principales

El backend implementa endpoints REST para la generación de reportes utilizando consultas SQL sobre PostgreSQL.

### Reportes disponibles

| Método | Endpoint | Descripción |
|---------|----------|-------------|
| GET | `/reportes/veterinarios` | Reporte de veterinarios con cantidad de citas atendidas. |
| GET | `/reportes/clientes-ciudad` | Reporte de clientes agrupados por ciudad. |
| GET | `/reportes/mascotas-especie` | Reporte de mascotas agrupadas por especie. |
| GET | `/reportes/diagnosticos-gravedad` | Reporte de diagnósticos agrupados por gravedad. |

---

## Exportación CSV

El sistema permite exportar un reporte detallado en formato CSV.

### Endpoint

```http
GET /reportes/mascotas-especie-csv
```

### Información exportada

- Especie
- Raza
- Nombre de la mascota
- Propietario
- Ciudad

Este reporte utiliza cinco tablas relacionadas mediante consultas SQL con `INNER JOIN` (`especie`, `raza`, `mascota`, `cliente` y `ciudad`), permitiendo generar un archivo CSV con información consolidada para su posterior análisis.

---
### CRUD Complejos  (Los endpoints de CRUD complejos implementan transacciones ACID)
- POST /crud/consulta-completa → Registra cita + consulta + diagnóstico + tratamiento
- PUT /crud/cita/:id/estado → Actualiza estado de cita y genera consulta vinculada
- DELETE /crud/mascota/:id → Elimina mascota y todo su historial en cascada

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

# Endpoints del sistema

## Reportes principales

GET /reportes/veterinarios  
→ Veterinarios con número de citas atendidas

GET /reportes/clientes-ciudad  
→ Clientes agrupados por ciudad

GET /reportes/mascotas-especie  
→ Cantidad de mascotas por especie

GET /reportes/diagnosticos-gravedad  
→ Diagnósticos según nivel de gravedad

---

## Exportación

GET /reportes/veterinarios-csv  
→ Exporta el reporte de veterinarios en formato CSV

---
### CRUD Complejos  (Los endpoints de CRUD complejos implementan transacciones ACID)
- POST /crud/consulta-completa → Registra cita + consulta + diagnóstico + tratamiento
- PUT /crud/cita/:id/estado → Actualiza estado de cita y genera consulta vinculada
- DELETE /crud/mascota/:id → Elimina mascota y todo su historial en cascada

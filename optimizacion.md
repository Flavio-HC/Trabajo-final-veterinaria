# Reporte de Optimización y Selectividad
## Consulta 1
### Antes
Consulta:
sql
SELECT*FROM usuarios
WHERE correo='carlos.mendoza@api.com';
Plan:Seq Scan
Cost:0.00..2483.01
Execution Time:3.875 ms

Selectividad:
1/100001=0.001%
Indice propuesto:
sql
CREATE INDEX idx_usuarios_correo
ON usuarios(correo);

### despues

Plan:Index Scan
Cost:0.42..8.44
Execution Time:0.057 ms
Resultado:PostgreSQL cambio de Seq Scan a Index Scan y la consulta se ejecuto mas rapido

## Consulta 2
### Antes
Consulta:
sql
SELECT*FROM usuarios
WHERE apellido='Apellido_45'
AND estado='Activo';


Plan:Seq Scan
Cost:0.00..2733.01
Execution Time:4.480 ms
Selectividad:
0/100001=0%
Indice propuesto:
sql
CREATE INDEX idx_usuarios_apellido_estado
ON usuarios(apellido, estado);

### despues
Plan:Bitmap Heap Scan + Bitmap Index Scan
Cost:12.04..1149.08
Execution Time:0.096 ms
Resultado:PostgreSQL utilizo el indice compuesto y redujo el tiempo de ejecucion


## consulta 3
### antes
consulta:

sql
SELECT*FROM usuarios
WHERE estado='Activo';
Plan:Seq Scan
Cost:0.00..2483.01
Execution Time:7.255 ms
Selectivida:
80001/100001=80%
Indice propuesto:
Ninguno

### Despues
Plan:Seq Scan
Cost:0.00..2483.01
Execution Time:7.255 ms
Resultado:PostgreSQL mantuvo Seq Scan debido a la baja selectividad de la consulta

## Conclusiones
La consulta por correo fue la que obtuvo la mayor mejora gracias al indice sobre la columna correo.
La consulta por apellido y estado tambien mejoro al utilizar un indice compuesto. 
En cambio, la consulta por estado devuelve gran parte de la tabla, por lo que PostgreSQL continua usando un escaneo secuencial.

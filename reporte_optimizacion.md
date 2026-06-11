Consulta 1: busqueda por dni
consulta:
select * from cliente where dni = '12345678';
plan: seq scan  
cost: 0.00..1.06  
execution time: 0.015 ms  
selectividad: 1/5 = 20%  
indice propuesto: create index idx_cliente_dni on cliente(dni);  
resultado: postgresql mantuvo seq scan por el pequeno tamaño de la tabla. con mas registros usaria index scan.

Consulta 2: reporte mensual de citas
consulta:
select * from cita where fecha between '2026-05-01' and '2026-05-31';
plan: seq scan  
cost: 0.00..1.07  
execution time: 0.021 ms  
selectividad: 5/5 = 100%  
indice propuesto: create index idx_cita_fecha on cita(fecha);  
resultado: postgresql mantuvo seq scan porque la consulta devuelve todas las filas. en una base real con muchos años de datos este indice seria util.

Consulta 3: historial clinico de una mascota
consulta:
select c.fecha, c.motivo, co.constantes, d.descripcion
from mascota m
join cita c on m.id_mascota = c.id_mascota
join consulta co on c.id_cita = co.id_cita
join diagnostico d on co.id_consulta = d.id_consulta
where m.id_mascota = 1;
plan: seq scan  
cost: 0.00..1.07  
execution time: 0.021 ms  
selectividad: 1/5 = 20%  
indices propuestos:  
create index idx_cita_id_mascota on cita(id_mascota);  
create index idx_consulta_id_cita on consulta(id_cita);  
create index idx_diagnostico_id_consulta on diagnostico(id_consulta);  
resultado: postgresql uso los indices para optimizar los joins. el tiempo aumento un poco por el tamaño pequeno de los datos.

Consulta 4: mascotas por cliente
consulta:
select * from mascota where id_cliente = 1;
plan: seq scan  
cost: 0.00..1.06  
execution time: 0.019 ms  
selectividad: 1/5 = 20%  
indice propuesto: create index idx_mascota_id_cliente on mascota(id_cliente);  
resultado: postgresql mantuvo seq scan por los pocos registros. en una tabla grande este indice seria mas util.

Consulta 5: pagos pendientes de un cliente
consulta:
select * from pago where id_cliente = 1 and estado_pago = 'pendiente';
plan: seq scan  
cost: 0.00..14.05  
execution time: 0.016 ms  
selectividad: 0/5 = 0%  
indice propuesto: create index idx_pago_id_cliente on pago(id_cliente);  
resultado: postgresql cambio de seq scan a index scan. esta fue la mejora mas clara.

Indices finales
-- 1. busqueda por dni  
create index idx_cliente_dni on cliente(dni);  

-- 2. mascotas por cliente  
create index idx_mascota_id_cliente on mascota(id_cliente);  

-- 3. historial clinico (joins)  
create index idx_cita_id_mascota on cita(id_mascota);  
create index idx_consulta_id_cita on consulta(id_cita);  
create index idx_diagnostico_id_consulta on diagnostico(id_consulta);  

-- 4. reportes por fecha  
create index idx_cita_fecha on cita(fecha);  

-- 5. pagos pendientes  
create index idx_pago_id_cliente on pago(id_cliente);

Conclusiones
La consulta de pagos pendientes (consulta 5) fue la que obtuvo la mayor mejora gracias al indice sobre id_cliente, cambiando de seq scan a index scan y reduciendo el tiempo de ejecucion.  
La consulta por fechas (consulta 2) no mejoro porque devuelve todas las citas registradas. en una base real con citas de varios años, el indice idx_cita_fecha seria muy util.  
El tamaño reducido de los datos (5 registros por tabla) limito el impacto visible de los indices. postgresql decide usar seq scan cuando las tablas son pequenas porque es mas rapido que leer un indice.  
En un entorno de produccion con miles o millones de registros, todos los indices propuestos serian esenciales para el rendimiento del siistema.

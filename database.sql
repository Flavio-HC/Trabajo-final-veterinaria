CREATE TABLE especie (
    id_especie SERIAL PRIMARY KEY,
    nombre_especie VARCHAR(50) NOT NULL,
    descripcion TEXT
);

CREATE TABLE ciudad (
    id_ciudad SERIAL PRIMARY KEY,
    nombre_ciudad VARCHAR(100) NOT NULL,
    codigo_ubigeo VARCHAR(10)
);

CREATE TABLE medicamento (
    id_medicamento SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    stock INT NOT NULL,
    precio_unitario NUMERIC(10,2) NOT NULL,
    fecha_vencimiento DATE NOT NULL
);

CREATE TABLE servicio (
    id_servicio SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio NUMERIC(10,2) NOT NULL,
    descripcion TEXT
);

CREATE TABLE veterinario (
    id_veterinario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    colegiatura VARCHAR(50) NOT NULL UNIQUE,
    especialidad VARCHAR(100) NOT NULL,
    turno VARCHAR(50) NOT NULL
);

CREATE TABLE raza (
    id_raza SERIAL PRIMARY KEY,
    nombre_raza VARCHAR(50) NOT NULL,
    id_especie INT NOT NULL,
    CONSTRAINT fk_raza_especie
        FOREIGN KEY (id_especie)
        REFERENCES especie(id_especie)
);

CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    dni VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(255),
    id_ciudad INT NOT NULL,
    CONSTRAINT fk_cliente_ciudad
        FOREIGN KEY (id_ciudad)
        REFERENCES ciudad(id_ciudad)
);

CREATE TABLE mascota (
    id_mascota SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    genero VARCHAR(20) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    id_cliente INT NOT NULL,
    id_raza INT NOT NULL,
    CONSTRAINT fk_mascota_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente),
    CONSTRAINT fk_mascota_raza
        FOREIGN KEY (id_raza)
        REFERENCES raza(id_raza),
    CONSTRAINT chk_mascota_genero CHECK (genero IN ('Macho', 'Hembra')),
    CONSTRAINT chk_mascota_estado CHECK (estado IN ('Activo', 'Inactivo', 'Fallecido', 'Adoptado'))
);

CREATE TABLE cita (
    id_cita SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    estado VARCHAR(50) NOT NULL,
    motivo TEXT NOT NULL,
    id_mascota INT NOT NULL,
    id_veterinario INT NOT NULL,
    CONSTRAINT fk_cita_mascota
        FOREIGN KEY (id_mascota)
        REFERENCES mascota(id_mascota),
    CONSTRAINT fk_cita_veterinario
        FOREIGN KEY (id_veterinario)
        REFERENCES veterinario(id_veterinario),
    CONSTRAINT chk_cita_estado CHECK (estado IN ('Agendada', 'Completada', 'Cancelada', 'En Espera'))
);

CREATE TABLE consulta (
    id_consulta SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    constantes VARCHAR(100),
    observaciones TEXT,
    id_cita INTEGER NOT NULL,
    CONSTRAINT fk_consulta_cita
        FOREIGN KEY (id_cita)
        REFERENCES cita(id_cita)
);

CREATE TABLE diagnostico (
    id_diagnostico SERIAL PRIMARY KEY,
    descripcion TEXT NOT NULL,
    gravedad VARCHAR(50) NOT NULL,
    fecha DATE NOT NULL,
    id_consulta INT NOT NULL,
    CONSTRAINT fk_diagnostico_consulta
        FOREIGN KEY (id_consulta)
        REFERENCES consulta(id_consulta),
    CONSTRAINT chk_diagnostico_gravedad CHECK (gravedad IN ('Leve', 'Moderada', 'Grave', 'Crítica'))
);

CREATE TABLE pago (
    id_pago SERIAL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    fecha_emision DATE NOT NULL,
    monto_total NUMERIC(10,2) NOT NULL,
    estado_pago VARCHAR(50) NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    CONSTRAINT fk_pago_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente),
    CONSTRAINT chk_pago_estado CHECK (estado_pago IN ('Pendiente', 'Pagado', 'Anulado', 'Reembolsado')),
    CONSTRAINT chk_pago_metodo CHECK (metodo_pago IN ('Efectivo', 'Tarjeta', 'Transferencia', 'Yape/Plin'))
);

CREATE TABLE det_cons_serv (
    id_consulta INT NOT NULL,
    id_servicio INT NOT NULL,
    PRIMARY KEY (id_consulta, id_servicio),
    CONSTRAINT fk_det_consulta
        FOREIGN KEY (id_consulta)
        REFERENCES consulta(id_consulta),
    CONSTRAINT fk_det_servicio
        FOREIGN KEY (id_servicio)
        REFERENCES servicio(id_servicio)
);

CREATE TABLE tratamiento (
    id_tratamiento SERIAL PRIMARY KEY,
    descripcion TEXT NOT NULL,
    duracion VARCHAR(50) NOT NULL,
    estado VARCHAR(20),
    id_diagnostico INT NOT NULL,
    CONSTRAINT fk_tratamiento_diagnostico
        FOREIGN KEY (id_diagnostico)
        REFERENCES diagnostico(id_diagnostico),
    CONSTRAINT chk_tratamiento_estado CHECK (estado IN ('En curso', 'Completado', 'Cancelado', 'Pendiente'))
);

CREATE TABLE detalle_pago (
    id_detalle_pago SERIAL PRIMARY KEY,
    id_pago INTEGER NOT NULL,
    id_consulta INTEGER NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    subtotal NUMERIC(10,2) NOT NULL,
    CONSTRAINT fk_detalle_pago_pago
        FOREIGN KEY (id_pago)
        REFERENCES pago(id_pago),
    CONSTRAINT fk_detalle_pago_consulta
        FOREIGN KEY (id_consulta)
        REFERENCES consulta(id_consulta)
);

CREATE TABLE receta (
    id_receta SERIAL PRIMARY KEY,
    dosis VARCHAR(100) NOT NULL,
    frecuencia VARCHAR(100) NOT NULL,
    duracion VARCHAR(100) NOT NULL,
    id_tratamiento INT NOT NULL,
    id_medicamento INT NOT NULL,
    CONSTRAINT fk_receta_tratamiento
        FOREIGN KEY (id_tratamiento)
        REFERENCES tratamiento(id_tratamiento),
    CONSTRAINT fk_receta_medicamento
        FOREIGN KEY (id_medicamento)
        REFERENCES medicamento(id_medicamento)
);

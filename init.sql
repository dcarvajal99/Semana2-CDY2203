-- Inicializacion de la base de datos para la veterinaria
USE mydatabase;

-- Tabla de usuarios para autenticacion
CREATE TABLE IF NOT EXISTS user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255),
    password VARCHAR(255) NOT NULL
);

-- Insertar usuario de prueba (password: 1234)
INSERT INTO user (username, email, password) VALUES ('admin', 'admin@veterinaria.cl', '1234');

-- Tabla de pacientes (mascotas)
CREATE TABLE IF NOT EXISTS patient (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    species VARCHAR(255),
    breed VARCHAR(255),
    age INT,
    owner VARCHAR(255)
);

-- Tabla de citas
CREATE TABLE IF NOT EXISTS appointment (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    time TIME,
    reason VARCHAR(255),
    veterinarian VARCHAR(255)
);

-- Tabla de servicios de cuidado
CREATE TABLE IF NOT EXISTS care (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    cost DOUBLE
);

-- Tabla de medicamentos
CREATE TABLE IF NOT EXISTS medication (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    cost DOUBLE
);

-- Tabla de facturas
CREATE TABLE IF NOT EXISTS invoice (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    patient_name VARCHAR(255),
    date DATE,
    time TIME,
    total_cost DOUBLE
);

-- Tabla intermedia factura-servicios
CREATE TABLE IF NOT EXISTS invoice_cares (
    invoice_id BIGINT,
    care_id BIGINT,
    PRIMARY KEY (invoice_id, care_id),
    FOREIGN KEY (invoice_id) REFERENCES invoice(id),
    FOREIGN KEY (care_id) REFERENCES care(id)
);

-- Tabla intermedia factura-medicamentos
CREATE TABLE IF NOT EXISTS invoice_medications (
    invoice_id BIGINT,
    medication_id BIGINT,
    PRIMARY KEY (invoice_id, medication_id),
    FOREIGN KEY (invoice_id) REFERENCES invoice(id),
    FOREIGN KEY (medication_id) REFERENCES medication(id)
);

-- Datos de ejemplo
INSERT INTO patient (name, species, breed, age, owner) VALUES
('Firulais', 'Perro', 'Labrador', 5, 'Juan Perez'),
('Michi', 'Gato', 'Siames', 3, 'Maria Lopez'),
('Rocky', 'Perro', 'Pastor Aleman', 7, 'Carlos Diaz');

INSERT INTO care (name, cost) VALUES
('Consulta General', 15000),
('Vacunacion', 25000),
('Desparasitacion', 12000),
('Cirugia Menor', 80000),
('Limpieza Dental', 35000);

INSERT INTO medication (name, cost) VALUES
('Amoxicilina', 8000),
('Antiparasitario', 5000),
('Antiinflamatorio', 6000),
('Vitaminas', 4000),
('Antibiotico Topico', 7000);

INSERT INTO appointment (date, time, reason, veterinarian) VALUES
('2025-04-01', '10:00:00', 'Control general', 'Dr. Martinez'),
('2025-04-02', '14:30:00', 'Vacunacion anual', 'Dra. Gonzalez'),
('2025-04-03', '09:00:00', 'Desparasitacion', 'Dr. Martinez');

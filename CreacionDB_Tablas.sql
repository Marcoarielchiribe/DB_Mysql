
-- PROYECTO BASE DE DATOS
-- DB VENTASHELADOS
CREATE DATABASE VentasHelados;

USE VentasHelados;

-- CREACION TABLAS 
CREATE TABLE IF NOT EXISTS forma_pago(
id_forma_pago INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Nombre VARCHAR (100)
);


CREATE TABLE IF NOT EXISTS Sabores(
idSabores INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Nombre VARCHAR(30),
Precio INT,
Kilogramos DECIMAL(6,2)
);

CREATE TABLE IF NOT EXISTS Localidad(
idLocalidad INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Nombre VARCHAR(40)
);

CREATE TABLE IF NOT EXISTS cliente(
idCliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Nombre VARCHAR(30) NOT NULL,
Apellido VARCHAR(30) NOT NULL,
Telefono CHAR(10) NOT NULL,
Correo VARCHAR(50),
Direccion VARCHAR(100) NOT NULL,
Dni CHAR(8) NOT NULL,
idlocalidad INT NOT NULL,
FOREIGN KEY (idlocalidad) REFERENCES localidad (idlocalidad) 
);

CREATE TABLE IF NOT EXISTS cliente_forma_pago(
idCliente INT NOT NULL,
id_forma_pago INT NOT NULL,
FOREIGN KEY (idCliente) REFERENCES cliente (idCliente),
FOREIGN KEY (id_forma_pago) REFERENCES forma_pago(id_forma_pago)
);

CREATE TABLE IF NOT EXISTS Factura(
idfactura INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Fecha DATE,
Monto_total INT,
idCliente INT NOT NULL,
id_Forma_Pago INT NOT NULL,
FOREIGN KEY (idCliente) REFERENCES Cliente (idCliente),
FOREIGN KEY (id_Forma_Pago) REFERENCES Forma_Pago (id_Forma_Pago)
);

CREATE TABLE IF NOT EXISTS Detalle_Factura(
idfactura INT NOT NULL,
idSabores INT NOT NULL,
Cantidad TINYINT,
Total INT,
FOREIGN KEY (idfactura) REFERENCES Factura (idFactura),
FOREIGN KEY (idSabores) REFERENCES Sabores (idSabores)
);

CREATE TABLE IF NOT EXISTS Historico_Clientes(
id_cliente INT,
Nombre VARCHAR(30),
Apellido VARCHAR(30),
Correo VARCHAR(50),
DNI CHAR(8),
Fecha_hora DATETIME,
operaciones VARCHAR(50),
Usuario VARCHAR(50)
);



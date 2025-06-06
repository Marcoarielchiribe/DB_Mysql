
USE VentasHelados;

-- TRIGGER 

-- Controlando y siguiendo las inserciones que se operan en la tabla clientes 
-- DROP TRIGGER Trg_Historico_clientes;
DELIMITER $$
CREATE TRIGGER  Trg_Historico_clientes
BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
	INSERT INTO HISTORICO_CLIENTES (id_cliente, Nombre, Apellido, Correo, DNI, Fecha_hora, operaciones) VALUES
		(NEW.idCliente, NEW.Nombre, NEW.Apellido, NEW.Correo, NEW.DNI, NOW(),'NUEVO REGISTRO');
END $$

DESCRIBE Cliente;
INSERT INTO Cliente VALUES (9,'Daiana','Davalos', 119401-3841,'Daiana93@hotmail.com','Balcarce y olazabal 446',21561067,1);
INSERT INTO Cliente VALUES (10,'Roman','Fernandez', 112693-9573,'Romanfz@gmail.com.ar','25 de mayo y Alsina 555',31982451,5);

-- Controlando si se ingresan precios negativos, el valor sea 0
-- DROP TRIGGER Trg_Precios_Negativos;
DELIMITER //
CREATE TRIGGER Trg_Precios_Negativos
BEFORE INSERT ON `sabores` 
FOR EACH ROW
BEGIN
    IF NEW. precio < 0 THEN
    SET NEW.precio = 0;
    END IF;
END
//

DESCRIBE sabores;
INSERT INTO sabores VALUES (NULL,'S011', 'Pistacho', -1000, 2100);
SELECT nombre, precio FROM sabores;

-- Si hay una actualizacion en clientes inserta seguimiento del registro en la tabla historico clientes
-- DROP TRIGGER Trg_UpdateClientes;
DELIMITER //
CREATE TRIGGER Trg_UpdateClientes
AFTER UPDATE ON cliente
FOR EACH ROW
BEGIN
	INSERT INTO historico_clientes (id_cliente, Nombre, Apellido, Correo, DNI, Fecha_hora, operaciones, Usuario) VALUES
		(NEW.idCliente, NEW.Nombre, NEW.Apellido, NEW.Correo, NEW.DNI, NOW(), 'REGISTRO ACTUALIZADO', USER());
END;
//

UPDATE `fabrica_helado_mac`.`cliente` SET `Correo` = 'Hernandez.Dante018@hotmail.com' WHERE (`idCliente` = '4');
UPDATE `fabrica_helado_mac`.`cliente` SET `Correo` = 'FrancoGutierrez_94@gmail.com' WHERE (`idCliente` = '6');

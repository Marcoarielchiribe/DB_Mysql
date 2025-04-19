
USE VentasHelados;

-- PROCEDIMIENTOS ALMACENADOS

-- Ordenando en la tabla sabores los precios de manera asc

DROP PROCEDURE IF EXISTS SP_OrdenPrecioSaboresASC;
DELIMITER //
CREATE PROCEDURE SP_OrdenPrecioSaboresASC (IN p_precio CHAR(20))
BEGIN
   IF p_precio <> '' THEN
   SET @ordenamiento = CONCAT('ORDER BY ', p_precio);
   ELSE
   SET @ordenamiento = '';
   END IF;
   
	SET @clausula = CONCAT('SELECT * FROM Sabores ', @ordenamiento);
    
    PREPARE runSQL FROM @clausula;
    EXECUTE runSQL;
    DEALLOCATE PREPARE runSQL;
END
//

 CALL SP_OrdenPrecioSaboresASC('Precio');
 
 -- averiguando los clientes que tienen su factura, pasandole como parametro el nombre
DROP PROCEDURE IF EXISTS SP_ClientesxFactura;
DELIMITER //
CREATE PROCEDURE SP_ClientesxFactura(IN p_nombre VARCHAR(30))
BEGIN
	DECLARE c1 VARCHAR(50);
    SET c1 = (SELECT Nombre FROM Cliente WHERE Nombre = p_nombre LIMIT 1);
    IF c1 = p_nombre THEN
		SELECT f.idFactura, CONCAT(c.nombre,' ',c.apellido) AS 'Cliente', 
			   f.fecha, f.monto_total AS 'Monto Total', fp.nombre AS 'Forma Pago' FROM factura f
		INNER JOIN cliente c ON f.idCliente = c.idCliente
		INNER JOIN forma_pago fp ON f.id_Forma_Pago = fp.id_forma_pago
        WHERE c.nombre = p_nombre;
	ELSE 
		SELECT 'No se ha encontrado el nombre del cliente especificado en la factura!!' AS 'ERROR';
	END IF;
END
//

CALL SP_ClientesxFactura('franco');


-- Mostrando el mayor monto total en la factura
DROP PROCEDURE IF EXISTS SP_Mayor_monto_total_Factura;
DELIMITER //
CREATE PROCEDURE SP_Mayor_monto_total_Factura()
BEGIN
	SELECT idFactura, idCliente, MAX(monto_total) AS 'Monto Total' FROM factura
	GROUP BY idfactura
	ORDER BY Monto_total DESC LIMIT 1;
END
//

CALL SP_Mayor_monto_total_Factura();

-- clientes x localidad
DROP PROCEDURE IF EXISTS SP_ClientexLocalidad;
DELIMITER //
CREATE PROCEDURE SP_ClientexLocalidad(IN p_nom VARCHAR(150))
BEGIN
	DECLARE consulta VARCHAR(150);
    SET consulta = (SELECT Nombre FROM cliente WHERE Nombre = p_nom LIMIT 1);
    BEGIN
		IF consulta = p_nom THEN
			SELECT c.nombre, c.apellido, c.correo, l.nombre AS 'Localidad' FROM cliente c 
            INNER JOIN localidad l ON c.idLocalidad = l.idLocalidad WHERE c.nombre = p_nom;
		ELSE  
			SELECT 'El nombre del cliente que ingreso no existe!!' AS 'ERROR';
		END IF;
    END;
END
//

 CALL SP_ClientexLocalidad('ivan'); 

 
 -- informacion de los sabores
DROP PROCEDURE IF EXISTS SP_SaboresInfo;
DELIMITER //
CREATE PROCEDURE SP_SaboresInfo(IN p_nombre VARCHAR(50))
BEGIN
	DECLARE sentencia VARCHAR(30);
    SET sentencia = (SELECT Nombre FROM sabores WHERE Nombre = p_nombre
					LIMIT 1);
    BEGIN
		IF p_nombre = sentencia THEN
			SELECT idSabores, Nombre, Precio, Kilogramos FROM sabores
			WHERE Nombre = p_nombre;
		ELSE 
			SELECT 'No se encontro el sabor especificado!!' AS 'ERROR';
        END IF;
	END;
END
//

CALL SP_SaboresInfo('dulce de leche');

-- Ultima facturacion 
DROP PROCEDURE IF EXISTS SP_UltimaFechaFacturacion;
DELIMITER //
CREATE PROCEDURE SP_UltimaFechaFacturacion()
BEGIN
	SELECT idFactura, MAX(fecha) AS 'Fecha', monto_total, idCliente FROM factura
	GROUP BY idFactura ORDER BY fecha DESC
	LIMIT 1;
END
//

CALL SP_UltimaFechaFacturacion();

-- total de facturas registradas en cada mes
DROP PROCEDURE IF EXISTS SP_Facturacionxmes;
DELIMITER //
CREATE PROCEDURE SP_Facturacionxmes()
BEGIN
	SET lc_time_names = 'es_ES'; -- seteo los meses del año en español
	SELECT COUNT(idfactura) AS 'total facturas',MONTHNAME(fecha) AS 'Meses Facturaciones' FROM factura
	GROUP BY MONTHNAME(fecha);
END
//

-- procedimiento almacenado mostrando  informacion de las factura de los clientes por su id
DROP PROCEDURE IF EXISTS SP_IdFacturaClientes;
DELIMITER //
CREATE PROCEDURE SP_IdFacturaClientes(IN p_id INT)
BEGIN
	DECLARE c1 VARCHAR(50);
    SET c1 = (SELECT idFactura FROM factura WHERE idFactura = p_id LIMIT 1);
    IF c1 = p_id THEN
		SELECT f.idFactura, CONCAT(c.nombre,' ',c.apellido) AS 'Cliente', f.fecha, fp.nombre AS 'Forma Pago' FROM factura f
		INNER JOIN cliente c ON f.idCliente = c.idCliente
		INNER JOIN forma_pago fp ON f.id_Forma_Pago = fp.id_forma_pago 
        WHERE f.idFactura = p_id;
	ELSE 
		SELECT 'No se ha encontrado el id de factura especificado!!' AS 'ERROR';
	END IF;
END //

CALL SP_IdFacturaClientes(4);

-- Procedimiento con transaccion en la cual agrega registros nuevos en la tabla sabores
-- controlando de que no haya errores en la insercion
DROP PROCEDURE IF EXISTS SP_InsertSabores
DELIMITER //
CREATE PROCEDURE SP_InsertSabores(
     IN nombre VARCHAR(30),
	 IN precio SMALLINT,
     IN kilogramos INT
)	 
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
		SELECT 'Hubo un error al insertar el nuevo registro!!' AS 'ERROR';
	END;
	
    START TRANSACTION;
    INSERT INTO sabores (Nombre, Precio, Kilogramos) VALUES 
		(nombre, precio, kilogramos);
	COMMIT;
	SELECT 'Se inserto el registro correctamente!!' AS 'Descripcion';
END
//

DESCRIBE sabores;
CALL SP_InsertSabores('Tramontana',4000,2150);
CALL SP_InsertSabores('Mascarpone',3500,2090);
CALL SP_InsertSabores('Frambuesa',1950,2240);

-- PROCEDURE CON TCL ACTUALIZANDO A LOS CLIENTES DE MANERA CORRECTA UTILZANDO EXEPCIONES QUE VERIFIQUEN SI EXISTE EL ID DEL CLIENTE
-- O HAYA ALGUN ERROR QUE IMPIDA LA ACTUALIZACION GARANTIZANDO LA SEGURIDAD Y NO SE PIERDA INFORMACION
DROP PROCEDURE IF EXISTS SP_ActualizacionClientes;
DELIMITER //
CREATE PROCEDURE SP_ActualizacionClientes(
   IN idcliente INT,
   IN nombre VARCHAR(30),
   IN apellido VARCHAR(30),
   IN telefono CHAR(11),
   IN correo VARCHAR(50),
   IN direccion VARCHAR(100),
   IN dni CHAR(8),
   IN idlocalidad INT
)
BEGIN
	BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
        ROLLBACK;
		SELECT 'Ocurrio un error al actualizar los datos del cliente' AS 'ERROR';
	END;
    
    START TRANSACTION;
    UPDATE cliente SET 
    idCliente = idcliente,
    Nombre = nombre,
    Apellido = apellido,
    Telefono = telefono,
    Correo = cerreo,
    Dni = dni,
    idLocalidad = idlocalidad
    WHERE idCliente = idcliente;
    
    IF ROW_COUNT() = 0 THEN -- verifico si existe el id del cliente
		ROLLBACK;
        SELECT 'No se ah encontrado en id del cliente especificado!!' AS 'ERROR';
	ELSE 
		COMMIT;
        SELECT 'Registro actualizado correctamente!!' AS 'DESCRIPCION';
	END IF;
END
//

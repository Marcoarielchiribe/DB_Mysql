
USE VentasHelados;

-- FUNCIONES

-- Retorna los nombres de las localidades del cliente   
DELIMITER //
CREATE FUNCTION f_clientes_localidades(p_localidad INT) 
RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
    DECLARE consulta VARCHAR(100);
    SET consulta = (SELECT nombre  FROM localidad WHERE idlocalidad = p_localidad );
	RETURN consulta;
END //

SELECT idCliente,nombre, apellido, f_clientes_localidades(idLocalidad) AS 'Localidad' FROM cliente;

-- Muestra nombre completo del cliente pasandole como parameto el idcliente
DELIMITER //
CREATE FUNCTION  f_ClientesFactura(p_id_cliente INT)
RETURNS VARCHAR (100)
READS SQL DATA
BEGIN
    DECLARE rs VARCHAR (100);
    SET rs = (SELECT CONCAT(nombre,' ',apellido) FROM cliente WHERE idCliente = p_id_cliente);
	RETURN rs;
END 
//

-- Utilizando la funcion con los datos de la tabla factura
SELECT f_ClientesFactura(idCliente) AS 'Clientes',fecha, monto_total FROM factura;

-- Retorna el total de los clientes registrados
DELIMITER //
CREATE FUNCTION f_total_clientes()
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE cons INT;
	SET cons = (SELECT COUNT(*) AS 'Total de Clientes' FROM cliente);
	RETURN cons;
END
//

SELECT f_total_clientes() AS 'Total de clientes';

-- funcion que retorna los Montos totales asignandole un argumento en especifico
DELIMITER //
CREATE FUNCTION F_MontosTotalesFactura(p_monto INT)
RETURNS VARCHAR(100)
NO SQL
-- MONTO BAJO 10 AL 30
-- MONTO MEDIO 31 AL 44
-- MONTO ALTO > 45
BEGIN
	CASE
	  WHEN p_monto BETWEEN 10000 AND 30000 THEN RETURN 'MONTO BAJO';
          WHEN p_monto BETWEEN 31000 AND 44000 THEN RETURN 'MONTO MEDIO';
	ELSE RETURN 'MONTO ALTO';
	END CASE;
END
//

SELECT *, F_MontosTotalesFactura(Monto_total) FROM factura;

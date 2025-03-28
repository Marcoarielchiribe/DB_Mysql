
USE VentasHelados;

-- CREACION DE VISTAS

-- Clientes ubicados en la localidad de 3 de febrero
CREATE OR REPLACE VIEW VW_clientes_localidad_3df AS
SELECT c.idCliente,c.nombre,c.apellido,l.nombre AS 'Localidad'
FROM cliente AS C
INNER JOIN localidad AS L
ON c.idlocalidad = l.idlocalidad
WHERE l.nombre IN ('Tres de febrero');

SELECT * FROM  VW_clientes_localidad_3df;

-- Clientes pagando con transferencia bancaria
CREATE OR REPLACE VIEW VW_cliente_pago_transferencia AS
SELECT c.nombre, c.apellido, c.telefono,fp.nombre AS 'Pago cliente' FROM cliente c
INNER JOIN cliente_forma_pago cfp
ON c.idCliente = cfp.idCliente
INNER JOIN forma_pago fp
ON fp.id_forma_pago = cfp.id_forma_pago
WHERE fp.nombre = 'Transferencia Bancaria';

SELECT * FROM VW_cliente_pago_transferencia;

-- Sabores con sus precios
CREATE OR REPLACE VIEW VW_sabores_precio AS
SELECT nombre AS 'gustos', precio
FROM sabores;

SELECT * FROM VW_sabores_precio;

-- Ver los sabores con precio mayores a 2000
CREATE OR REPLACE VIEW VW_Sb_PrecioMayor_a2000 AS
SELECT nombre AS 'Gustos', precio
FROM sabores
WHERE precio > 2000;

SELECT * FROM VW_Sb_PrecioMayor_a2000;

-- Mostrando al cliente con el segundo monto total mas alto en facturas 
CREATE OR REPLACE VIEW vw_cliente_2do_monto_total_alto 
AS
WITH ranking AS (
	SELECT  CONCAT(c.nombre,' ',c.apellido) AS Cliente, 
			f.fecha,
            f.monto_total,
    DENSE_RANK() OVER(ORDER BY monto_total DESC)
	AS rank2 FROM factura f 
    INNER JOIN cliente c ON f.idCliente = c.idCliente
) SELECT Cliente, fecha, monto_total FROM ranking
WHERE rank2 = 2;

SELECT * FROM vw_cliente_2do_monto_total_alto;

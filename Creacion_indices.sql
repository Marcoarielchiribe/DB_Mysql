
USE fabrica_helado_mac;

/**CREACION DE INDICES
Aceleran en tiempo de respuesta de las consultas(No abusar, consumen muchos recursos
relentizando las operaciones de insert, update, delete)
**/
CREATE INDEX idx_nombre_sabores ON sabores(nombre);

-- indice unico (evita valores duplicados en una columna)
CREATE UNIQUE INDEX indx_dni_cliente ON cliente(dni);

-- Muesta los indices creados en las tablas
SHOW INDEX FROM sabores;
SHOW INDEX FROM cliente;

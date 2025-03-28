
USE VentasHelados;

-- Creacion del usuario
CREATE USER Administrador1@localhost IDENTIFIED BY '4444'; -- contraseña

-- Otorgando permisos
GRANT SELECT, UPDATE ON VentasHelados.* TO 'Administrador1'@'localhost'; -- .* todos los objetos de la db

-- Ver los privilegios del usuario
SHOW GRANTS FOR 'Administrador1'@'localhost'; 

-- Mosstrar los usuarios creados
SELECT * FROM mysql.USER; 

-- Eliminar todos los permisos del usuario
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'Administrador1'@'localhost'; 





USE VentasHelados;

-- INSERCIONES EN LAS TABLAS
INSERT INTO sabores  (`nombre`, `precio`, `kilogramos`) VALUES
			('Americana', 1900, 2200),
			('Vainilla', 2000, 2500),
            ('Chocolate', 1800,2300),
            ('Dulce de leche', 2100,2600), 
            ('Frutilla al agua', 1700, 2700),
            ('Frutos del Bosque', 1600, 2400),
            ('Durazno', 1300, 2200),
            ('Bananita dolce', 2400,2800),
            ('Banana splits', 2600,2700),
            ('Mantecol', 2300,2200);

INSERT INTO Cliente (`nombre`, `apellido`, `telefono`, `correo`, `direccion`, `dni`,`idlocalidad`) VALUES
			('Lautaro','Rivera', 114508-0344,'LautiRivera@hotmail.com','Av H Yrigoyen y Acevedo 567',36233087,1),
            ('Piero','Garcia', 112887-2936,'Garcia_piero@hotmail.com','Del fomentista y Roque Saenz Pena 129',18632859,2),
			('Abril','Mendoza', 115813-9167,'Abril92@gmail.com.ar','AV. PTE. PERÓN ESQ. ALBERDI 339',81544670,3),
			('Dante','Hernandez', 112406-7791,'Hernandez_D18@hotmail.com','Florentino Ameghino y Florida 517',20281994,4),
			('Dario','Romero',158869-2204,'DarioRomero14@hotmail.com.ar','Bv Los Granaderos y Paraná 338',27239726,5),
            ('Franco','Gutierrez', 157728-1967,'Fran.Gutierrez94@gmail.com','ORTEGA Y GASSET 229',33951311,6),
            ('Yanina','Rojas', 118715-4241,'Rojas_Y09@gmail.com','Andrés Baranda y Av Carlos pellegrini 487',40448130,7),
			('Ivan','Monserrat', 156149-4482,'Ivanmt77@hotmail.com.ar','PERÚ Y LABARDEN 991',43671053,6);


INSERT INTO forma_pago (nombre) VALUES
			( 'PayPal'),
            ( 'Transferencia Bancaria'),
            ( 'Efectivo');

INSERT INTO Localidad (nombre) VALUES
			( 'Lomas de zamora'),
            ( 'San Isidro'),
            ( 'Muniz'),
            ( 'Vicente Lopez'),
            ( 'Tigre'),
            ( 'Tres de Febrero'),
            ( 'Quilmes');

INSERT INTO Factura (fecha, idcliente, Monto_total, id_forma_pago) VALUES
			('2022-12-15',1,17700,2),					
            ('2022-12-19',5,32800,3),							
            ('2023-01-10',3,39500,1),						
            ('2023-02-23',7,43200,3),			
            ('2023-02-08',6,47500,1),								
            ('2023-01-16',2,28300,3),					
            ('2023-03-15',8,47900,2),							
            ('2023-03-26',4,52600,2);
					
            
INSERT INTO Detalle_factura (idfactura,idsabores,cantidad,total) VALUES
            (1,1,3,5700),(1,3,4,7200),(1,6,3,4800),
            (2,9,2,4600),(2,2,4,8000),(2,5,2,3400),(2,4,4,8400),(2,7,3,3900),
            (3,1,3,5700),(3,4,5,10500),(3,10,3,6900),(3,8,4,9600),(3,7,4,5200),(3,6,1,1600),
            (4,2,4,8000),(4,9,4,10400),(4,6,5,8000),(4,8,3,7200),(4,3,4,7200),(4,4,5,10500),(4,7,1,1300),
            (5,9,4,10400),(5,8,4,9600),(5,10,4,9200),(5,3,2,3600),
            (6,5,5,8500),(6,7,5,6500),(6,4,6,12600),(6,9,4,10400),(6,1,5,9500),
            (7,1,4,7600),(7,8,4,9600),(7,10,5,11500),(7,5,5,8500),(7,2,3,6000),
            (8,3,4,7200),(8,7,3,3900),(8,9,5,13000),(8,10,5,11500),(8,5,3,5100),(8,8,3,7200);
                        
INSERT INTO cliente_forma_pago (idcliente, id_forma_pago) VALUES
			(3,1),
			(6,1),
			(1,2),
			(4,2),
			(8,2),
			(2,3),
			(5,3),
			(7,3);
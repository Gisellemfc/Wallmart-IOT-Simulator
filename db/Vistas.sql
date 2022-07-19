

		-------------------------------------------------------------------------------

					--             		 PROYECTO 1                      --
					-- ALumnas: Nicole Brito. Carnet: 20181110056 		 --
					--			Giselle Ferreira. Carnet: 20181110399	 --

		-------------------------------------------------------------------------------


						   		-- VISTAS DEL PROYECTO --
						

--Enlace al Google Data Studio: https://datastudio.google.com/reporting/c6d40124-6ec5-4308-ac68-99ae802819eb


--Vista de cuántos clientes con tapabocas y sin tapabocas llegan a la tienda (diario)
	
	CREATE OR REPLACE VIEW tapabocas_clientes_diarios AS
	
		--Se suma, depende
		SELECT date_trunc('day', fecha_entrada) "Dia",
				SUM(CASE --Si no tiene tapaboca se suma 1 a "personas sin tapaboca"
               		WHEN tapaboca = false THEN 1
	       			ELSE 0
					END) AS "Personas sin tapaboca",
				SUM(CASE --Si tiene tapaboca se suma 1 a "personas con tapaboca"
               		WHEN tapaboca = true THEN 1
	       			ELSE 0
					END) AS "Personas con tapaboca"
		FROM visita
		--Ordenar por las fechas de entradas de las visitas
		GROUP BY 1
		--Desde las últimas hasta las más viejas
		ORDER BY 1 DESC
		LIMIT 1;

SELECT * FROM tapabocas_clientes_diarios;

--Vista del promedio del Tiempo de duración de las personas en la tienda (diario)

	CREATE OR REPLACE VIEW promedio_tiempo AS
		--Buscando promedio de tiempo de visita
		SELECT date_trunc('day', fecha_entrada) "Dia",
				avg(tiempo_visita) AS "Tiempo promedio visita" 
		FROM visita
		--Ordenar por las fechas de entradas de las visitas
		GROUP BY 1
		--Desde las últimas hasta las más viejas
		ORDER BY 1 DESC
		LIMIT 1;

SELECT * FROM promedio_tiempo;

--Vista de temperatura promedio de los clientes (diario)
	
	CREATE OR REPLACE VIEW promedio_temperatura AS
	
		SELECT date_trunc('day', fecha_entrada) "Dia",
				avg(temperatura) AS "Temperatura promedio" 
		FROM visita
		--Ordenar por las fechas de entradas de las visitas
		GROUP BY 1
		--Desde las últimas hasta las más viejas
		ORDER BY 1 DESC
		LIMIT 1;
		
SELECT * FROM promedio_temperatura;
	
--Vista que diga cuales son las 3 categorías de producto que menos 
--se ha vendido en la castellana
	
	CREATE OR REPLACE VIEW categorias_productos_menos_vendidos_castellana AS
		--Buscando las 3 categorías menos vendidas en la castellana
		SELECT ca.nombre AS Categoria, SUM(c.cantidad) AS Cantidad FROM carrito AS c
        INNER JOIN categoria_producto AS cp ON cp.id_producto = c.id_producto
		INNER JOIN categoria AS ca ON ca.id = cp.id_categoria
        INNER JOIN factura AS f ON f.id = c.id_factura
        INNER JOIN cliente AS cl ON cl.id = f.id_cliente
        INNER JOIN visita AS v ON v.id_cliente = cl.id
		INNER JOIN sucursal AS su ON su.id = v.id_sucursal
        WHERE v.fecha_salida = f.fecha AND su.id=1
        GROUP BY ca.nombre
        ORDER BY cantidad ASC
		LIMIT 3;
		
SELECT * FROM categorias_productos_menos_vendidos_castellana;
		
--Vista que diga cuales son las 3 categorías de producto que menos 
--se ha vendido en el hatillo

	CREATE OR REPLACE VIEW categorias_productos_menos_vendidos_hatillo AS
	
		--Buscando las 3 categorías menos vendidas en el hatillo
		SELECT ca.nombre AS Categoria, SUM(c.cantidad) AS Cantidad FROM carrito AS c
        INNER JOIN categoria_producto AS cp ON cp.id_producto = c.id_producto
		INNER JOIN categoria AS ca ON ca.id = cp.id_categoria
        INNER JOIN factura AS f ON f.id = c.id_factura
        INNER JOIN cliente AS cl ON cl.id = f.id_cliente
        INNER JOIN visita AS v ON v.id_cliente = cl.id
		INNER JOIN sucursal AS su ON su.id = v.id_sucursal
        WHERE v.fecha_salida = f.fecha AND su.id=2
        GROUP BY ca.nombre
        ORDER BY cantidad ASC
		LIMIT 3;

SELECT * FROM categorias_productos_menos_vendidos_hatillo;

--Vista de cantidad de personas rechazadas

	CREATE OR REPLACE VIEW cantidad_personas_rechazadas AS
	
		--Se suma, depende
		SELECT SUM(CASE --Si no tiene tapaboca se suma 1 a "Rechazadas sin tapaboca"
               		WHEN tapaboca = false THEN 1
	       			ELSE 0
					END) AS "Rechazadas sin tapaboca",
				SUM(CASE --Si tiene temperatura se suma 1 a "Rechazadas por temperatura"
               		WHEN temperatura >= 38 THEN 1
	       			ELSE 0
					END) AS "Rechazadas por temperatura"
		FROM visita;
		
SELECT * FROM cantidad_personas_rechazadas;

--Cuales es el top 5 de productos que más se han vendido en la castellana
	
	CREATE OR REPLACE VIEW productos_mas_vendidos_castellana AS
	
		--Buscando los 5 productos más vendidos en la castellana
		SELECT p.nombre AS Producto, SUM(c.cantidad) AS Cantidad FROM carrito AS c
        INNER JOIN producto AS p ON p.id = c.id_producto
        INNER JOIN factura AS f ON f.id = c.id_factura
        INNER JOIN cliente AS cl ON cl.id = f.id_cliente
        INNER JOIN visita AS v ON v.id_cliente = cl.id
		INNER JOIN sucursal AS su ON su.id = v.id_sucursal
        WHERE v.fecha_salida = f.fecha AND su.id=1
        GROUP BY p.nombre
        ORDER BY cantidad DESC
		LIMIT 5;

SELECT * FROM productos_mas_vendidos_castellana;

--Cuales es el top 5 de productos que más se han vendido en el hatillo
	
	CREATE OR REPLACE VIEW productos_mas_vendidos_hatillo AS
	
		--Buscando los 5 productos más vendidos en el hatillo
		SELECT p.nombre AS Producto, SUM(c.cantidad) AS Cantidad FROM carrito AS c
        INNER JOIN producto AS p ON p.id = c.id_producto
        INNER JOIN factura AS f ON f.id = c.id_factura
        INNER JOIN cliente AS cl ON cl.id = f.id_cliente
        INNER JOIN visita AS v ON v.id_cliente = cl.id
		INNER JOIN sucursal AS su ON su.id = v.id_sucursal
        WHERE v.fecha_salida = f.fecha AND su.id=2
        GROUP BY p.nombre
        ORDER BY cantidad DESC
		LIMIT 5;

SELECT * FROM productos_mas_vendidos_hatillo;

--Diga todos los clientes que en los últimos 7 días a partir de la ejecución del query 
--han comprado solo en una tienda 
--y los que han comprado en las dos tiendas (realice queries distintos). 
	
	CREATE OR REPLACE VIEW clientes_comprar_una_sucursal AS
	
		SELECT v.id_sucursal AS Sucursal, COUNT(DISTINCT c.id) AS "Numero de clientes" FROM factura AS f
		INNER JOIN cliente AS c ON c.id = f.id_cliente
		INNER JOIN visita AS v ON v.id_cliente = c.id
		WHERE v.fecha_salida = f.fecha 
		AND NOT EXISTS (SELECT * FROM factura AS fa
					INNER JOIN cliente AS cl ON cl.id = fa.id_cliente
					INNER JOIN visita AS vi ON vi.id_cliente = cl.id
					WHERE vi.fecha_salida = fa.fecha AND vi.id_sucursal <> v.id_sucursal AND cl.id = c.id)
		AND f.fecha BETWEEN ((SELECT fecha FROM factura ORDER BY fecha DESC LIMIT 1) - INTERVAL'7 days') AND (SELECT fecha FROM factura ORDER BY fecha DESC LIMIT 1)
		GROUP BY v.id_sucursal;

SELECT * FROM clientes_comprar_una_sucursal;

CREATE OR REPLACE VIEW clientes_comprar_dos_sucursales AS
	
		SELECT COUNT(DISTINCT c.id) AS "Numero de clientes" FROM factura AS f
		INNER JOIN cliente AS c ON c.id = f.id_cliente
		INNER JOIN visita AS v ON v.id_cliente = c.id
		WHERE f.fecha = v.fecha_salida 
		AND EXISTS (SELECT * FROM factura AS fa
					INNER JOIN cliente AS cl ON cl.id = fa.id_cliente
					INNER JOIN visita AS vi ON vi.id_cliente = cl.id
					WHERE vi.fecha_salida = fa.fecha AND vi.id_sucursal <> v.id_sucursal AND cl.id = c.id)
		AND f.fecha BETWEEN ((SELECT fecha FROM factura ORDER BY fecha DESC LIMIT 1) - INTERVAL'7 days') AND (SELECT fecha FROM factura ORDER BY fecha DESC LIMIT 1);
	
SELECT * FROM clientes_comprar_dos_sucursales;


--Vista que haga un análisis por estante de cuáles categorías de producto 
--tienen mayor rotación de inventario y haga una propuesta de modificación.

	CREATE OR REPLACE VIEW estante_analisis AS

		SELECT ca.nombre AS Categoria, SUM(veces_rellenado) AS "veces rellenado" 
		FROM estante AS e
		INNER JOIN producto AS p ON p.id = e.id_producto
		INNER JOIN categoria_producto AS cp ON cp.id_producto = p.id
		INNER JOIN categoria AS ca ON ca.id = cp.id_categoria
		GROUP BY ca.nombre
		ORDER BY "veces rellenado" DESC
		LIMIT 5;
		
SELECT * FROM estante_analisis;
		
		
--Encuentre a todos los clientes que han pagado con 2 bancos distintos en 
--la última semana. Enumérelos y diga si son parte del programa de afiliados. 
--(Mostrar tabla y cantidad pagada)

	CREATE OR REPLACE VIEW clientes_pagan_2_bancos_diferentes AS
		
		SELECT c.id AS Cliente, c.afiliado AS Afiliado, SUM(f.total_con_descuento) AS "Total pagado" FROM cliente AS c
		INNER JOIN factura AS f ON f.id_cliente = c.id
		WHERE f.fecha BETWEEN ((SELECT fecha FROM factura ORDER BY fecha DESC LIMIT 1) - INTERVAL'7 days') AND (SELECT fecha FROM factura ORDER BY fecha DESC LIMIT 1)
		GROUP BY c.id
		HAVING COUNT(DISTINCT f.banco) > 1;
		
SELECT * FROM clientes_pagan_2_bancos_diferentes;
		
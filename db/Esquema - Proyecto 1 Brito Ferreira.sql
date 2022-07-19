

		-------------------------------------------------------------------------------

					--             		 PROYECTO 1                      --
					-- ALumnas: Nicole Brito. Carnet: 20181110056 		 --
					--			Giselle Ferreira. Carnet: 20181110399	 --

		-------------------------------------------------------------------------------


						-- ESQUEMA DE LA BASE DE DATOS DEL PROYECTO --
						
						
--DROPEANDO LAS TABLAS
DROP TABLE categoria_producto;
DROP TABLE mensaje;
DROP TABLE visita;
DROP TABLE carrito;
DROP TABLE factura;
DROP TABLE categoria;
DROP TABLE cliente;
DROP TABLE costo;
DROP TABLE estante;
DROP TABLE producto;
DROP TABLE sucursal;


-- TABLA CLIENTE
	CREATE TABLE IF NOT EXISTS cliente (
		id serial NOT NULL,
		puntos integer NOT NULL,
		afiliado boolean NOT NULL,
		PRIMARY KEY (id)
	);


-- TABLA SUCURSAL
	CREATE TABLE IF NOT EXISTS sucursal (
			id serial NOT NULL,
			maximo_clientes integer NOT NULL,
			nombre character varying NOT NULL,
			ubicacion character varying NOT NULL,
			apertura time NOT NULL,
			cierre time NOT NULL,
			inventario integer NOT NULL,
			PRIMARY KEY (id)
	);	


-- TABLA VISITA
	CREATE TABLE IF NOT EXISTS visita (
		id serial NOT NULL,
		temperatura numeric(16,2) NOT NULL,
		tapaboca boolean NOT NULL,
		tiempo_visita time NOT NULL,
		fecha_entrada timestamp NOT NULL,
		fecha_salida timestamp NOT NULL,
		id_cliente integer,
		id_sucursal integer NOT NULL,
		PRIMARY KEY (id), 
		FOREIGN KEY (id_cliente) REFERENCES cliente(id) ON DELETE SET NULL,
		FOREIGN KEY (id_sucursal) REFERENCES sucursal(id) ON DELETE CASCADE
	);


-- TABLA PRODUCTO
	CREATE TABLE IF NOT EXISTS producto (
		id serial NOT NULL,
		nombre character varying NOT NULL,
		PRIMARY KEY (id)
	);


-- TABLA CATEGORÍA
	CREATE TABLE IF NOT EXISTS categoria (
		id serial NOT NULL,
		nombre character varying NOT NULL,
		PRIMARY KEY (id)
	);


--TABLA INTERMEDIARIA ENTRE PRODUCTO Y CATEGORÍA
	CREATE TABLE IF NOT EXISTS categoria_producto (
			id_producto integer NOT NULL,
			id_categoria integer NOT NULL,
			PRIMARY KEY (id_producto, id_categoria),
			FOREIGN KEY (id_producto) REFERENCES producto(id) ON DELETE CASCADE,
			FOREIGN KEY (id_categoria) REFERENCES categoria(id) ON DELETE CASCADE
		);

	
-- TABLA COSTO
	CREATE TABLE IF NOT EXISTS costo (
		id serial NOT NULL,
		costo numeric(16,2) NOT NULL,
		fecha timestamp NOT NULL,
		id_producto integer NOT NULL,
		PRIMARY KEY (id),
		FOREIGN KEY (id_producto) REFERENCES producto(id) ON DELETE CASCADE
	);

		
-- TABLA ESTANTE
	CREATE TABLE IF NOT EXISTS estante (
		id serial NOT NULL,
		capacidad integer NOT NULL,
		disponible integer NOT NULL,
		veces_rellenado integer NOT NULL,
		id_producto integer,
		id_sucursal integer NOT NULL,
		PRIMARY KEY (id),
		FOREIGN KEY (id_producto) REFERENCES producto(id) ON DELETE SET NULL,
		FOREIGN KEY (id_sucursal) REFERENCES sucursal(id) ON DELETE CASCADE
	);
	

-- TABLA MENSAJE
	CREATE TABLE IF NOT EXISTS mensaje (
			id serial NOT NULL,
			mensaje character varying NOT NULL,
			fecha timestamp NOT NULL,
			id_visita integer,
			id_estante integer,
			PRIMARY KEY (id),
			FOREIGN KEY (id_visita) REFERENCES visita(id) ON DELETE SET NULL,
			FOREIGN KEY (id_estante) REFERENCES estante(id) ON DELETE SET NULL
	);
	

-- TABLA FACTURA
	CREATE TABLE IF NOT EXISTS factura (
			id serial NOT NULL,
			total numeric(16,2) NOT NULL,
			fecha timestamp NOT NULL,
			tipo_de_tarjeta character varying NOT NULL CHECK (tipo_de_tarjeta IN ('Debito', 'Credito')),
			banco character varying NOT NULL CHECK (banco IN ('Bancamiga', 'Banesco', 'Mercantil Panamá')),
			total_con_descuento numeric(16,2) NOT NULL,
			pagado boolean NOT NULL,
			id_cliente integer,
			PRIMARY KEY (id),
			FOREIGN KEY (id_cliente) REFERENCES cliente(id) ON DELETE SET NULL
	);


-- TABLA CARRITO
	CREATE TABLE IF NOT EXISTS carrito (
			precio numeric(8,2) NOT NULL,
			cantidad integer NOT NULL,
			id_factura integer NOT NULL,
			id_producto integer NOT NULL,
			PRIMARY KEY (id_producto, id_factura),
			FOREIGN KEY (id_producto) REFERENCES producto(id) ON DELETE CASCADE,
			FOREIGN KEY (id_factura) REFERENCES factura(id) ON DELETE CASCADE
	);


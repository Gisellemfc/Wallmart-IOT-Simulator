

		-------------------------------------------------------------------------------

					--             		 PROYECTO 1                      --
					-- ALumnas: Nicole Brito. Carnet: 20181110056 		 --
					--			Giselle Ferreira. Carnet: 20181110399	 --

		-------------------------------------------------------------------------------


								-- TRIGGERS DEL PROYECTO --
								

-- Trigger que cada vez que entre un cliente afiliado, se debe agregar 1 
-- punto a su estado de cuenta del programa de fidelidad

	CREATE OR REPLACE FUNCTION agregar_puntos_fidelidad() 
	RETURNS TRIGGER 
	LANGUAGE plpgsql
	AS $$
	DECLARE
		puntos_afiliado INT;
	BEGIN
		--Si el tiempo de visita es mayor a cero, o sea, si entró a la sucursal, ejecuta
		IF NEW.tiempo_visita > '00:00:00' THEN

			--Buscando los puntos de afiliado del cliente de la visita
			SELECT c.puntos INTO puntos_afiliado FROM cliente AS c
			WHERE c.afiliado = 'true' AND new.id_cliente = c.id;
			
			IF puntos_afiliado IS NOT NULL THEN
				--Actualizando puntos del cliente
				UPDATE cliente
				SET puntos = puntos_afiliado +1
				WHERE id=new.id_cliente;
				
			END IF; 
			
		 END IF;  

		 RETURN NEW;

	END $$;

	-- Creando trigger
	CREATE TRIGGER agregar_puntos_fidelidad
	AFTER INSERT
	ON visita
	FOR EACH ROW
	EXECUTE PROCEDURE agregar_puntos_fidelidad();
	

-- Si un cliente sin estar afiliado con la misma cédula compra más de 4 veces, 
-- automáticamente se agregara al programa de fidelidad.

	CREATE OR REPLACE FUNCTION cambiando_la_fidelidad() 
	RETURNS TRIGGER 
	LANGUAGE plpgsql
	AS $$
	DECLARE
		es_afiliado BOOLEAN;
		compras INT;
	BEGIN
		--Buscando si es afiliado o no el cliente
		SELECT c.afiliado INTO es_afiliado FROM cliente AS c
		WHERE new.id_cliente=c.id;
		
		IF es_afiliado = false THEN
			--Contando la cantidad de compras 
			compras := (SELECT count(*) FROM factura WHERE id_cliente = new.id_cliente);
			
			--Si la persona NO esta afiliada y la cantidad de compras es mayor a 4, ejecuta
			IF(es_afiliado = false AND compras > 4) THEN
					UPDATE cliente
					SET afiliado = true
					WHERE id = new.id_cliente;
			END IF;
			
		END IF;

            RETURN NEW;
	END $$;

	-- Creando trigger
	CREATE TRIGGER cambiando_la_fidelidad
	AFTER INSERT
	ON factura
	FOR EACH ROW
	EXECUTE PROCEDURE cambiando_la_fidelidad();


--Trigger que actualice el inventario de los estantes

	CREATE OR REPLACE FUNCTION actualizar_estante() 
	RETURNS TRIGGER 
	LANGUAGE plpgsql
	AS $$
	DECLARE
		inventario_disponible INT;
		capacidad INT;
		momento_de_actualizar INT;
		inventario_almacen INT;
		cantidad_a_reponer INT;
		rellenado_estante INT;
		fecha_relleno TIMESTAMP;

	BEGIN
		--Buscando el inventario disponible y las veces rellenado
		SELECT e.disponible, e.veces_rellenado INTO inventario_disponible, rellenado_estante FROM estante AS e
		WHERE new.id=e.id;
		
		--Buscando la capacidad
		SELECT e.capacidad INTO capacidad FROM estante AS e
		WHERE new.id=e.id;
	
		--Calculando el 20% de la capacidad para saber cuándo actualizar
		momento_de_actualizar := (0.2*capacidad); 
		
		IF inventario_disponible < momento_de_actualizar THEN
			inventario_almacen := (SELECT s.inventario FROM sucursal AS s WHERE new.id_sucursal=id);
			cantidad_a_reponer := (new.capacidad - new.disponible);
			
			--Sumando las veces rellenado
			rellenado_estante := rellenado_estante + 1;
			
			UPDATE estante
			SET disponible=new.capacidad, veces_rellenado=rellenado_estante
			WHERE new.id=id;
			
			UPDATE sucursal
			SET inventario = (inventario-cantidad_a_reponer) WHERE new.id_sucursal=id;
			
			--Buscando la fecha de actualización del estante para ingresar mensaje
			SELECT v.fecha_entrada INTO fecha_relleno FROM estante AS e
			INNER JOIN producto AS p ON p.id = e.id_producto
			INNER JOIN carrito AS c ON c.id_producto = p.id
			INNER JOIN factura AS f ON f.id = c.id_factura
			INNER JOIN cliente AS cl ON cl.id = f.id_cliente
			INNER JOIN visita AS v ON v.id_cliente = cl.id
			WHERE e.id = new.id
			ORDER BY v.fecha_entrada DESC
			LIMIT 1;
			
			INSERT INTO mensaje(mensaje, fecha, id_estante)
			VALUES ('El estante fue rellenado', fecha_relleno, new.id);
		
		END IF;
		
		RETURN NEW;
		
	END $$;

	-- Creando trigger
	CREATE TRIGGER actualizar_estante
	AFTER UPDATE
	ON estante
	FOR EACH ROW
	EXECUTE PROCEDURE actualizar_estante();


--Trigger que actualice el almacen

	CREATE OR REPLACE FUNCTION actualizar_almacen() 
	RETURNS TRIGGER 
	LANGUAGE plpgsql
	AS $$
	DECLARE
	
		inventario_disponible INT;
		momento_de_actualizar INT;
		
	BEGIN
		--Buscando el inventario disponible
		SELECT s.inventario INTO inventario_disponible FROM sucursal AS s
		WHERE new.id_sucursal = id;
		
		--Calculando el 20% de la capacidad para saber cuándo actualizar
		momento_de_actualizar := (0.2*10000); 
		
		--Si el inventario que queda en el almacen es menor al 20%, ejecuta
		IF inventario_disponible < momento_de_actualizar THEN
			UPDATE sucursal
			SET inventario = 10000 WHERE new.id_sucursal=id;
		
		END IF;
		
		RETURN NEW;
		
	END $$;

	-- Creando trigger
	CREATE TRIGGER actualizar_almacen
	AFTER UPDATE
	ON estante
	FOR EACH ROW
	EXECUTE PROCEDURE actualizar_almacen();
	
	
--Trigger que antes de insertar una visita, si el id del cliente no está registrado, que registre al usuario

	CREATE OR REPLACE FUNCTION ingresar_cliente_si_no_existe() 
	RETURNS TRIGGER 
	LANGUAGE plpgsql
	AS $$
	DECLARE

	BEGIN
		--Si el cliente ya existe, no hagas nada
		IF EXISTS (SELECT c.id FROM cliente AS c WHERE c.id = new.id_cliente) THEN
		
		-- Si el cliente no existe, ejecuta
		ELSE
		
			INSERT INTO cliente(id, puntos, afiliado)
			VALUES (new.id_cliente, 0, false);
			
		END IF;
		
		RETURN NEW;
		
	END $$;

	-- Creando trigger
	CREATE TRIGGER ingresar_cliente_si_no_existe
	BEFORE INSERT
	ON visita
	FOR EACH ROW
	EXECUTE PROCEDURE ingresar_cliente_si_no_existe();


--Trigger que actualice el inventario al ingresar/sacar productos del carrito

	CREATE OR REPLACE FUNCTION ingresar_sacar_carrito() 
	RETURNS TRIGGER 
	LANGUAGE plpgsql
	AS $$
	DECLARE
	
		tipo_operacion VARCHAR(50) := TG_OP;
		disponible_estante INT;
		id_estante INT;
		
	BEGIN
	
		IF upper(tipo_operacion) = 'INSERT' THEN
			
			--Buscando la disponibilidad del estante y su id
			SELECT e.disponible, e.id INTO disponible_estante, id_estante FROM factura AS f
			INNER JOIN cliente AS cl ON cl.id = f.id_cliente
			INNER JOIN visita AS v ON v.id_cliente = cl.id
			INNER JOIN sucursal AS s ON s.id = v.id_sucursal
			INNER JOIN estante AS e ON e.id_sucursal = s.id
			WHERE e.id_producto = new.id_producto AND f.id = new.id_factura
			ORDER BY v.fecha_entrada DESC
			LIMIT 1;
			
			--Actualizando la cantidad de producto restante en el estante
			disponible_estante:= disponible_estante - new.cantidad;
			
			UPDATE estante
			SET disponible = disponible_estante
			WHERE id=id_estante;
			
		ELSE
			--Buscando la disponibilidad del estante y su id
			SELECT e.disponible, e.id INTO disponible_estante, id_estante FROM factura AS f
			INNER JOIN cliente AS cl ON cl.id = f.id_cliente
			INNER JOIN visita AS v ON v.id_cliente = cl.id
			INNER JOIN sucursal AS s ON s.id = v.id_sucursal
			INNER JOIN estante AS e ON e.id_sucursal = s.id
			WHERE e.id_producto = old.id_producto AND f.id = old.id_factura
			ORDER BY v.fecha_entrada DESC
			LIMIT 1;
			
			--Actualizando la cantidad de producto del estante
			disponible_estante:= disponible_estante + old.cantidad;
			
			UPDATE estante
			SET disponible=disponible_estante
			WHERE id=id_estante;
		
		END IF;
		
		RETURN NEW;
		
	END $$;

	-- Creando trigger
	CREATE TRIGGER ingresar_sacar_carrito
	AFTER INSERT OR DELETE
	ON carrito
	FOR EACH ROW
	EXECUTE PROCEDURE ingresar_sacar_carrito();
	

--Trigger que haga que un cliente no saque o meta en el estante una cantidad de producto mayor a la que hay o se puede tener

    CREATE OR REPLACE FUNCTION verificar_estante() 
    RETURNS TRIGGER 
    LANGUAGE plpgsql
    AS $$
    DECLARE
	
        disponible_estante INT;
        id_estante INT;
		tipo_operacion VARCHAR(50) := TG_OP;
		capacidad_estante INT;
		id_sucursal INT;
		cantidad_verificar INT;
	
    BEGIN
	
		IF upper(tipo_operacion) = 'INSERT' THEN
			
			--Buscando el id del estante
			SELECT e.disponible, e.id INTO disponible_estante, id_estante FROM factura AS f
				INNER JOIN cliente AS cl ON cl.id = f.id_cliente
				INNER JOIN visita AS v ON v.id_cliente = cl.id
				INNER JOIN sucursal AS s ON s.id = v.id_sucursal
				INNER JOIN estante AS e ON e.id_sucursal = s.id
				WHERE e.id_producto = new.id_producto AND f.id = new.id_factura
				ORDER BY v.fecha_entrada DESC
				LIMIT 1;

			--Si la cantidad que se quiere extraer es mayor a lo disponible
			IF (NEW.cantidad > disponible_estante) THEN

				RAISE EXCEPTION 'Error, el estante no tiene suficiente cantidad del producto';

			END IF;
			
		ELSE
		
			--Buscando el id del estante
			SELECT e.disponible, e.id, e.capacidad, s.id INTO disponible_estante, id_estante, capacidad_estante, id_sucursal FROM factura AS f
				INNER JOIN cliente AS cl ON cl.id = f.id_cliente
				INNER JOIN visita AS v ON v.id_cliente = cl.id
				INNER JOIN sucursal AS s ON s.id = v.id_sucursal
				INNER JOIN estante AS e ON e.id_sucursal = s.id
				WHERE e.id_producto = OLD.id_producto AND f.id = OLD.id_factura
				ORDER BY v.fecha_entrada DESC
				LIMIT 1;
				
			cantidad_verificar := OLD.cantidad + disponible_estante;
			
			--Si la cantidad que se quiere devolver sobrepasa capacidad del estante
			IF (cantidad_verificar > capacidad_estante) THEN

				UPDATE sucursal
				SET inventario = inventario + OLD.cantidad
				WHERE id = id_sucursal;
				
				UPDATE estante 
				SET disponible = (disponible - OLD.cantidad) 
				WHERE id = id_estante;

			END IF;
		
		END IF;
		
        RETURN NEW;
		
    END $$;
	
    -- Creando trigger
    CREATE TRIGGER verificar_estante
    AFTER INSERT OR DELETE
    ON carrito
    FOR EACH ROW
    EXECUTE PROCEDURE verificar_estante();
	

--Trigger que valide el ingreso con mascarilla y temperatura mandando un mensaje

    CREATE OR REPLACE FUNCTION mascarilla_temperatura_mensaje() 
    RETURNS TRIGGER 
    LANGUAGE plpgsql
    AS $$
    DECLARE
		
    BEGIN
	
		--Validando tapaboca, si tiene guardar mensaje que lo posee 
		IF new.tapaboca = true THEN
			INSERT INTO mensaje(mensaje, fecha, id_visita)
			VALUES ('Tiene tapaboca, puede entrar', new.fecha_entrada, new.id);
		--Si no tiene tapaboca guardar mensaje que no lo posee 
		ELSE
			INSERT INTO mensaje(mensaje, fecha, id_visita)
			VALUES ('No tiene tapaboca, no puede entrar', new.fecha_entrada, new.id);
		
		END IF;
		
		--Validando temperatura, si tiene baja, media, alta reportar
		IF new.temperatura < 38 THEN
			INSERT INTO mensaje(mensaje, fecha, id_visita)
			VALUES ('Temperatura adecuada, puede entrar', new.fecha_entrada, new.id);
		
		ELSIF new.temperatura >= 38 AND new.temperatura > 40 THEN
			INSERT INTO mensaje(mensaje, fecha, id_visita)
			VALUES ('Temperatura muy alta, no puede entrar', new.fecha_entrada, new.id);
		
		ELSE 
			INSERT INTO mensaje(mensaje, fecha, id_visita)
			VALUES ('Temperatura muy alta, no puede entrar. Estamos llamando una ambulancia!', new.fecha_entrada, new.id);
		
		END IF;
		
        RETURN NEW;
		
    END $$;
	
    -- Creando trigger
    CREATE TRIGGER mascarilla_temperatura_mensaje
    AFTER INSERT
    ON visita
    FOR EACH ROW
    EXECUTE PROCEDURE mascarilla_temperatura_mensaje();
	

--Trigger que la persona no puede salir del establecimiento si no ha pagado los productos desde la app

    CREATE OR REPLACE FUNCTION factura_pagada() 
    RETURNS TRIGGER 
    LANGUAGE plpgsql
    AS $$
    DECLARE
    BEGIN
			
			--Colocando que la persona pago la factura
			IF (new.pagado = false) THEN
				
				UPDATE factura
            	SET pagado = true
            	WHERE ID = new.id;
				
			END IF;      
			
        RETURN NEW;

    END $$;

    -- Creando trigger
    CREATE TRIGGER factura_pagada
    AFTER UPDATE
    ON factura
    FOR EACH ROW
    EXECUTE PROCEDURE factura_pagada();
	
	
-- Trigger que cuando se agrega una visita donde el tiempo_visita es distinto a ‘00:00:00’ 
-- entonces se crea una factura vacía para el cliente	
	
	CREATE OR REPLACE FUNCTION crear_factura_por_visita() 
    RETURNS TRIGGER 
    LANGUAGE plpgsql
    AS $$
    DECLARE
		--Datos para sacar una tarjeta random entre las dos propuestas
	 	tarjeta_debito character varying = 'Debito';
		tarjeta_credito character varying = 'Cedito';
		tipo_tarjeta character varying;
		num_random_tarjeta INT;
		
		--Datos para sacar un banco random entre los propuestos
		banco_1 character varying = 'Bancamiga';
		banco_2 character varying = 'Banesco';
		banco_3 character varying = 'Mercantil Panamá';
		tipo_banco character varying;
		num_random_banco INT;
		
		
    BEGIN
			
			--Si el tiempo de la visita es igual a 00:00:00, no hacer nada
			IF (new.tiempo_visita = '00:00:00') THEN
			
			--Si el tiempo de la visita es diferente a 00:00:00, crear factura
			ELSE
				--Seleccionar un num random entre 0 y 1 para sacar la tarjeta
				SELECT random() * 2 + 0 INTO num_random_tarjeta;
				--Depende del num que sale en el random se asigna la tarjeta
				IF num_random_tarjeta < 1 THEN
					tipo_tarjeta = 'Debito';
				ELSE
					tipo_tarjeta = 'Credito';
				END IF;
				
				--Seleccionar un num random entre 0 y 2 para sacar el banco
				SELECT random() * 3 + 0 INTO num_random_banco;
				--Depende del num que sale en el random se asigna el banco
				IF num_random_banco < 1 THEN
					tipo_banco = 'Bancamiga';
				ELSIF num_random_banco < 2 THEN
					tipo_banco = 'Banesco';
				ELSE
					tipo_banco ='Mercantil Panamá';
				END IF;
					
				--Insertando factura
		  		INSERT INTO public.factura(total, fecha, tipo_de_tarjeta, banco, total_con_descuento, pagado, id_cliente)
    			VALUES (0, new.fecha_salida, tipo_tarjeta, tipo_banco, 0, false, new.id_cliente);
			
			
			END IF;
		
        RETURN NEW;
		
    END $$;
	
    -- Creando trigger
    CREATE TRIGGER crear_factura_por_visita
    AFTER INSERT 
    ON visita
    FOR EACH ROW
    EXECUTE PROCEDURE crear_factura_por_visita();
	
	
--Trigger que cuando se agregue un producto al carrito se busque el precio del producto y se le agregue
	
	CREATE OR REPLACE FUNCTION agregar_costo_producto_al_carrito() 
    RETURNS TRIGGER 
    LANGUAGE plpgsql
    AS $$
    DECLARE
		--Variable para guardar el precio del producto seleccionado
		precio_producto numeric(8,2); 
    BEGIN
			--Buscando y guardando el precio/costo del producto seleccionado
			SELECT c.costo INTO precio_producto FROM costo AS c
			WHERE c.id_producto = new.id_producto
			ORDER BY c.fecha DESC;
			
			--Actualizando el carrito con el precio/costo del producto correcto
			UPDATE public.carrito
			SET precio = precio_producto
			WHERE id_factura =new.id_factura AND id_producto =new.id_producto;
		
        RETURN NEW;
		
    END $$;
	
    -- Creando trigger
    CREATE TRIGGER agregar_costo_producto_al_carrito
    AFTER INSERT 
    ON carrito
    FOR EACH ROW
    EXECUTE PROCEDURE agregar_costo_producto_al_carrito();
	
		
	


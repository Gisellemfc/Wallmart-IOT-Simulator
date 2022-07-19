		#                   PROYECTO 1
		# Integrantes:  Nicole Brito. Carnet: 20181110056
		#               Giselle Ferreira. Carnet: 20181110399


# CONEXIÓN A LA BASE DE DATOS Y MÉTODOS

#Importaciones
import psycopg2
import json
import random
import numpy as np
import pandas as pd


#Conexión a la Base de datos
def connection():
    connection = psycopg2.connect(
        user = "yyieabru",
        password = "RzP7L4DpqHP_TR7T-zz0jwPvjqN4afEX",
        host = "batyr.db.elephantsql.com",
        port = "5432",
        database = "yyieabru"
    )
    return connection


#Buscar la fecha de entrada de la ultima visita
def select_ultima_fecha(query):

    try:
        #Conexión con la BD
        conexion = connection()
        cursor = conexion.cursor()

        #Query para traer la ultima fecha
        cursor.execute(query)
        ultima_fecha = cursor.fetchone()

        #Cerrar conexión
        close_connection(conexion)

        #Devolver la ultima fecha
        return ultima_fecha

    #Error
    except (Exception, psycopg2.Error) as error:

        print('Error buscando la data',error)


#Insertar visita de cliente a sucursal
def insertar_visita(temperatura, tapaboca, tiempo_visita, fecha_entrada, fecha_salida, id_cliente, id_sucursal):
   
    #Conexión con la BD
    con = connection()
    cur = con.cursor()
    #Query que inserta la visita del cliente 
    cur.execute("""
        INSERT INTO public.visita
        (temperatura, tapaboca, tiempo_visita, fecha_entrada, fecha_salida, id_cliente, id_sucursal)
	    VALUES (%s, %s, %s, %s, %s, %s, %s);""",
        (float(temperatura), tapaboca, tiempo_visita, fecha_entrada, fecha_salida, int(id_cliente), int(id_sucursal)))
    con.commit()
    #Cerrar conexión
    close_connection(con)


#Comprar en la sucursal
def comprar(cliente):

    try:
        #Conexión con la BD
        con = connection()
        cur = con.cursor()
        
        #Transacción que lleva la compra del cliente
        #Aquí la persona selecciona unos productos con sus cantidad respectivas
        #y decide cuales de los mismos desea devolver a los estantes
        #Al finalizar la compra, se calcula el total, total con descuento si aplica y se aplica en factura
        cur.execute("""
        
            BEGIN;
            DO
            $$
            DECLARE

                producto RECORD;
                cant_productos INT;
                num_productos INT;
                id_fact INT;
                cantidad INT;
                factura_carrito RECORD;
                total_con_des numeric(16,2);
                total_sin_descuento numeric(16,2) := 0;
                afiliado_cliente BOOLEAN;

            BEGIN

                SELECT f.id INTO id_fact FROM factura AS f
                INNER JOIN cliente AS c ON c.id = f.id_cliente
                INNER JOIN visita AS v ON v.id_cliente = c.id
                WHERE c.id = %s
                ORDER BY f.fecha DESC
                LIMIT 1;

                SELECT COUNT(*) INTO num_productos FROM estante AS e
                INNER JOIN producto AS p ON e.id_producto = p.id
                WHERE e.id_sucursal = %s;
                
                SELECT floor(random() * 15 + 2)::int INTO cant_productos;
                
                FOR producto IN 
                (SELECT p.id AS "id", p.nombre AS "nombre" FROM estante AS e
                INNER JOIN producto AS p ON e.id_producto = p.id
                WHERE e.id_sucursal = %s
                OFFSET FLOOR(RANDOM() * num_productos + 2) 
                LIMIT cant_productos)
                LOOP
                
                    SELECT floor(random() * 10 + 1)::int INTO cantidad;

                    INSERT INTO carrito(
                    precio, cantidad, id_factura, id_producto)
                    VALUES (0, cantidad, id_fact, producto."id");
                    
                    IF(SELECT (ROUND(RANDOM())::INT)::BOOLEAN) THEN
                    
                        IF EXISTS (SELECT * FROM carrito WHERE id_factura = id_fact AND id_producto <> producto."id") THEN

                            DELETE FROM carrito
                            WHERE id_factura = id_fact AND id_producto = producto."id";
                        
                        END IF;
                    
                    END IF;

                END LOOP;
                
                FOR factura_carrito IN 
                (SELECT c.precio AS "precio", c.cantidad AS "cantidad" FROM carrito AS c
                INNER JOIN factura AS f ON f.id = c.id_factura
                WHERE f.id = id_fact)
                LOOP
                    
                    total_sin_descuento = total_sin_descuento + (factura_carrito."precio" * factura_carrito."cantidad");
                    
                END LOOP;

                IF (total_sin_descuento = 0) THEN

                    SELECT floor(random() * 10 + 1)::int INTO cantidad;

                    INSERT INTO carrito(
                    precio, cantidad, id_factura, id_producto)
                    VALUES (0, cantidad, id_fact, 1);

                    FOR factura_carrito IN 
                    (SELECT c.precio AS "precio", c.cantidad AS "cantidad" FROM carrito AS c
                    INNER JOIN factura AS f ON f.id = c.id_factura
                    WHERE f.id = id_fact)
                    LOOP
                    
                        total_sin_descuento = total_sin_descuento + (factura_carrito."precio" * factura_carrito."cantidad");
                    
                    END LOOP;

                END IF;
                    
                --Buscando si el cliente es afiliado
                SELECT c.afiliado INTO afiliado_cliente FROM cliente AS c
                WHERE c.id = %s;
                
                --Si el cliente no es afiliado, no hacer nada
                IF afiliado_cliente = false THEN
                    
                    total_con_des = total_sin_descuento;
                        
                --Si el cliente es afiliado, ejecuta
                ELSE
                    total_con_des = (total_sin_descuento -(total_sin_descuento * 0.05));
                    
                END IF;
                
                UPDATE factura
                SET total = total_sin_descuento, total_con_descuento = total_con_des
                WHERE id = id_fact;
            
            END;
            $$;
            COMMIT;

        """,
        (cliente['id_cliente'], cliente['id_sucursal'], cliente['id_sucursal'], cliente['id_cliente']))
        
        #Mensaje que indica que el cliente termino su compra
        print("El cliente " + cliente['id_cliente'] + " terminó su compra en la sucursal " + cliente['id_sucursal'] + " y se guardó en la base de datos.")
    
    #Error
    except (Exception, psycopg2.Error) as error:
        #Si hay error, imprimir mensaje y hacer Rollback de la transaccion
        print("Error buscando los productos de la compra", error)
        con = connection()
        cur = con.cursor()
        cur.execute("""ROLLBACK;""")

    finally:
        #Cerrar conexión
        cur.close()
        close_connection(con)


#Streamlit relacionado a cuáles son las categorías de producto que 
#se venden mejor en cada una de las tiendas
def streamlit_categorias(tienda):

    try:
        #Conexión con la BD
        con = connection()
        #Si es la castellana
        if (tienda == "La Castellana"):
            #Query
            query = """SELECT ca.nombre AS Categoria, SUM(c.cantidad) AS Cantidad FROM carrito AS c
                        INNER JOIN categoria_producto AS cp ON cp.id_producto = c.id_producto
                        INNER JOIN categoria AS ca ON ca.id = cp.id_categoria
                        INNER JOIN factura AS f ON f.id = c.id_factura
                        INNER JOIN cliente AS cl ON cl.id = f.id_cliente
                        INNER JOIN visita AS v ON v.id_cliente = cl.id
                        WHERE v.fecha_salida = f.fecha AND v.id_sucursal = 1
                        GROUP BY ca.nombre
                        ORDER BY cantidad DESC
                        LIMIT 5;"""

        #Si es el hatillo
        else:
            #Query
            query = """SELECT ca.nombre as Categoria, SUM(c.cantidad) AS Cantidad FROM carrito AS c
                        INNER JOIN categoria_producto AS cp ON cp.id_producto = c.id_producto
                        INNER JOIN categoria AS ca ON ca.id = cp.id_categoria
                        INNER JOIN factura AS f ON f.id = c.id_factura
                        INNER JOIN cliente AS cl ON cl.id = f.id_cliente
                        INNER JOIN visita AS v ON v.id_cliente = cl.id
                        WHERE v.fecha_salida = f.fecha AND v.id_sucursal = 2
                        GROUP BY ca.nombre
                        ORDER BY cantidad DESC
                        LIMIT 5;"""

        df = pd.read_sql(query, con)
        return df

    #Error
    except (Exception, psycopg2.Error) as error:

        print("Se ha producido un error buscando el top de categorías: ", error)


#Streamlit relacionado a los bancos que prefieren los clientes
def streamlit_banco_afiliados(tienda):

    try:
        #Conexión con la BD
        con = connection()  

        #Si es la castellana
        if (tienda == "La Castellana"):
            #Query
            query = """SELECT f.banco AS Banco, COUNT(f.banco) AS Compras FROM factura AS f
                        INNER JOIN cliente AS c ON c.id = f.id_cliente
                        INNER JOIN visita AS v ON v.id_cliente = c.id
                        WHERE v.fecha_salida = f.fecha AND v.id_sucursal = 1 AND c.afiliado = true
                        GROUP BY f.banco
                        ORDER BY compras DESC;"""

        #Si es el hatillo
        else:
            #Query
            query = """SELECT f.banco AS Banco, COUNT(f.banco) AS Compras FROM factura AS f
                        INNER JOIN cliente AS c ON c.id = f.id_cliente
                        INNER JOIN visita AS v ON v.id_cliente = c.id
                        WHERE v.fecha_salida = f.fecha AND v.id_sucursal = 2 AND c.afiliado = true
                        GROUP BY f.banco
                        ORDER BY compras DESC;"""

        df = pd.read_sql(query, con)
        return df

    #Error
    except (Exception, psycopg2.Error) as error:

        print("Se ha producido un error buscando el mejor banco de los afiliados: ", error)


#Streamlit relacionado a las categorias que prefieren los clientes
def streamlit_categoria_afiliados(tienda):

    try:
        #Conexión con la BD
        con = connection()
        #Si es la castellana
        if (tienda == "La Castellana"):
            #Query
            query = """SELECT ca.nombre AS categoria, SUM(c.cantidad) AS cantidad FROM carrito AS c
                        INNER JOIN categoria_producto AS cp ON cp.id_producto = c.id_producto
                        INNER JOIN categoria AS ca ON ca.id = cp.id_categoria
                        INNER JOIN factura AS f ON f.id = c.id_factura
                        INNER JOIN cliente AS cl ON cl.id = f.id_cliente
                        INNER JOIN visita AS v ON v.id_cliente = cl.id 
                        WHERE v.fecha_salida = f.fecha AND v.id_sucursal = 1 AND cl.afiliado = true
                        GROUP BY ca.nombre
                        ORDER BY cantidad DESC;"""

        #Si es el hatillo
        else:
            #Query
            query = """SELECT ca.nombre AS categoria, SUM(c.cantidad) AS cantidad FROM carrito AS c
                        INNER JOIN categoria_producto AS cp ON cp.id_producto = c.id_producto
                        INNER JOIN categoria AS ca ON ca.id = cp.id_categoria
                        INNER JOIN factura AS f ON f.id = c.id_factura
                        INNER JOIN cliente AS cl ON cl.id = f.id_cliente
                        INNER JOIN visita AS v ON v.id_cliente = cl.id 
                        WHERE v.fecha_salida = f.fecha AND v.id_sucursal = 2 AND cl.afiliado = true
                        GROUP BY ca.nombre
                        ORDER BY cantidad DESC;"""

        df = pd.read_sql(query, con)
        return df

    #Error
    except (Exception, psycopg2.Error) as error:

        print("Se ha producido un error buscando la mejor categoría de los afiliados: ", error)


#Streamlit relacionado a la sucursal que prefieren los clientes
def streamlit_sucursal_afiliados():

    try:
        #Conexión con la BD
        con = connection()
        #Query
        query = """SELECT v.id_sucursal AS sucursal, COUNT(v.id_sucursal) AS visitas FROM cliente AS cl
                    INNER JOIN visita AS v ON v.id_cliente = cl.id
                    WHERE cl.afiliado = true
                    GROUP BY v.id_sucursal
                    ORDER BY visitas DESC;"""

        df = pd.read_sql(query, con)
        return df

    #Error
    except (Exception, psycopg2.Error) as error:

        print("Se ha producido un error buscando la mejor categoría de los afiliados: ", error)


#Streamlit relacionado a qué día de la semana 
#y a qué hora existen mayor número de ventas 
#en cada tienda
def streamlit_dia_hora_ventas(tienda):

    try:
        #Conexión con la BD
        con = connection()

        #Si es la castellana
        if (tienda == "La Castellana"):
            #Query
            query = """SELECT f.id AS factura, f.fecha AS fecha FROM factura AS f
                        INNER JOIN cliente AS c ON c.id = f.id_cliente
                        INNER JOIN visita AS v ON v.id_cliente = c.id
                        WHERE v.fecha_salida = f.fecha AND v.id_sucursal = 1;"""
        
        #Si es el hatillo
        else:
            #Query
            query = """SELECT f.id AS factura, f.fecha AS fecha FROM factura AS f
                        INNER JOIN cliente AS c ON c.id = f.id_cliente
                        INNER JOIN visita AS v ON v.id_cliente = c.id
                        WHERE v.fecha_salida = f.fecha AND v.id_sucursal = 2;"""

        df = pd.read_sql(query, con)
        return df

    #Error
    except (Exception, psycopg2.Error) as error:

        print("Se ha producido un error buscando la mejor categoría de los afiliados: ", error)


#Cerrar conexión de la BD
def close_connection(connection):
    if connection:
        connection.close()



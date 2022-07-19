		#                   PROYECTO 1
		# Integrantes:  Nicole Brito. Carnet: 20181110056
		#               Giselle Ferreira. Carnet: 20181110399


# SUSCRIPTOR DE LAS ENTRADAS WALLMART DE AMBAS SUCURSALES

#Importaciones
import sys
import threading
import time
import paho.mqtt.client
import psycopg2
import db as conexionBD
import json


#Variables a utilizar
#Variables para llevar la cola de los clientes en cada sucursal cuando la misma esta llena
cola_la_castellana = []
cola_el_hatillo = []
#Variables para llevar los clientes en cada sucursal
clientes_la_castellana = []
clientes_el_hatillo = []


#Método para verificar la visita de los clientes
def verificar_visita(cliente):

	try:
		#Si el cliente no cumple con el tapaboca, ejecuta
		if(cliente['tapaboca'] == 'false'):
			
			#Imprimir mensaje que no puede entrar e ingresar la "visita" del cliente a la sucursal
			print('El cliente ' + cliente['id_cliente'] +' no puede entrar en la sucursal ' + cliente['id_sucursal'] + ', porque no tiene tapaboca')
			conexionBD.insertar_visita(cliente['temperatura'], cliente['tapaboca'], cliente['tiempo_visita'], cliente['fecha_entrada'], cliente['fecha_salida'], cliente['id_cliente'], cliente['id_sucursal'])
			#Retorna false porque no puede entrar a comprar
			return False

		#Si el cliente cumple con la temperatura alta, ejecuta
		elif (float(cliente['temperatura']) >= 38 and float(cliente['temperatura']) < 40):

			#Imprimir mensaje que no puede entrar e ingresar la "visita" del cliente a la sucursal
			print('El cliente ' + cliente['id_cliente'] +' no puede entrar en la sucursal ' + cliente['id_sucursal'] + ', porque tiene la temperatura muy alta')
			conexionBD.insertar_visita(cliente['temperatura'], cliente['tapaboca'], cliente['tiempo_visita'], cliente['fecha_entrada'], cliente['fecha_salida'], cliente['id_cliente'], cliente['id_sucursal'])
			#Retorna false porque no puede entrar a comprar
			return False

		#Si el cliente cumple con la temperatura ambulancia, ejecuta
		elif (float(cliente['temperatura']) >= 40):

			#Imprimir mensaje que no puede entrar e ingresar la "visita" del cliente a la sucursal
			print('El cliente ' + cliente['id_cliente'] +' no puede entrar en la sucursal ' + cliente['id_sucursal'] + ', porque llamaremos una ambulancia por su alta temperatura')
			conexionBD.insertar_visita(cliente['temperatura'], cliente['tapaboca'], cliente['tiempo_visita'], cliente['fecha_entrada'], cliente['fecha_salida'], cliente['id_cliente'], cliente['id_sucursal'])
			#Retorna false porque no puede entrar a comprar
			return False

		#Si el cliente cumple con el tapaboca y con la temperatura, ejecuta
		else:
			#Imprimir mensaje que puede entrar e ingresar la visita del cliente a la sucursal
			print('El cliente ' + cliente['id_cliente'] + ' puede entrar en la sucursal ' + cliente['id_sucursal'])
			conexionBD.insertar_visita(cliente['temperatura'], cliente['tapaboca'], cliente['tiempo_visita'], cliente['fecha_entrada'], cliente['fecha_salida'], cliente['id_cliente'], cliente['id_sucursal'])
			#Retorna true porque puede entrar a comprar
			return True
	#Error
	except (Exception, psycopg2.Error) as error:

		print('Error en la entrada de la tienda: ', error)


#Método ejecutar la tienda de La Castellana
def ejecutar_tienda_la_castellana():

	while(True):
		#Si no hay clientes, ejecuta
		if (len(clientes_la_castellana) == 0):
			#Imprimir mensajes que no hay clientes
			print('No clientes en el Wallmart La Castellana')
			time.sleep(2)

		#Si hay clientes, ejecuta
		else:
			#Se usa el método verificar_visita para ver si la persona puede entrar 
			# al tener tapaboca y buena temperatura, si es así, ejecuta
			if (verificar_visita(clientes_la_castellana[0]) == True):
				#Imprimir mensaje que el cliente ingresa y está comprando
				print('El cliente ' + clientes_la_castellana[0]['id_cliente'] + ' está comprando en La Castellana')
				#Se ejecuta comprar para simular la compra del cliente en la sucursal
				conexionBD.comprar(clientes_la_castellana[0])
			#Al finalizar la compra, se saca al cliente
			clientes_la_castellana.pop(0)
		
		#Al sacar el cliente, si hay personas en cola y ya disminuyeron la cantidad de clientes dentro
		#de la sucursal, ejecuta
		if ((len(clientes_la_castellana) < 20) and (len(cola_la_castellana) > 0)):
			#liberar puestos ocupados
			puestos_libres = 20 - len(clientes_la_castellana)
			#Ingresar cliente que se encontraban en la cola esperando para entrar y sacarlo de la cola
			for i in range(puestos_libres):

				clientes_la_castellana.append(cola_la_castellana[0])
				cola_la_castellana.pop(0)    


#Método ejecutar la tienda del Hatillo
def ejecutar_tienda_el_hatillo():

	while(True):
		#Si no hay clientes, ejecuta
		if (len(clientes_el_hatillo) == 0):
			#Imprimir mensajes que no hay clientes
			print('No clientes en el Wallmart El Hatillo')
			time.sleep(2)

		#Si hay clientes, ejecuta
		else:
			#Se usa el método verificar_visita para ver si la persona puede entrar 
			#al tener tapaboca y buena temperatura, si es así, ejecuta
			if (verificar_visita(clientes_el_hatillo[0]) == True):
				#Imprimir mensaje que el cliente ingresa y está comprando
				print('El cliente ' + clientes_el_hatillo[0]['id_cliente'] + ' está comprando en El Hatillo')
				#Se ejecuta comprar para simular la compra del cliente en la sucursal
				conexionBD.comprar(clientes_el_hatillo[0])
			#Al finalizar la compra, se saca al cliente
			clientes_el_hatillo.pop(0)
			
		#Al sacar el cliente, si hay personas en cola y ya disminuyeron la cantidad de clientes dentro
		#de la sucursal, ejecuta
		if ((len(clientes_el_hatillo) < 20) and (len(cola_el_hatillo) > 0)):
			#liberar puestos ocupados
			puestos_libres = 20 - len(clientes_el_hatillo)
			#Ingresar cliente que se encontraban en la cola esperando para entrar y sacarlo de la cola
			for i in range(puestos_libres):

				clientes_el_hatillo.append(cola_el_hatillo[0])
				cola_el_hatillo.pop(0)  


#Método para llevar las colas de las entradas de las sucursales
def cola_entrada(cliente):
	#Verificar sucursal
	if (cliente['id_sucursal'] == '1'):
		#Si hay menos de 20 personas
		if (len(clientes_la_castellana) < 20):
			#El cliente entra
			clientes_la_castellana.append(cliente)
		#Si hay más de 20 personas
		else:
			#Imprimir mensaje que esta llena la sucursal y mandar al cliente a la cola
			print('Wallmart de La Castellana está lleno, el cliente ' + cliente['id_cliente'] + ' esperará en cola')
			cola_la_castellana.append(cliente)
	#Verificar sucursal
	else:
		#Si hay menos de 20 personas
		if (len(clientes_el_hatillo) < 20):
			#El cliente entra
			clientes_el_hatillo.append(cliente)
		#Si hay más de 20 personas
		else:
			#Imprimir mensaje que esta llena la sucursal y mandar al cliente a la cola
			print('Wallmart de El Hatillo está lleno, el cliente ' + cliente['id_cliente'] + ' esperará en cola')
			cola_el_hatillo.append(cliente)


#Suscritor
def suscriptor_entrada():
	client = paho.mqtt.client.Client(client_id='Wallmart_subs', clean_session=False)
	client.on_connect = on_connect
	client.on_message = on_message
	client.connect(host='127.0.0.1', port=1883)
	client.loop_forever()


#Conexion
def on_connect(client, userdata, flags, rc):
	print('connected (%s)' % client._client_id)
	client.subscribe(topic='Wallmart/#', qos=2)


def on_message(client, userdata, message):

	try:
		#Recibida la data del pub, transformarla
		cliente = json.loads(message.payload.decode('utf-8'))
		#Ejecutar método cola_entrada para verificar si el cliente debe hacer cola
		cola_entrada(cliente)

	#Error
	except (Exception, psycopg2.Error) as error:

		print("Error while connecting to PostgreSQL", error)


def main():
	#Hilos
	#Hilo para la entrada 
	entrada = threading.Thread(target = suscriptor_entrada)
	entrada.start()
	#Hilo para la tienda de La Castellana
	tienda_la_castellana = threading.Thread(target = ejecutar_tienda_la_castellana)
	tienda_la_castellana.start()
	#Hilo para la tienda de El Hatillo
	tienda_el_hatillo = threading.Thread(target = ejecutar_tienda_el_hatillo)
	tienda_el_hatillo.start()


if __name__ == '__main__':
	main()

sys.exit(0)
		#                   PROYECTO 1
		# Integrantes:  Nicole Brito. Carnet: 20181110056
		#               Giselle Ferreira. Carnet: 20181110399


# PUBLICADOR ENTRADA PARA EL WALLMART LA CASTELLANA

#Importaciones
import ssl
import sys
import json
import random
import time
import paho.mqtt.client
import paho.mqtt.publish
import numpy as np
import datetime
import psycopg2
import db as conexionBD
import json
import math

#Definición de on_connect para saber si estoy conectado
def on_connect(client, userdata, flags, rc):
	print('conectado publicador')

def main():

	#Información del publicador
	  #Cliente
	client = paho.mqtt.client.Client("Entrada_La_Castellana", False)
	  #Calidad del Servicio
	client.qos = 0
	  #Conexión
	client.connect(host='localhost')

	#Query que busca la última fecha de entrada en la sucursal para hacerla la Hora base para trabajar
	query = """SELECT fecha_entrada FROM visita WHERE id_sucursal = 1 ORDER BY ID DESC LIMIT 1;"""
	#Asignando la Hora base de la fecha de entrada de un cliente
	fecha_entrada= conexionBD.select_ultima_fecha(query)

	#Si la fecha de entrada asignada es nula, ejecuta
	if (fecha_entrada == None):
		#Tomando el día de la computadora
		fecha_entrada = datetime.datetime.today()
		#Asignando, que en ese día, empiece a las 9am la simulación
		fecha_entrada = fecha_entrada.replace(hour=9, minute=0, second=0, microsecond=0)
	
	#Si la fecha de entrada que se buscó tiene como última hora las 19 horas/hora anterior al cierre de la sucursal, ejecuta
	elif(fecha_entrada[0].hour == 19):
		#Se cambia la fecha que se tiene por la del día siguiente
		fecha_entrada = fecha_entrada[0] + datetime.timedelta(days=1)
		#Se asigna que la hora de comienzo es a las 9am/hora que abre la sucursal y puede comenzar a ir la gente 
		fecha_entrada = fecha_entrada.replace(hour=9, minute=0, second=0, microsecond=0)

	else:
		fecha_entrada = fecha_entrada[0]

	while(True):

		#Array de personas donde se ingresaran los clientes para luego mezclar el orden con que ingresan personas con o sin tapaboca
		personas = []

		#Canculando la cantidad de personas con y sin tapaboca que van a la sucursal
		personas_con_tapaboca = np.random.poisson(10)
		personas_sin_tapaboca = np.random.poisson(15)

		#Calculando el tiempo de visita entre clientes para que no todos entren a la misma hora
		# Son 60 min entre la cantidad de clientes con o sin tapaboca que asisten, 
		tiempo_entre_visita = round(60 / (personas_con_tapaboca + personas_sin_tapaboca))

		#While para sacar la información de todas las personas con tapaboca que asisten
		while(personas_con_tapaboca > 0):
			#Calculando temperatura de la persona con tapaboca
			temperatura = round(random.uniform(35.0, 42.0),2)
			mensaje_tapaboca = 'Si tiene tapaboca'

			if temperatura < 38:

				#Mensaje si la temperatura es menor a 38
				mensaje_temperatura = "Tu temperatura está bien"

			elif temperatura >= 38 and temperatura < 40:

				#Mensaje si la temperatura es mayor o igual a 38 y menor que 40
				mensaje_temperatura = "Tu temperatura es muy alta, no puedes entrar"

			elif temperatura >= 40:
				#Mensaje si la temperatura es mayor o igual a 40
				mensaje_temperatura = "Tu temperatura es demasiado alta, estamos llamando a la ambulancia"

			payload = {
				#Sacando id random del cliente
				"id_cliente": str(np.random.randint(1,100)),
				#Sucursal de la castellana = id: 1
				"id_sucursal": '1',
				"tapaboca": 'true',
				"temperatura": str(temperatura),
				"mensaje_tapaboca": mensaje_tapaboca,
				"mensaje_temperatura": mensaje_temperatura
			}

			#Guardando persona en el array con su info
			personas.append(payload)
			#Restando la cantidad de personas que tiene tapaboca para "hacerles" la información correspondiente
			personas_con_tapaboca = personas_con_tapaboca - 1

		#While para sacar la información de todas las personas sin tapaboca que asisten
		while(personas_sin_tapaboca > 0):
			#Calculando temperatura de la persona sin tapaboca
			temperatura = round(random.uniform(35.0, 42.0),2)
			mensaje_tapaboca = 'No tiene tapaboca'

			if temperatura < 38:
				#Mensaje si la temperatura es menor a 38
				mensaje_temperatura = "Tu temperatura está bien"

			elif temperatura >= 38 and temperatura < 40:
				#Mensaje si la temperatura es mayor o igual a 38 y menor que 40
				mensaje_temperatura = "Tu temperatura es muy alta, no puedes entrar"

			elif temperatura >= 40:
				#Mensaje si la temperatura es mayor o igual a 40
				mensaje_temperatura = "Tu temperatura es demasiado alta, estamos llamando a la ambulancia"

			payload = {
				#Sacando id random del cliente
				"id_cliente": str(np.random.randint(1,10000)),
				#Sucursal de la castellana = id: 1
				"id_sucursal": '1',
				"tapaboca": 'false',
				"temperatura": str(temperatura),
				"mensaje_tapaboca": mensaje_tapaboca,
				"mensaje_temperatura": mensaje_temperatura
			}

			#Guardando persona en el array con su info
			personas.append(payload)
			#Restando la cantidad de personas que no tiene tapaboca para "hacerles" la información correspondiente
			personas_sin_tapaboca = personas_sin_tapaboca - 1			
		
		#Mezclando las personas ingresadas en el array para que ingresen de manera desordenada personas con o sin tapaboca
		random.shuffle(personas)

		#Recorrido por el array de personas para asignarles la fecha de entrada a cada uno
		for persona in personas:

			#Dato a ingresar
			persona["fecha_entrada"] = str(fecha_entrada)

			#Si la temperatura es mayor a 38, no puede visitar la sucursal
			if(persona["tapaboca"] == 'false' or float(persona["temperatura"]) >= 38):
				
				#No tendrá tiempo de visita
				tiempo_visita = '00:00:00'
				persona["tiempo_visita"] = str(tiempo_visita)
				#La fecha de entrada será igual a la fecha de salida porque no entró
				persona["fecha_salida"] = str(fecha_entrada)
			
			#Si puede entrar 
			else:
				
				#Se calcula el tiempo de visita
				tiempo_visita = round(np.random.normal(50, 15))
				#La fecha salida será igual a la fecha de entrada más el tiempo de visita
				persona["fecha_salida"] = str(fecha_entrada + datetime.timedelta(minutes = tiempo_visita))
				tiempo_visita = datetime.timedelta(minutes = tiempo_visita)
				persona["tiempo_visita"] = str(tiempo_visita)

			#Si la visita es luego de las 8pm se cambia la fecha
			if(fecha_entrada.hour == 20):
				#Se cambia la fecha que se tiene por la del día siguiente
				fecha_entrada = fecha_entrada + datetime.timedelta(days = 1)
				#Se asigna que la hora de comienzo es a las 9am/hora que abre la sucursal y puede comenzar a ir la gente 
				fecha_entrada = fecha_entrada.replace(hour=9, minute=0, second=0, microsecond=0)
			
			else:
				#Actualizando la fecha de entrada entre las personas que ingresan
				fecha_entrada = fecha_entrada + datetime.timedelta(minutes=tiempo_entre_visita)

			#Canal
			client.publish('Wallmart/La_Castellana',json.dumps(persona),qos=0)	
			#Imprimir mensaje de persona
			print('El cliente ' + persona['id_cliente'] + ' llegó a la sucursal ' + persona['id_sucursal'] + ' el ' + persona['fecha_entrada'] +
			'\nTapaboca: ' + persona['tapaboca'] + ' --> ' + persona['mensaje_tapaboca'] + 
			'\nTemperatura: ' + persona['temperatura'] + ' °C --> ' + persona['mensaje_temperatura'] + '\n')
			#Tiempo para la publicación de mensajes
			time.sleep(1)

if __name__ == '__main__':
	main()
	sys.exit(0)
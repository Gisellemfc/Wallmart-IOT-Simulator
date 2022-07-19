		#                   PROYECTO 1
		# Integrantes:  Nicole Brito. Carnet: 20181110056
		#               Giselle Ferreira. Carnet: 20181110399


# STREAMLIT DEL PROYECTO

#Importaciones
import streamlit as st
import db as conexionDB
import psycopg2
import pandas as pd
import plotly.express as px
import numpy as np
import calendar


#Titulo base
st.title('Wallmart Venezuela')

#Titulo bienvenida a las estadísticas
st.write('Bienvenidos al panel de estadísticas de Wallmart Venezuela.')

#Selectbox que te permite seleccionar y ver los datos de la sucursal que deseas 
tienda = st.sidebar.selectbox("Selecciona el Wallmart que desea revisar", ("La Castellana","El Hatillo"))

#Mensaje que indica de qué sucursal se ven los datos
st.write("Usted está viendo la información de Wallmart " + tienda)

#Titulo que indica la parte de las categorías más vendidas
st.title("Categorías más vendidas")

#Top 5 de categorías más vendidas
st.write("Top 5 de categorías más vendidas de Wallmart " + tienda)

#Ejecutar streamlit_categorias que busca el Top 5 de categorías más vendidas
top_categorias = conexionDB.streamlit_categorias(tienda)

#Si no hay Top 5 de categorías más vendidas
if(len(top_categorias) == 0):
	#Mensaje indicando que no hay
	st.write('No hay top de categorías en las sucursal de ' + tienda + '.')

#Si hay Top 5 de categorías más vendidas
else:
	#Pivot Table
	top_categorias_pivot = top_categorias.pivot_table(values = 'cantidad', index = 'categoria')
	top_categorias_pivot = top_categorias_pivot.reindex(top_categorias_pivot['cantidad'].sort_values(ascending=False).index)

	st.write(top_categorias_pivot)

	#Mensajes que indican el razonamiento del resultado 
	st.write('La categoría más vendida de la tienda de ' + tienda + ' es ' + top_categorias.loc[0, "categoria"] + " y se han vendido " + str(top_categorias.loc[0, "cantidad"]) + ' productos.')
	st.write('La categoría menos vendida de la tienda de ' + tienda + ' es ' + top_categorias.loc[4, "categoria"] + " y se han vendido " + str(top_categorias.loc[4, "cantidad"]) + ' productos.')
	st.write('Esto se debe a que la mayoría de los clientes de esta sucursal prefieren los productos de tipo ' + top_categorias.loc[0, "categoria"] + '.')

#Titulo que indica la parte de los bancos preferidos del programa de afiliados
st.title("Bancos preferidos del programa de afiliados")

#Ejecutar streamlit_banco_afiliados que busca los bancos preferidos del programa de afiliados
bancos_afiliados = conexionDB.streamlit_banco_afiliados(tienda)

#Si no hay
if(len(bancos_afiliados) == 0):
	#Mensaje indicando que no hay
	st.write('No hay compras de afiliados en las sucursal de ' + tienda + '.')

#Si hay
else:
	#Mostrar datos
	grafica_bancos_afiliados = px.histogram(bancos_afiliados, x="banco", y="compras", labels={"banco": "Bancos", "compras": "número de compras"})

	st.write(grafica_bancos_afiliados)

	#Mensajes que indican el razonamiento del resultado 
	st.write('El banco preferido de nuestro programa de afiliados en ' + tienda + ' es ' + bancos_afiliados.loc[0, "banco"] + " y se han hecho " + str(bancos_afiliados.loc[0, "compras"]) + ' compras.')
	st.write('Esto se debe a que cerca de nuestra sucursal en ' + tienda + ' hay una sede de ' + bancos_afiliados.loc[0, "banco"] + ', entonces los clientes de la zona tienen cuenta en ese banco.')

#Titulo que indica la parte de las categorías preferidas del programa de afiliados
st.title("Categorías preferidas del programa de afiliados")

#Ejecutar streamlit_categoria_afiliados que busca las categorías preferidas del programa de afiliados
categorias_afiliados = conexionDB.streamlit_categoria_afiliados(tienda)

#Si no hay categorías preferidas del programa de afiliados
if(len(categorias_afiliados) == 0):
	#Mensaje indicando que no hay
	st.write('No hay compras de afiliados en las sucursal de ' + tienda + '.')

#Si hay categorías preferidas del programa de afiliados
else:
	#Mostrar datos
	grafica_categorias_afiliados = px.histogram(categorias_afiliados, x="categoria", y="cantidad", labels={"categoria": "Categorías", "cantidad": "número de compras"})

	st.write(grafica_categorias_afiliados)

	#Mensajes que indican el razonamiento del resultado 
	st.write('La categoría preferida de nuestro programa de afiliados en ' + tienda + ' es ' + categorias_afiliados.loc[0, "categoria"] + " y se han hecho " + str(categorias_afiliados.loc[0, "cantidad"]) + ' compras de esa categoría.')
	st.write('Esto se debe a que los productos de tipo ' + categorias_afiliados.loc[0, "categoria"] + ' son de excelente calidad en nuestra sucursal de ' + tienda + '.')

#Titulo que indica la parte de la sucursal preferida del programa de afiliados
st.title("Sucursal preferida del programa de afiliados")

#Ejecutar streamlit_sucursal_afiliados que busca la sucursal preferida del programa de afiliados
sucursal_afiliados = conexionDB.streamlit_sucursal_afiliados()

#Si no hay
if(len(sucursal_afiliados) == 0):
	#Mensaje indicando que no hay
	st.write('No hay visitas de afiliados en ninguna sucursal.')

#Si hay
else:
	#Mostrar datos
	grafica_sucursal_afiliados = px.histogram(sucursal_afiliados, x="sucursal", y="visitas", labels={"sucursal": "Sucursales"})

	st.write(grafica_sucursal_afiliados)

	#Si estamos en la sucursal de la castellana
	if(sucursal_afiliados.loc[0,"sucursal"] == 1):
		#Mensaje que indica el razonamiento del resultado 
		st.write('La sucursal preferida de nuestro programa de afiliados es La Castellana y se han hecho ' + str(sucursal_afiliados.loc[0, "visitas"]) + ' visitas de afiliados.')
	
	#Si estamos en la sucursal del hatillo
	else:
		#Mensaje que indica el razonamiento del resultado 
		st.write('La sucursal preferida de nuestro programa de afiliados es El Hatillo y se han hecho ' + str(sucursal_afiliados.loc[0, "visitas"]) + ' visitas de afiliados.')

	#Mensaje general que indica el razonamiento del resultado sea la sucursal que sea
	st.write('Esto se debe a que la ubicación céntrica es muy buena y la variedad de productos en esta sucursal es bastante amplia, lo que le permite a los clientes realizar las compras de manera fácil y rápida.')

#Titulo que indica la parte del mapa de calor de día de la semana y hora preferida de nuestros clientes
st.title("Mapa de calor de día de la semana y hora preferida de nuestros clientes")

#Ejecutar streamlit_dia_hora_ventas que busca generar el mapa de calor de día de la semana y hora preferida de nuestros clientes
dia_hora_ventas = conexionDB.streamlit_dia_hora_ventas(tienda)

#Si no hay
if(len(dia_hora_ventas) == 0):
	#Mensaje indicando que no hay
	st.write('No hay compras en la sucursal.')

#Si hay
else:

	#Mostrando datos - Mapa calor
	dia_hora_ventas['dia'] = dia_hora_ventas['fecha'].dt.dayofweek
	dia_hora_ventas['hora'] = dia_hora_ventas['fecha'].dt.hour

	dia_hora_ventas = dia_hora_ventas.groupby(['dia','hora']).size().reset_index(name="compras")
	dia_hora_ventas = dia_hora_ventas.pivot(index='hora', columns='dia', values='compras')

	dias = []

	for dia in dia_hora_ventas.columns.tolist():
		dias.append(calendar.day_name[dia])
	
	mapa_de_calor = px.imshow(dia_hora_ventas,
					labels=dict(x="Día", y="Hora", color="Compras")   ,
					x=dias)

	mapa_de_calor.update_xaxes(side="top")

	st.write(mapa_de_calor)

	dia_hora_ventas_traspuesto = pd.DataFrame(dia_hora_ventas.stack()).T
	
	#Mensaje que indica el razonamiento del resultado 
	st.write('En la sucursal de ' + tienda + ', el día de la semana con más compras es el ' + calendar.day_name[dia_hora_ventas_traspuesto.max().idxmax()[1]] + ' y la hora más vendida del día es a las ' + str(dia_hora_ventas_traspuesto.max().idxmax()[0]) + ' horas. En ese día y hora se han realizado ' + str(int(dia_hora_ventas.max().max())) + ' compras.')

	horas_ventas = dia_hora_ventas_traspuesto.max()
	horas_ventas = horas_ventas.groupby(level=[0]).sum()
	horas_ventas = horas_ventas.sort_values(0, ascending=[False])

	#Mensaje que indican el razonamiento del resultado 
	st.write('Además, partir del mapa de calor, se tiene que los 3 horarios más rentables para la sucursal de ' + tienda + ' son las ' + str(horas_ventas.index[0]) + ' horas, las ' + str(horas_ventas.index[1]) + ' horas y las ' + str(horas_ventas.index[2]) + ' horas.')
	st.write('Esto se debe a que estás son los días y horas donde las personas tienen un tiempo libre o descanso del trabajo para acercarse a las tiendas a comprar.')

#Titulo que indica la parte de la cantidad de mercancía por hora en los estantes
st.title('Cantidad de mercancía por hora en los estantes')
#Mensaje que no se puede mostrar y razonar este punto con la BD
st.write('Actualmente, no es posible visualizar esta información.')

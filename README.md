# calendar-heat-map
En este repositorio, muestro como crear un mapa de calor en calendario, mostrando los días con mayor requerimiento, en este caso, de camas para Asistencia Extracorpórea (ya sea ECMO o Asistencia Ventricular) durante el período 2019-2021.

Este calendario esta realizado en R, usando las librerías 'tydiverse', 'readxl' ,'ggplot' y 'ggTimeSeries', tal como se ve en el archivo R adjunto.

Los primeras 10 líneas sirven para detectar si R tiene instaladas o no las librerías necesarias y, posteriormente, procede a realizar la carga de ellas. En caso de que no tengas instalada la librería, procede a instalarla junto con las dependencias necesarias para el buen funcionamiento

Dado que la BBDD que se utiliza, tiene valores NaN en las fechas, se procede a realizar la limpieza de estos, con el fin de obtener las fechas concretas de interés

La BBDD original, se transforma para obtener los intervalos de tiempo que se requieren para generar los conteos necesarios, posteriormente, se realiza un conteo de fechas individual y se genera una nueva base de datos con dicho conteo.

Finalmente, usando ggplot_calendar_map se genera el mapa de calor por día y mes calendario, mostrando la distribución diaria de pacientes con requerimientos de Asistencia Extracorpórea

El resultado final se observa a continuación:
![image](https://user-images.githubusercontent.com/49925953/159347139-24a9b1c2-abf5-481f-bc9f-f923b70383b2.png)


#Cargando librerias necesarias
librerias<-c("ggplot2", "tidyverse",'readxl','ggTimeSeries')
ipak <- function(pkg){
    new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
    if (length(new.pkg))
        install.packages(new.pkg, dependencies = TRUE)
    sapply(pkg, require, character.only = TRUE)
}
ipak(librerias)

#Definiendo ruta de acceso
getwd()
setwd("/Volumes/GoogleDrive/Otros ordenadores/Desktop/Proyectos 2022/Proyecto ECMO/")

#Cargando base de datos
ecmo <-read_excel('ecmo.xlsx',col_names=TRUE) #cargando BBDD

#Filtrando la información requerida
ecmo1<-ecmo %>%
    filter(!is.na(INSTALACIÓN) & !is.na(`FECHA RETIRO`)) %>%  #removiendo NA
    arrange(-ID) %>%
    rowwise() %>%
    transmute(ID,
              date = list(seq(INSTALACIÓN, `FECHA RETIRO`, by = "day"))) %>% # generando intervalos de tiempo
    unnest(date) %>%
    group_by(date) %>%
    summarise(conteo=n()) #conteo de casos por fecha

#Generando mapa
ggplot_calendar_heatmap(
    ecmo1,'date','conteo') + #Definiendo base a utilizar, eje 'X' y eje 'Y'
    ggtitle('Conteo Casos de Asistencia Extracorpórea durante años 2019 a 2021') + #Colocando título
    xlab('Mes') + ylab('Días de la Semana') + # Nombres de ejes
    scale_fill_continuous(name='Nº Casos',low='#f9f90a',high='#e03812',breaks=seq(1,10,1)) + # Generando leyenda
    facet_wrap(~Year,ncol=1) # Permite mostrar cada año como una columna

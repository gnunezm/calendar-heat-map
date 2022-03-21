#Cargando librerias necesarias
librerias<-c("ggplot2", "tidyverse",'readxl','ggTimeSeries')
ipak <- function(pkg){
    new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
    if (length(new.pkg))
        install.packages(new.pkg, dependencies = TRUE)
    sapply(pkg, require, character.only = TRUE)
}
ipak(librerias)

getwd()
setwd("/Volumes/GoogleDrive/Otros ordenadores/Desktop/Proyectos 2022/Proyecto ECMO/")

ecmo <-read_excel('ecmo.xlsx',col_names=TRUE) #cargando BBDD

ecmo1<-ecmo %>%
    filter(!is.na(INSTALACIÓN) & !is.na(`FECHA RETIRO`)) %>%  #removiendo NA
    arrange(-ID) %>%
    rowwise() %>%
    transmute(ID,
              date = list(seq(INSTALACIÓN, `FECHA RETIRO`, by = "day"))) %>% # generando intervalos de tiempo
    unnest(date) %>%
    group_by(date) %>%
    summarise(conteo=n()) #conteo de casos por fecha

ggplot_calendar_heatmap(
    ecmo1,'date','conteo') +
    ggtitle('Conteo Casos de Asistencia Extracorpórea durante años 2019 a 2021') +
    xlab('Mes') + ylab('Días de la Semana') +
    scale_fill_continuous(name='Nº Casos',low='#f9f90a',high='#e03812',breaks=seq(1,10,1)) +
    facet_wrap(~Year,ncol=1)

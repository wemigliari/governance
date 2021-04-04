library(knitr)
library(writexl)
library(rgdal)
library(sf) ## Read shapefiles
library(dplyr)
library(leaflet)
library(cowplot)
library(ggplot2)
library(plotly)
library(readxl)
library(htmlwidgets)

favelas <- read_sf("/Users/wemigliari/Documents/R/data/AglomeradosSubnormais/AglomeradosSubnormais2010_Limites.shp",
                   options = "ENCODING=WINDOWS-1252") ### Shape in form of sf


mina_ma <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Mina Mar Azul1.shp")
mina_mu <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Mina da Mutuca.shp")
mina_mc <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Mina Morro do Chapéu.shp")
mina_cp <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Mina de Capão.shp")

acaba_mundo <- favelas%>%filter(nm_agsn=="ACABA MUNDO")
santa_lucia <- favelas%>%filter(nm_agsn=="VILA BARRAGEM SANTA LUCIA")



labels <- paste(sep = "  ",
                 favelas$nm_municip,
                 "|",
                "Assentamento:",
                 favelas$nm_agsn,
                 "População:",
                 favelas$populacao)

labels2 <-  paste(sep = "  ",
                  acaba_mundo$nm_municip,
                  "|",
                  "Assentamento:",
                  acaba_mundo$nm_agsn,
                  "População:",
                  acaba_mundo$populacao)
labels3 <-  paste(sep = "  ",
                  santa_lucia$nm_municip,
                  "|",
                  "Assentamento:",
                  santa_lucia$nm_agsn,
                  "População:",
                  santa_lucia$populacao)



leaflet() %>% 
  addTiles() %>% 
  addPolygons(data=favelas$geometry, weight = 1, fillColor = "red", 
              fillOpacity = 0.2, color = "red", label = labels)%>%
  addPolygons(data=acaba_mundo$geometry, weight = 1, 
              fillColor = 'red',
              label = labels2,
              group = "Vila Acaba Mundo",
              fillOpacity = 0.8)%>%
  addPolygons(data=santa_lucia$geometry, weight = 1, 
              fillColor = 'orange',
              label = labels3,
              group = "Vila Barragem Santa Lúcia",
              fillOpacity = 0.8)%>%
  addPolygons(data=mina_ma$geometry, weight = 1, 
              fillColor = 'gold',
              color="gold",
              label = "Mina Mar Azul, Vale S/A",
              group = "Mina Mar Azul",
              fillOpacity = 0.8)%>%
  addPolygons(data=mina_mc, weight = 1, 
              fillColor = 'green',
              color="green",
              label = "Mina do Chapéu, Vale S/A",
              group = "Mina do Chapéu",
              fillOpacity = 0.8)%>%
  addPolygons(data=mina_cp, weight = 1, 
              fillColor = 'purple',
              color="purple",
              label = "Mina de Capão, Vale S/A",
              group = "Mina de Capão",
              fillOpacity = 0.8)%>%
  addPolygons(data=mina_mu, weight = 1, 
              fillColor = 'steelblue',
              color="steelblue",
              label = "Mina da Mutuca, Vale S/A",
              group = "Mina da Mutuca",
              fillOpacity = 0.8)%>%
  addProviderTiles(providers$Stamen.TonerLite)%>% 
  setView(lat= -19.983333, lng = -43.940933, zoom = 11)%>%
  addLayersControl(
    overlayGroups = c("Vila Acaba Mundo", "Vila Barragem Santa Lúcia", "Mina Mar Azul", "Mina do Chapéu", "Mina da Mutuca", "Mina de Capão"),
    options = layersControlOptions(collapsed = FALSE)
  )

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

mineracao <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Belo Horizonte.shp",
                    stringsAsFactors = TRUE) ### Shape in form of sf



mina_ma <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Mina Mar Azul1.shp")
mina_mu <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Mina da Mutuca.shp")
mina_mc <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Mina Morro do Chapéu.shp")
mina_cp <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Mina de Capão.shp")
mina_abo <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Mina Abóboras.shp")
mina_acaba <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Mina Acaba Mundo.shp")
mina_cdm <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Mina Capitão do Mato.shp")
mina_casa_pedra <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Mina Casa de Pedra.shp")
mina_cascalheira <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Mina Cascalheira.shp")
mina_central_brasil <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Mina Central do Brasil.shp")
mina_cofins <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Mina Cofins.shp")
mina_corrego_feijao <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Mina Córrego do Feijão.shp")
mina_corrego_samamb <- read_sf("/Users/wemigliari/Documents/HTML/polos_data/img/Mina Córrego Samambaia.shp")


leaflet() %>% 
  addTiles() %>% 
  addPolygons(data=mina_corrego_samamb, weight = 1,
              fillColor = "#CBB31B ", 
              color = "black",
              fillOpacity = 0.8, 
              label = "Mina Córrego do Samambaia",
              group = "Mina Córrego do Samambaia")%>%
  addPolygons(data=mina_corrego_feijao, weight = 1,
              fillColor = "#E49812", 
              color = "black",
              fillOpacity = 0.8, 
              label = "Mina Córrego do Feijão",
              group = "Mina Córrego do Feijão")%>%
  addPolygons(data=mina_abo, weight = 1,
              fillColor = "green", 
              color = "black",
              fillOpacity = 0.8, 
              label = "Mina Abóboras",
              group = "Mina Abóboras")%>%
  addPolygons(data=mina_cofins, weight = 1,
              fillColor = "#ABB2B7", 
              color = "black",
              fillOpacity = 0.8, 
              label = "Mina Cofins",
              group = "Mina Cofins")%>%
  addPolygons(data=mina_acaba, weight = 1, 
              fillColor = 'turquoise',
              color = "black",
              label = "Mina Acaba Mundo",
              group = "Mina Acaba Mundo",
              fillOpacity = 0.8)%>%
  addPolygons(data=mina_central_brasil, weight = 1,
              fillColor = "#0D98FC", 
              color = "black",
              fillOpacity = 0.8, 
              label = "Mina Central do Brasil",
              group = "Mina Central do Brasil")%>%
  addPolygons(data=mina_cascalheira, weight = 1,
              fillColor = "#133B56", 
              color = "black",
              fillOpacity = 0.8, 
              label = "Mina Cascalheira",
              group = "Mina Cascalheira")%>%
  addPolygons(data=mineracao, weight = 1,
              fillColor = "olive", 
              color = "olive",
              fillOpacity = 0.2, 
              label = mineracao$NOME)%>%
  addPolygons(data=mina_cdm, weight = 1, 
              fillColor = "darkgreen", 
              color = "black",
              fillOpacity = 0.8, 
              label = "Mina Capitão do Mato",
              group = "Mina Capitão do Mato")%>%
  addPolygons(data=mina_ma$geometry, weight = 1, 
              fillColor = 'gold',
              color="gold",
              label = "Mina Mar Azul, Vale S/A",
              group = "Mina Mar Azul",
              fillOpacity = 0.8)%>%
  addPolygons(data=mina_mc, weight = 1, 
              fillColor = 'green',
              color = "green",
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
              color = "steelblue",
              label = "Mina da Mutuca, Vale S/A",
              group = "Mina da Mutuca",
              fillOpacity = 0.8)%>%
  addPolygons(data=mina_casa_pedra, weight = 1, 
              fillColor = '#0D7A7E ',
              color = "black",
              label = "Mina Casa de Pedra",
              group = "Mina Casa de Pedra",
              fillOpacity = 0.8)%>%
  addProviderTiles(providers$Stamen.TonerLite)%>% 
  setView(lat= -19.983333, lng = -43.940933, zoom = 11)%>%
  addLayersControl(
    overlayGroups = c("Mina Abóboras",
                      "Mina Acaba Mundo",
                      "Mina Capitão do Mato", 
                      "Mina de Capão",
                      "Mina Cascalheira",
                      "Mina Casa de Pedra",
                      "Mina Central do Brasil",
                      "Mina Cofins",
                      "Mina Córrego do Feijão",
                      "Mina Córrego do Samambaia",
                      "Mina do Chapéu", 
                      "Mina da Mutuca", 
                      "Mina Mar Azul"),
    options = layersControlOptions(collapsed = FALSE)
  )

  
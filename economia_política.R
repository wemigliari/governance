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


brasil1 <- read_sf("/Users/wemigliari/Documents/R/data/BRA_adm3.shp") ### Shape in form of sf
estados <- read_sf("/Users/wemigliari/Documents/R/data/BRA_adm1.shp")
amazonas <- read_sf("/Users/wemigliari/Documents/R/data/para/Rio Amazonas.shp")
amazonia_legal <- read_sf("/Users/wemigliari/Documents/R/data/para/amazonia_legal.shp")
poten_econ_eixo_leste <- read_sf("/Users/wemigliari/Documents/R/data/para/poten_econo_eixo_leste.shp")
poten_produt_eixo_oeste <- read_sf("/Users/wemigliari/Documents/R/data/para/poten_produt_eixo_oeste.shp")
zoce <- read_sf("/Users/wemigliari/Documents/R/data/para/zona_oeste_conso_exp.shp")
zlc <- read_sf("/Users/wemigliari/Documents/R/data/para/zona_leste_conso.shp")

hidrovias <- read_sf("/Users/wemigliari/Documents/R/data/para/hidrovias_brasil.shp")
hidrovias_b <- st_zm(hidrovias)

portos <- read_sf("/Users/wemigliari/Documents/R/data/para/portos_brasil.shp")
portos_b <- st_zm(portos)

cabotagem <- read_sf("/Users/wemigliari/Documents/R/data/para/cabotagem_brasil.shp")
cabotagem_b <- st_zm(cabotagem)

dutovias <- read_sf("/Users/wemigliari/Documents/R/data/para/dutovias_brasil.shp")
dutovias_b <- st_zm(dutovias) ### From polygon Z to ZM dimensions

obidos <- brasil1%>%filter(NAME_2=="Óbidos")
santarem <- brasil1%>%filter(NAME_2=="Santarém")
alenquer <- brasil1%>%filter(NAME_2=="Alenquer")
itaituba <- brasil1%>%filter(NAME_2=="Itaituba")
belterra <- brasil1%>%filter(NAME_2=="Belterra")
oriximina <- brasil1%>%filter(NAME_2=="Oriximiná")
aveiro <- brasil1%>%filter(NAME_2=="Aveiro")



serie_desmat <- read_excel("/Users/wemigliari/Documents/R/data/para/desmatamento_para.xlsx",
                           sheet = "municipios")
serie_desmat <- data.frame(serie_desmat, stringsAsFactors = FALSE)

i <- c(2:12)   

test <- serie_desmat[ , i] <- apply(serie_desmat[ , i], 2,            # Specify own function within apply
                                    function(x) as.numeric(as.character(x)))
class(test)

test1 <- as.data.frame(test)

test_desmat <- cbind(serie_desmat$Localidade, test1)

asc_desmat <- test_desmat[with(test_desmat, order(X2009)), ]

baixo_desmat <- asc_desmat[1:10,]
alto_desmat <- asc_desmat[134:143,]

dez_munic <- test_desmat[c(6, 14, 58, 81, 83, 113),c(1:12)]
asc_munic <- dez_munic[with(dez_munic, order(X2009)), ]


peel <- paste(sep = " ",
              "Município:",
              poten_econ_eixo_leste$NOME_MUNIC,
              "|",
              "Dimensão Econômica:",
              poten_econ_eixo_leste$DIM__ECONO)


leaflet() %>% 
  addTiles() %>% 
  addPolygons(data=estados$geometry, weight = 1, fillColor = 'darkgray', fillOpacity = 0.1, color = 'gray', smoothFactor = 0.1) %>%
  addPolygons(data=poten_produt_eixo_oeste$geometry, weight = 1, fillColor = 'purple', fillOpacity = 0.5, smoothFactor = 0.1, 
              color = 'purple')%>%
  addPolygons(data=poten_econ_eixo_leste$geometry, weight = 1, fillColor = 'orange', fillOpacity = 0.5, smoothFactor = 0.2, 
              color = 'orange', label = peel)%>%
  addProviderTiles(providers$Esri.WorldGrayCanvas)%>% 
  setView(lat= -3.0000, lng = -52.00000, zoom = 5)


ceze1 <- paste(sep = " ",
               "Município:",
               poten_produt_eixo_oeste$MUNICIPI1,
               "|",
               "Status:",
               zoce$CATEGORIA)


ceze2 <- paste(sep = " ",
               "Município:",
               zlc$MUNICIPIO,
               "|",
               "Nível de Consolidação:",
               zlc$NOME)


leaflet() %>% 
  addTiles() %>% 
  addPolygons(data=estados$geometry, weight = 1, fillColor = 'gray', fillOpacity = 0.1, color = 'gray', smoothFactor = 0.1) %>%
  addPolygons(data=para$geometry, weight = 1, fillColor = 'green', fillOpacity = 0.1, color = 'green', smoothFactor = 0.1) %>%
  addPolygons(data=zoce$geometry, weight = 1, fillColor = 'red', fillOpacity = 0.1, smoothFactor = 0.1, 
              color = 'red', label = ceze1, group = "Consolidação e Expansão")%>%
  addPolygons(data=zlc$geometry, weight = 1, fillColor = 'darkgreen', fillOpacity = 0.2, smoothFactor = 0.2, 
              color = 'darkgreen', label = ceze2, group = "Consolidação I, II e III")%>%
  addPolygons(data=obidos$geometry, weight = 1, fillColor = 'gold', opacity = 0.3, color = 'gray', label = "Óbidos")%>%
  addPolygons(data=santarem$geometry, weight = 1, fillColor = 'gold', opacity = 0.3, color = 'gray', label = "Santarém")%>%
  addPolygons(data=alenquer$geometry, weight = 1, fillColor = 'gold', opacity = 0.3, color = 'gray', label = "Alenquer")%>%
  addPolygons(data=itaituba$geometry, weight = 1, fillColor = 'gold', opacity = 0.3, color = 'gray', label = "Itaituba")%>%
  addPolygons(data=belterra$geometry, weight = 1, fillColor = 'gold', opacity = 0.3, color = 'gray', label = "Belterra")%>%
  addPolygons(data=oriximina$geometry, weight = 1, fillColor = 'gold', opacity = 0.3, color = 'gray', label = "Oriximiná")%>%
  addPolygons(data=aveiro$geometry, weight = 1, fillColor = 'gold', opacity = 0.3, color = 'gray', label = "Aveiro")%>%
  addPolygons(data=amazonas, weight = 1, fillColor = 'blue', fillOpacity = 0.5, color = 'blue', label = "Rio Amazonas")%>%
  addProviderTiles(providers$Esri.WorldGrayCanvas)%>% 
  setView(lat= -3.0000, lng = -52.00000, zoom = 5)%>%
  addLayersControl(
    baseGroups = c("Consolidação e Expansão", "Consolidação I, II e III"),
    options = layersControlOptions(collapsed = FALSE)
  )


test<-leaflet() %>% 
  addTiles() %>% 
  addPolygons(data=estados$geometry, weight = 1, fillColor = 'gray', fillOpacity = 0.2, color = 'gray', label = estados$NAME_1)%>%
  addPolygons(data=brasil1$geometry, weight = 1, fillColor = 'gray', fillOpacity = 0.2, color = 'gray', label = brasil1$NAME_2)%>%
  addPolygons(data=obidos$geometry, weight = 1, fillColor = 'gold', opacity = 0.9, color = 'gold', group = "Óbidos")%>%
  addPolygons(data=santarem$geometry, weight = 1, fillColor = 'gold', opacity = 0.8, color = 'gold', group = "Santarém")%>%
  addPolygons(data=alenquer$geometry, weight = 1, fillColor = 'gold', opacity = 0.7, color = 'gold', group = "Alenquer")%>%
  addPolygons(data=itaituba$geometry, weight = 1, fillColor = 'gold', opacity = 0.6, color = 'gold', group = "Itaituba")%>%
  addPolygons(data=belterra$geometry, weight = 1, fillColor = 'gold', opacity = 0.5, color = 'gold', group = "Belterra")%>%
  addPolygons(data=oriximina$geometry, weight = 1, fillColor = 'gold', opacity = 0.4, color = 'gold', group = "Oriximiná")%>%
  addPolygons(data=aveiro$geometry, weight = 1, fillColor = 'gold', opacity = 0.3, color = 'gold', group = "Aveiro")%>%
  addPolygons(data=amazonia_legal$geometry, weight = 1, fillColor = 'green', fillOpacity = 0.1, color = 'green', group = "Amazônia Legal")%>%
  addPolygons(data=hidrovias_b$geometry, weight = 1, fillColor = 'blue', fillOpacity = 0.2, color = 'blue',
              group = "Rede Hidroviária", label = hidrovias_b$nome)%>%
  addCircleMarkers(portos_b, lng = portos_b$LON, lat = portos_b$LAT, color = "red", 
                   group = "Portos", label = portos_b$NOMEPORTO, radius = 1)%>%
  addPolygons(data=cabotagem_b$geometry, weight = 1, fillColor = 'yellow', fillOpacity = 0.5, color = 'yellow',
              group = "Cabotagem", label = cabotagem_b$NOME)%>%
  addPolygons(data=dutovias_b$geometry, weight = 1, fillColor = 'black', fillOpacity = 0.8, color = 'black',
              group = "Rede de Dutos", label = dutovias_b$Nome_Dut_1)%>%
  addProviderTiles(providers$Esri.WorldGrayCanvas)%>% 
  setView(lat= -12.0000, lng = -52.00000, zoom = 4)%>%
  addLayersControl(
    baseGroups = c("Rede Hidroviária", "Portos", "Cabotagem", "Rede de Dutos"),
    overlayGroups = c("Amazônia Legal", "Alenquer", "Óbidos", "Oriximiná", "Santarém", "Belterra", "Aveiro", "Itaituba"),
    options = layersControlOptions(collapsed = FALSE)
  )

saveWidget(test, '/Users/wemigliari/Documents/HTML/polos_data/amazonia_legal_par4', selfcontained = FALSE)

leaflet() %>% 
  addTiles() %>% 
  addPolygons(data=para$geometry, weight = 1, fillColor = 'darkgray', fillOpacity = 0.5, color = 'gray', smoothFactor = 0.2) %>%
  addPolygons(data=obidos$geometry, weight = 1, fillColor = 'red', opacity = 0.3, color = 'gray', label = "Óbidos")%>%
  addPolygons(data=santarem$geometry, weight = 1, fillColor = 'red', opacity = 0.3, color = 'gray', label = "Santarém")%>%
  addPolygons(data=alenquer$geometry, weight = 1, fillColor = 'red', opacity = 0.3, color = 'gray', label = "Alenquer")%>%
  addPolygons(data=itaituba$geometry, weight = 1, fillColor = 'red', opacity = 0.3, color = 'gray', label = "Itaituba")%>%
  addPolygons(data=belterra$geometry, weight = 1, fillColor = 'red', opacity = 0.3, color = 'gray', label = "Belterra")%>%
  addPolygons(data=oriximina$geometry, weight = 1, fillColor = 'red', opacity = 0.3, color = 'gray', label = "Oriximiná")%>%
  addPolygons(data=aveiro$geometry, weight = 1, fillColor = 'red', opacity = 0.3, color = 'gray', label = "Aveiro")%>%
  addPolygons(data=amazonas, weight = 1, fillColor = 'blue', fillOpacity = 0.5, color = 'blue', label = "Rio Amazonas")%>%
  addProviderTiles(providers$Esri.WorldGrayCanvas)%>% 
  setView(lat= -3.0000, lng = -52.00000, zoom = 6)


library(readxl)
library(plotly)
library(sf) ## Read shapefiles
library(rgdal)
library(leaflet)
library(htmlwidgets)
library(tmap)
library(dplyr)

### Regi??es

prpolos <-  read_xlsx("/Users/wemigliari/Documents/R/tabelas/populacao_rua_polos.xlsx")

names(prpolos)[1] <- "nome"

regioes <- read_sf("/Users/wemigliari/Documents/R/data/regioes_2010.shp", 
                  options = "ENCODING=windows-1252")

data_polos1 <- merge(prpolos, regioes, by = "nome")


###

shp_joined <- inner_join(regioes, data_polos1, by = "nome")
class(shp_joined) # Dataframe. It does not work yet!

shp_joined <- st_as_sf(shp_joined) 
class(shp_joined) # It is now converted to "sf" and "data.frame". It works!

data_polos1 <- shp_joined %>%
  arrange(Soma) %>%
  mutate(name=factor(nome, unique(nome)))


####

mybins1 <- c(5414, 11203, 20334, 22900, 100259)
mypalette1 <- colorBin(palette="YlOrBr", na.color="transparent", domain=data_polos1, bins=mybins1)

mytext1 <- paste(
  "Regi??o: ", data_polos1$nome, "<br/>",
  "Total: ", data_polos1$Soma, "<br/>",
  "Preta: ", data_polos1$Preta, "<br/>",
  "Parda: ", data_polos1$Parda, "<br/>",
  "Ind??gena: ", data_polos1$Ind??gena, "<br/>",
  "Branca: ", data_polos1$Branca, "<br/>",
  "Indefinido: ", data_polos1$Indefinido, "<br/>",
  sep="") %>%
  lapply(htmltools::HTML)

#####

leaflet(data_polos1) %>% 
  addPolygons( 
    fillColor = ~mypalette1(Soma), 
    stroke=TRUE, 
    fillOpacity = 1, 
    color="white", 
    weight=0.3,
    label = mytext1,
    labelOptions = labelOptions( 
      style = list("font-weight" = "normal", padding = "3px 8px"), 
      textsize = "13px", 
      direction = "auto"
    )
  )%>% 
  addTiles()  %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addLegend(pal=mypalette1, values=~data_polos1$Soma, opacity=1, title = "Moradores em Situa????o de Rua", position = "bottomright" )%>%
  setView(-47.9392, -15.7801, zoom = 4.3)


### Capitais

prpolos2 <-  read_xlsx("/Users/wemigliari/Documents/R/tabelas/populacao_rua_polos.xlsx")

names(prpolos2)[1] <- "nome"

capitais <- read_sf("/Users/wemigliari/Documents/R/data/BRA_adm2.shp", 
                  options = "ENCODING=windows-1252")

populacao <- as.numeric(capitais$populacao)

capitais <- cbind(capitais, populacao)


capitais <- capitais%>%
  filter(populacao.1>320000)

data_polos2 <- merge(prpolos2, capitais, by = "nome")

brasil <- read_sf("/Users/wemigliari/Documents/R/data/BRA_adm1.shp", 
                  options = "ENCODING=windows-1252")
brasil <- st_as_sf(brasil)



###

shp_joined2 <- inner_join(capitais, data_polos2, by = "nome")
class(shp_joined) # Dataframe. It does not work yet!

shp_joined2 <- st_as_sf(shp_joined2) 
class(shp_joined2) # It is now converted to "sf" and "data.frame". It works!

data_polos2 <- shp_joined2 %>%
  arrange(Soma) %>%
  mutate(name=factor(nome, unique(nome)))


####

mybins2 <- c(0,10, 20, 30, 40, 50, 100, 200, 500, 1000, 2000, 5000, 8700, 10000, 25000, 50000, 70000)
mypalette2 <- colorBin(palette="YlOrBr", na.color="transparent", domain=test$Soma, bins=mybins2)

mytext2 <- paste(
  "Capital: ", data_polos2$nome, "<br/>",
  "Total: ", data_polos2$Soma, "<br/>",
  "Preta: ", data_polos2$Preta, "<br/>",
  "Parda: ", data_polos2$Parda, "<br/>",
  "Ind??gena: ", data_polos2$Ind??gena, "<br/>",
  "Branca: ", data_polos2$Branca, "<br/>",
  "Indefinido: ", data_polos2$`Sem Resposta`, "<br/>",
  sep="") %>%
  lapply(htmltools::HTML)

#####

leaflet(data_polos2) %>% 
  addPolygons(
    fillColor = ~mypalette2(Soma), 
    stroke=TRUE, 
    fillOpacity = 1, 
    color="white", 
    weight=0.3,
    label = mytext2,
    labelOptions = labelOptions( 
      style = list("font-weight" = "normal", padding = "3px 8px"), 
      textsize = "13px", 
      direction = "auto"
    )
  )%>% 
  addTiles()  %>%
  addProviderTiles(providers$Stamen.TonerBackground) %>%
  addLegend(pal=mypalette2, values=~data_polos2$Soma, opacity=1, title = "Moradores em Situa????o de Rua, Capitais", position = "bottomright" )%>%
  setView(-47.9392, -15.7801, zoom = 4.7)

#####

library(leaflet.minicharts)

escolaridade1 <-  read_xlsx("/Users/wemigliari/Documents/R/tabelas/populacao_rua_polos.xlsx",
                       sheet = "Escolaridade")

escolaridade1 <- escolaridade1[-c(1:6), ]
seq <- seq(1,53, 2)
escolaridade1 <- escolaridade1[-c(seq), ]

brasil <- read_sf("/Users/wemigliari/Documents/R/data/BRA_adm1.shp", 
                   options = "ENCODING=windows-1252")
brasil <- st_as_sf(brasil)

colors = c("gray", "yellow", "gold", "coral", "black", "orange") 


leaflet(brasil) %>%
  addPolygons( 
    fillColor = "red", 
    stroke=TRUE, 
    fillOpacity = 0.2, 
    color="black", 
    weight=0.3
  )%>%
  addTiles()%>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addMinicharts(lng = escolaridade1$Longitude, 
                lat = escolaridade1$Latitude, 
                type = "pie", 
                chartdata = escolaridade1[ , c("0-6 (pr??-escolar)",	"7-17 (fundamental e m??dio)",	"18-59", "A partir de 60", "Sem Resposta", "Total")], 
                colorPalette = colors, 
                width = 100 * sqrt(escolaridade1$Total) / sqrt(max(escolaridade1$Total)),
                transitionTime = 0,
                showLabels = FALSE,
                layerId = escolaridade1$Regi??o)%>%
  setView(-47.9392, -15.7801, zoom = 4.7)

##### Total

genero <-  read_xlsx("/Users/wemigliari/Documents/R/tabelas/populacao_rua_polos.xlsx",
                            sheet = "Etnia")
genero <- genero[-c(1:6),]

n <- seq(1,54, 2)

genero <- genero[-c(n),]


brasil <- read_sf("/Users/wemigliari/Documents/R/data/BRA_adm1.shp", 
                  options = "ENCODING=windows-1252")
brasil <- st_as_sf(brasil)

colors = c("white", "black", "yellow", "orange", "coral", "lightgray", "red") 


leaflet(brasil) %>%
  addPolygons( 
    fillColor = "red", 
    stroke=TRUE, 
    fillOpacity = 0.2, 
    color="black", 
    weight=0.3
  )%>%
  addTiles()%>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addMinicharts(lng = genero$Longitude, 
                lat = genero$Latitude, 
                type = "pie", 
                chartdata = genero[ ,c("Branca", "Preta", "Amarela", "Parda",	"Ind??gena", "Sem Resposta", "Soma")], 
                colorPalette = colors, 
                width = 100 * sqrt(genero$Soma) / sqrt(max(genero$Soma)),
                transitionTime = 0,
                showLabels = FALSE,
                layerId = genero$Regi??o)%>%
  setView(-47.9392, -15.7801, zoom = 4.7)

### Feminino

genero_f <-  read_xlsx("/Users/wemigliari/Documents/R/tabelas/populacao_rua_polos.xlsx",
                     sheet = "Etnia-2")
genero_f <- genero_f[-c(1:6),]

n <- seq(1,54, 2)

genero_f <- genero_f[-c(n),]


brasil <- read_sf("/Users/wemigliari/Documents/R/data/BRA_adm1.shp", 
                  options = "ENCODING=windows-1252")
brasil <- st_as_sf(brasil)

colors_f = c("white", "black", "yellow", "orange", "coral", "lightgray", "purple") 


leaflet(brasil) %>%
  addPolygons( 
    fillColor = "red", 
    stroke=TRUE, 
    fillOpacity = 0.2, 
    color="black", 
    weight=0.3
  )%>%
  addTiles()%>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addMinicharts(lng = genero_f$Longitude, 
                lat = genero_f$Latitude, 
                type = "pie", 
                chartdata = genero_f[ ,c("Branca", "Preta", "Amarela", "Parda",	"Ind??gena", "Sem Resposta", "Soma")], 
                colorPalette = colors_f, 
                width = 100 * sqrt(genero_f$Soma) / sqrt(max(genero_f$Soma)),
                transitionTime = 0,
                showLabels = FALSE,
                layerId = genero_f$Regi??o)%>%
  setView(-47.9392, -15.7801, zoom = 4.7)


### Masculino

genero_m <-  read_xlsx("/Users/wemigliari/Documents/R/tabelas/populacao_rua_polos.xlsx",
                       sheet = "Etnia-3")
genero_m <- genero_m[-c(1:6),]

n <- seq(1,54, 2)

genero_m <- genero_m[-c(n),]


brasil <- read_sf("/Users/wemigliari/Documents/R/data/BRA_adm1.shp", 
                  options = "ENCODING=windows-1252")
brasil <- st_as_sf(brasil)

colors_m = c("white", "black", "yellow", "orange", "coral", "lightgray", "green") 


leaflet(brasil) %>%
  addPolygons( 
    fillColor = "red", 
    stroke=TRUE, 
    fillOpacity = 0.2, 
    color="black", 
    weight=0.3
  )%>%
  addTiles()%>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addMinicharts(lng = genero_m$Longitude, 
                lat = genero_m$Latitude, 
                type = "pie", 
                chartdata = genero_m[ ,c("Branca", "Preta", "Amarela", "Parda",	"Ind??gena", "Sem Resposta", "Soma")], 
                colorPalette = colors_m, 
                width = 100 * sqrt(genero_m$Soma) / sqrt(max(genero_m$Soma)),
                transitionTime = 0,
                showLabels = FALSE,
                layerId = genero_m$Regi??o)%>%
  setView(-47.9392, -15.7801, zoom = 4.7)

### Percentuais

percentuais_r <-  read_xlsx("/Users/wemigliari/Documents/R/tabelas/populacao_rua_polos.xlsx",
                       sheet = "Percentuais-R")

percentuais_r <- percentuais_r[-c(1),]

regioes <- read_sf("/Users/wemigliari/Documents/R/data/regioes_2010.shp", 
                  options = "ENCODING=windows-1252")
regioes <- st_as_sf(regioes)

colors_m = c("yellow", "orange", "coral", "lightgray", "gold") 


leaflet(regioes) %>%
  addPolygons( 
    fillColor = "orange", 
    stroke=TRUE, 
    fillOpacity = 0.2, 
    color="black", 
    weight=0.3
  )%>%
  addTiles()%>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addMinicharts(lng = percentuais_r$Longitude, 
                lat = percentuais_r$Latitude, 
                type = "pie", 
                chartdata = percentuais_r[ ,c("0-6", "7-17", "18-59", "A partir de 60", "Total (%)")], 
                colorPalette = colors_m, 
                width = 100 * sqrt(percentuais_r$Total) / sqrt(max(percentuais_r$Total)),
                transitionTime = 0,
                showLabels = FALSE,
                layerId = percentuais_r$Regi??o)%>%
  setView(-47.9392, -15.7801, zoom = 4.7)


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

manufacturing <- read_excel("/Users/wemigliari/Documents/R/tabelas/manufac_in_wb.xlsx")

par(family= "Times", cex = 0.7, oma = c(4, 1, 1, 1))

plot(manufacturing$Year, manufacturing$`Latin America & Caribbean`,
     type = "b", pch = 1, col = "steelblue", xlim = c(2010, 2020), ylim = c(5, 40),
     xlab = "", ylab = "Indústria de Manufaturas (% PIB)")
lines(manufacturing$Year, manufacturing$`East Asia & Pacific`, type = "b", col = "darkgreen", pch=2)
lines(manufacturing$Year, manufacturing$`Middle East & North Africa`, type = "b",col = "orange", pch = 3)
lines(manufacturing$Year, manufacturing$`European Union`, type = "b", col = "black", pch = 4)

legend("topright", legend = c("América Latina & Caribe", 
                            "Leste Asiático & Pacífico", 
                            "Oriente Médio & Norte da África",
                             "União Europeia"),
       col = c("steelblue", "darkgreen", "orange", "black"), 
       pch = c(1:4),
       bty = "n", cex = 0.7)

par(family= "Times", cex = 0.7, oma = c(4, 1, 1, 1))

plot(manufacturing$Year, manufacturing$Argentina, 
     type = "b", col = "red", pch = 5,
     xlim = c(2010, 2020), ylim = c(5, 40),
     xlab = "", ylab = "Indústria de Manufaturas (% PIB)")
lines(manufacturing$Year, manufacturing$Brazil,
      type = "b", pch = 6, col = "steelblue")
lines(manufacturing$Year, manufacturing$Chile, type = "b", col = "purple", pch = 7)
lines(manufacturing$Year, manufacturing$China, type = "b", col = "black", pch = 8)
lines(manufacturing$Year, manufacturing$Singapore, type = "b", col = "darkgreen", pch=9)
lines(manufacturing$Year, manufacturing$`Korea, Rep.`, type = "b",col = "orange", pch = 10)
lines(manufacturing$Year, manufacturing$Uruguay, type = "b", col = "gold", pch = 11)

legend("topright", legend = c("Argentina", 
                              "Brasil",
                              "Chile", 
                              "China",
                              "Cingapura",
                              "Koreia do Sul",
                              "Uruguay"),
       col = c("red", "steelblue", "purple", "black", "darkgreen", "orange", "gold"), 
       pch = c(5:11),
       bty = "n", cex = 0.7)









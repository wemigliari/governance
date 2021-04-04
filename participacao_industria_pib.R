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

participacao <- read_excel("/Users/wemigliari/Documents/R/tabelas/participacao_industria_pib.xls")


par(family= "Times", cex = 0.7, oma = c(4, 1, 1, 1))

plot(participacao$Período, participacao$`Total_Ind_PIB(%)`,
     type = "l", lty =1, col = "steelblue",
     main = "",
     xlab = "", ylab = "(%)",
     ylim = c(0,30))

lines(participacao$Período, participacao$`Total_Ind_Trans_PIB(%)`, type = "l", col = "steelblue", lty=2)
lines(participacao$Período, participacao$`Total_Agro_PIB(%)`, type = "l", col = "red", lty=2)
lines(participacao$Período, participacao$`Total_Ind_Ex_PIB(%)`, type = "l",col = "darkgray", lty=1)
lines(participacao$Período, participacao$`Total_Ele_PIB(%)`, type = "l", col = "darkgray", lty=2)
lines(participacao$Período, participacao$`Total_Const_PIB(%)`, type = "l", col = "black",lty=2)

legend("topright", legend = c("Total Indústria", 
                              "Indústria de Transformação", 
                              "Agronegócio",
                              "Mineração",
                              "Energia",
                              "Construção"),
       col = c("steelblue", "steelblue", "red", "darkgray", "darkgray", "black"), 
       lty = c(1, 2, 2, 1, 2, 2),
       bty = "n", cex = 0.7)




######

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


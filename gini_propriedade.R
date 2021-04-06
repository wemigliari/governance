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

gini <- read_excel("/Users/wemigliari/Documents/R/tabelas/gini_propriedade.xlsx")

p_a1 <- gini %>% select(4)
p_a2 <- gini %>% select(5)

a <- p_a1[order(as.numeric(as.character(p_a1$`Proporção Propriedade`))), ]
b <- p_a2[order(as.numeric(as.character(p_a2$`Proporção Área (ha)`))), ]

par(family= "Times", cex = 0.7, oma = c(4, 1, 1, 1))


cumul_p <- cumsum(gini$`Propriedades Total`)/max(cumsum(gini$`Propriedades Total`))
cumul_a <- cumsum(gini$`Área Total (ha)`)/max(cumsum(gini$`Área Total (ha)`))
plot(cumul_a, cumul_p, type= "b", pch = 2)
abline(h=0.067, col = "red", lty=2)


####

propriedades <- gini$`Proporção Propriedade`
area <- gini$`Proporção Área (ha)`
cumul_prop <- cumsum(propriedades*area)/max(cumsum(propriedades*area))
cumul_area <- cumsum(area)/max(cumsum(propriedades))
plot(cumul_area, cumul_prop, type= "l")
lines(cumul_area, cumul_prop,col = 2, lwd = 2, type = "p")
legend("topleft", c('My calc', 'LC'), col = 1:2, lty = 1, box.col = 1)

#####


library(ineq)
Lc.p <- Lc(gini$`Área Total (ha)`,n=gini$`Propriedades Total`)
plot(Lc.p, col = "coral", xlab = "Área", ylab = "Propriedade",
     main = "",
     panel.first=grid())

abline(h=0.74, col = "darkgray", lty=2)
abline(v=0.86, col = "darkgray", lty=2)


abline(h=0.067, col = "red", lty=2)
abline(v=0.5, col = "red", lty=2)

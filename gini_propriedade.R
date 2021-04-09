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


x1 <- c(0, 0.5, 0.5, 0)
y1 <-c(0, 0.064, 0.5, 0)

x2 <- c(0.5, 0.86, 0.86, 0.5)
y2 <- c(0.07, 0.74, 0.86, 0.5)

x3 <- c(0.86, 1, 1, 0.86)
y3 <- c(0.739, 1, 1, 0.86)

x11 <- c(0, 0.5, 0.5, 0.0645)
y11 <-c(0, 0, 0.0645, 0)

x22 <- c(0.5, 1, 1, 0.5)
y22 <- c(0, 0, 1, 0.0645)


num <- seq(0,1, 0.05)

library(ineq)
par(family= "Times", cex = 0.7, oma = c(4, 1, 1, 1))

Lc.p <- Lc(gini$`Área Total (ha)`,n=gini$`Propriedades Total`)
plot(Lc.p, col = "black", xlab = "Quantidade de Propriedades", 
     ylab = "Área das Propriedades (ha)",
     main = "", 
     xaxt="n",
     yaxt="n")
axis(side=1,at=num,labels=num)
axis(side=2,at=num,labels=num, las=2)
grid()


polygon(x1, y1, col = "gray", density = 40, border = NA, angle = 90)
polygon(x2, y2, col = "gray", density = 40, border = NA, angle = 90)
polygon(x3, y3, col = "gray", density = 40, border = NA, angle = 90)
polygon(x11, y11, col = "coral", density = 40, border = NA, angle = 60)
polygon(x22, y22, col = "gold", density = 40, border = NA, angle = 60)


segments(0, 0.06, x1 = 0.5, y1 = 0.065,
         col = "purple", lty = 2)
segments(0.5, 0, x1 = 0.5, y1 = 0.065,
         col = "purple", lty = 2)

segments(0, 0.74, x1 = 0.86, y1 = 0.74,
         col = "purple", lty = 2)
segments(0.86, 0, x1 = 0.86, y1 = 0.74,
         col = "purple", lty = 2)

####

legend("topright", legend = c("Propriedades de 0 a 200 (ha)", 
                              "Propriedades de 200 a 2500 (ha) & mais de 2500 (ha)"), 
                   fill = c("coral", "gold"), 
                   density = c(40, 40),
                   angle = c(60, 60),
                   bty = "n", x = "top",  ncol = 2,
                   cex = 0.8)




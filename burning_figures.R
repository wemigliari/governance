library(readxl)
library(varhandle)
library(yarrr)
library(XLConnect)

data_bf <- read_excel("/Users/wemigliari/Documents/R/data/burning_fire_emissions_gfd.xlsx",
                      sheet = "Transposed")


library(extrafont)
library(RColorBrewer)


par(family= "Arial", cex = 0.5, oma = c(4, 1, 1, 1))

plot(data_bf$year, data_bf$BONA, type = "b", bty = "l", pch = 1, col = "blue",
     main = "BC emissions estimates in 1E9 g BC for the globe, different regions, and different fire types", 
     xlab = "", 
     ylab = "Annual fire C emissions (Tg C year)", cex = 0.5,
     ylim =c(0, 3000))

lines(data_bf$year, data_bf$TENA...3, type = "b", bty = "l", pch=3, col = "darkgreen", cex = 0.5)
lines(data_bf$year, data_bf$CEAM...4, type = "b", bty = "l", pch=2, col = "gray", cex = 0.5)
lines(data_bf$year, data_bf$NHSA...5, type = "b", bty = "l", pch=4, col = "gold", cex = 0.5)
lines(data_bf$year, data_bf$SHSA...6, type = "b", bty = "l", pch=5, col = "darkgray", cex = 0.5)
lines(data_bf$year, data_bf$EURO...7, type = "b", bty = "l", pch=6, col = "lightblue", cex = 0.5)
lines(data_bf$year, data_bf$MIDE...8, type = "b", bty = "l", pch=7, col = "gray", cex = 0.5)
lines(data_bf$year, data_bf$NHAF...9, type = "b", bty = "l", pch=8, col = "orange", cex = 0.5)
lines(data_bf$year, data_bf$SHAF...10, type = "b", bty = "l", pch=9, col = "steelblue", cex = 0.5)
lines(data_bf$year, data_bf$BOAS...11, type = "b", bty = "l", pch=10, col = "darkgray", cex = 0.5)
lines(data_bf$year, data_bf$TEAS...12, type = "b", bty = "l", pch=11, col = "lightblue", cex = 0.5)
lines(data_bf$year, data_bf$SEAS...13, type = "b", bty = "l", pch=12, col = "darkgreen", cex = 0.5)
lines(data_bf$year, data_bf$EQAS...14, type = "b", bty = "l", pch=13, col = "darkgray", cex = 0.5)
lines(data_bf$year, data_bf$AUST...15, type = "b", bty = "l", pch=14, col = "lightblue", cex = 0.5)
lines(data_bf$year, data_bf$Global...16, type = "b", bty = "l", pch=15, col = "darkgreen", cex = 0.5)

legend("topright", legend = c("Bona", "TENA", "CEAM", "NHSA", "SHSA",
                             "EURO", "MIDE", "NHAF", "SHAF", "BOAS",
                             "TEAS", "SEAS", "EQAS", "AUST", "Global"),
       col = c("blue", "gray", "darkgreen", "gold", "darkgray", "lightblue",
               "gray", "orange ", "steelblue", "darkgray", "lightblue", "darkgreen",
               "gray", "yellow", "darkgreen"), 
       pch = c(1:15),
       bty = "n", cex = 0.7)

#abline(v=c(9,11), col= "gray")
#abline(v=c(21,23), col="gray")
#abline(v=c(33,35), col="gray")
#abline(v=c(45,47), col="gray")


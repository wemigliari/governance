library(readxl)
library(varhandle)
library(yarrr)
library(XLConnect)

## Load library XLConnect for the function loadWorkbook

mysheets <- loadWorkbook("/Users/wemigliari/Documents/R/tabelas/tour_gov_health_spain.xlsx")

nordic_countries = readWorksheet(mysheets, sheet = "Nordic Countries")
germany = readWorksheet(mysheets, sheet = "Germany")
uk = readWorksheet(mysheets, sheet = "UK")
france = readWorksheet(mysheets, sheet = "France")
belgium = readWorksheet(mysheets, sheet = "Belgium")
italy = readWorksheet(mysheets, sheet = "Italy")
ireland = readWorksheet(mysheets, sheet = "Ireland")
netherlands = readWorksheet(mysheets, sheet = "Netherlands")
portugal = readWorksheet(mysheets, sheet = "Portugal")
switzerland = readWorksheet(mysheets, sheet = "Switzerland")
russia = readWorksheet(mysheets, sheet = "Russia")
other_european = readWorksheet(mysheets, sheet = "Other European")
totals = readWorksheet(mysheets, sheet = "Totals")

library(extrafont)
library(RColorBrewer)


par(family= "Arial", cex = 0.5, oma = c(4, 1, 1, 1))


plot(nordic_countries$Arrivals/1000000, type = "b", bty = "l", pch = 1, col = "blue",
     xlab = "Historical Series 1 = Oct/2015; 50 = Apr/2020. Shaded Area = Period of Vacation Jun-Aug", 
     ylab = "Million", ylim = c(0, 3), cex = 0.5, 
     panel.first = c(rect(9, -1e6, 11 , 1e6, col='lightgray', border=NA),
                     rect(21, -1e6, 23 , 1e6, col='lightgray', border=NA),
                     rect(33, -1e6, 35 , 1e6, col='lightgray', border=NA),
                     rect(45, -1e6, 47 , 1e6, col='lightgray', border=NA)))
     
#lines(totals$Arrivals/1000000, type = "b", bty = "l", pch=10, col = "gray", cex = 0.5)

lines(uk$Arrivals/1000000, type = "b", bty = "l", pch=3, col = "darkgreen", cex = 0.5)
lines(germany$Arrivals/1000000, type = "b", bty = "l", pch=2, col = "gray", cex = 0.5)
lines(france$Arrivals/1000000, type = "b", bty = "l", pch=4, col = "gold", cex = 0.5)
lines(belgium$Arrivals/1000000, type = "b", bty = "l", pch=5, col = "darkgray", cex = 0.5)
lines(italy$Arrivals/1000000, type = "b", bty = "l", pch=6, col = "lightblue", cex = 0.5)
lines(ireland$Arrivals/1000000, type = "b", bty = "l", pch=7, col = "gray", cex = 0.5)
lines(netherlands$Arrivals/1000000, type = "b", bty = "l", pch=8, col = "orange", cex = 0.5)
lines(portugal$Arrivals/1000000, type = "b", bty = "l", pch=9, col = "gold", cex = 0.5)
lines(switzerland$Arrivals/1000000, type = "b", bty = "l", pch=10, col = "darkgray", cex = 0.5)
lines(russia$Arrivals/1000000, type = "b", bty = "l", pch=11, col = "lighblue", cex = 0.5)
lines(other_european$Arrivals/1000000, type = "b", bty = "l", pch=12, col = "darkgreen", cex = 0.5)

legend("topleft", legend = c("Nordic Countries", "UK", "Germany", "France", "Belgium",
                             "Italy", "Ireland", "Netherlands", "Portugal", "Switzerland",
                             "Russia", "Other European Countries"),
       col = c("blue", "gray", "darkgreen", "gold", "darkgray", "lightblue",
               "gray", "orange ", "gold", "darkgray", "lightblue", "darkgreen"), 
       pch = c(1:12),
       bty = "n", cex = 0.7)

#abline(v=c(9,11), col= "gray")
#abline(v=c(21,23), col="gray")
#abline(v=c(33,35), col="gray")
#abline(v=c(45,47), col="gray")


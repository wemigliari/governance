library(readxl)
library(varhandle)
library(yarrr)
library(XLConnect)

mysheets <- loadWorkbook("/Users/wemigliari/Documents/R/tabelas/gov_health_spain.xlsx")

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


par(family= "Arial", cex = 0.5, oma = c(4, 1, 1, 4))

plot(nordic_countries$Arrivals/1000000, type = "b", bty = "l", pch = 1, col = "blue",
     xlab = "Historical Series. 1 = Oct/2015; 50 = Apr/2020. Shaded Areas = Periods of Vacation Jun-Aug", 
     ylab = "Million", ylim = c(0, 3), cex = 1, 
     panel.first = c(rect(9, -0.12, 11 , 3.1, col='lightgray', border=NA),
                     rect(21, -0.12, 23 , 3.1, col='lightgray', border=NA),
                     rect(33, -0.12, 35 , 3.1, col='lightgray', border=NA),
                     rect(45, -0.12, 47 , 3.1, col='lightgray', border=NA)))

#lines(totals$Arrivals/1000000, type = "b", bty = "l", pch=10, col = "gray", cex = 0.5)

lines(uk$Arrivals/1000000, type = "b", bty = "l", pch=2, col = "darkgreen", cex = 1)
lines(france$Arrivals/1000000, type = "b", bty = "l", pch=3, col = "gold", cex = 1)
lines(germany$Arrivals/1000000, type = "b", bty = "l", pch=4, col = "gray", cex = 1)
lines(italy$Arrivals/1000000, type = "b", bty = "l", pch=5, col = "lightblue", cex = 1)
lines(netherlands$Arrivals/1000000, type = "b", bty = "l", pch=6, col = "orange", cex = 1)
lines(belgium$Arrivals/1000000, type = "b", bty = "l", pch=7, col = "darkgray", cex = 1)
lines(ireland$Arrivals/1000000, type = "b", bty = "l", pch=8, col = "gray", cex = 1)
lines(portugal$Arrivals/1000000, type = "b", bty = "l", pch=9, col = "gold", cex = 1)
lines(switzerland$Arrivals/1000000, type = "b", bty = "l", pch=10, col = "darkgray", cex = 1)
lines(russia$Arrivals/1000000, type = "b", bty = "l", pch=11, col = "lightblue", cex = 1)
lines(other_european$Arrivals/1000000, type = "b", bty = "l", pch=12, col = "darkgreen", cex = 1)

text(x=10, y=3, "2016",col="gold4", font=2, cex=1)
text(x=22, y=3, "2017",col="gold4", font=2, cex=1)
text(x=34, y=3, "2018",col="gold4", font=2, cex=1)
text(x=46, y=3, "2019",col="gold4", font=2, cex=1)

legend("topright", legend = c("Nordic Countries", "UK", "France", "Germany", "Italy",
                             "The Netherlands", "Belgium", "Ireland", "Portugal", "Switzerland",
                             "Russia", "Other European Countries"),
       col = c("blue", "darkgreen", "gold", "gray", "lightblue", "orange",
               "darkgray", "gray ", "gold", "darkgray", "lightblue", "darkgreen"), 
       pch = c(1:12),
       inset=c(-0.1,0), horiz=FALSE,
       bty = "n", cex = 1)

#abline(v=c(9,11), col= "gray")
#abline(v=c(21,23), col="gray")
#abline(v=c(33,35), col="gray")
#abline(v=c(45,47), col="gray")


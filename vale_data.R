library(readxl)
library(dplyr)


## Load library XLConnect for the function loadWorkbook



test <- read.csv("/Users/wemigliari/Documents/R/Tabelas/vale_shares.csv", stringsAsFactors = FALSE)
test$Close.Last = as.numeric(gsub("[\\$]", "", test$Close.Last))

test2 <- as.Date(test$Date, format = "%m/%d/%Y", tryFormats = c("%m-%d-%Y", "%Y/%m/%d"))
head(test2)
tail(test2)

shares2 <- cbind(test, test2)

shares2$Date <- NULL


shares2 <- shares2 %>% 
  rename(
    Year = `test2`,
    Price = `Close.Last`
  )


shares2 <- shares2[order(as.Date(shares2$Year, format="%m-%d-%Y")),]     ###https://www.statology.org/sort-by-date-in-r/
shares2$Open = as.numeric(gsub("[\\$]", "", shares2$Open))
shares2$High = as.numeric(gsub("[\\$]", "", shares2$High))
shares2$Low = as.numeric(gsub("[\\$]", "", shares2$Low))

shares2 %>% 
  mutate_if(is.numeric, round, digits = 2)

library(extrafont)
library(RColorBrewer)
library(ggplot2)


par(family= "Arial", cex = 0.5, oma = c(4, 1, 1, 1), mar= c(5,3,2,2))



plot(shares2$Price, type = "b", bty = "l", pch = 1, col = "red", las = 1,
     xlab = "S??rie Hist??rica Junho 2011 - Junho 2021. ??rea sombreada = pre??o em d??lar das a????es da Vale.", 
     ylab = "Pre??o/Unidade A????o (d??lar)", 
     panel.first = c(rect(9, -1e6, 11 , 1e6, col='lightgray', border=NA),
                     rect(21, -1e6, 23 , 1e6, col='lightgray', border=NA),
                     rect(33, -1e6, 35 , 1e6, col='lightgray', border=NA),
                     rect(45, -1e6, 47 , 1e6, col='lightgray', border=NA)))


#lines(totals$Arrivals/1000000, type = "b", bty = "l", pch=10, col = "gray", cex = 0.5)

lines(shares2$Price, type = "b", bty = "l", pch=3, col = "darkgreen", cex = 0.5)



legend("topleft", legend = c("Ferro (ton) - Pre??o em D??lar"),
       col = c("blue"), 
       pch = c(3),
       bty = "n", cex = 0.7)

#####

p <- ggplot(shares2, aes(x=Year, y=Price)) +
  geom_line() + 
  xlab("")
p


library(hrbrthemes)

p <- ggplot(shares2, aes(x=Year, y=Price)) +
  geom_line(color="#ffa500") + 
  annotate("rect", xmin = as.Date("2015-01-01"), xmax = as.Date("2021-06-21"), ymin = 0, ymax = 35,
           alpha = .2) +
  xlab("") +
  theme_ipsum() +
  theme(plot.caption = element_text(size = 10)) +
  labs(title="Vale S/A. A????es Negociadas na Bolsa de Valores de Nova Iorque ",
       y = "Unidade (US$)", caption = "Fonte: Nasdaq. Elaborado por Migliari, W. (2021).")

p

#####

library("writexl")
write_xlsx(shares2, "/Users/wemigliari/Documents/R/Tabelas/vale_shares.xlsx")
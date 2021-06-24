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

####

library(ggplot2)
library(hrbrthemes)

####Graph 1
p <- ggplot(shares2, aes(x=Year, y=Price)) +
  geom_line(color="#ffa500", size = 0.3) + 
  annotate("rect", xmin = as.Date("2015-01-01"), xmax = as.Date("2021-06-21"), ymin = 0, ymax = 35,
           alpha = .2) +
  xlab("") +
  theme_ipsum() +
  theme(plot.caption = element_text(size = 10)) +
  labs(title="Gr??fico 1. Pre??o das A????es da Vale S/A na Bolsa de Valores de Nova Iorque ",
       y = "Unidade (US$)", caption = "Fonte: Nasdaq. Elaborado por Migliari, W. (2021).") +
  annotate(geom="text", x=as.Date("2015-11-05"), y=18, label="Rompimento da Barragem do Fund??o, Mariana", 
           angle = 90,
           size=2,
           color = "#3E3E3E") +
  annotate(geom="text", x=as.Date("2018-12-20"), y=17, label="Rompimento da Barragem da Mina C??rrego do Feij??o, Brumadinho", 
           angle = 90,
           size=2,
           color = "#3E3E3E")+
  geom_vline(xintercept=as.Date("2015-12-05"), linetype="dotted", color = "red")+
  geom_vline(xintercept=as.Date("2019-01-20"), linetype="dotted", color = "red")
p

#####Graph2

colors <- c("Valor Final" = "red", "Maior Valor" = "gold", "Menor Valor" = "#ffa500")


p2 <- ggplot(shares2, aes(x=Year)) +
  geom_line(aes(y = Price, color = "Valor Final"), size = 1, linetype = "dotted") + 
  geom_line(aes(y = High, color = "Maior Valor"), size = 1, linetype = "dotted") +
  geom_line(aes(y = Low, color ="Menor Valor"), size = 1, linetype = "dotted") +
  xlab("") +
  theme_ipsum() +
  theme(plot.caption = element_text(size = 10)) +
  labs(title="Gr??fico 2. Varia????o do Valor das A????es da Vale S/A na Bolsa de Nova Iorque",
       y = "Varia????o das A????es (US$)", caption = "Fonte: Nasdaq. Elaborado por Migliari, W. (2021).",
       color = "") +
  scale_color_manual(values = colors) +
  annotate(geom="text", x=as.Date("2015-11-05"), y=20, label="Rompimento da Barragem do Fund??o, Mariana", 
           angle = 90,
           size=2,
           color = "#3E3E3E") +
  annotate(geom="text", x=as.Date("2018-12-20"), y=25, label="Rompimento da Barragem da Mina C??rrego do Feij??o, Brumadinho", 
           angle = 90,
           size=2,
           color = "#3E3E3E") +
  geom_vline(xintercept=as.Date("2015-12-05"), linetype="dotted", color = "red") +
  geom_vline(xintercept=as.Date("2019-01-20"), linetype="dotted", color = "red") +
  geom_segment(aes(x=as.Date("2015-11-05"), y=3, xend=as.Date("2021-06-20"), yend=21), color = "darkgray",
               linetype="dashed", size = 0.5)
p2

#####Graph2

library(ggtext)

p3 <- ggplot(shares2, aes(x=Year, y= Volume/1000000)) +
  geom_line(color="red") + 

  annotate("rect", xmin = as.Date("2015-01-01"), xmax = as.Date("2021-06-21"), ymin = 0, ymax = 150,
           alpha = .2) +
  xlab("") +
  theme_ipsum() +
  theme(plot.caption = element_text(size = 10)) +
  labs(title="Gr??fico 3. Volume das A????es Negociadas da Vale S/A na Bolsa de Valores de Nova Iorque ",
       y = "Quantidade de A????es (unidades em milh??es)", caption = "Fonte: Nasdaq. Elaborado por Migliari, W. (2021).") +
  annotate(geom="text", x=as.Date("2015-11-05"), y=100, label="Rompimento da Barragem do Fund??o, Mariana", 
           angle = 90,
           size=2,
           color = "#3E3E3E") +
  annotate(geom="text", x=as.Date("2018-12-20"), y=105, label="Rompimento da Barragem da Mina C??rrego do Feij??o, Brumadinho", 
           angle = 90,
           size=2,
           color = "#3E3E3E")+
  geom_vline(xintercept=as.Date("2015-12-05"), linetype="dotted", color = "red")+
  geom_vline(xintercept=as.Date("2019-01-20"), linetype="dotted", color = "red")
  

p3


#####Graph4

library("writexl")
write_xlsx(shares2, "/Users/wemigliari/Documents/R/Tabelas/vale_shares.xlsx")
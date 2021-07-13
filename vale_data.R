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

library(zoo)
colors <- c("Valor Final" = "red", "Maior Valor" = "gold", "Menor Valor" = "#ffa500")


p2 <- ggplot(shares2, aes(x=Year)) +
  geom_line(aes(y = Price, color = "Valor Final"), size = 1, linetype = "dotted") + 
  geom_line(aes(y = High, color = "Maior Valor"), size = 1, linetype = "dotted") +
  geom_line(aes(y = Low, color ="Menor Valor"), size = 1, linetype = "dotted") +
  xlab("") +
  theme_ipsum() +
  theme(plot.caption = element_text(size = 10)) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
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

#### scale_x_yearmon(format="%Y %m", n=20) + Retirada a linha, porque parece desnecess??ria.

#####Graph3

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


#####Graph4 - Correla????es

library(dplyr)
library(lubridate)
shares3 <- shares2[,-c(1,3:5)]

### Soma do volume de a????es de todos os dias por ano - interessante, mas n??o serve, pois o interessante ?? uma m??dia anual
shares4 <- shares3 %>%                #### https://stackoverflow.com/questions/63271525/summing-rows-by-month-over-years-in-r
  mutate(Year = year(Year)) %>% 
  group_by(Year) %>% 
  filter(between(Year, 2011, 2021)) %>% 
  summarise(Volume = sum(Volume, rm.na =TRUE))

### M??dia anual do volume de a????es - o ideal, pois consigo analisar s?? a m??dia anual do volume operado

shares5 <- shares3 %>% 
  mutate(Year = year(Year)) %>% 
  group_by(Year) %>% 
  filter(between(Year, 2011, 2021)) %>% 
  summarise(Volume = mean(Volume, rm.na =TRUE))



ggplot(shares5, aes(x=Year, y= Volume/1000000)) +
  geom_line(color="red")

#####


inter_demand <- read_xlsx("/Users/wemigliari/Documents/R/Tabelas/commodities_quantity_wto.xlsx",
                          col_types = c("numeric", "numeric"))
inter_demand <- inter_demand[-c(1:21),]

shares_6 <- shares5[-c(10:11), -c(1)]

table <- cbind(inter_demand, shares_6)


color_sd <- c("Ferro Comprado" = "gold", "Volume Operado" = "#c47f00")

ggplot(table, aes(x=Year)) +
  geom_line(aes(y = iron_ore_consumption/1000000, color = "Ferro Comprado"), size = 1, linetype = "F1") + 
  geom_line(aes(y = Volume/1000000, color = "Volume Operado"), size = 1, linetype = "longdash") +
  xlab("") +
  theme_ipsum() +
  theme(plot.caption = element_text(size = 10)) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  labs(title="Gr??fico 4. M??dia Anual do Volume das A????es da Vale S/A na Bolsa de Nova Iorque e Ferro Comprado",
       y = "A????es (milh??o) e Ferro (ton. m??tricas)", caption = "Fonte: Nasdaq. Elaborado por Migliari, W. (2021).",
       color = "") +
  labs(caption = "Fonte: Nasdaq. Elaborado por Migliari, W. (2021).",
      color = "") +
  scale_color_manual(values = color_sd) +
  scale_x_continuous(breaks = c(2011:2019)) +
  scale_y_continuous(
    
    # Features of the first axis
    name = "Volume de A????es (milh??es)",
    
    # Add a second axis and specify its features
    sec.axis = sec_axis( trans=~.*10, name="Ferro (mil ton. m??tricas)")
  ) +
  
  annotate(geom="text", x=2014.94, y=10, label="Rompimento da Barragem do Fund??o, Mariana", 
           angle = 90,
           size=2,
           color = "#3E3E3E") +
  annotate(geom="text", x=2018.95, y=10, label="Rompimento da Barragem da Mina C??rrego do Feij??o, Brumadinho", 
           angle = 90,
           size=2,
           color = "#3E3E3E")+
  annotate("rect", xmin = 2015, xmax = 2019, ymin = 0, ymax = 30,
           alpha = .2) +
  geom_vline(xintercept= 2015, linetype="dotted", color = "red")+
  geom_vline(xintercept= 2019, linetype="dotted", color = "red")

  




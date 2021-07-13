library(readxl)
library(dplyr)
library(ggplot2)
library(zoo)

cambio_custo <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/vale_cambio_custo.xlsx")
cambio_custo <- data.frame(cambio_custo)
cambio_custo2 <- as.Date(cambio_custo$Data, format = "%m/%d/%Y", tryFormats = c("%m-%d-%Y", "%Y/%m/%d"))

cambio_custo <- cbind(cambio_custo, cambio_custo2)

cambio_custo$cambio_custo2 <- NULL

cambio_custo$Data <- as.Date(cambio_custo$Data)
class(cambio_custo)



ggplot(cambio_custo, aes(x=Data)) +
  geom_line(aes(y = Cambio, color = "Câmbio (US$)"), size = 1, linetype = "F1") + 
  geom_line(aes(y = Custo, color = "Custo (R$)"), size = 1, linetype = "longdash") +
  xlab("") +
  theme_ipsum() +
  theme(plot.caption = element_text(size = 10)) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  labs(title="Gráfico B. Variação Cambial Real-Dólar e Diminuição de Custos da Vale S.A. no Brasil ",
       y = "Câmbio Real-Dólar", caption = "Fonte: Banco Central Elaborado por Migliari, W. (2021).",
       color = "") +
  labs(caption = "Fonte: Banco Central. Elaborado por Migliari, W. (2021).",
       color = "") +
  scale_color_manual(values = c("steelblue", "#1c4966")) +
  annotate(geom="text", x=as.Date("2015-11-05"), y=2, label="Rompimento da Barragem do Fundão, Mariana", 
           angle = 90,
           size=2,
           color = "#3E3E3E") +
  annotate(geom="text", x=as.Date("2018-12-20"), y=2, label="Rompimento da Barragem da Mina Córrego do Feijão, Brumadinho", 
           angle = 90,
           size=2,
           color = "#3E3E3E")+
  geom_vline(xintercept=as.Date("2015-12-05"), linetype="dotted", color = "red")+
  geom_vline(xintercept=as.Date("2019-01-20"), linetype="dotted", color = "red")+
  annotate("rect", xmin = as.Date("2015-01-01"), xmax = as.Date("2021-06-21"), ymin = 0, ymax = 6,
           alpha = .2) 



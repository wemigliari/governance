library(readxl)
library(dplyr)
library(plotly)


macacos_covid <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/macacos_polos_well.xlsx",
                     sheet = "Covid")

class(macacos_covid)

macacos_covid <- data.frame(macacos_covid)


test1 <- macacos_covid %>% filter(grupo == "perfil_eta")
test2 <- macacos_covid %>% filter(grupo == "enfermi")
test3 <- macacos_covid %>% filter(grupo == "sintocovid")
test4 <- macacos_covid %>% filter(grupo == "cuidacovi")
test5 <- macacos_covid %>% filter(grupo == "cuidhosp")
test6 <- macacos_covid %>% filter(grupo == "test")
test7 <- macacos_covid %>% filter(grupo == "casos")

### Faixa Etária

plot_ly(test1, x = test1$variavel, y = test1$total, name = "Faixa Etária", type = "bar", 
        color= I("#660000"), text = c("Total, somados idosos e não idosos", "Sobre o total de 292 entrevistados", "Somente idosos"))%>%
  layout(xaxis = list(titlefont = list(size = 10), tickfont = list(size = 10)))

### Doença e Testes

### Doentes

plot_ly(test2, x = test2$variavel, y = test2$total, name = "Testes", type = "bar", 
           color=I("#cc0000"))%>%
  layout(xaxis = list(titlefont = list(size = 10), tickfont = list(size = 10)))
  
### Doença e Testes

plot_ly() %>%
add_trace(type='pie', values=test3$total,
        name = "",
        labels = c("Com Sintomas", "Sem Sintomas"),
        insidetextorientation='radial',
        domain = list(row = 0, column = 0),
        hovertemplate = "%{label} <br>Percentual: %{percent} </br>")%>%
  add_trace(type='pie', values=test4$total,
            name = "",
            labels = c("Infectados", "Não Infectados"),
            insidetextorientation='radial',
            domain = list(row = 0, column = 1),
            hovertemplate = "%{label} <br>Percentual: %{percent} </br>")%>%
  add_trace(type='pie', values=test5$total,
            name = "",
            labels = c("Hospital Público", "Hospital Privado", "Em Casa"),
            insidetextorientation='radial',
            domain = list(row = 1, column = 0),
            hovertemplate = "%{label} <br>Percentual: %{percent} </br>")%>%
  add_trace(type='pie', values=test6$total,
            name = "",
            labels = c("Testes Positivos", "Testes Negativos", "Inconclusivos",
                       "Não Deseja Informar", "Nao Realizou Teste", "Realizou Teste Rede Pública",
                       "Realizou Teste Rede Privada"),
            insidetextorientation='radial',
            domain = list(row = 1, column = 1),
            hovertemplate = "%{label} <br>Percentual: %{percent} </br>")%>%
  layout(title = "", showlegend = TRUE,
         grid=list(rows=2, columns=2),
         xaxis = list(showgrid = TRUE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = TRUE, zeroline = FALSE, showticklabels = FALSE)
  )


##### Boxplots
library(ggplot2)

set.seed(1000)

mean_doent<- mean(test7$total) ### Média do Número de Doentes
sd_doent <-sd(test7$total) ###

###
min(test7$total)
max(test7$total)

x1 <- seq(6, 44, by = 0.1)
y1 <- dnorm(x1, mean = 24, sd = 13)

par(mfrow = c(1,1), family= "Arial", cex = 0.5, oma = c(4, 1, 1, 4))
plot(x1, y1, col = "darkgray",  type = "l", lty = 1, lwd = 1, 
     xlim = c(-20,60),
     xlab = "Número de Doentes",
     ylab = "Densidades")
lines(density(test7$total), col="steelblue")



hist(test7$total, freq=F, breaks=7)
lines(density(test7$total), col="red")


abline(v = mean_doent, col="steelblue")
text(x=26,y = 60, lty = 2, lwd=1, col='black', "Média", srt = 90)


# Boxplot

plot_ly(macacos_covid, type = "box",
        text = test7$variavel,
        quartilemethod="linear",
        boxpoints = "all", jitter = 0.2,
        pointpos = -1.8,
        color = I("steelblue"))%>%
  add_trace(y = test7$total, type = "box", 
            color = I("steelblue"), 
            marker = list(color = "gray"), 
            name = 'Doentes')






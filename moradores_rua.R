library(readxl)
library(plotly)

rua_region <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/brasil_popula_rua.xlsx",
                     sheet = "Region")

rua_region <- data.frame(rua_region)

plot_ly(rua_region, x = rua_region$ANO, y = rua_region$BRASIL, 
        type = 'scatter', mode = 'lines', 
        name = "Brasil",
        color = I("orange"))%>%
  add_trace(rua_region$NORTE,y = rua_region$NORTE, name = "Norte",
            color = I("black"),type = 'scatter', mode = 'lines')%>%
  add_trace(y = rua_region$NORDESTE, name = "Nordeste",
            color = I("gold"),type = 'scatter', mode = 'lines')%>%
  add_trace(y = rua_region$SUDESTE, name = "Sudeste",
            color = I("coral"),type = 'scatter', mode = 'lines')%>%
  add_trace(y = rua_region$SUL, name = "Sul",
            color = I("yellow"),type = 'scatter', mode = 'lines')%>%
  add_trace(y = rua_region$CENTRO, name = "Centro",
            color = I("darkgray"),type = 'scatter', mode = 'lines')%>%
  layout(showlegend = TRUE)

###

rua_capitals <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/brasil_popula_rua.xlsx",
                        sheet = "Capitals")

plot_ly(rua_capitals, x =rua_capitals$ANO, y = rua_capitals$`PEQUENO I`, type = 'bar', 
        name = 'Pequeno I', color = I("black"))%>%
  add_trace(y = rua_capitals$`PEQUENO II`, name = 'Pequeno II', color = I("gray"))%>%
  add_trace(y = rua_capitals$MEDIO, name = 'Médio', color = I("coral"))%>%
  add_trace(y = rua_capitals$GRANDE, name = 'Grande', color = I("gold"))%>%
  add_trace(y = rua_capitals$METROPOLE, name = 'Metrópole', color = I("yellow"))%>%
  add_trace(y = rua_capitals$TOTAL, name = 'Total', color = I("orange"))%>%
  layout(title = "",
          xaxis = list(title = ""),
          yaxis = list(title = ""), barmode="stack")

##

rua_pop <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/brasil_popula_rua.xlsx",
                      sheet = "Population")

plot_ly(rua_pop, x = rua_pop$Ano, y =  rua_pop$`Censo Suas`, type = 'scatter', 
        mode = 'markers+lines', color = I("orange"), name = "Censo SUAS")%>%
  add_markers(x = rua_pop$Ano, rua_pop$`Cadastro Único`, type = 'scatter', 
              mode = 'markers', color = I("orange"), name = "Cadastro Único",
              marker = list(size = rua_pop$`Cadastro Único`/1500 , opacity = 0.4))
  
  
  
## Table Participation

library(knitr)
library(kableExtra)

rua_part <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/brasil_popula_rua.xlsx",
                        sheet = "Participation")

rua_part %>%
  kbl(format = "html", table.attr = "style='width:700%;'") %>%
  kable_paper("hover", full_width = F)

## Table Correlation

rua_correl <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/brasil_popula_rua.xlsx",
                        sheet = "Correlations")

rua_correl %>%
  kbl(format = "html", table.attr = "style='width:700%;'") %>%
  kable_paper("hover", full_width = F)


#### Cronbach's Alpha/data consistency

rua_region <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/brasil_popula_rua.xlsx",
                        sheet = "Region")
rua_region <- rua_region[,-c(1)]

library(psych)

alpha(rua_region)

#### or regression (simple/multiple linear regression)

test3 <- lm(rua_region$SUDESTE ~ rua_region$BRASIL)
summary(test3)

test4 <- lm(rua_region$SUDESTE ~ rua_region$NORTE + rua_region$NORDESTE +
              rua_region$SUL + rua_region$`CENTRO-OESTE`)
summary(test4)










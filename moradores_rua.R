library(readxl)
library(plotly)

rua_region <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/brasil_popula_rua.xlsx",
                     sheet = "Region")

rua_region <- data.frame(rua_region)

plot_ly(rua_region, x = rua_region$ANO, y = rua_region$BRASIL, 
        type = 'scatter', mode = 'lines', 
        name = "Brasil",
        color = I("black"))%>%
  add_trace(rua_region$NORTE,y = rua_region$NORTE, name = "Norte",
            color = I("#768976"),type = 'scatter', mode = 'lines')%>%
  add_trace(y = rua_region$NORDESTE, name = "Nordeste",
            color = I("#4eb14e"),type = 'scatter', mode = 'lines')%>%
  add_trace(y = rua_region$SUDESTE, name = "Sudeste",
            color = I("#007600"),type = 'scatter', mode = 'lines')%>%
  add_trace(y = rua_region$SUL, name = "Sul",
            color = I("#1de21d"),type = 'scatter', mode = 'lines')%>%
  add_trace(y = rua_region$CENTRO, name = "Centro",
            color = I("darkgray"),type = 'scatter', mode = 'lines')%>%
  layout(showlegend = TRUE)

###

rua_capitals <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/brasil_popula_rua.xlsx",
                        sheet = "Capitals")

plot_ly(rua_capitals, x =rua_capitals$ANO, y = rua_capitals$`PEQUENO I`, type = 'bar', 
        name = 'Pequeno I', color = I("black"))%>%
  add_trace(y = rua_capitals$`PEQUENO II`, name = 'Pequeno II', color = I("#768976"))%>%
  add_trace(y = rua_capitals$MEDIO, name = 'Médio', color = I("#4eb14e"))%>%
  add_trace(y = rua_capitals$GRANDE, name = 'Grande', color = I("#007600"))%>%
  add_trace(y = rua_capitals$METROPOLE, name = 'Metrópole', color = I("#1de21d"))%>%
  add_trace(y = rua_capitals$TOTAL, name = 'Total', color = I("darkgray"))%>%
  layout(title = "",
          xaxis = list(title = ""),
          yaxis = list(title = ""), barmode="stack")

##

rua_pop <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/brasil_popula_rua.xlsx",
                      sheet = "Population")

plot_ly(rua_pop, x = rua_pop$Ano, y =  rua_pop$`Censo Suas`, type = 'scatter', 
        mode = 'markers+lines', color = I("red"), name = "Censo SUAS")%>%
  add_markers(x = rua_pop$Ano, rua_pop$`Cadastro Único`, type = 'scatter', 
              mode = 'markers', color = I("darkgreen"), name = "Cadastro Único",
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






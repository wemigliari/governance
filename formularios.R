library(readxl)
library(plotly)
library(dplyr)
library(knitr)

macacos <- read_excel("/Users/wemigliari/Documents/R/tabelas/macacos.xlsx", sheet = "gen")
macacos <- data.frame(macacos)

macacos1 <- read_excel("/Users/wemigliari/Documents/R/tabelas/macacos.xlsx", sheet = "rac")
macacos1 <- data.frame(macacos1)

macacos2 <- read_excel("/Users/wemigliari/Documents/R/tabelas/macacos.xlsx", sheet = "orig")
macacos2 <- data.frame(macacos2)

macacos3 <- read_excel("/Users/wemigliari/Documents/R/tabelas/macacos.xlsx", sheet = "aces")
macacos3 <- data.frame(macacos3)

macacos4 <- read_excel("/Users/wemigliari/Documents/R/tabelas/macacos.xlsx", sheet = "dificuldade")
macacos4 <- data.frame(macacos4)


### Cirkeldiagrammer

colors <- c('#8B4513', '#D2691E')
colors1 <- c('#A52A2A', '#D2691E', '#8B4513', '#DAA520', '#F4A460', '#DEB887')

plot_ly() %>% add_pie(data = macacos, 
                      labels = macacos$Gênero, 
                      values = macacos$Total,
                      type = "pie",
                      name = "Gênero", 
                      hole = 0.6,
                      marker = list(colors = colors)) %>%
  layout(title = "",   
         margin = list(l = 120, r = 10, t = 50, b = 80),
         paper_bgcolor = '#FFF8DC',
         plot_bgcolor = '#FFF8DC',
         color = "darkgray" , autosize = TRUE,
         font = list(family = 'Arial', size = 10),
         showlegend = TRUE,
         xaxis = list(showgrid = FALSE, zeroline = FALSE,
                      showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE,
                      showticklabels = FALSE))



plot_ly()%>%  add_pie(data = macacos1,
                      labels = macacos1$Cor,
                      values = macacos1$Total,
                      type = "pie", 
                      name = "Raça",
                      hole = 0.6,
                      marker = list(colors = colors1)) %>%
              layout(title = "",  
                     margin = list(l = 120, r = 10, t = 50, b = 80),
                     paper_bgcolor = '#FFF8DC',
                     plot_bgcolor = '#FFF8DC',
                     color = "darkgray" , autosize = TRUE,
                     font = list(family = 'Arial', size = 10),
                     showlegend = TRUE,
                     xaxis = list(showgrid = FALSE, zeroline = FALSE,
                                  showticklabels = FALSE),
                     yaxis = list(showgrid = FALSE, zeroline = FALSE,
                                  showticklabels = FALSE))






#####

colors2 <- c('#D2691E')

fig2 <- plot_ly(data = macacos2, x = macacos2$Total, 
                y = ~reorder(macacos2$Bairro, macacos2$Total), 
                text = paste(macacos2$Média, '%'),
                labels = c(macacos2$Total, macacos2$Bairro),
                name = "Comunidade",
                type = 'bar', orientation = 'h',
                marker = list(color = colors2,
                              line = list(color = colors2, width = 1))) %>%
  
  layout(yaxis = list(showgrid = FALSE, showline = FALSE, 
                      showticklabels = TRUE,
                      domain= c(0, 0.85)),
         xaxis = list(zeroline = FALSE, showline = FALSE, 
                      showticklabels = TRUE,
                      showgrid = TRUE), legend = F) 
####

colors3 <- c('#A52A2A', '#D2691E', '#8B4513') 

fig3 <- plot_ly(data = macacos3, x = macacos3$Total, y = ~reorder(macacos3$Total, macacos3$Registros), 
                hoverinfo = "text",
                text = paste(macacos3$Registros, macacos3$Média, '%'),
                name = "Registro",
                type = 'scatter', mode = 'lines+markers',
                line = list(color = '#D2691E')) 

fig3 <- fig3 %>% layout(yaxis = list(showgrid = FALSE, 
                                     showline = TRUE, showticklabels = FALSE,
                                     linecolor = colors3, linewidth = 2,
                                     domain = c(0, 0.85)),
                        xaxis = list(zeroline = FALSE, showline = FALSE,
                                     showticklabels = TRUE, showgrid = TRUE,
                                     side = 'top', dtick = 1000)) 

fig3 <- fig3 %>% add_annotations(x = macacos3$Total, y = macacos3$Registros,
                                 xref = 'x2', yref = 'y2',
                                 text = paste('', ''),
                                 font = list(family = 'Arial', size = 12, color = colors3),
                                 showarrow = FALSE)

fig <- subplot(fig2, fig3)

###

fig <- fig %>% layout(title = '',
                      legend = list(x = 0.029, y = 1.038),
                      color = "darkgray" , autosize = F,
                      font = list(family = 'Arial', size = 10),
                      margin = list(l = 120, r = 10, t = 50, b = 80),
                      paper_bgcolor = '#FFF8DC',
                      plot_bgcolor = '#FFF8DC')

fig <- fig %>% add_annotations(xref = 'paper', yref = 'paper',
                               x = 0.2, y = -0.15,
                               text = paste('Dados Publicados pelo Programa Polos de Cidadania'),
                               font = list(family = 'Arial', size = 8, color = '#D2691E'),
                               showarrow = FALSE)

fig


### Registration


colors4 <- c('#A52A2A', '#D2691E', '#8B4513', '#DAA520')

plot_ly() %>% add_pie(data = macacos4, 
                      labels = macacos4$Resposta, 
                      values = macacos4$Total,
                      type = "pie",
                      name = "Questionários", 
                      hole = 0.6,
                      marker = list(colors = colors4)) %>%
  layout(autosize = TRUE, title = "",  
         color = "darkgray" ,
         font = list(family = 'Arial', size = 10),
         showlegend = TRUE,
         paper_bgcolor = '#FFF8DC',
         plot_bgcolor = '#FFF8DC',
         margin = list(l = 120, r = 20, t = 50, b = 80),
         xaxis = list(showgrid = FALSE, zeroline = FALSE,
                      showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE,
                      showticklabels = FALSE))



####

macacos5 <- read_excel("/Users/wemigliari/Documents/R/tabelas/macacos.xlsx", 
                       sheet = "day")
macacos5 <- data.frame(macacos5)


plot_ly(macacos5, x = macacos5$Dias.Cadastramento, y =  macacos5$Total.de.Dias, 
        type = 'bar', 
        color = macacos5$Total.de.Dias, 
        name = "Espera",
        text = ~paste('Valor sobre 1: ', macacos5$Média.de.Dias),
        marker = list(size = macacos5$Total.de.Dias, opacity = 0.4))%>%
  layout(paper_bgcolor = '#FFF8DC',
         plot_bgcolor = '#FFF8DC',
         xaxis=list(
         categoryorder = "array",
         categoryarray = macacos5$Dias.Cadastramento))%>%
  hide_colorbar()


macacos55 <- read_excel("/Users/wemigliari/Documents/R/tabelas/macacos.xlsx", 
                       sheet = "week")
macacos55 <- data.frame(macacos55)

plot_ly(x = macacos55$Total.de.Semanas, y = macacos55$Semanas.Para.Recebimento.Após.Cadastro, 
              type = 'scatter', 
              mode = 'markers',
              orientation = 'h',
              text = ~paste('Valor sobre 1: ', macacos55$Média.de.Semanas),
              color = macacos55$Total.de.Semanas,
              name = "Espera",
              marker = list(size = macacos55$Total.de.Semanas, opacity = 0.4))%>%
  layout(paper_bgcolor = '#FFF8DC',
         plot_bgcolor = '#FFF8DC',
         yaxis=list(categoryorder = "array",
         categoryarray = macacos55$Semanas.Para.Recebimento.Após.Cadastro))%>%
  hide_colorbar()



####

macacos6 <- read_excel("/Users/wemigliari/Documents/R/tabelas/macacos.xlsx", 
                       sheet = "agreem")
macacos6 <- data.frame(macacos6)

plot_ly(macacos6, x = macacos6$Concordância..Acordo.e.Valores, y = macacos6$Total, 
        type = 'bar', 
        mode = 'lines', color = macacos6$Total, 
        text = ~paste('Valor sobre 1: ', macacos6$Média),
        name = "Concordância",
        marker = list(size = macacos6$Total, opacity = 0.4))%>%
  layout(showscale = FALSE, paper_bgcolor = '#FFF8DC',
         plot_bgcolor = '#FFF8DC')%>%
  hide_colorbar()

####

macacos7 <- read_excel("/Users/wemigliari/Documents/R/tabelas/macacos.xlsx", 
                       sheet = "payment")
macacos7 <- data.frame(macacos7)

plot_ly(macacos7, x = macacos7$Total, y = macacos7$Recebimento.do.Pagamento, 
        type = 'bar', 
        orientation = 'h',
        mode = 'lines', color = macacos7$Total, 
        text = ~paste('Valor sobre 1: ', macacos7$Média),
        name = "Recebimento",
        marker = list(size = macacos7$Total, opacity = 0.4))%>%
  hide_colorbar()%>%
  layout(paper_bgcolor = '#FFF8DC',
         plot_bgcolor = '#FFF8DC',
         showlegend=FALSE)%>%
  colorbar(limits = c(-1, 1))
##
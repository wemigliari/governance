library(broom)
library(readxl)
library(highcharter)
library(plotly)

data_bf <- read_excel("/Users/wemigliari/Documents/R/data/burning_fire_emissions_gfd.xlsx",
                      sheet = "Transposed")



fig1 <- plot_ly(data_bf, x = ~year, y = data_bf$BONA, type = 'bar', name = 'BONA')%>% 
  add_trace(y = data_bf$TENA...3, name = 'TENA')%>% 
  add_trace(y = data_bf$CEAM...4, name = 'CEAM')%>% 
  add_trace(y = data_bf$NHSA...5, name = 'NHSA')%>% 
  add_trace(y = data_bf$SHSA...6, name = 'SHSA')%>% 
  add_trace(y = data_bf$EURO...7, name = 'EURO')%>% 
  add_trace(y = data_bf$MIDE...8, name = 'MIDE')%>% 
  add_trace(y = data_bf$NHAF...9, name = 'NHAF')%>% 
  add_trace(y = data_bf$SHAF...10, name = 'BOAS')%>% 
  add_trace(y = data_bf$BOAS...11, name = 'BOAS')%>% 
  add_trace(y = data_bf$TEAS...12, name = 'TEAS')%>% 
  add_trace(y = data_bf$SEAS...13, name = 'SEAS')%>% 
  add_trace(y = data_bf$EQAS...14, name = 'EQAS')%>% 
  add_trace(y = data_bf$AUST...15, name = 'AUST')%>% 
  add_trace(y = data_bf$Global...16, name = 'Global')%>% 
  layout(yaxis = list(title = 'Annual fire C emissions (Tg C year)'), 
                      xaxis = list(title = ""), barmode = 'stack')

fig1

###

fig2 <- plot_ly(data_bf, x = ~year, y = data_bf$BONA_savana, name = "BONA", type = "scatter", mode = 'lines+markers', color = I("red"), opacity = 0.5, marker = list(size = data_bf$BONA_savana/100, color = "steelblue"))%>%
  add_trace(y = data_bf$TENA...18, name = 'TENA', color = I("black"), marker = list(color = "black"))%>%
  add_trace(y = data_bf$CEAM...19, name = 'CEAM', color = I("green"), marker = list(color = "green"))%>%
  add_trace(y = data_bf$NHSA...20, name = 'NHSA', color = I("red"), marker = list(color = "red"))%>%
  add_trace(y = data_bf$SHSA...21, name = 'SHSA', color = I("orange"), marker = list(color = "orange"))%>%
  add_trace(y = data_bf$EURO...22, name = 'EURO', color = I("#7f0000"), marker = list(color = "#7f0000"))%>%
  add_trace(y = data_bf$MIDE...23, name = 'MIDE', color = I("#124c00"), marker = list(color = "#124c00"))%>%
  add_trace(y = data_bf$NHAF...24, name = 'NHAF', color = I("#3cff00"), marker = list(color = "#3cff00"))%>%
  add_trace(y = data_bf$SHAF...25, name = 'SHAF', color = I("#0c3300"), marker = list(color = "#0c3300"))%>%
  add_trace(y = data_bf$BOAS...26, name = 'BOAS', color = I("#124c00"), marker = list(color = "#124c00"))%>%
  add_trace(y = data_bf$TEAS...27, name = 'TEAS', color = I("#52db92"), marker = list(color = "#52db92"))%>%
  add_trace(y = data_bf$SEAS...28, name = 'SEAS', color = I("#b20000"), marker = list(color = "#b20000"))%>%
  add_trace(y = data_bf$EQAS...29, name = 'EQAS', color = I("gold"), marker = list(color = "gold"))%>%
  add_trace(y = data_bf$AUST...30, name = 'AUST', color = I("gray"), marker = list(color = "gray"))%>%
  add_trace(y = data_bf$Global...31, name = 'Global', color = I("#186600"), marker = list(color = "#186600"))%>%
  layout(yaxis = list(title = "Savanna, grassland and shrubland fires C emissions (Tg C year)"),
         xaxis = list(title = ""))

fig2

####


fig3 <- plot_ly(data_bf, x = ~year, y = data_bf$BONA_boreal, name = "BONA", type = "scatter", mode = 'markers', 
                color = I("red"), opacity = 0.5, marker = list(size = data_bf$BONA_boreal/7, color = "red"))%>%
  add_trace(y = data_bf$TENA...33, name = 'TENA', color = I("black"), marker = list(color = "black"))%>%
  add_trace(y = data_bf$CEAM...34, name = 'CEAM', color = I("green"), marker = list(color = "green"))%>%
  add_trace(y = data_bf$NHSA...35, name = 'NHSA', color = I("red"), marker = list(color = "red"))%>%
  add_trace(y = data_bf$SHSA...36, name = 'SHSA', color = I("orange"), marker = list(color = "orange"))%>%
  add_trace(y = data_bf$EURO...37, name = 'EURO', color = I("#7f0000"), marker = list(color = "#7f0000"))%>%
  add_trace(y = data_bf$MIDE...38, name = 'MIDE', color = I("#124c00"), marker = list(color = "#124c00"))%>%
  add_trace(y = data_bf$NHAF...39, name = 'NHAF', color = I("#3cff00"), marker = list(color = "#3cff00"))%>%
  add_trace(y = data_bf$SHAF...40, name = 'SHAF', color = I("#0c3300"), marker = list(color = "#0c3300"))%>%
  add_trace(y = data_bf$BOAS...41, name = 'BOAS', color = I("#124c00"), marker = list(color = "#124c00"))%>%
  add_trace(y = data_bf$TEAS...42, name = 'TEAS', color = I("#52db92"), marker = list(color = "#52db92"))%>%
  add_trace(y = data_bf$SEAS...43, name = 'SEAS', color = I("#b20000"), marker = list(color = "#b20000"))%>%
  add_trace(y = data_bf$EQAS...44, name = 'EQAS', color = I("gold"), marker = list(color = "gold"))%>%
  add_trace(y = data_bf$AUST...45, name = 'AUST', color = I("gray"), marker = list(color = "gray"))%>%
  add_trace(y = data_bf$Global...46, name = 'Global', color = I("#186600"), marker = list(color = "#186600"))%>%
  layout(yaxis = list(title = "Boreal forest fires C emissions (Tg C year)"),
         xaxis = list(title = ""))

fig3

###

fig4 <- plot_ly(data_bf, x = ~year, y = data_bf$BONA_temper, name = "BONA", type = "scatter",
                mode = 'lines+markers', color = I("red"), opacity = 0.5, marker = list(size = data_bf$BONA_temper, color = "red"))%>%
  add_trace(y = data_bf$TENA...48, name = 'TENA', color = I("black"), marker = list(color = "black"))%>%
  add_trace(y = data_bf$CEAM...49, name = 'CEAM', color = I("green"), marker = list(color = "green"))%>%
  add_trace(y = data_bf$NHSA...50, name = 'NHSA', color = I("red"), marker = list(color = "red"))%>%
  add_trace(y = data_bf$SHSA...51, name = 'SHSA', color = I("orange"), marker = list(color = "orange"))%>%
  add_trace(y = data_bf$EURO...52, name = 'EURO', color = I("#7f0000"), marker = list(color = "#7f0000"))%>%
  add_trace(y = data_bf$MIDE...53, name = 'MIDE', color = I("#124c00"), marker = list(color = "#124c00"))%>%
  add_trace(y = data_bf$NHAF...54, name = 'NHAF', color = I("#3cff00"), marker = list(color = "#3cff00"))%>%
  add_trace(y = data_bf$SHAF...55, name = 'SHAF', color = I("#0c3300"), marker = list(color = "#0c3300"))%>%
  add_trace(y = data_bf$BOAS...56, name = 'BOAS', color = I("#124c00"), marker = list(color = "#124c00"))%>%
  add_trace(y = data_bf$TEAS...57, name = 'TEAS', color = I("#52db92"), marker = list(color = "#52db92"))%>%
  add_trace(y = data_bf$SEAS...58, name = 'SEAS', color = I("#b20000"), marker = list(color = "#b20000"))%>%
  add_trace(y = data_bf$EQAS...59, name = 'EQAS', color = I("gold"), marker = list(color = "gold"))%>%
  add_trace(y = data_bf$AUST...60, name = 'AUST', color = I("gray"), marker = list(color = "gray"))%>%
  add_trace(y = data_bf$Global...61, name = 'Global', color = I("#186600"), marker = list(color = "#186600"))%>%
  layout(yaxis = list(title = "Temperate forest fires C emissions (Tg C year)"),
         xaxis = list(title = ""), barmode = "group")

fig4

###

fig5 <- plot_ly(data = data_bf, x = data_bf$year, y = data_bf$BONA_tropic, type = 'scatter',
              mode = 'markers', symbol = data_bf$BONA_tropic, symbols = c('x'),
              color = I('black'), marker = list(size = 6))%>%
  add_trace(y = data_bf$TENA...63, name = 'TENA', color = I("black"), marker = list(color = "black"))%>%
  add_trace(y = data_bf$CEAM...64, name = 'CEAM', color = I("green"), marker = list(color = "green"))%>%
  add_trace(y = data_bf$NHSA...65, name = 'NHSA', color = I("red"), marker = list(color = "red"))%>%
  add_trace(y = data_bf$SHSA...66, name = 'SHSA', color = I("orange"), marker = list(color = "orange"))%>%
  add_trace(y = data_bf$EURO...67, name = 'EURO', color = I("#7f0000"), marker = list(color = "#7f0000"))%>%
  add_trace(y = data_bf$MIDE...68, name = 'MIDE', color = I("#124c00"), marker = list(color = "#124c00"))%>%
  add_trace(y = data_bf$NHAF...69, name = 'NHAF', color = I("#3cff00"), marker = list(color = "#3cff00"))%>%
  add_trace(y = data_bf$SHAF...70, name = 'SHAF', color = I("#0c3300"), marker = list(color = "#0c3300"))%>%
  add_trace(y = data_bf$BOAS...71, name = 'BOAS', color = I("#124c00"), marker = list(color = "#124c00"))%>%
  add_trace(y = data_bf$TEAS...72, name = 'TEAS', color = I("#52db92"), marker = list(color = "#52db92"))%>%
  add_trace(y = data_bf$SEAS...73, name = 'SEAS', color = I("#b20000"), marker = list(color = "#b20000"))%>%
  add_trace(y = data_bf$EQAS...74, name = 'EQAS', color = I("gold"), marker = list(color = "gold"))%>%
  add_trace(y = data_bf$AUST...75, name = 'AUST', color = I("gray"), marker = list(color = "gray"))%>%
  add_trace(y = data_bf$Global...76, name = 'Global', color = I("#186600"), marker = list(color = "#186600"))%>%
  layout(title = "Tropical deforestation and degradation",  showlegend = F,
         xaxis = list(showgrid = TRUE, zeroline = FALSE, showticklabels = TRUE),
         yaxis = list(showgrid = TRUE, zeroline = FALSE, showticklabels = TRUE))

fig5

###

fig6 <- plot_ly(data = data_bf, x = data_bf$year, y = data_bf$BONA_peat, type = 'scatter',
                mode = 'markers', symbol = data_bf$BONA_peat, symbols = c('x'),
                color = I('black'), marker = list(size = 10))%>%
  add_trace(y = data_bf$TENA...78, name = 'TENA', color = I("black"), marker = list(color = "black"))%>%
  add_trace(y = data_bf$CEAM...79, name = 'CEAM', color = I("green"), marker = list(color = "green"))%>%
  add_trace(y = data_bf$NHSA...80, name = 'NHSA', color = I("red"), marker = list(color = "red"))%>%
  add_trace(y = data_bf$SHSA...81, name = 'SHSA', color = I("orange"), marker = list(color = "orange"))%>%
  add_trace(y = data_bf$EURO...82, name = 'EURO', color = I("#7f0000"), marker = list(color = "#7f0000"))%>%
  add_trace(y = data_bf$MIDE...83, name = 'MIDE', color = I("#124c00"), marker = list(color = "#124c00"))%>%
  add_trace(y = data_bf$NHAF...84, name = 'NHAF', color = I("#3cff00"), marker = list(color = "#3cff00"))%>%
  add_trace(y = data_bf$SHAF...85, name = 'SHAF', color = I("#0c3300"), marker = list(color = "#0c3300"))%>%
  add_trace(y = data_bf$BOAS...86, name = 'BOAS', color = I("#124c00"), marker = list(color = "#124c00"))%>%
  add_trace(y = data_bf$TEAS...87, name = 'TEAS', color = I("#52db92"), marker = list(color = "#52db92"))%>%
  add_trace(y = data_bf$SEAS...88, name = 'SEAS', color = I("#b20000"), marker = list(color = "#b20000"))%>%
  add_trace(y = data_bf$EQAS...89, name = 'EQAS', color = I("#b487ce"), marker = list(color = "#b487ce"))%>%
  add_trace(y = data_bf$AUST...90, name = 'AUST', color = I("#e4caf2"), marker = list(color = "#e4caf2"))%>%
  add_trace(y = data_bf$Global...91, name = 'Global', color = I("#503c5b"), marker = list(color = "#503c5b"))%>%
  layout(title = "Peat Fires C emissions (Tg C year)",  showlegend = F,
         xaxis = list(showgrid = TRUE, zeroline = FALSE, showticklabels = TRUE),
         yaxis = list(showgrid = TRUE, zeroline = FALSE, showticklabels = TRUE))

fig6

###

fig7 <- plot_ly(data = data_bf, x = data_bf$year, y = data_bf$BONA_agri, type = 'scatter',
               mode = "lines+markers", color = I('black'))%>%
  add_trace(y = data_bf$TENA...93, name = 'TENA', color = I("black"), marker = list(color = "black"))%>%
  add_trace(y = data_bf$CEAM...94, name = 'CEAM', color = I("green"), marker = list(color = "green"))%>%
  add_trace(y = data_bf$NHSA...95, name = 'NHSA', color = I("red"), marker = list(color = "red"))%>%
  add_trace(y = data_bf$SHSA...96, name = 'SHSA', color = I("orange"), marker = list(color = "orange"))%>%
  add_trace(y = data_bf$EURO...97, name = 'EURO', color = I("#7f0000"), marker = list(color = "#7f0000"))%>%
  add_trace(y = data_bf$MIDE...98, name = 'MIDE', color = I("#124c00"), marker = list(color = "#124c00"))%>%
  add_trace(y = data_bf$NHAF...99, name = 'NHAF', color = I("#3cff00"), marker = list(color = "#3cff00"))%>%
  add_trace(y = data_bf$SHAF...100, name = 'SHAF', color = I("#0c3300"), marker = list(color = "#0c3300"))%>%
  add_trace(y = data_bf$BOAS...101, name = 'BOAS', color = I("#124c00"), marker = list(color = "#124c00"))%>%
  add_trace(y = data_bf$TEAS...102, name = 'TEAS', color = I("#52db92"), marker = list(color = "#52db92"))%>%
  add_trace(y = data_bf$SEAS...103, name = 'SEAS', color = I("#b20000"), marker = list(color = "#b20000"))%>%
  add_trace(y = data_bf$EQAS...104, name = 'EQAS', color = I("gold"), marker = list(color = "gold"))%>%
  add_trace(y = data_bf$AUST...105, name = 'AUST', color = I("gray"), marker = list(color = "gray"))%>%
  add_trace(y = data_bf$Global...106, name = 'Global', color = I("#186600"), marker = list(color = "#186600"))%>%
  layout(title = "Agricultural waste burning",  showlegend = F,
         xaxis = list(showgrid = TRUE, zeroline = FALSE, showticklabels = TRUE),
         yaxis = list(showgrid = TRUE, zeroline = FALSE, showticklabels = TRUE))

fig7





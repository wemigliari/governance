library(shiny)
library(shinyWidgets)
library(dslabs)
library(tidyverse)
library(plotly)

library(readxl)
library(plotly)
library(sf) ## Read shapefiles
library(rgdal)
library(leaflet)
library(htmlwidgets)
library(tmap)
library(dplyr)
library(RColorBrewer)


### Regiões Totais de Moradores

## https://www.r-bloggers.com/2017/03/4-tricks-for-working-with-r-leaflet-and-shiny/

#### Histogram

prpolos <-  read_xlsx("/Users/wemigliari/Documents/R/tabelas/populacao_rua_polos.xlsx",
                      sheet="Etnia")

ui <- fluidPage(
  
  # Application title
  titlePanel("Metadados Interativos"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Moradores em situação de rua:",
                  min = 10,
                  max = 500,
                  value = 10)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x <- (prpolos$Total)
    
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'orange', border = 'white',
         main="Histograma sobre a População em Situação de Rua",
         xlab="Casos no Brasil", ylab="Frequência")
  })
}

shinyApp(ui, server)

### Boxplot


prpolos <-  read_xlsx("/Users/wemigliari/Documents/R/tabelas/populacao_rua_polos.xlsx",
                      sheet="Etnia")
prpolos <- data.frame(prpolos)

ui <- shinyUI(fluidPage(
  titlePanel(""),
  sidebarLayout(
    sidebarPanel(
      selectInput("var",label="Moradores por cor",choices=c("Branca"=10,
                                                           "Preta"=11,
                                                           "Amarela"=12,
                                                           "Parda"=13,
                                                           "Indígena"=14,
                                                           "Sem Resposta"=15,
                                                           "Pretos & Pardos"=17), selectize=FALSE)),
    mainPanel(
      h4("Estatística Descritiva"),
      verbatimTextOutput("sum"),
      plotOutput("box")
    )
  ))
)


server <- shinyServer(function(input,output){
  
  output$sum <- renderPrint({
    
    summary(prpolos[,as.numeric(input$var)])
  })
  
  output$box <- renderPlot({
    
    x<-summary(prpolos[,as.numeric(input$var)])
    boxplot(x,col="yellow",border="black",main=names(prpolos[as.numeric(input$var)]),
            outline = TRUE,
            ylim = c(0,100))
  })
}
)

shinyApp(ui, server)


#### Mapas

map_mr <-  read_xlsx("/Users/wemigliari/Documents/R/tabelas/populacao_rua_polos.xlsx",
                      sheet="Etnia")

names(map_mr)[1] <- "nome"

summary(map_mr)

regioes <- read_sf("/Users/wemigliari/Documents/R/data/regioes_2010.shp", 
                   options = "ENCODING=windows-1252")

data_polos1 <- merge(map_mr, regioes, by = "nome")


###

shp_joined <- inner_join(regioes, data_polos1, by = "nome")
class(shp_joined) # Dataframe. It does not work yet!

shp_joined <- st_as_sf(shp_joined) 
class(shp_joined) # It is now converted to "sf" and "data.frame". It works!

data_polos1 <- shp_joined %>%
  arrange(Total) %>%
  mutate(name=factor(nome, unique(nome)))


####

mybins1 <- c(5414, 11203, 20334, 22900, 100259)
mypalette1 <- colorBin(palette="YlOrBr", na.color="transparent", domain=data_polos1, bins=mybins1)

mytext1 <- paste(
  "Região: ", data_polos1$nome, "<br/>",
  "Total: ", data_polos1$Total, "<br/>",
  "Preta: ", data_polos1$Preta, "<br/>",
  "Parda: ", data_polos1$Parda, "<br/>",
  "Indígena: ", data_polos1$Indígena, "<br/>",
  "Branca: ", data_polos1$Branca, "<br/>",
  "Sem Resposta: ", data_polos1$`Sem Resposta`, "<br/>",
  sep="") %>%
  lapply(htmltools::HTML)

#####


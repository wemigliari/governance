library(knitr)
library(writexl)
library(rgdal)
library(sf) ## Read shapefiles
library(dplyr)
library(leaflet)
library(cowplot)
library(ggplot2)
library(plotly)
library(readxl)
library(htmlwidgets)

participacao <- read_excel("/Users/wemigliari/Documents/R/tabelas/participacao_industria_pib.xls")


par(family= "Times", cex = 0.7, oma = c(4, 1, 1, 1))

plot(participacao$Período, participacao$`Total_Ind_PIB(%)`,
     type = "l", lty =1, col = "steelblue",
     main = "",
     xlab = "", ylab = "(%)",
     las =1,
     ylim = c(0,30),
     panel.first = c(rect(1997, 0, 2000 , 30, col="#ececec", border=NA),
                     rect(2008, 0, 2016, 30, col="#ececec", border=NA)))

lines(participacao$Período, participacao$`Total_Ind_Trans_PIB(%)`, type = "l", col = "steelblue", lty=2)
lines(participacao$Período, participacao$`Total_Ind_Ex_PIB(%)`, type = "l",col = "darkgray", lty=1)
lines(participacao$Período, participacao$`Total_Ele_PIB(%)`, type = "l", col = "darkgray", lty=2)
lines(participacao$Período, participacao$`Total_Const_PIB(%)`, type = "l", col = "black",lty=2)
lines(participacao$Período, participacao$`Total_Agro_PIB(%)`, type = "l", col = "red", lty=2)

legend(2016, 29, legend = c("Total Participação da Indústria", 
                              "Indústria de Transformação", 
                              "Mineração",
                              "Energia",
                              "Construção",
                              "Agronegócio"),
       col = c("steelblue", "steelblue", "darkgray", "darkgray", "black", "red"), 
       lty = c(1, 2, 1, 2, 2, 2),
       bty = "n", cex = 0.7)




######

tomadores <- read.xlsx("/Users/wemigliari/Documents/R/tabelas/tomadores_bndes.xlsx",
                       sheetName = "Dados", encoding = "UTF-8", stringsAsFactors = F)


par(mar=c(3, 18, 3, 3), family= "Times", cex = 0.7, oma = c(2, 2, 2, 5))

test <- barplot(height=tomadores$Total.Bilhões,
        names=tomadores$Tomador.de.recursos, 
        col="#69b3a2", horiz=TRUE, las =1,
        xlim = c(0,70))

text(tomadores$Total.Bilhões, test, 
     round(tomadores$Total.Bilhões, 1),
     cex=0.9, pos=4, col="black") 

######

pesquisa <- read.xlsx("/Users/wemigliari/Documents/R/tabelas/p_d_brasil.xlsx",
                       sheetName = "Dados", encoding = "UTF-8", stringsAsFactors = F)

pesquisa_total <- pesquisa%>%filter(Quantidade=="Total")


pt <- barplot(pesquisa_total$Bilhões, main="",
        space=1,
        density=c(25) , angle=c(45),
        names.arg=pesquisa_total$Ano, col=c("darkgray"),
        ylab="Bilhões de Reais",
        ylim = c(0,80))
text(pt, pesquisa_total$Bilhões, 
     round(pesquisa_total$Bilhões, 1),
     cex=0.9, pos=3, col="black") 


###

pesquisa_setor <- pesquisa %>% filter(Quantidade %in% c("Investimentos públicos",
                           "Investimentos empresariais - Empresas privadas e estatais", 
                            "Total"))

ps <- barplot(pesquisa_setor$Bilhões, main="",
              space=1,
              density=c(60, 50, 70) , angle=c(45, 30, 10),
              names.arg=pesquisa_setor$Ano, col=c("darkgray", "red", "brown"),
              ylab="Bilhões de Reais",
              ylim = c(0,80),
              legend = c("Total", "Públicos", "Empresariais"), 
              args.legend = list(title = "P&D", 
                                 bty = "n", x = "top", ncol = 3,
                                 cex = .7))

text(ps, pesquisa_setor$Bilhões, 
     round(pesquisa_setor$Bilhões, 1),
     cex=0.9, pos=3, col="black") 

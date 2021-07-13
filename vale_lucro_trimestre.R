library(dplyr)
library(readxl)
library(formattable)
library(kable)

lucros <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/vale_lucro_trimestre.xlsx")
lucros <- data.frame(lucros)

colnames(lucros)[3] <- "Data do Balanço"
colnames(lucros)[4] <- "Lucro Líquido Ajustado pelo IPCA (Bilhões de Reais)"


customGreen <- c("#00c400", "#14ff14", "#89ff89", "#b1ffb1", "#ebffeb")


formattable(lucros, digits = 5, 
            align = c("l","l", "l", "r"),
            format = "f", list(
                           `Empresa` = formatter("span", style = ~ style(color = "grey",font.weight = "bold")), 
                           `Lucro Líquido Ajustado pelo IPCA (Bilhões de Reais)`= color_bar(customGreen)
                           ))

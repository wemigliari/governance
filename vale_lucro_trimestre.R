library(dplyr)
library(readxl)
library(formattable)

lucros <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/vale_lucro_trimestre.xlsx")
lucros <- data.frame(lucros)

colnames(lucros)[3] <- "Data do Balanço"
colnames(lucros)[4] <- "Lucro Líquido Ajustado pelo IPCA (Bilhões de Reais)"

class(lucros)

formattable(lucros, list(`Lucro Líquido Ajustado pelo IPCA (Bilhões de Reais)` =
                           color_bar("steeblue", proportion)))
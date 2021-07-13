library(readxl)
library(tibble)
library(RColorBrewer)
library(dplyr)
library(stringr)


indeniza <- read_xlsx("/Users/wemigliari/Documents/R/tabelas/indenizacao_media.xlsx")
indeniza <- data.frame(indeniza)

### Inserir mais cores
nb.cols <- 11
mycolors <- colorRampPalette(brewer.pal(8, "Blues"))(nb.cols) 



ggplot(indeniza, aes(reorder(Lugar, -Calculo, sum), y = Calculo/1000000, fill = Tipos, label = Letra)) + 
  theme_bw() + 
  labs(title = "Gráfico 4. Tipologia e Valores das Indenizações (US$)", 
       x = "", y = "Milhões (US$)", caption = "Fonte: Tribunais Brasileiro (2021), Espanhol (2021), Australiano (2019) e NIOSH. Elaborated by W. Migliari (2021).") +
  geom_bar(stat = "identity") +
  theme(legend.position = "right") +
  geom_text(size = 2.5, color="black", position = position_stack(vjust = 0.5)) +
  scale_fill_manual(values = mycolors) +
  guides(fill=guide_legend(title="Tipologia do quantum"))
  
  


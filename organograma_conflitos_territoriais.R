library(DiagrammeR)

### https://cyberhelp.sesync.org/blog/visualization-with-diagrammeR.html
### See documentation https://graphviz.org/doc/info/attrs.html and https://rich-iannone.github.io/DiagrammeR/graphviz_and_mermaid.html

### Sem conflitos territoriais

grViz("digraph{
  
      graph[rankdir = LR]
  
      node[shape = rectangle, style = filled]
  
      node[fillcolor = YellowGreen, margin = 0.2]
      A[label = 'Poder Judiciário']
      B[label = 'Exportações']
      C[label = 'Administração Pública']
  
      subgraph cluster_0 {
        graph[shape = rectangle]
        style = rounded
        bgcolor = Gold
    
        label = 'Assentamentos Humanos & Economias Circulares'
        node[shape = rectangle, fillcolor = LemonChiffon, margin = 0.25]
        D[label = 'Comunidades Tradicionais']
        E[label = 'Pequenas Propriedades']
        
      }
  
      subgraph cluster_1 {
         graph[shape = rectangle]
         style = rounded
         bgcolor = Gold
    
         label = 'Expansão da Fronteira Produtiva & Economias Integradas ao Comércio Internacional'
         node[shape = rectangle, fillcolor = LemonChiffon, margin = 0.25]
         F[label = 'Média e Grande Propriedade']
         G[label = 'Cadeia Produtiva & Compliance']
      
      }
  
  
      node[fillcolor = LawnGreen, margin = 0.2]
      H[label = 'Agropecuária Intensiva']
      
      node[fillcolor = LawnGreen, margin = 0.2]
      I[label = 'Agropecuária Extensiva']
      
      node[fillcolor = LawnGreen, margin = 0.2]
      J[label = 'Economia Extrativista']
      
      {A C} -> {F} [dir=both color='black', style = dotted]
      {A C} -> {D E} [dir=both color='black', style = dotted]
      {B} -> {F G} [dir=both color='black']
      {F} -> {G} [dir=both color='black']
      {F} -> {H I J} [dir=both color='DodgerBlue']
      
    }")

#### Com conflitos territoriais

grViz("digraph{
  
      graph[rankdir = LR]
  
      node[shape = rectangle, style = filled]
  
      node[fillcolor = YellowGreen, margin = 0.2]
      A[label = 'Poder Judiciário']
      B[label = 'Exportações']
      C[label = 'Administração Pública']
  
      subgraph cluster_0 {
        graph[shape = rectangle]
        style = rounded
        bgcolor = Gold
    
        label = 'Assentamentos Humanos & Economias Circulares'
        node[shape = rectangle, fillcolor = LemonChiffon, margin = 0.25]
        D[label = 'Comunidades Tradicionais']
        E[label = 'Pequenas Propriedades']
        
      }
  
      subgraph cluster_1 {
         graph[shape = rectangle]
         style = rounded
         bgcolor = Gold
    
         label = 'Expansão da Fronteira Produtiva & Economias Integradas ao Comércio Internacional'
         node[shape = rectangle, fillcolor = LemonChiffon, margin = 0.25]
         F[label = 'Média e Grande Propriedade']
         G[label = 'Cadeia Produtiva & Compliance']
      
      }
  
  
      node[fillcolor = LawnGreen, margin = 0.2]
      H[label = 'Agropecuária Intensiva']
      
      node[fillcolor = LawnGreen, margin = 0.2]
      I[label = 'Agropecuária Extensiva']
      
      node[fillcolor = LawnGreen, margin = 0.2]
      J[label = 'Economia Extrativista']
      
      {A C} -> {F} [dir=both color='black', style = dotted]
      {A C} -> {D E} [dir=both color='black', style = dotted]
      {B} -> {F G} [dir=both color='black']
      {D E} -> {F} [dir=both color='red']
      {D E} -> {G} [dir=both color='red', style = dotted]
      {F} -> {G} [dir=both color='black']
      {F} -> {H I J} [dir=both color='DodgerBlue']
      
    }")









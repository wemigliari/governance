library(DiagrammeR)

DiagrammeR("
sequenceDiagram;
   Propriedade Rural-->>Agroindústria: Melhoramento Genético;
   Propriedade Rural-->>Agroindústria: Bem-Estar;
   Propriedade Rural-->>Agroindústria: Pastagem;
   Propriedade Rural-->>Agroindústria: Sanidade Animal;
   Propriedade Rural-->>Agroindústria: Criação;
   Propriedade Rural-->>Agroindústria: Nutrição;
   Propriedade Rural-->>Agroindústria: Rastreabilidade;
   Agroindústria->>Consumidor: Transporte;
   Agroindústria->>Consumidor: Abate;
   Agroindústria->>Consumidor: Processamento;
   Agroindústria->>Consumidor: Distribuição;
   Agroindústria->>Consumidor: Comercialização;
   Consumidor-xConsumidor: Consumo
   Note right of Consumidor: Fim da cadeia <br/>no âmbito nacional<br/>internacional
   Note right of Agroindústria: Intermediários<br/>e atravessadores<br/>dependentes de combustível fóssil
   Note right of Propriedade Rural: Início da cadeia<br/>envolvendo grande propriedade
")


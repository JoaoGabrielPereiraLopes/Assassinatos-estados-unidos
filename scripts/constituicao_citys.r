# Lê os dados
dados <- read.csv("../database/database.csv")

# Obter os valores únicos da coluna 'City'
cidade_colum <- unique(dados$City)

# Criar um vetor para armazenar contagens por cidade
contagem_cidades <- sapply(cidade_colum, function(cidade) {
  sum(dados$City == cidade)
})

# Obter as 5 cidades com maior número de ocorrências
top_5 <- sort(contagem_cidades, decreasing = TRUE)
top_5 <- head(top_5, 5)

# Definir as categorias de armas/causas
categorias <- list(
  "armas de fogo" = c("Rifle", "Shotgun", "Handgun", "Gun", "FireArm"),
  "armas brancas" = c("Blunt Object", "Knife"),
  "acidentes causados" = c("Strangulation", "Fall", "Drowning", "Suffocation", "Fire"),
  "químicos" = c("Explosives", "Drugs", "Poison")
)

# Inicializa uma lista para armazenar os resultados
hash_bidimensional <- list()

# Loop pelas cidades no top 5
for (cidade in names(top_5)) {
  # Contar ocorrências por categoria
  contagem_categorias <- sapply(names(categorias), function(categoria) {
    sum(dados$City == cidade & dados$Weapon %in% categorias[[categoria]])
  })
  # Armazena no hash
  hash_bidimensional[[cidade]] <- contagem_categorias
}

# Gerar gráficos para as 5 principais cidades
for (i in seq_along(hash_bidimensional)) {
  cidade <- names(hash_bidimensional)[i]
  valores <- hash_bidimensional[[cidade]]
  nome_arquivo <- paste0("../resultados/composicoes/",cidade, "_composicao.png")
  titulo <- paste("Armas usadas nos assassinatos em", cidade)
  
  # Salvar o gráfico
  png(nome_arquivo, width = 800, height = 600)
  pie(
    valores,
    labels = names(valores),
    main = titulo,
    col = rainbow(length(valores))
  )
  dev.off()
}

# Contagem geral para todo o USA
contagem_geral <- sapply(names(categorias), function(categoria) {
  sum(dados$Weapon %in% categorias[[categoria]])
})

# Gerar gráfico para os dados gerais
nome_arquivo_geral <- "../resultados/composicoes/USA_composicao.png"
titulo_geral <- "Armas usadas nos assassinatos em todo o USA"
png(nome_arquivo_geral, width = 800, height = 600)
pie(
  contagem_geral,
  labels = names(contagem_geral),
  main = titulo_geral,
  col = rainbow(length(contagem_geral))
)
dev.off()
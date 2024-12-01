# Lê os dados
dados <- read.csv("../database/database.csv")

# Obter os valores únicos da coluna city
cidade_colum <- unique(dados$City)
print(unique(dados$Weapon))

# Criar um vetor vazio com nomes (anos)
dict <- numeric(length(cidade_colum))
names(dict) <- cidade_colum

# Loop para contar as ocorrências de cada cidade
for (cidade_item in cidade_colum) {
  quantidade <- nrow(dados[dados$City == cidade_item, ])
  dict[as.character(cidade_item)] <- quantidade
}
top_5 <- sort(dict, decreasing = TRUE) # Ordena em ordem decrescente
top_5 <- head(top_5, 5) # Pega os 5 primeiros

# Pega a biblioteca hash
library(hash)

# Inicializa o hash
hash_bidimensional <- hash()

# Armazena as cidades e suas respectivas quantidades
hash_bidimensional[["cidades"]] <- names(top_5)

# Define as categorias
categorias <- list(
  "armas de fogo" = c("Rifle", "Shotgun", "Handgun", "Gun", "FireArm"),
  "brancas" = c("Blunt Object", "Knife"),
  "acidentes causados" = c("Strangulation", "Fall", "Drowning", "Suffocation", "Fire"),
  "químicos" = c("Explosives", "Drugs", "Poison")
)

# Loop pelas cidades para criar o hash bidimensional
for (x in names(top_5)) {
  # Inicializa um vetor para armazenar os valores de cada categoria para a cidade atual
  valores <- numeric(length(categorias))
  names(valores) <- names(categorias)
  
  # Loop para cada categoria
  for (y in names(categorias)) {
    # Conta o número de ocorrências em 'dados' que correspondem à cidade e à categoria
    valores[y] <- nrow(dados[dados$City == x & dados$Weapon %in% categorias[[y]], ])
    
    # Depuração opcional
    print(paste("Cidade:", x))
    print(paste("Categoria:", y))
    print(paste("Quantidade:", valores[y]))
  }
  
  # Armazena o vetor de valores no hash bidimensional
  hash_bidimensional[[x]] <- valores
}

# Exibe o hash final
print(hash_bidimensional)

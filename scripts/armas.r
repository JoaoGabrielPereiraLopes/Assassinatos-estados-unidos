dados <- read.csv("../database/database.csv")

# Obter os valores únicos da coluna city
cidade_colum <- unique(dados$City)

# Criar um vetor vazio com nomes (anos)
dict <- numeric(length(cidade_colum))
names(dict) <- cidade_colum

# Loop para contar as ocorrências de cada ano
for (cidade_item in cidade_colum) {
    quantidade <- nrow(dados[dados$City == cidade_item & dados$Weapon %in% c('Handgun','Rifle','Shotgun'), ])
    dict[as.character(cidade_item)] <- quantidade
}

top_5 <- sort(dict, decreasing = TRUE) # Ordena em ordem decrescente
top_5 <- head(top_5, 5) # Pega os 5 primeiros

png("../resultados/armas.png", width = 800, height = 600, bg = "white")
barplot(top_5,
        names.arg = names(top_5),
        col = "skyblue",
        main = "Gráfico de Barras",
        xlab = "Categorias",
        ylab = "Valores")
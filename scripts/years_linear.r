dados <- read.csv("../database/database.csv")

# Obter os valores únicos da coluna Year
anos_unicos <- unique(dados$Year)

# Criar um vetor vazio com nomes (anos)
dict <- numeric(length(anos_unicos))
names(dict) <- anos_unicos

# Loop para contar as ocorrências de cada ano
for (ano in anos_unicos) {
  quantidade <- nrow(dados[dados$Year == ano, ])
  dict[as.character(ano)] <- quantidade
}

library(ggplot2)

grafico <- ggplot(dados, aes(x = Year)) +
geom_point(aes(y = dict[as.character(Year)]), color = "blue") +  # Adicionar os pontos
geom_smooth(method = "lm", aes(y = dict[as.character(Year)]), color = "red", se = TRUE) +  # Adicionar a linha de redução
labs(title = "relação ano-numero de assassinato", x = "Ano", y = "Quantidade") +#descrições di gráfico
theme_light()#bg branco

#salvar o gráfico como png com largura 10 e altura 6 e dpi 300 na pasta resultados
ggsave("../resultados/linear_reducion_years.png", plot = grafico, device = "png", width = 10, height = 6, dpi = 300)
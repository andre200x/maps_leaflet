#### Quick Start

## O que é o leaflet?
# leaflet é um pacote open source para mapas interativos

install.packages("leaflet")
library(leaflet)

## O que ele faz?
# cria mapas interativos

map <- leaflet() %>% 
  addTiles() %>% 
  addMarkers(lng = 174.768, lat = -36.852, popup = "The birthplace of R")

# leaflet() é uma função que retorna um "leaflet map widget"
# addTiles() e addMarkers() são similares ao + geom() no ggplot2
# no sentido que adicionam camadas ao seu mapa criado com a função leaflet()

#### Map Widget

## O que é um map widget?
# "widget" traduz para ferramenta, podemos pensar então como uma ferramenta
# criadora de mapas 

# a função leaflet() retorna um map widget e nele é armazenado uma lista de
# objetos, esses objetos são os argumentos escolhidos dentro dessa função
# e da função leafletOptions

## Map Methods
# podemos manipular os atributos do nosso map widget com uma serie de metodos, dessas funções a que
# mais usamos é setView()

map <- leaflet() %>% addTiles() %>% 
  setView(lng = -47.87080311824759, lat = -15.759003304840647, zoom = 11) # 15 18
map

## Data Objetc

# a leaflet() pode receber argumento de "spatial data", do prorio R base ou dos
# pacotes sp ou maps
# algumas funções precisamos definir qual tipo de "data", então quando definimos 
# o argumentos data no leaflet(data = algo), essas funções irão receber o argumento
# previamente definido

install.packages("maps")
library(maps)

mapStates = map("state", fill = TRUE, plot = FALSE)
leaflet(data = mapStates) %>% addTiles() %>%
  addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)

#### Markets ----
# São marcadores para chamar pontos do mapa, através de coordenadas (lat/lng) 
# podem aparecer ou como ícones ou como círculos.

## os dados podem vir de algumas fontes como: 
# SpatialPoints ou SpatialPointsDataFrame (do pacote "sp") 
# POINT, sfc_POINT ou sf (do pacote "sf") 
#-> em que apenas as dimensões X e Y serão consideradas
# Matrizes numericas com colunas
#-> A primeira coluna seria a longitude e a segunda a tatitude 
# Dataframe com colunas de longitude e latitude 
#-> possível dizer explicitamente à função quais colunas contêm os dados de
#--> coordenadas
# Fornecer vectores numéricos com os argumento de longitude e latitude

## addMarkers

addMarkers(lng, lat, popup, label)
# adiciona ícones básicos (default)

data(quakes)
head(quakes)
# Data frame com 1000 observações com 5 variáveis.
# latitude, longitude, profundidade (km), magnitude, Número de relatórios de estações
# link -> https://stat-ethz-ch.translate.goog/R-manual/R-devel/library/datasets/html/quakes.html?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=pt-BR&_x_tr_pto=sc

# Mapa com marcadores por default
leaflet(data = quakes[1:6,]) %>% 
  addTiles() %>%
  addMarkers(~long, ~lat)


## makeIcon
# Com essa função é possível alterar esses ícones por link ou imagem presente no computador (e afins)

# cria um ícone de alfinete com esses parâmetros
leaflet_Icon <- makeIcon(
  iconUrl = "https://icons.iconarchive.com/icons/shlyapnikova/toolbar-2/32/pin-icon.png",
  iconWidth = 25, iconHeight = 50,
  iconAnchorX = 1, iconAnchorY = 45)

# mapa com os mesmo dados que o anterior, mas com novo ícone
leaflet(data = quakes[1:6,]) %>% 
  addTiles() %>%
  addMarkers(~long, ~lat, icon = leaflet_Icon)

## multiplos ícones

# icons()
# Ambos possuem o mesmo tamanho e pontos de ancoragem

# separando os ícones e seus parâmetros
leaflet_Icons <- icons(
  iconUrl = 
    ifelse(quakes[1:10,]$mag < 4.6,
           "https://icons.iconarchive.com/icons/shlyapnikova/toolbar-2/32/pin-icon.png",
           "http://clubedefinancas.com.br/wp-content/uploads/2018/04/map-marker-icon.png"
  ),
  iconWidth = 25, iconHeight = 50,
  iconAnchorX = 13, iconAnchorY = 54)

# mapa com 2 ícones a depender de quakes$mag
leaflet(data = quakes[1:10,]) %>% 
  addTiles() %>%
  addMarkers(~long, ~lat, icon = leaflet_Icons)


# iconList()
# Permite criar uma lista de ícones, com diferentes ícones e parâmetros  
# A partir da função makeIcon()

# separando os ícones, cada um com parâmetros diferentes
icon_data <- iconList(
  red = makeIcon(
    iconUrl = "http://clubedefinancas.com.br/wp-content/uploads/2018/04/map-marker-icon.png",
    iconWidth = 23, iconHeight = 38),
  green = makeIcon(
    iconUrl = "https://icons.iconarchive.com/icons/shlyapnikova/toolbar-2/32/pin-icon.png",
    iconWidth = 32, iconHeight = 28))

# criando uma coluna para decidir qual ícone para cada informação
quakes_2 <- mutate(quakes, 
                   type = factor(ifelse(quakes$mag < 4.6, "green", "red")))

# mapa com 2 ícones, mas esse com parâmetros diferentes
leaflet(data = quakes_2[1:10,]) %>% 
  addTiles() %>%
  addMarkers(~long, ~lat, icon = ~icon_data[type])


## Awesome Icons 
# funções addAwesomeMarkers(), makeAwesomeIcon(), awesomeIcons(), awesomeIconList()
# semelhante aos anteriores, mas com cores e ícones customizáveis
# a partir de ícones das bibliotecas: Font Awesome, Bootstrap Glyphicons, and Ion icons

# separando o ícone 
icon_fa <- makeAwesomeIcon(
  icon = "exclamation", markerColor = "orange",
  library = "fa", iconColor = "black")

# mapa com a customização escolhida anteriormente
leaflet(data = quakes[1:10,]) %>% 
  addTiles() %>%
  addAwesomeMarkers(~long, ~lat, icon =icon_fa )

# OBS: O argumento library pode ser ‘ion’, ‘fa’, ou ‘glyphicon’. 

## Marker Clusters
# agrupa marcadores, quando esses são muitos
# Basta adicionar o parâmetro clusterOptions e markerClusterOptions()

leaflet(quakes) %>% 
  addTiles() %>% 
  addMarkers(~long, ~lat, clusterOptions = markerClusterOptions())

# ainda pode-se "congelar" o zoom com um nível específico  

leaflet(quakes) %>% 
  addTiles() %>% 
  addMarkers(clusterOptions = markerClusterOptions(freezeAtZoom = 5))

## Circle Markers
# por defaulf

leaflet(quakes[1:20,]) %>% 
  addTiles() %>% 
  addCircleMarkers()

# pode alterar a cor, raio, transparência

leaflet(quakes_2[1:10,]) %>% 
  addTiles() %>%
  addCircleMarkers(radius = ~ifelse(depth < 200, 5, 10),
    color = ~type,
    stroke = FALSE, fillOpacity = 0.5)

#### popups ----
# adiciona pequenas caixa de texto nos marcadores

leaflet(data = quakes[1:20,]) %>% addTiles() %>%
  addMarkers(~long, ~lat, popup = ~as.character(mag))

# possui 2 principais formas de cria-los
# função addPopups() ou como parâmetro em addMarkers(..., popup, ...)

# criando o texto
content <- paste(sep = "<br/>",
  "<b><a href='http://www.est.unb.br/'>Estatística Unb</a></b>",
  "(61) 3107-3661")

# mapa com o texto
leaflet() %>% 
  addTiles() %>%
  addPopups(-47.8690438, -15.7584196, content,
            options = popupOptions(closeButton = T))

# criando um data frame
Local <- c("Departamento CIC/EST", "Departamento de Mat", "FACE")
Lat <- c(-15.7584196, -15.7623606, -15.7585618)
Long <- c(-47.8690438, -47.8696452, -47.8715123)
df <- data.frame(Local, Lat,Long)

# mapa com o nome do lugar nos marcadores
leaflet(df) %>% 
  addTiles() %>%
  addMarkers(~Long, ~Lat, popup = ~Local)

#### Labels ----
# semelhante ao anterior, mas só de passar o mouse o bloco de texto aparece

leaflet(df) %>% 
  addTiles() %>%
  addMarkers(~Long, ~Lat, label = ~Local)

# o texto pode ser modificado

# semelhante ao mapa anterior, mas com o texto alterado
leaflet(df) %>% 
  addTiles() %>% 
  addMarkers(~Long, ~Lat, label = ~Local, 
             labelOptions = 
               labelOptions(textsize = "15px",direction = "bottom",
                            noHide = T))
    





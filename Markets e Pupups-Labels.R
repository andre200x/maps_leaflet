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

""" resumindo uma tabela com essas informações """

## addMarkers

addMarkers(lng, lat, popup, label)
# adiciona ícones básicos (default)

head(quakes)
# Data frame com 1000 observações com 5 variáveis.
# latitude, longitude, profundidade (km), magnitude, Número de relatórios de estações
https://stat-ethz-ch.translate.goog/R-manual/R-devel/library/datasets/html/quakes.html?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=pt-BR&_x_tr_pto=sc

leaflet(data = quakes[1:6,]) %>% 
  addTiles() %>%
  addMarkers(~long, ~lat)


## makeIcon/icons (iconUrl, iconWidth, iconHeight, iconAnchorX, iconAnchorY,
## shadowUrl, shadowWidth, shadowHeight, ... )

# tabela com resumo dos parametros e suas funcionalidades

leaflet_Icon <- makeIcon(
  iconUrl = "https://icons.iconarchive.com/icons/shlyapnikova/toolbar-2/32/pin-icon.png",
  iconWidth = 25, iconHeight = 50,
  iconAnchorX = 1, iconAnchorY = 45
)

leaflet(data = quakes[1:6,]) %>% 
  addTiles() %>%
  addMarkers(~long, ~lat, icon = leaflet_Icon)

## multiplos ícones

# icons()
# Ambos possuem o mesmo tamanho e pontos de ancoragem


leaflet_Icons <- icons(
  iconUrl = 
    ifelse(quakes[1:10,]$mag < 4.6,
           "https://icons.iconarchive.com/icons/shlyapnikova/toolbar-2/32/pin-icon.png",
           "http://clubedefinancas.com.br/wp-content/uploads/2018/04/map-marker-icon.png"
  ),
  iconWidth = 25, iconHeight = 50,
  iconAnchorX = 13, iconAnchorY = 54)

leaflet(data = quakes[1:10,]) %>% 
  addTiles() %>%
  addMarkers(~long, ~lat, icon = leaflet_Icons)


# iconList()
# Permite criar uma lista de ícones, com diferentes ícones e parâmetros  
# A partir da função makeIcon()


icon_data <- iconList(
  red = makeIcon(
    iconUrl = "http://clubedefinancas.com.br/wp-content/uploads/2018/04/map-marker-icon.png",
    iconWidth = 23, iconHeight = 38),
  green = makeIcon(
    iconUrl = "https://icons.iconarchive.com/icons/shlyapnikova/toolbar-2/32/pin-icon.png",
    iconWidth = 32, iconHeight = 28)
)

quakes_2 <- mutate(quakes, 
                   type = factor(ifelse(quakes$mag < 4.6, "green", "red")))

leaflet(data = quakes_2[1:10,]) %>% 
  addTiles() %>%
  addMarkers(~long, ~lat, icon = ~icon_data[type])


## Awesome Icons 
# funções addAwesomeMarkers(), makeAwesomeIcon(), awesomeIcons(), awesomeIconList()
#-> comparar com os sem Awesome, em tabela
# customizando cores e ícones 
# como com ícones das bibliotecas: Font Awesome, Bootstrap Glyphicons, and Ion icons


icon_fa <- makeAwesomeIcon(
  icon = "exclamation", markerColor = "orange",
  library = "fa", iconColor = "black")

leaflet(data = quakes[1:10,]) %>% 
  addTiles() %>%
  addAwesomeMarkers(~long, ~lat, icon =icon_fa )


# O argumento library pode ser ‘ion’, ‘fa’, ou ‘glyphicon’. 

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

# pode alterar a cor, raio, stroke??, transparência

leaflet(quakes_2[1:10,]) %>% 
  addTiles() %>%
  addCircleMarkers(radius = ~ifelse(depth < 200, 5, 10),
    color = ~type,
    stroke = FALSE, fillOpacity = 0.5)

#### popups ----
# adiciona pequenas caixa de mensagens nos marcadores

leaflet(data = quakes[1:20,]) %>% addTiles() %>%
  addMarkers(~long, ~lat, popup = ~as.character(mag))

# possui 2 principais formas de cria-los
# função addPopups() ou como parâmetro em addMarkers(..., popup, ...)

content <- paste(sep = "<br/>",
  "<b><a href='http://www.est.unb.br/'>Estatística Unb</a></b>",
  "(61) 3107-3661")

leaflet() %>% 
  addTiles() %>%
  addPopups(-47.8690438, -15.7584196, content,
            options = popupOptions(closeButton = T))

Local <- c("Departamento CIC/EST", "Departamento de Mat", "FACE")
Lat <- c(-15.7584196, -15.7623606, -15.7585618)
Long <- c(-47.8690438, -47.8696452, -47.8715123)
df <- data.frame(Local, Lat,Long)

leaflet(df) %>% 
  addTiles() %>%
  addMarkers(~Long, ~Lat, popup = ~Local)

#### Labels ----
# semelhante ao anterior, mas só de passar o mouse o bloco de texto aparece

leaflet(df) %>% 
  addTiles() %>%
  addMarkers(~Long, ~Lat, label = ~Local)

# o texto pode ser modificado

leaflet(df) %>% 
  addTiles() %>% 
  addMarkers(~Long, ~Lat, label = ~Local, 
             labelOptions = 
               labelOptions(textsize = "15px",direction = "bottom",
                            noHide = T))
    










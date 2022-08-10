## Basemaps
# A maneira mais fácil de adicionar blocos é chamando addTiles() sem argumentos; por padrão, 
#os blocos do OpenStreetMap são usados.

MAT <- leaflet() %>%
  setView(lng = -47.86977, lat = -15.76261, zoom = 18) %>%
  addTiles()
MAT  

# Além da visualização padrão, temos outros blocos de mapa gratuitos. 
# Para usá-los, precisamos da função addProviderTiles()

MAT %>%
  addProviderTiles(providers$CartoDB.Positron)

MAT %>%
  addProviderTiles(providers$Esri.WorldStreetMap)



# Lines and Shapes
# O Leaflet facilita a obtenção de linhas e formas espaciais do R e 
#  as adiciona aos mapas.


## Delimitar áreas usando círculos
# Aqui é possível delimitar a precisão de uma localização por meio do raio. 

MAT %>%
  addCircles(lat = -15.76261, lng = -47.86977,
             weight = 1, radiu = sqrt(3.14)*20)
MAT

## Delimitando áreas usando retângulos
# Com essa função, é possível determinar áreas dentro do mapa. 

planaltina <- leaflet() %>% 
  addTiles() %>%
  addRectangles(
    lng1=-47.68076, lat1=-15.596049,
    lng2=-47.62090, lat2=-15.646100,
    fillColor = "transparent")
planaltina

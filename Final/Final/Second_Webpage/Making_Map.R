# Load Packages
library(tidyverse)
library(leaflet) 
library(rgdal)
library(raster)
library(htmlwidgets)



full <- readRDS("Second_Webpage/full.RDS")
?leaflet::addTiles
?tileOptions()

# Making map
map <- leaflet::leaflet() %>% 
  leaflet::addTiles(options = tileOptions(noWrap = TRUE)) %>% 
  setView(lng = 90, lat =-180, zoom = 0) %>% # this seems to change map, trying to get so it doesn't repeat world
  leaflet::addProviderTiles(providers$Esri.WorldImagery, group = "Esri World Imagery") %>% 
  leaflet::addCircleMarkers(lng = full$Longitude,lat = full$Latitude, 
                            group = "SESYNC", radius = 2,
                      popup = paste0("Country: ", full$Country, "<br>",
                                     "Population: ", full$`Population (2020)`, "<br>")) %>% 
  leaflet::addLayersControl(baseGroups = c("OSM", "Esri World Imagery"),
                            overlayGroups = c("SESYNC"),
                            options = layersControlOptions(collapsed=FALSE))

map

#####
# Saving as Widget
saveWidget(map, "Second_Webpage/map.html", selfcontained = FALSE)


library(tidyverse)
library(readxl)
library(leaflet) 
library(rgdal)
library(raster)
library(htmlwidgets)
library(ggplot2)

# reading in and cleaning data
df1 <- read_excel("fungi_cultures.xlsx", sheet = 1)
df2 <- read_excel("fungi_cultures.xlsx", sheet = 2)

df1 <- df1 %>% 
  mutate(location = case_when(location == "a" ~ "Kiwanis Park",
                                     location == "b" ~ "Springville Canyon",
                                     location == "c" ~ "Elk Ridge",
                                     location == "d" ~ "Bountiful"))

# creating full data
md <- df2 %>% 
  full_join(df1, by ="dish_id")


# correcting long to make negative for map
md <- md %>% 
  mutate(lon=lon*-1)


# creating map
map <- leaflet::leaflet() %>% 
  leaflet::addTiles(options = tileOptions(noWrap = TRUE)) %>% 
  setView(lng = 90, lat =-180, zoom = 0) %>% # this seems to change map, trying to get so it doesn't repeat world
  leaflet::addProviderTiles(providers$Esri.WorldImagery, group = "Esri World Imagery") %>% 
  leaflet::addCircleMarkers(lng = md$lon,lat = md$lat, 
                            group = "SESYNC", radius = 5
                            ) %>% 
  leaflet::addLayersControl(baseGroups = c("OSM", "Esri World Imagery"),
                            overlayGroups = c("SESYNC"),
                            options = layersControlOptions(collapsed=FALSE))
map




# reading in and cleaning our matrix
df3 <- read_excel("Matrix.xlsx")
df3[is.na(df3)] <- 0
names(df3)[1] <- "site"
# will need to replace columns with actual fungal species
# if we have some of the same species we will need to change some O's to 1's


df3 %>% 
  dplyr::select(-site) %>% 
  rowSums()

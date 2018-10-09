library(tidyverse)
library(OpenStreetMap)
library(ggmap)

grads <- read_csv("data/raw/pgy1_grads.csv") %>%
    filter(!is.na(first_institution))

jobs <- grads$first_address %>% 
    map_df(geocode, source = "dsk") 

usa <- openmap(c(50, -128), c(20, -63))
usa2 <- openproj(usa)

merc <- projectMercator(jobs$lat, jobs$lon)
merc2 <- jitter(merc)

png("figs/alumni_map.png", bg = "transparent")

plot(usa)
points(merc2, pch = 21, bg = "yellow")

dev.off()

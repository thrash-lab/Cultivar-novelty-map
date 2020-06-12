# R script to generate plots of LSUCC and closely related cultivars on a global map 


# Clear existing settings and data
rm(list=ls()) 

# Required libraries
require(reshape2)
require(ggplot2)
require(maps)

cbbPalette <- c("#808080", "#ff7f50", "#F0E442", "#009E73", "#e79f00", "#9ad0f3", "#0072B2", "#D55E00", "#CC79A7", "#000000", "#ADFF2F", "#8B4513", "#FFC0CB", "#333366")

##############################################################
# Plot cultivar isolation on a world map
# This was generated through help from Murat Eren and his script 
# here: https://github.com/merenlab/world-map-r/
##############################################################

# Read in the data where each desired strain has lat-long values associated with
df <- read.csv("GGmap_Cultivars.csv", header=T)  

# World Map
min_lat <- min(df$lat) + -25
max_lat <- max(df$lat) + 5
min_lon <- min(df$long) + -5
max_lon <- max(df$long) + 5

# Generate the world plot
world <- map_data("world",)
gg1 <- ggplot() +
  geom_polygon(data=world, aes(x=long, y=lat, group=group, alpha=0.4)) +
  coord_fixed(1.2, xlim = c(min_lon, max_lon), ylim = c(min_lat, max_lat)) +
  theme_bw()

#plot all cultivars (LSUCC and others)
gg2 <- gg1 + geom_point(data=df, aes(long, lat, color = Group, shape = Map_Category), alpha=0.8, size =3) + scale_color_manual(values=cbbPalette)+
  labs(x="Longitude", y="Latitude") 
gg2 + theme(legend.position = "none")

#Read in LSUCC only cultivars to plot in a zoomed in region of Louisiana
df2 <- read.csv("Geographic_distribution_ggmap_LSUCConly.csv", header=T)  

# Constrain limits of the map based on plotted values for Louisiana
min_lat <- min(df2$lat) + -0.5
max_lat <- max(df2$lat) + 0.5
min_lon <- min(df2$long) + -0.5
max_lon <- max(df2$long) + 0.5

louisiana <- ggplot() +
  geom_polygon(data=world, aes(x=long, y=lat, group=group)) +
  coord_fixed(1.2, xlim = c(min_lon, max_lon), ylim = c(min_lat, max_lat)) +
  theme_bw()

gg4 <- louisiana + geom_point(data=df2, aes(long, lat, color = TAX), alpha=0.8, size =3) + scale_color_manual(values=cbbPalette)+
  labs(x="Longitude", y="Latitude")
gg4

#Global map (all isolates) and Louisiana map (LSUCC only) were combined in Illustrator




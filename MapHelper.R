install.packages("mapproj")
install.packages("scales")
install.packages("maps")
install.packages("ggmap")
library(ggmap)


library(maps)
library(ggplot2)
library(scales) # for function alpha()
library(mapproj)

#World map
map.dat <- map_data("world")
ggplot() + geom_polygon(aes(long,lat, group=group), fill="grey65", data=map.dat) + theme_bw() + theme(axis.text = element_blank(), axis.title=element_blank()) 
#colored map
ggplot(map.dat, aes(x=long, y=lat, group=group, fill=region))+ geom_polygon() + theme(legend.position = "none")
#USA
us.dat <- map_data("state")
ct.dat <- map_data("county")
ggplot() + geom_polygon(aes(long,lat, group=group), fill="grey65", data=ct.dat) + geom_polygon(aes(long,lat, group=group), color='white', fill=NA, data=us.dat) + theme_bw() + theme(axis.text = element_blank(), axis.title=element_blank()) 

#USA polyconic map
us.dat <- map_data("state")
ggplot(us.dat, aes(x=long, y=lat, group=group)) + geom_polygon(fill="grey65", colour = alpha("white", 1/2), size = 0.2) + theme_bw() + theme(legend.position = "none", text = element_blank(), line = element_blank()) + coord_map("polyconic") 


#GGMAP Package - Google maps api

geocode("University NE, Omaha") # geocode of the location
geocode("PKI, Omaha")
revgeocode(c(-96,41))# gives address for the latitude and longitude
mapdist("Omaha","lincoln") #distance and time




#MAP - CRIME MAP
crimes <- read.csv("./omaha-crimes.csv")
omaps <- get_map(location = 'Omaha', source = 'stamen', maptype = 'toner')
ggmap(omaps) +
  geom_point(size=5, alpha = 1/2, aes(lon,lat, color=type), data=crimes) 


get_map(location = 'Omaha') #returns map details of the area

get_map(location = 'Omaha', maptype = 'satellite')

ggmap(omaps) + stat_bin2d(aes(x = lon, y = lat, colour = type, fill = type), size = .5, bins = 30, alpha = 1/2, data = crimes) + xlim(c(-96.25,-95.85)) + ylim(c(41.15,41.4))

#Crimes
ggmap(omapg) + stat_density2d(aes(x = lon, y = lat, fill = ..level.., alpha = ..level..), 
                              size = 2, bins = 4, data = crimes, geom = "polygon")

x=get_map(location = 'Omaha', maptype = 'roadmap', zoom = 11, color='bw') #saves the map as pixels in x
ggmap(x) # displays the map


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
##                                                                          ##
##                  Extract Points from Chelsa data                         ##
##                                                                          ##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
rm(list = ls())
gc()

library(raster)
library(xlsx)

## read data and maps, ps ich hoffe
geo_points <- read.xlsx("C://Users/ma22buky/Documents/Lotte_help/Chelsa_new/geo_points_chelsa.xlsx", sheetIndex = 1)
temp <- raster("C://Users/ma22buky/Documents/Lotte_help/Chelsa_new/CHELSA_bio10_01.tif")
prec <- raster("C://Users/ma22buky/Documents/Lotte_help/Chelsa_new/CHELSA_bio10_12.tif")

##extract point values, need to divide by 10 cause Chelsa did C*10 (cause they wanted integers rather than floats,
##see the readme)
fin_data <- data.frame(ID = geo_points$ID.x, study = geo_points$study, Nr = geo_points$Nr,
                       annual_mean_temp = c(extract(temp, geo_points[,c("longitude", "latitude")])/10),
                       annual_mean_prec = c(extract(prec, geo_points[,c("longitude", "latitude")])))

##make sure the points fall into the places we expect, just to be safe
plot(temp)
points(geo_points[,c("longitude", "latitude")])

## write new table 
write.xlsx(fin_data, file = "temp_prec_chelsa.xlsx")
getwd()
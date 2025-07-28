#Load population differentiation values
fst=read.table("Rb_fst(1-fst).txt",header=T, dec=",")

#Convert them to the distance format
fst.dists <- dist(fst, method = "euclidean", 
                  diag = TRUE, upper = TRUE)
fst.dists
#Load geographic and environmental population data
farms <- read.table("Geotaxobiology.txt", header=T)
#Environmental euclidean distance (Aridity Index):
envdist=dist(farms[5], diag=T, upper=T)

#geodesic distances (Latitude and Longitude): 
dist=geodist(farms[3:4], measure = "geodesic")
dist=as.dist(dist)

#Create data frames for each distance (geographic, genetic, environmental)
distframe=as.data.frame(dist)
fstframe=as.data.frame(fst.dists)
envframe=as.data.frame(envdist)

#Combine them
distframe$fst=fstframe$x
distframe$env=envframe$x

#Load partial mantel test package
library (ncf)

#Partial mantel tests:
partial.mantel.test(M1 = fst.dists2, M2 = dist2, M3 = envdist2, resamp = 10000)

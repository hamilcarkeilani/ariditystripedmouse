fst=read.table("Rb_fst(1-fst).txt",header=T, dec=",")

fst.dists <- dist(fst, method = "euclidean", 
                  diag = TRUE, upper = TRUE)
fst.dists
farms <- read.table("Geotaxobiology.txt", header=T)
#euclidean distances in degrees:
dist=dist(farms[3:4], diag=T, upper=T)
envdist=dist(farms[5], diag=T, upper=T)

#geodesic distances: 
dist=geodist(farms[3:4], measure = "geodesic")
dist=as.dist(dist)

distframe=as.data.frame(dist)
fstframe=as.data.frame(fst.dists)
envframe=as.data.frame(envdist)

distframe$fst=fstframe$x
distframe$env=envframe$x

r1=mantel.rtest(dist, fst.dists, strata=envdist, nrepet = 10000)
r1
plot(r1)


r2=mantel.rtest(envdist, fst.dists, nrepet = 10000)
r2



r3=mantel.rtest(envdist, dist, nrepet = 10000)
r3




dist2=as.matrix(dist)
envdist2=as.matrix(envdist)
fst.dists2=as.matrix(fst.dists)

mantel(
  dist,
  fst.dists,
  method = "pearson",
  permutations = 999,
  strata = NULL,
  na.rm = FALSE,
  parallel = getOption("mc.cores")
)
#Partial mantel tests:


partial.mantel.test(M1 = fst.dists2, M2 = dist2, M3 = envdist2, resamp = 10000)

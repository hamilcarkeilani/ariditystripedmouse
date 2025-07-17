install.packages("BiocManager")

BiocManager::install("LEA", force = TRUE)
BiocManager::install("tess3r", force = TRUE)

devtools::install_github("bcm-uga/TESS3_encho_sen")


#Load package
library(LEA)
library(ggplot2)

library(tess3r)
library(maps)
library(naniar)


geno2lfmm("populations_nomissing50_nomistake_2.recode.geno", output.file="populations_nomissing50_nomistake_2.recode.lfmm")

genotype = read.table("populations_nomissing50_nomistake_2.recode.lfmm")
max(genotype$V1)
genotype_new= genotype %>% replace_with_na_all(condition = ~ .x == "9")
genotype_new= genotype %>% replace_with_na_all(condition = ~ .x > 2)

coordinates = read.table("tess3coord")


plot(coordinates, pch = 19, cex = .5, 
     xlab = "Longitude (°E)", ylab = "Latitude (°N)")
map(add = T, interior = F)



tess3.obj <- tess3(X = as.matrix(genotype_new), coord = as.matrix(coordinates), K = 1:15, 
                   method = "projected.ls", ploidy = 2, openMP.core.num = 4) 


plot(tess3.obj, pch = 19, col = "blue",
     xlab = "Number of ancestral populations",
     ylab = "Cross-validation score")


q.matrix <- qmatrix(tess3.obj, K = 7)
q.matrix <- as.data.frame(qmatrix(tess3.obj, K = 7))




barplot(q.matrix, border = NA, space = 0, 
        xlab = "Individuals", ylab = "Ancestry proportions", 
        main = "Ancestry matrix") -> bp
axis(1, at = 1:nrow(q.matrix), labels = bp$order, las = 3, cex.axis = .4) 



plot(q.matrix, coordinates, method = "map.max", interpol = FieldsKrigModel(10),  
     main = "Ancestry coefficients",
     xlab = "Longitude", ylab = "Latitude", 
     resolution = c(300,300), cex = .4, 
     col.palette =  CreatePalette(c( "orange", "turquoise", "green4","lightgreen", "red","brown", "purple",8)))

#convert to geno file
output = vcf2geno("populations_nomissing20.recode.vcf")
output = vcf2geno("populations_nomissing50_nomistake_2.recode.vcf")
output = vcf2geno("Rbfinal50missingnomistake.recode.vcf")
output = vcf2geno("Rbfinaldownsampled.recode.vcf")
output = vcf2geno("Rgenusfinaldownsampled.recode.vcf", "Rgenusfinaldownsampled2.recode.geno")
output = vcf2geno("Rgenusfinaldownsampled.recode.vcf", "Rgenusfinaldownsampled3.recode.geno")

output = vcf2geno("Rbfinaldownsampled.recode.vcf","Rbfinaldownsampled3.recode.geno")

output = vcf2geno("populations.snps_minDP3_minGQ40.recode_mac3_meanDP10_maxmeanDP30_v2.p.snps.vcf")

#accessing the project
obj.snmfRbdownsampled1 = load.snmfProject("Rbfinaldownsampled1.recode.snmfProject")
obj.snmfRgenusdownsampled1 = load.snmfProject("Rgenusfinaldownsampled.recode.snmfProject")
obj.snmfRbdownsampled2 = load.snmfProject("Rbfinaldownsampled2.recode.snmfProject")
obj.snmfRbdownsampled3 = load.snmfProject("Rbfinaldownsampled3.recode.snmfProject")

#cross-entropy estimation / creation of snmf object
obj.snmf1 = snmf("populations_nomissing20.recode.geno", K = 1:15, alpha = 100, entropy=T, project = "new", repetitions = 1000)
obj.snmfgenus = snmf("populations_nomissing50_nomistake_2.recode.geno", K = 1:15, alpha = 100,  entropy=T, project = "new",repetitions = 500)

obj.snmf3 = snmf("populations.snps_minDP3_minGQ40.recode_mac3_meanDP10_maxmeanDP30_v2.p.snps.geno", K = 1:15, alpha = 100, entropy=T, project = "new", repetitions = 20)


obj.snmfRb= snmf("Rbfinal50missingnomistake.recode.geno", K = 1:15, alpha = 100, entropy=T, project = "new", repetitions = 500)
obj.snmfRbdownsampled= snmf("Rbfinaldownsampled1.recode.geno", K = 1:8, alpha = 100, entropy=T, project = "new", repetitions =500)
obj.snmfRbdownsampled= snmf("Rbfinaldownsampled2.recode.geno", K = 1:15, alpha = 100, entropy=T, project = "new", repetitions =500)
obj.snmfRbdownsampled3= snmf("Rbfinaldownsampled3.recode.geno", K = 1:8, alpha = 100, entropy=T, project = "new", repetitions =500)



obj.snmfRgenusdownsampled1= snmf("Rgenusfinaldownsampled.recode.geno", K = 1:15, alpha = 100, entropy=T, project = "new", repetitions =500)
obj.snmfRgenusdownsampled2= snmf("Rgenusfinaldownsampled2.recode.geno", K = 1:15, alpha = 100, entropy=T, project = "new", repetitions =500)
obj.snmfRgenusdownsampled3= snmf("Rgenusfinaldownsampled3.recode.geno", K = 1:15, alpha = 100, entropy=T, project = "new", repetitions =500)


obj.snmfRbdownsampled2 = load.snmfProject("Rbfinaldownsampled2.recode.snmfProject")
pcatotal = pca("Rbfinaldownsampled2.recode.geno")
projections=as.data.frame(scale(pcatotal$projections))
Add_columns=read.table("Add_column_species", header=T)

eigenvalues=read.table("Rbfinaldownsampled.recode.pca/Rbfinaldownsampled.recode.eigenvalues")
eigenvalues=eigenvalues/211058.8*100
eigenvalues
sum(eigenvalues)
projections$Pop=Add_columns$Pop

projections$Species=Add_columns$Species
projections$missing=Add_columns$frequency_missing
plotpcatotal=ggplot(projections, aes(V1, V2, color = Pop, fill=Pop)) +
  geom_point(projections, mapping=aes(V1, V2, color = Pop, fill=Pop)) +stat_ellipse(geom="polygon", aes(fill = Pop), alpha=0.2, level=0.95) + scale_fill_manual("Pop", values = c( "red",  "orange", "brown", "red3", "pink", "orangered", "tomato","brown4", "pink3", "orchid", "orchid4"))+ scale_color_manual("Pop", values = c( "red",  "orange", "brown", "red3", "pink", "orangered", "tomato","brown4" ,"pink3", "orchid", "orchid4"))+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                                                                                                                                                                                                                                                                                                 panel.background = element_blank(), axis.line = element_line(colour = "black"))+xlab("PC1 (2.33 %)")+ylab("PC2 (1.85 %)")+xlim(-6.25,5.75)




plotpcatotal=ggplot(projections, aes(V1, V3, color = Pop, fill=Pop)) +
  geom_point(projections, mapping=aes(V1, V3, color = Pop, fill=Pop)) +stat_ellipse(geom="polygon", aes(fill = Pop), alpha=0.2, level=0.95) + scale_fill_manual("Pop", values = c( "red",  "orange", "brown", "red3", "pink", "orangered", "tomato","brown4", "pink3", "orchid", "orchid4"))+ scale_color_manual("Pop", values = c( "red",  "orange", "brown", "red3", "pink", "orangered", "tomato","brown4" ,"pink3", "orchid", "orchid4"))+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                                                                                                                                                                                                                                                                                                                                                                                     panel.background = element_blank(), axis.line = element_line(colour = "black"))+xlab("PC1 (2.33 %)")+ylab("PC3 (1.61 %)")+xlim(-6.25,5.75)


obj.snmf1=as.list("/populations_nomissing20.recode.snmf/")

#plot cross-entropy /choose optimal number of Ks
plot(obj.snmf1, col = "blue4", cex = 1.4, pch = 19)
plot(obj.snmf2, col = "blue4", cex = 1.4, pch = 19)
plot(obj.snmf3, col = "blue4", cex = 1.4, pch = 19)
plot(obj.snmfRb, col = "blue4", cex = 1.4, pch = 19)
plot(obj.snmfgenus, col = "blue4", cex = 1.4, pch = 19)
plot(obj.snmfRbdownsampled, col = "blue4", cex = 1.4, pch = 19)
plot(obj.snmfRbdownsampled2, col = "blue4", cex = 1.4, pch = 19,xlim=c(0,8))

plot(obj.snmfRbdownsampled3, col = "blue4", cex = 1.4, pch = 19)

plot(obj.snmfRgenusdownsampled1, col = "blue4", cex = 1.4, pch = 19)
plot(obj.snmfRgenusdownsampled2, col = "blue4", cex = 1.4, pch = 19)
plot(obj.snmfRgenusdownsampled3, col = "blue4", cex = 1.4, pch = 19)

qmatrix = Q(obj.snmfRgenusdownsampled1, K = 9, run=best)

qmatrix = Q(obj.snmfRgenusdownsampled1, K = 7, run=best)
qmatrix = Q(obj.snmfRgenusdownsampled1, K = 8, run=best)
qmatrix = Q(obj.snmfRgenusdownsampled1, K = 2, run=best)
qmatrix = Q(obj.snmfRgenusdownsampled1, K = 6, run=best)
qmatrix = Q(obj.snmfRgenusdownsampled1, K = 5, run=best)
qmatrix = Q(obj.snmfRgenusdownsampled1, K = 4, run=best)
qmatrix = Q(obj.snmfRgenusdownsampled1, K = 3, run=best)
qmatrix = Q(obj.snmfRgenusdownsampled1, K = 2, run=best)



qmatrix = Q(obj.snmf2, K = 8, run=best)
qmatrix = Q(obj.snmfRbdownsampled2, K = 2, run=best)
qmatrix = Q(obj.snmfRbdownsampled3, K = 2, run=best)

qmatrix = Q(obj.snmfRbdownsampled, K = 3, run=best)
qmatrix = Q(obj.snmfRbdownsampled2, K = 3, run=best)

qmatrix = Q(obj.snmfRbdownsampled3, K = 3, run=best)

qmatrix = Q(obj.snmfRbdownsampled, K = 4, run=best)
qmatrix = Q(obj.snmfRbdownsampled2, K = 4, run=best)

qmatrix = Q(obj.snmfRbdownsampled3, K = 4, run=best)

qmatrix = Q(obj.snmfRbdownsampled, K = 5, run=best)

qmatrix = Q(obj.snmfgenus, K = 8, run=best)
qmatrix = Q(obj.snmfRb, K = 4, run=best)

qmatrix2=as.data.frame(qmatrix)
write.csv(qmatrix2,"Downsampledgenusancestry1")

set.seed(123)
install.packages("BiocManager")

BiocManager::install("LEA", force = TRUE)
#Load package
library(LEA)
library(ggplot2)
library(maps)
library(naniar)

#convert to geno file

output1 = vcf2geno("Rbfinaldownsampled.recode.vcf")
output2 = vcf2geno("Rgenusfinaldownsampled.recode.vcf", "Rgenusfinaldownsampled2.recode.geno")
output3 = vcf2geno("Rgenusfinaldownsampled.recode.vcf", "Rgenusfinaldownsampled3.recode.geno")

output = vcf2geno("Rbfinaldownsampled.recode.vcf","Rbfinaldownsampled3.recode.geno")

output = vcf2geno("populations.snps_minDP3_minGQ40.recode_mac3_meanDP10_maxmeanDP30_v2.p.snps.vcf")

#accessing the project
obj.snmfRbdownsampled1 = load.snmfProject("Rbfinaldownsampled1.recode.snmfProject")
obj.snmfRbdownsampled2 = load.snmfProject("Rbfinaldownsampled2.recode.snmfProject")
obj.snmfRbdownsampled3 = load.snmfProject("Rbfinaldownsampled3.recode.snmfProject")

#cross-entropy estimation / creation of snmf object

obj.snmfRbdownsampled= snmf("Rbfinaldownsampled1.recode.geno", K = 1:8, alpha = 100, entropy=T, project = "new", repetitions =500)
obj.snmfRbdownsampled2= snmf("Rbfinaldownsampled2.recode.geno", K = 1:15, alpha = 100, entropy=T, project = "new", repetitions =500)
obj.snmfRbdownsampled3= snmf("Rbfinaldownsampled3.recode.geno", K = 1:8, alpha = 100, entropy=T, project = "new", repetitions =500)

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

#PCA plot
plotpcatotal=ggplot(projections, aes(V1, V2, color = Pop, fill=Pop)) +
  geom_point(projections, mapping=aes(V1, V2, color = Pop, fill=Pop)) +stat_ellipse(geom="polygon", aes(fill = Pop), alpha=0.2, level=0.95) + scale_fill_manual("Pop", values = c( "red",  "orange", "brown", "red3", "pink", "orangered", "tomato","brown4", "pink3", "orchid", "orchid4"))+ scale_color_manual("Pop", values = c( "red",  "orange", "brown", "red3", "pink", "orangered", "tomato","brown4" ,"pink3", "orchid", "orchid4"))+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                                                                                                                                                                                                                                                                                                 panel.background = element_blank(), axis.line = element_line(colour = "black"))+xlab("PC1 (2.33 %)")+ylab("PC2 (1.85 %)")+xlim(-6.25,5.75)




plotpcatotal=ggplot(projections, aes(V1, V3, color = Pop, fill=Pop)) +
  geom_point(projections, mapping=aes(V1, V3, color = Pop, fill=Pop)) +stat_ellipse(geom="polygon", aes(fill = Pop), alpha=0.2, level=0.95) + scale_fill_manual("Pop", values = c( "red",  "orange", "brown", "red3", "pink", "orangered", "tomato","brown4", "pink3", "orchid", "orchid4"))+ scale_color_manual("Pop", values = c( "red",  "orange", "brown", "red3", "pink", "orangered", "tomato","brown4" ,"pink3", "orchid", "orchid4"))+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                                                                                                                                                                                                                                                                                                                                                                                     panel.background = element_blank(), axis.line = element_line(colour = "black"))+xlab("PC1 (2.33 %)")+ylab("PC3 (1.61 %)")+xlim(-6.25,5.75)


obj.snmf1=as.list("/populations_nomissing20.recode.snmf/")

#plot cross-entropy /choose optimal number of Ks

plot(obj.snmfRbdownsampled, col = "blue4", cex = 1.4, pch = 19)
plot(obj.snmfRbdownsampled2, col = "blue4", cex = 1.4, pch = 19,xlim=c(0,8))

plot(obj.snmfRbdownsampled3, col = "blue4", cex = 1.4, pch = 19)


qmatrix = Q(obj.snmfRbdownsampled, K = 3, run=best)
qmatrix = Q(obj.snmfRbdownsampled2, K = 3, run=best)

qmatrix = Q(obj.snmfRbdownsampled3, K = 3, run=best)

qmatrix = Q(obj.snmfRbdownsampled, K = 4, run=best)
qmatrix = Q(obj.snmfRbdownsampled2, K = 4, run=best)

qmatrix = Q(obj.snmfRbdownsampled3, K = 4, run=best)


qmatrix2=as.data.frame(qmatrix)
write.csv(qmatrix2,"Downsampledgenusancestry1")

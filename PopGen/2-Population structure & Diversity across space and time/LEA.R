set.seed(123)

#Load package
library(LEA)
library(ggplot2)
library(maps)
library(naniar)

#convert to geno file
output = vcf2geno("Rbfinaldownsampled.recode.vcf")
#Rbfinaldownsampled.recode.geno is generated.

#cross-entropy estimation / creation of snmf object
obj.snmfRbdownsampled= snmf("Rbfinaldownsampled.recode.geno", K = 1:8, alpha = 100, entropy=T, project = "new", repetitions =1500)

#Create PCA object
pcatotal = pca("Rbfinaldownsampled.recode.geno")
projections=as.data.frame(scale(pcatotal$projections))

#Load sample data for visualisation of PCA
Add_columns=read.table("Add_column_species", header=T)

#Get eigenvalues
eigenvalues=read.table("Rbfinaldownsampled.recode.pca/Rbfinaldownsampled.recode.eigenvalues")
eigenvalues=eigenvalues/211058.8*100
eigenvalues
sum(eigenvalues)
#Add sample data to PCA table
projections$Pop=Add_columns$Pop
projections$missing=Add_columns$frequency_missing

#PCA plot
plotpcatotal=ggplot(projections, aes(V1, V3, color = Pop, fill=Pop)) +
  geom_point(projections, mapping=aes(V1, V3, color = Pop, fill=Pop)) +stat_ellipse(geom="polygon", aes(fill = Pop), alpha=0.2, level=0.95) + scale_fill_manual("Pop", values = c( "red",  "orange", "brown", "red3", "pink", "orangered", "tomato","brown4", "pink3", "orchid", "orchid4"))+ scale_color_manual("Pop", values = c( "red",  "orange", "brown", "red3", "pink", "orangered", "tomato","brown4" ,"pink3", "orchid", "orchid4"))+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                                                                                                                                                                                                                                                                                                                                                                                     panel.background = element_blank(), axis.line = element_line(colour = "black"))+xlab("PC1 (2.33 %)")+ylab("PC3 (1.61 %)")+xlim(-6.25,5.75)

#plot cross-entropy /choose optimal number of Ks

plot(obj.snmfRbdownsampled, col = "blue4", cex = 1.4, pch = 19)

#K=3 and K=4 seem to be the two most supported values of K.

#Get matrix of ancestry values for K=3
qmatrix = Q(obj.snmfRbdownsampled, K = 3, run=best)
qmatrix2=as.data.frame(qmatrix)
write.csv(qmatrix2,"DownsampledgenusancestryK3")

#Get matrix of ancestry values for K=4
qmatrix = Q(obj.snmfRbdownsampled, K = 4, run=best)
qmatrix2=as.data.frame(qmatrix)
write.csv(qmatrix2,"DownsampledgenusancestryK4")

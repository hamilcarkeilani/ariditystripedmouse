#Load necessary packages
library(ape)
library(ggtree)

#Create neighbor-joining object
tre= nj(DNA)

#Load color data to color tips and branches (based on Ancestry matrix)
Color=read.table("Newcolor.txt", header=T)

#Construct ggtree object
tree=ggtree(tre, layout="ape", aes(color=Color$Color), size=1.5)+geom_tiplab(size=0)+scale_color_manual("Color", labels=c("Mixed", "K1", "K2", "K3"), values=c( "grey","pink", "red", "brown"))



#Save tree
ggsave("plottreeRbdownsampled.pdf",plot = tree)






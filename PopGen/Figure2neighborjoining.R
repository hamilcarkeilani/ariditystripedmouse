#Load necessary packages
library(ape)
library(ggtree)


nj$edge.length=abs(nj$edge.length)

nj=nj(fst.dists)
nj$tip.label=as.character(geo)
njtree=as.phylo(tre)


tree=ggtree(tre, layout="ape")
treecoord=na.omit(tree$data)


coordpop$x=treecoord$x
coordpop$y=treecoord$y

coordpopRdd$x=treecoord$x
coordpopRdd$y=treecoord$y

tiplabel2=as.list(tiplabel)
tree2=groupOTU(tre, tiplabel2)


#Load color data to color tips and branches
Color=read.table("Newcolor.txt", header=T)

Color$`tiplabel$Color`

#Construct ggtree object
tree=ggtree(tre, layout="ape", aes(color=Color$Color), size=1.5)+geom_tiplab(size=0)+scale_color_manual("Color", labels=c("Mixed", "K1", "K2", "K3"), values=c( "grey","pink", "red", "brown"))



#Save tree
ggsave("plottreeRbdownsampled.pdf",plot = tree)






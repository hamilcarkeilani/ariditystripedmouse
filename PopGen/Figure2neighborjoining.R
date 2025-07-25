library(ape)
library(ggtree)


nj$edge.length=abs(nj$edge.length)

nj=nj(fst.dists)
nj$tip.label=as.character(geo)
njtree=as.phylo(tre)
plot(fst_all_tree, "fan")



tree=ggtree(tre, layout="ape")
treecoord=na.omit(tree$data)


coordpop$x=treecoord$x
coordpop$y=treecoord$y

coordpopRdd$x=treecoord$x
coordpopRdd$y=treecoord$y

tiplabel2=as.list(tiplabel)
tree2=groupOTU(tre, tiplabel2)
Color=read.table("Color.txt", header=T)
Color=read.table("Color2.txt", header=T)
Color=read.table("Newcolor.txt", header=T)

Color$`tiplabel$Color`

library(ggtree)
tree=ggtree(tre, layout="ape", size=1.5)+geom_tiplab(size=1)



tree=ggtree(tre, layout="ape", aes(color=Color$Color), size=1.5)+geom_tiplab(size=0)+scale_color_manual("Color", labels=c("Mixed", "K1", "K2", "K3"), values=c( "grey","pink", "red", "brown"))




ggsave("plottreeRbdownsampled.pdf",plot = tree)

ggtree(tre, layout="ape", aes(color=Color$Color))+geom_tiplab(size=1)+scale_color_manual("Color", labels=c("TdR", "Admixed", "Soetdoring", "Kalahari", "Sandveld"), values=c("brown", "green4", "grey", "khaki", "lightgreen", "orange", "purple", "red", "orangered", "turquoise", "rosybrown"))






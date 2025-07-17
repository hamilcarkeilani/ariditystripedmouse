library(ape)
library(ggtree)

omega2=dist(omega, method="bray-curtis")
omega3=hclust(omega2, method="ward.D2")
plot(omega3)
omega4=as.phylo.hclust(omega3)
omega=as.matrix(read.table("Runname_mat_omega.out"))
nj=nj(omega)
plot(omega4, "u")
omega4$tip.label=as.character(geo)
Color=c("KleinPella", "KolomelaMine", "LakeNaute", "Mariental", "Molopo", "Benfontein", "Sandveld", "Soetdoring", "Tswalu", "TdR", "Gariep", "Tswalu", "Tswalu", "Tswalu", "Tswalu", "Tswalu", "black", "black", "Tswalu", "black", "Tswalu")


plot=ggtree(omega4, layout="ape", aes(color=Color))+geom_tiplab(size=1)+scale_color_manual("Color", labels=c("KleinPella", "KolomelaMine", "LakeNaute", "Mariental", "Molopo", "Benfontein", "NA", "Sandveld", "Soetdoring", "Tswalu", "TdR", "Gariep"), values=c("grey", "black", "grey", "red", "grey", "red", "red", "red", "orangered", "orange", "brown", "red"))+
  theme(text = element_text(family = "mono"))
plot
ggsave("plot.pdf",plot = plot)

?X11Fonts
if(capabilities()[["X11"]]) withAutoprint({
  X11Fonts()
  X11Fonts("mono")
  utopia <- X11Font("-*-utopia-*-*-*-*-*-*-*-*-*-*-*-*")
  X11Fonts(utopia = utopia)
})


Roboto <- X11Font("-*-roboto-*-*-*-*-*-*-*-*-*-*-*-*")
X11Fonts(Roboto = Roboto)
#-------------------
X11Fonts()

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






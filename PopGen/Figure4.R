#Script for Figure 4 
#Load Baypass data


#Generate Figure 4.A
plot=ggplot(totalassocdiff, aes(x=XtXtotal, y=BFtotal))+geom_point()+ geom_vline(xintercept = 14.4, lty="dashed")+ geom_hline(yintercept = 10, lty="dashed")+geom_point(data=totalassocdiff2, aes(x=XtXtotal, y=BFtotal))+geom_point(data=totalassocdiff2, aes(x=XtXtotal, y=BFtotal, color=signif))+  scale_colour_manual(values=c("orangered", "orangered", "orangered", "orangered", "orangered", "orangered", "orangered", "orangered", "orangered", "orangered", "orangered", "orangered"), na.value = "orange")+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                                                                                                                                                                                                                                                                                                                                                                                           panel.background = element_blank(), axis.line = element_line(colour = "black"))
#Save to pdf
ggsave("totalassocdiff2.pdf",plot = plot)

#Create subset with only SNPs significantly associated with aridity
totalassoc=subset(totalassocdiff, BFtotal >= 10)
#Create subset with only significantly differentiated SNPs
totaldiff=subset(totalassocdiff, XtXtotal >= 14.4)

#Generate Figure 4.B
plot=ggplot(totalassocdiff, aes(POS, BFtotal), show.legend = FALSE)+ geom_hline(yintercept = 10, lty="dashed")+geom_point(totalassocdiff, mapping=aes(POS, BFtotal, fill=CHROM),shape=21,size=1)+ facet_grid(~CHROM, scales = 'free', space = 'free')+ theme(panel.spacing = unit(0,'lines'))+scale_fill_manual("CHROM", values = c( "black",  "white",  "black",  "white","black",  "white",  "black",  "white",  "black",  "white","black",  "white","black",  "white",  "black",  "white","black",  "white","black",  "white",  "black",  "white","black",  "white"))+geom_point(totalassoc, mapping=aes(POS, BFtotal, color=signif),size=2) + theme(legend.position = "none") +  scale_colour_manual(values=c("orangered", "orangered", "orangered", "orangered", "orangered", "orangered", "orangered", "orangered" ,"orangered" ,"orangered","orangered","orangered"), na.value = "orange") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           panel.background = element_blank(), axis.line = element_line(colour = "black"))
#Save to pdf
ggsave("manhattanBF2.pdf",plot = plot)

#Generate Figure 4.C
plot=ggplot(totalassocdiff, aes(POS, XtXtotal), show.legend = FALSE)+geom_point(totalassocdiff, mapping=aes(POS, XtXtotal, fill=CHROM),shape=21,size=1)+ facet_grid(~CHROM, scales = 'free', space = 'free')+ theme(panel.spacing = unit(0,'lines'))+scale_fill_manual("CHROM", values = c( "black",  "white",  "black",  "white","black",  "white",  "black",  "white",  "black",  "white","black",  "white","black",  "white",  "black",  "white","black",  "white","black",  "white",  "black",  "white","black",  "white"))+geom_point(totaldiff, mapping=aes(POS, XtXtotal, color=signif), size=1)+  scale_colour_manual(values=c("orangered", "orangered", "orangered", "orangered", "orangered", "orangered", "orangered", "orangered", "orangered", "orangered", "orangered", "orangered"), na.value = "orange") + theme(legend.position = "none")    + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     panel.background = element_blank(), axis.line = element_line(colour = "black")) +  geom_hline(yintercept = 14.4, lty="dashed")
#Save to pdf
ggsave("manhattanXtX2.pdf",plot = plot)


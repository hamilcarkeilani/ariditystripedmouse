Stairway=read.table("StairwayplotRb.txt",h=T)
StairwayKa=read.table("StairwayplotKalahari.txt",h=T)
StairwaySa=read.table("StairwayplotSandveld.txt",h=T)
StairwaySo=read.table("StairwayplotSoetdoring.txt",h=T)
StairwayTd=read.table("StairwayplotTdR.txt",h=T)
StairwayRd=read.table("StairwayplotRdd.txt",h=T)
StairwayLa=read.table("StairwayplotLajuma.txt",h=T)
StairwayRc=read.table("StairwayplotRdc.txt",h=T)
StairwayKp=read.table("StairwayplotKleinPella.txt",h=T)
StairwayTdR=read.table("StairwayplotTussendR.txt",h=T)
StairwaySa=read.table("StairwayplotSandvelddownsampled.txt",h=T)
StairwayRbdownsampled=read.table("StairwayplotRbownsampled.txt",h=T)
StairwayRb1indperpop=read.table("StairwayplotRb1indperpop.txt",h=T)


StairwayKp=read.table("StairwayplotKleinPellasingleton.txt",h=T)
StairwayTdR=read.table("StairwayplotTussendRsingleton.txt",h=T)
StairwaySa=read.table("StairwayplotSandvelddownsampledsingleton.txt",h=T)
StairwayRbdownsampled=read.table("StairwayplotRbdownsampledsingleton.txt",h=T)
StairwayRb1indperpop=read.table("StairwayplotRb1indperpopsingleton.txt",h=T)



library(scales)
library(ggplot2)

min(log(Stairway$year))
exp(-724.9696)


hist(log(Stairway$year))


plot=ggplot(Stairway, aes(year+1, Ne_median))+geom_line(Stairway, mapping=aes(year+1, Ne_median), color="salmon", size=1 )+geom_ribbon(aes(ymin = Ne_12.5., ymax = Ne_87.5.),alpha = 0.1, fill="salmon")+ scale_x_continuous(name="Years (before present)", breaks=c( 11700, 12800, 14100, 20000, 26000, 32000, 44000, 61000), limits=c(0,100000))+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                                                                                                                                                                                                                                                                                                panel.background = element_blank(), axis.line = element_line(colour = "black"))+ scale_y_continuous(limits=c(1000,10000000), trans="log10")+ geom_rect(aes(xmin=20000, xmax=26000, ymin=1000, ymax=Inf), fill="grey", alpha=0.01)


ggplot(StairwayKa, aes(year+1, Ne_median))+geom_line(StairwayKa, mapping=aes(year+1, Ne_median), color="red", size=1 )+geom_ribbon(aes(ymin = Ne_12.5., ymax = Ne_87.5.),alpha = 0.08, fill="red")+ scale_x_continuous(name="Years (before present)", breaks=c( 11700, 12800, 14100, 20000, 26000, 32000, 44000, 61000), limits=c(0,100000))+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                                                                                                                                                                                                                                                                                                                           panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(StairwaySa, mapping=aes(year+1, Ne_median), colour="orange", size=1 )+geom_ribbon(data=StairwaySa, aes(ymin = Ne_12.5., ymax = Ne_87.5.),alpha = 0.08, fill="orange")+
  geom_line(StairwaySo, mapping=aes(year+1, Ne_median), colour="salmon", size=1 )+geom_ribbon(data=StairwaySo, aes(ymin = Ne_12.5., ymax = Ne_87.5.),alpha = 0.08, fill="salmon")+
  geom_line(StairwayTd, mapping=aes(year+1, Ne_median), colour="brown", size=1 )+geom_ribbon(data=StairwayTd, aes(ymin = Ne_12.5., ymax = Ne_87.5.),alpha = 0.08, fill="brown")+ scale_y_continuous(limits=c(10000,10e+06), trans="log10")+ geom_rect(aes(xmin=20000, xmax=26000, ymin=10000, ymax=Inf), fill="grey", alpha=0.01)


ggplot(StairwayRd, aes(year+1, Ne_median))+geom_line(StairwayRd, mapping=aes(year+1, Ne_median), color="lightgreen", size=1 )+geom_ribbon(aes(ymin = Ne_12.5., ymax = Ne_87.5.),alpha = 0.08, fill="lightgreen")+ scale_x_continuous(name="Years (before present)", breaks=c( 11700, 12800, 14100, 20000, 26000, 32000, 44000, 61000), limits=c(0,100000))+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                                                                                                                                                                                                                                                                                                 panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(StairwayLa, mapping=aes(year+1, Ne_median), colour="green4", size=1 )+geom_ribbon(data=StairwayLa, aes(ymin = Ne_12.5., ymax = Ne_87.5.),alpha = 0.04, fill="green4")+ scale_y_continuous(limits=c(10000,10e+06), trans="log10")+ geom_rect(aes(xmin=20000, xmax=26000, ymin=10000, ymax=Inf), fill="grey", alpha=0.01)


ggplot(StairwayRc, aes(year+1, Ne_median))+geom_line(StairwayRc, mapping=aes(year+1, Ne_median), color="turquoise", size=1 )+geom_ribbon(aes(ymin = Ne_12.5., ymax = Ne_87.5.),alpha = 0.04, fill="turquoise")+ scale_x_continuous(name="Years (before present)", breaks=c( 11700, 12800, 14100, 20000, 26000, 32000, 44000, 61000), limits=c(0,100000))+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                                                                                                                                                                                                         panel.background = element_blank(), axis.line = element_line(colour = "black"))+ scale_y_continuous(limits=c(10000,10e+06), trans="log10")+ geom_rect(aes(xmin=20000, xmax=26000, ymin=10000, ymax=Inf), fill="grey", alpha=0.01)
  

library(ggplot2)
ggplot()+geom_rect(aes(xmin=0, xmax=3115696, ymin=87612, ymax=100000), fill="grey", alpha=1) +
  geom_rect(aes(xmin=-799756*7/8, xmax=799756*1/8, ymin=0, ymax=87612), fill="grey", alpha=1)+
  geom_rect(aes(xmin=3115696-602643*1/8, xmax=3115696+602643*7/8, ymin=83453, ymax=87612), fill="grey", alpha=1)+
  geom_rect(aes(xmin=3115696+602643*7/8-418979*1/8, xmax=3115696+602643*7/8+418979*7/8, ymin=73600, ymax=83453), fill="grey", alpha=1)+
  geom_rect(aes(xmin=3115696-602643-548799, xmax=3115696-602643, ymin=0, ymax=83453), fill="grey", alpha=1)+
  geom_rect(aes(xmin=3115696-384802, xmax=3115696, ymin=0, ymax=73600), fill="grey", alpha=1)+
  geom_rect(aes(xmin=3115696+418979, xmax=3115696+418979+721710, ymin=0, ymax=73600), fill="grey", alpha=1)+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                                    panel.background = element_blank(), axis.line = element_line(colour = "black"))


install.packages("installr")
library(installr)
updateR(install_R=TRUE) 

sessionInfo()

snps=eigenstrat(prefix="out")
pops=c("KleinPella", "Goegap")
result=f3(A=pops, B=pops, C="38_Lr", data=snps)

LD=read.table("ld_window_1000000.geno.ld",h=T)
LDmiss=na.omit(LD$R.2)
mean(LDmiss)
hist(LDmiss)
sum(LDmiss)
write.csv(signifassocdiff, file="signifassocdiff")



plot=ggplot(StairwayKp, aes(year+1, Ne_median))+geom_line(StairwayKp, mapping=aes(year+1, Ne_median), color="pink", size=1 )+geom_ribbon(aes(ymin = Ne_2.5., ymax = Ne_97.5.),alpha = 0.08, fill="pink")+ scale_x_continuous(name="Years (before present)", breaks=c( 10000, 20000, 30000, 40000, 50000,60000), limits=c(0,60000))+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                                                                                                                                                                                                                                                                                    panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(StairwaySa, mapping=aes(year+1, Ne_median), colour="tomato", size=1 )+geom_ribbon(data=StairwaySa, aes(ymin = Ne_2.5., ymax = Ne_97.5.),alpha = 0.08, fill="tomato")+
    geom_line(StairwayTdR, mapping=aes(year+1, Ne_median), colour="brown", size=1 )+geom_ribbon(data=StairwayTdR, aes(ymin = Ne_2.5., ymax = Ne_97.5.),alpha = 0.08, fill="brown")+
  geom_line(StairwayRbdownsampled, mapping=aes(year+1, Ne_median), color="red", size=3 )+geom_ribbon(data=StairwayRbdownsampled,aes(ymin = Ne_2.5., ymax = Ne_97.5.),alpha = 0.08, fill="red")+ scale_y_continuous(limits=c(1000,10000000), trans="log10")+
geom_line(StairwayRb1indperpop, mapping=aes(year+1, Ne_median), color="red", size=2, lty=2 )+geom_ribbon(data=StairwayRb1indperpop,aes(ymin = Ne_2.5., ymax = Ne_97.5.),alpha = 0.08, fill="red")



plot=ggplot(StairwayKp, aes(year+1, Ne_median))+geom_line(StairwayKp, mapping=aes(year+1, Ne_median), color="pink", size=1 )+geom_ribbon(aes(ymin = Ne_2.5., ymax = Ne_97.5.),alpha = 0.08, fill="pink")+ scale_x_continuous(name="Years (before present)", breaks=c( 10000, 20000, 30000, 40000, 50000,60000))+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                                                                                                                                                                                                                                                                          panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  geom_line(StairwaySa, mapping=aes(year+1, Ne_median), colour="tomato", size=1 )+geom_ribbon(data=StairwaySa, aes(ymin = Ne_2.5., ymax = Ne_97.5.),alpha = 0.08, fill="tomato")+
  geom_line(StairwayTdR, mapping=aes(year+1, Ne_median), colour="brown", size=1 )+geom_ribbon(data=StairwayTdR, aes(ymin = Ne_2.5., ymax = Ne_97.5.),alpha = 0.08, fill="brown")
  
  
  
 
  
  

  
plot= ggplot(StairwayRbdownsampled, aes(year+1, Ne_median))+ geom_rect(aes(xmin=11000, xmax=15000, ymin=1, ymax=Inf), fill="darkgoldenrod1", alpha=0.01)+ geom_rect(aes(xmin=5000, xmax=7000, ymin=1, ymax=Inf), fill="darkgoldenrod1", alpha=0.01)+ geom_rect(aes(xmin=500, xmax=1500, ymin=1, ymax=Inf), fill="darkgoldenrod1", alpha=0.01)+ geom_rect(aes(xmin=20000, xmax=26000, ymin=1, ymax=Inf), fill="grey", alpha=0.01)+geom_line(StairwayRbdownsampled, mapping=aes(year+1, Ne_median), color="black", size=3 )+  geom_line(StairwayRbdownsampled, mapping=aes(year+1, Ne_median), color="red", size=2 )+geom_ribbon(data=StairwayRbdownsampled,aes(ymin = Ne_2.5., ymax = Ne_97.5.),alpha = 0.08, fill="red")+ scale_y_continuous( name="Median Ne",trans="log10")+
  geom_line(StairwayRb1indperpop, mapping=aes(year+1, Ne_median), color="red", size=2, lty=2 )+geom_ribbon(data=StairwayRb1indperpop,aes(ymin = Ne_2.5., ymax = Ne_97.5.),alpha = 0.08, fill="red")+ scale_x_continuous(name="Years (before present)",  trans="log10")+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                                                                                                                                                                                                              panel.background = element_blank(), axis.line = element_line(colour = "black"))




colors()

ggsave("Figure1NEW.pdf",plot = plot)

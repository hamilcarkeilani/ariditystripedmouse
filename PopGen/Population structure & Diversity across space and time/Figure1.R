#Load Stairway plot files for each inference
StairwayRbdownsampled=read.table("StairwayplotRbownsampled.txt",h=T)
StairwayRb1indperpop=read.table("StairwayplotRb1indperpop.txt",h=T)

#Load ggplot2 package for graph construction
library(ggplot2)

#Build the plot with paleoclimatic information 
plot= ggplot(StairwayRbdownsampled, aes(year+1, Ne_median))+ geom_rect(aes(xmin=11000, xmax=15000, ymin=1, ymax=Inf), fill="darkgoldenrod1", alpha=0.01)+ geom_rect(aes(xmin=5000, xmax=7000, ymin=1, ymax=Inf), fill="darkgoldenrod1", alpha=0.01)+ geom_rect(aes(xmin=500, xmax=1500, ymin=1, ymax=Inf), fill="darkgoldenrod1", alpha=0.01)+ geom_rect(aes(xmin=20000, xmax=26000, ymin=1, ymax=Inf), fill="grey", alpha=0.01)+geom_line(StairwayRbdownsampled, mapping=aes(year+1, Ne_median), color="black", size=3 )+  geom_line(StairwayRbdownsampled, mapping=aes(year+1, Ne_median), color="red", size=2 )+geom_ribbon(data=StairwayRbdownsampled,aes(ymin = Ne_2.5., ymax = Ne_97.5.),alpha = 0.08, fill="red")+ scale_y_continuous( name="Median Ne",trans="log10")+
  geom_line(StairwayRb1indperpop, mapping=aes(year+1, Ne_median), color="red", size=2, lty=2 )+geom_ribbon(data=StairwayRb1indperpop,aes(ymin = Ne_2.5., ymax = Ne_97.5.),alpha = 0.08, fill="red")+ scale_x_continuous(name="Years (before present)",  trans="log10")+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                                                                                                                                                                                                                                                                              panel.background = element_blank(), axis.line = element_line(colour = "black"))
#Save the plot in pdf format
ggsave("Figure1NEW.pdf",plot = plot)

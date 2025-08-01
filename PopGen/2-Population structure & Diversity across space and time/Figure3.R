set.seed(123)

#Load distance data
distframe=load.table("Geotaxobiology.txt")


#Create composite plot
plot=ggplot(distframe, aes(x/1000, fst)) +geom_point(distframe, mapping=aes(x/1000, fst),color="black")+geom_smooth(distframe, mapping=aes(x/1000, fst),method = "lm", color="black", alpha=0.1)+geom_smooth(distframe, mapping=aes(env*4000, fst), method = "lm", color="orange", fill="orange", alpha=0.1)+geom_point(distframe, mapping=aes(env*4000, fst),color="orange")+ scale_x_continuous(sec.axis=sec_axis (~ . /4000))+ylab("log(FST/(1-FST)")+
   theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          panel.background = element_blank(), axis.line = element_line(colour = "black"))


#Save to pdf
ggsave("doubleplot.pdf",plot = plot)

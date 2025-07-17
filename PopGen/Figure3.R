
ggplot(distframe, aes(x, fst))+geom_point()+geom_smooth(method = "lm", color="black")+xlab("log(Geographic distance)")+ylab("log(FST/(1-FST)")

ggplot(distframe, aes(env, fst))+geom_point()+geom_smooth(method = "lm", color="black")+xlab("log(Environmental distance)")+ylab("log(FST/(1-FST)")

ggplot(distframe, aes(env, x))+geom_point()+geom_smooth(method = "lm", color="black")+xlab("log(Environmental distance)")+ylab("log(Geographic distance)")


plot=ggplot(distframe, aes(x/1000, fst)) +geom_point(distframe, mapping=aes(x/1000, fst),color="black")+geom_smooth(distframe, mapping=aes(x/1000, fst),method = "lm", color="black", alpha=0.1)+geom_smooth(distframe, mapping=aes(env*4000, fst), method = "lm", color="orange", fill="orange", alpha=0.1)+geom_point(distframe, mapping=aes(env*4000, fst),color="orange")+ scale_x_continuous(sec.axis=sec_axis (~ . /4000))+ylab("log(FST/(1-FST)")+
   theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          panel.background = element_blank(), axis.line = element_line(colour = "black"))


ggsave("doubleplot.pdf",plot = plot)

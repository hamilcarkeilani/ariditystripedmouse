Add_columns=read.table("Add_columns_genuslevel20.txt", header=T)
Add_columns=read.table("Add_columns_genuslevel50.txt", header=T)
Add_columns=read.table("Add_columns_genuslevel.txt", header=T)
Add_columns=read.table("Add_column_species", header=T)
Add_columns=read.table("Add_columns_Rbdownsampled", header=T)
Add_columns=read.table("Add_columns_Rgenusdownsampled", header=T)




qmatrix2$Sample=Add_columns$ID
qmatrix2$Species=Add_columns$species
qmatrix2$Population=Add_columns$Pop
q.matrix$Species=Add_columns$Species
q.matrix$V2=q.matrix$V2*10000
q.matrix$V4=q.matrix$V4*1000
q.matrix$V8=q.matrix$V8*100000


library(tidyverse)
library(dplyr)

plot_data <- qmatrix2 %>% 
  dplyr::mutate(id = row_number()) %>% 
  gather('pop', 'prob', V1:V4) %>% 
  group_by(id) %>% 
  mutate(likely_assignment = pop[which.max(prob)],
         assingment_prob = max(prob)) %>% 
  arrange(likely_assignment, desc(assingment_prob)) %>% 
  ungroup() %>% 
  mutate(id = forcats::fct_inorder(factor(id)))

plot_data <- qmatrix2 %>% 
  dplyr::mutate(id = row_number()) %>% 
  gather('pop', 'prob', V1:V8) %>% 
  group_by(id) %>% 
  mutate(likely_assignment = pop[which.max(prob)],
         assingment_prob = max(prob)) %>% 
  arrange(likely_assignment, desc(assingment_prob)) %>% 
  ungroup() %>% 
  mutate(id = forcats::fct_inorder(factor(id)))


plotstructure=ggplot(plot_data, aes(id, prob, fill = pop)) +
  geom_col(width=1) +
  facet_grid(~Species, scales = 'free', space = 'free')
ggsave("plotstructuredownsampledgenus2.pdf",plot = plotstructure)
ggsave("plotstructuredownsampledgenus2K6.pdf",plot = plotstructure)
ggsave("plotstructuredownsampledgenus2K5.pdf",plot = plotstructure)
ggsave("plotstructuredownsampledgenus2K4.pdf",plot = plotstructure)
ggsave("plotstructuredownsampledgenus2K3.pdf",plot = plotstructure)
ggsave("plotstructuredownsampledgenus2K2.pdf",plot = plotstructure)
ggsave("plotstructuredownsampledgenus2K8.pdf",plot = plotstructure)
ggsave("plotstructuredownsampledgenus2K9.pdf",plot = plotstructure)

ggsave("plotstructuredownsampledRb2K2.pdf",plot = plotstructure)
ggsave("plotstructuredownsampledRb3K3.pdf",plot = plotstructure)
ggsave("plotstructuredownsampledRb3K4.pdf",plot = plotstructure)
ggsave("plotstructuredownsampledRb3K2.pdf",plot = plotstructure)

ggsave("plotstructuredownsampledRb2K2.pdf",plot = plotstructure)

ggsave("plotstructuredownsampledRb2K3.pdf",plot = plotstructure)
ggsave("plotstructuredownsampledRb2K4.pdf",plot = plotstructure)

ggsave("crossentropydownsampledtotal.pdf",plot = plot)

ggsave("crossentropydownsampled2.pdf",plot = p)
ggsave("StairwayplotRb.pdf",plot = plot)
ggsave("StairwayplotRbaridvssemiarid2.pdf",plot = plot)
ggsave("StairwayplotRbaridvssemiaridsingleton.pdf",plot = plot)

plotstructure=ggplot(plot_data, aes(id, prob, fill = pop)) +
  geom_col(width=1) +
  facet_grid(~Population, scales = 'free', space = 'free')+ scale_fill_manual("pop", values = c( "orange", "brown",  "pink", "red"))+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank()) 



plotstructure=ggplot(plot_data, aes(id, prob, fill = pop)) +
  geom_col(width=1) +
  facet_grid(~Species, scales = 'free', space = 'free')+ scale_fill_manual("pop", values = c( "orange",  "pink", "turquoise", "purple", "lightgreen", "green4", "brown", "red", "green"))+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank()) 



write.csv(qmatrix2,file='./Ancestryfinalfinal.csv')
write.csv(qmatrix2,file='./AncestryfinalfinalRb.csv')
write.csv(qmatrix2,file='./AncestryfinalfinalRb3.csv')

write.csv(qmatrix2,file='./Ancestryfinalfinalgenus.csv')

write.csv(Crossentropy,file='./Crossentropygenus.csv')

Crossentropy=read.csv(file='./CrossentropyRb.csv', header=T)

obj.snmfRgenusdownsampled1=load.snmfProject("Rgenusfinaldownsampled.recode.snmfProject")
G(obj.snmfRgenusdownsampled1, K=7)

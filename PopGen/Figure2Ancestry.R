Add_columns=read.table("Add_columns_Rbdownsampled", header=T)


obj.snmfRgenusdownsampled1=load.snmfProject("Rgenusfinaldownsampled.recode.snmfProject")
G(obj.snmfRgenusdownsampled1, K=4)
G(obj.snmfRgenusdownsampled1, K=3)

qmatrix2$Sample=Add_columns$ID
qmatrix2$Population=Add_columns$Pop


library(tidyverse)
library(dplyr)

#K=3
plot_data <- qmatrix2 %>% 
  dplyr::mutate(id = row_number()) %>% 
  gather('pop', 'prob', V1:V3) %>% 
  group_by(id) %>% 
  mutate(likely_assignment = pop[which.max(prob)],
         assingment_prob = max(prob)) %>% 
  arrange(likely_assignment, desc(assingment_prob)) %>% 
  ungroup() %>% 
  mutate(id = forcats::fct_inorder(factor(id)))

#K=4
plot_data <- qmatrix2 %>% 
  dplyr::mutate(id = row_number()) %>% 
  gather('pop', 'prob', V1:V4) %>% 
  group_by(id) %>% 
  mutate(likely_assignment = pop[which.max(prob)],
         assingment_prob = max(prob)) %>% 
  arrange(likely_assignment, desc(assingment_prob)) %>% 
  ungroup() %>% 
  mutate(id = forcats::fct_inorder(factor(id)))


plotstructure=ggplot(plot_data, aes(id, prob, fill = pop)) +
  geom_col(width=1) +
  facet_grid(~Population, scales = 'free', space = 'free')+ scale_fill_manual("pop", values = c( "orange", "brown",  "pink", "red"))+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank()) 





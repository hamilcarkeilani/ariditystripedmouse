#Load additional sample info file
Add_columns=read.table("Add_columns_Rbdownsampled", header=T)
#load the necessary packages
library(LEA)
library(tidyverse)
library(dplyr)
#Access the projct
obj.snmfRgenusdownsampled1=load.snmfProject("Rgenusfinaldownsampled.recode.snmfProject")
#Access the ancestry matrix for K=3
qmatrixK3=t(G(obj.snmfRgenusdownsampled, K=3))

#Access the ancestry matrix for K=4
qmatrixK4=G(obj.snmfRgenusdownsampled1, K=4)

#Add sample info for K=3
qmatrixK3$Sample=Add_columns$ID
qmatrixK3$Population=Add_columns$Pop

#Add sample info for K=4
qmatrixK4$Sample=Add_columns$ID
qmatrixK4$Population=Add_columns$Pop


#Construct a working table for K=3
plot_data <- qmatrixK3 %>% 
  dplyr::mutate(id = row_number()) %>% 
  gather('pop', 'prob', V1:V3) %>% 
  group_by(id) %>% 
  mutate(likely_assignment = pop[which.max(prob)],
         assingment_prob = max(prob)) %>% 
  arrange(likely_assignment, desc(assingment_prob)) %>% 
  ungroup() %>% 
  mutate(id = forcats::fct_inorder(factor(id)))

#Construct a working table for K=4
plot_data <- qmatrixK4 %>% 
  dplyr::mutate(id = row_number()) %>% 
  gather('pop', 'prob', V1:V4) %>% 
  group_by(id) %>% 
  mutate(likely_assignment = pop[which.max(prob)],
         assingment_prob = max(prob)) %>% 
  arrange(likely_assignment, desc(assingment_prob)) %>% 
  ungroup() %>% 
  mutate(id = forcats::fct_inorder(factor(id)))


#Plot for K=3
plotstructure=ggplot(plot_data, aes(id, prob, fill = pop)) +
  geom_col(width=1) +
  facet_grid(~Population, scales = 'free', space = 'free')+ scale_fill_manual("pop", values = c( "red", "brown",  "pink"))+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank()) 






#Plot for K=4
plotstructure=ggplot(plot_data, aes(id, prob, fill = pop)) +
  geom_col(width=1) +
  facet_grid(~Population, scales = 'free', space = 'free')+ scale_fill_manual("pop", values = c( "orange", "brown",  "pink", "red"))+ theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank()) 





#Load the Baypass output from three different runs
covis.snp.res=read.table("FinalRb_V1_summary_betai_reg.out",h=T)
covis.snp.res2=read.table("FinalRb_V2_summary_betai_reg.out",h=T)
covis.snp.res3=read.table("FinalRb_V3_summary_betai_reg.out",h=T)

#Put all Bayes' factor data together
covis.snp.res$BF2=covis.snp.res2$BF.dB.
covis.snp.res$BF3=covis.snp.res3$BF.dB.

#Create a column containing the average Bayes' Factor value:
covis.snp.res$BFtotal=(covis.snp.res$BF.dB.+covis.snp.res$BF2+covis.snp.res$BF3)/3

#Now do the same with the XtX values :
xtx1=read.table("FinalRb_V1_summary_pi_xtx.out",h=T)
xtx2=read.table("FinalRb_V2_summary_pi_xtx.out",h=T)
xtx3=read.table("FinalRb_V3_summary_pi_xtx.out",h=T)
xtx1$XtX2=xtx2$M_XtX
xtx1$XtX3=xtx3$M_XtX
xtx1$XtXtotal=(xtx1$M_XtX+xtx1$XtX2+xtx1$XtX3)/3

#Check the distribution of the p-values
qqnorm(1/exp(xtx1$logptotal*log(10)), pch = 1, frame = FALSE)
qqline(1/exp(xtx1$logptotal*log(10)), col = "steelblue", lwd = 2)

#The p-values are not well-behaved. We'll have to generate a pseudo-observed dataset to check the XtX threshold of significance!

#upload the original data to obtain total allele count
bta14.data<-geno2YN("Baypassinputfinal.bta14")
pi.beta.coef=read.table("FinalRb_V2_summary_beta_params.out",h=T)$Mean
omega=as.matrix(read.table("FinalRb_V2_mat_omega.out"))
#Create the POD
simu.bta<-simulate.baypass(omega.mat=omega,nsnp=1000,sample.size=bta14.data$NN,
                           beta.pi=pi.beta.coef,pi.maf=0,suffix="btapods")


#######################################################
#Sanity Check: Compare POD and original data estimates
#######################################################
#get estimate of omega from the POD analysis
pod.omega=as.matrix(read.table("anapod_mat_omega.out"))
plot(pod.omega,omega) ; abline(a=0,b=1)
fmd.dist(pod.omega,omega)
#get estimates (post. mean) of both the a_pi and b_pi parameters of
#the Pi Beta distribution from the POD analysis
pod.pi.beta.coef=read.table("anapod_summary_beta_params.out",h=T)$Mean
plot(pod.pi.beta.coef,pi.beta.coef) ; abline(a=0,b=1)
#######################################################
#XtX calibration
#######################################################
#get the pod XtX
pod.xtx=read.table("anapod_summary_pi_xtx.out",h=T)$M_XtX
#compute the 1% threshold
pod.thresh=quantile(pod.xtx,probs=0.95)
#add the thresh to the actual XtX plot
plot(xtx1$M_XtX)
abline(h=pod.thresh,lty=2)



signifassoc=subset(covis.snp.res, BFtotal >=10)
signifassoc$MRK
signifassocdiff$MRK

library(dplyr)
signifdiff=subset(xtx1, XtXtotal >= 13.7)
signifassocdiff <- left_join(signifassoc, signifdiff, by = "MRK")
signifassocdiff <- subset(signifassocdiff, log10.1.pval.>0)

covis.snp.res2=read.table("Runname_V2_summary_betai_reg.out",h=T)
covis.snp.res3=read.table("Runname_V3_summary_betai_reg.out",h=T)
covis.snp.res$BF.dB.run2=covis.snp.res2$BF.dB.
covis.snp.res$BF.dB.run3=covis.snp.res3$BF.dB.


plot(covis.snp.res$BF.dB.,covis.snp.res$BF.dB.run3)




significant=subset(covis.snp.res, BF.dB.>=20)
significant$BF.dB.
significantbis=subset(covis.snp.res, BF.dB. >= 10)

significant2=subset(covis.snp.res, BF.dB. >= 15)
significant2=subset(significant2, BF.dB.<20)
significant2$MRK
significant2$BF.dB.


significant3=subset(covis.snp.res, BF.dB.>=10)
significant3=subset(significant3, BF.dB.<15)
significant3$MRK

SNPpos=read.table("SNPpos", header=T)

totalassocdiff$CHROM=SNPpos$CHROM
totalassocdiff$POS=SNPpos$POS
totalassocdiff$signif=SNPpos$signif
library(tidyverse)
totalassocdiff=totalassocdiff %>%
  arrange(CHROM)
totalassocdiff$CHROM=as.factor(totalassocdiff$CHROM)
totalassocdiff$CHROM=SNPpos$CHROM
totalassocdiff$POS=SNPpos$POS
totalassocdiff$signif=SNPpos$signif
totalassocdiff$signif=SNPpos$signif
totalassocdiff2 <- totalassocdiff[(totalassocdiff$XtXtotal >= 14.4) & (totalassocdiff$BFtotal >= 10), ]
View(totalassocdiff2)
totalassocdiff <- left_join(covis.snp.res, xtx1, by = "MRK")
totalassocdiff$CHROM=SNPpos$CHROM
totalassocdiff$POS=SNPpos$POS
totalassocdiff$signif=SNPpos$signif
totalassocdiff$signif=SNPpos$signif
totalassocdiff2 <- totalassocdiff[(totalassocdiff$XtXtotal >= 14.4) & (totalassocdiff$BFtotal >= 10), ]
totalassocdiff=totalassocdiff %>%
  arrange(CHROM)
totalassocdiff$CHROM=as.factor(totalassocdiff$CHROM)

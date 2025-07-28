#Filtering script to remove all sites with a genotype quality under 40 and depth under 3
vcftools --vcf populations.snps.vcf --minDP 3 --minGQ 40 --out populations.snps_minDP3_minGQ40_Rb --recode

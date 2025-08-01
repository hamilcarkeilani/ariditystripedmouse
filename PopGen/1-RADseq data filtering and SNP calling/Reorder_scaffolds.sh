#Script to reorder scaffolds 
bcftools view -T scaffold_list vcf.vcf.gz -Oz -o new_vcf.vcf.gz

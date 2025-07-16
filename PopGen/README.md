**Scripts used in Keilani et al. (2025)
**

A set of scripts used to generate and analyse SNP data, with raw data available at XXX

Contents :

Align to reference genome : mappingscript.sh

Stats for BAM files : flagstatscript.sh

Remove PCR duplicates : rmpcrscript.sh

Sort BAM files : sortingscript.sh

Demultiplexing : process_radtags.sh

Locus and SNP calling :
 - Gstacks : gstacks.sh
 - Populations : Initial_populations.sh

SNP filtering :
- vcftools/bcftools filtering : vcftools_minDP_GQ_meanDPfiltering.sh
- populations filtering (without mac) : populations_write-single-snpNOMAC.sh
- populations filtering (with mac) : populations_write-single-snpMAC.sh
  
Analyses & figures :
 - easySFS.py output file: Rb.sfs
 - Stairway plot initialization file: two-epoch_Rb.txt
 - Stairway plot script : two-epoch_Rb.txt.plot.sh
 - Stairway plot R visualization : Figure1.R
 - LEA R script : LEA.R
     - LEA Ancestry graph : Figure2Ancestry.R 
 - Neighbor-joining _ape_ R script (Figure 2) : Figure2neighborjoining.R 
 - Mantel tests R script : Manteltest.R
     - Figure 3 : Figure3.R
 - BayPass GEA :
     - geno format conversion script : generate_baypass_input_fromvcf.R
     - input geno file : Baypassinput.geno
     - input aridity file : Baypassinput.env
     - Baypass command : Baypass.sh
     - R analyses : GEAanalyses.R
     - Figure 4 : Figure4.R
     - Figure 5 : Figure5.R

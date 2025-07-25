#!/bin/bash

# script ÃƒÂ  mettre dans le rÃƒÂ©pertoire juste avant les rÃƒÂ©pertoires avec les fastq et le rÃƒÂ©pertoire d'output

SAMPLELIST=list_sample #path to the list of PREFIX for each fastq file (basically without the 1.fq or 2.fq)
OUTPUTDIR=/media/bigvol/afiston/Work/4-project_PopGenMouse/5-Demultiplexage/NovaSEQ_run1/FASTQ_DEMULTI_V2/ #path to where the demultiplexed fastq are
SUFFIXDEMULTI1=.1.fq #ajouter suffixe fichiers dÃƒÆ’Ã‚Â©multiplexÃƒÆ’Ã‚Â©s, mÃƒÆ’Ã‚Âªme que fichiers initiaux?
SUFFIXDEMULTI2=.2.fq
REFINDEX=/media/bigvol/afiston/Work/4-project_PopGenMouse/2-Rhado_genome/Rhab_genome_upper.fa_30000000 #path to index file for the reference
SAMSUFFIX=.sam
SAMDIR=/media/bigvol/afiston/Work/4-project_PopGenMouse/5-Demultiplexage/NovaSEQ_run1/samfiles_run1_V2/
BAMSUFFIX=.bam
BAMDIR=/media/bigvol/afiston/Work/4-project_PopGenMouse/5-Demultiplexage/NovaSEQ_run1/bamfiles_run1_V2/
NSDIR=/media/bigvol/afiston/Work/4-project_PopGenMouse/5-Demultiplexage/NovaSEQ_run1/namesorted_bamfiles_run1_V2/
NAMESORTSUFFIX=_namesorted.bam
PSDIR=/media/bigvol/afiston/Work/4-project_PopGenMouse/5-Demultiplexage/NovaSEQ_run1/positionsorted_bamfiles_run1_V2/
POSITIONSORTSUFFIX=_positionsorted.bam
FMDIR=/media/bigvol/afiston/Work/4-project_PopGenMouse/5-Demultiplexage/NovaSEQ_run1/fixmate_bamfiles_run1_V2/
FIXMATESUFFIX=_fixmate.bam

for SAMPLEFILE in `cat $SAMPLELIST`; do
#ne pas oublier d'indexer le gÃ©nome de rÃ©fÃ©rence avant avec bowtie2-build ou bwa index selon le programme utilisÃ©
# Ã  choisir un des deux programmes pour le mapping : bwa ou bowtie2, enlever la ligne Ã  ne pas utiliser
 sudo bowtie2 -x $REFINDEX -1 $OUTPUTDIR$SAMPLEFILE$SUFFIXDEMULTI1 -2 $OUTPUTDIR$SAMPLEFILE$SUFFIXDEMULTI2 -S $SAMDIR$SAMPLEFILE$SAMSUFFIX --reorder -p 4
        samtools view -b -o $BAMDIR$SAMPLEFILE$BAMSUFFIX $SAMDIR$SAMPLEFILE$SAMSUFFIX
        samtools sort -n -o $NSDIR$SAMPLEFILE$NAMESORTSUFFIX $BAMDIR$SAMPLEFILE$BAMSUFFIX
        samtools fixmate -m $NSDIR$SAMPLEFILE$NAMESORTSUFFIX $FMDIR$SAMPLEFILE$FIXMATESUFFIX
        samtools sort -o $PSDIR$SAMPLEFILE$POSITIONSORTSUFFIX $FMDIR$SAMPLEFILE$FIXMATESUFFIX
        
done

!/bin/bash

# script to put in the directory right before the one containing the fastq files and the output directory

SAMPLELIST=list_sample #path to the list of PREFIX for each fastq file (basically without the 1.fq or 2.fq)
OUTPUTDIR=/media/bigvol/afiston/Work/4-project_PopGenMouse/5-Demultiplexage/NovaSEQ_run1/FASTQ_DEMULTI_INTRARUN/ #path to where the demultiplexed fastq are
SUFFIXDEMULTI1=.1.fq #ajouter suffixe fichiers dÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â©multiplexÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â©s, mÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Âªme que fichiers initiaux?
SUFFIXDEMULTI2=.2.fq
REFINDEX=/media/bigvol/afiston/Work/4-project_PopGenMouse/2-Rhado_genome/Rhab_genome_upper.fa_30000000 #path to index file for the reference
SAMSUFFIX=.sam
SAMDIR=/media/bigvol/afiston/Work/4-project_PopGenMouse/5-Demultiplexage/NovaSEQ_run1/samfiles_run1/
BAMSUFFIX=.bam
BAMDIR=/media/bigvol/afiston/Work/4-project_PopGenMouse/5-Demultiplexage/NovaSEQ_run1/bamfiles_run1/
NSDIR=/media/bigvol/afiston/Work/4-project_PopGenMouse/5-Demultiplexage/NovaSEQ_run1/namesorted_bamfiles_run1/
NAMESORTSUFFIX=_namesorted.bam
PSDIR=/media/bigvol/afiston/Work/4-project_PopGenMouse/5-Demultiplexage/NovaSEQ_run1/positionsorted_bamfiles_run1/
POSITIONSORTSUFFIX=_positionsorted.bam
FMDIR=/media/bigvol/afiston/Work/4-project_PopGenMouse/5-Demultiplexage/NovaSEQ_run1/fixmate_bamfiles_run1/
FIXMATESUFFIX=_fixmate.bam
RMDIR=/media/bigvol/afiston/Work/4-project_PopGenMouse/5-Demultiplexage/NovaSEQ_run1/rmpcr_positionsorted_bamfiles_run1/
RMPCRSUFFIX=_rmpcr_positionsorted.bam



for SAMPLEFILE in `cat $SAMPLELIST`; do
	samtools sort -n -o $NSDIR$SAMPLEFILE$NAMESORTSUFFIX $BAMDIR$SAMPLEFILE$BAMSUFFIX
	samtools fixmate -m $NSDIR$SAMPLEFILE$NAMESORTSUFFIX $FMDIR$SAMPLEFILE$FIXMATESUFFIX
	samtools sort -o $PSDIR$SAMPLEFILE$POSITIONSORTSUFFIX $FMDIR$SAMPLEFILE$FIXMATESUFFIX
	samtools markdup -r $PSDIR$SAMPLEFILE$POSITIONSORTSUFFIX $RMDIR$SAMPLEFILE$RMPCRSUFFIX &
	
done


#!/bin/bash

# script to put in the directory right before the one containing the fastq files and the output directory

SAMPLELIST=list_sample #path to the list of PREFIX for each fastq file (basically without the 1.fq or 2.fq)
SORTDIR=/media/bigvol/afiston/Work/4-project_PopGenMouse/5-Demultiplexage/NovaSEQ_run1/sorted_bamfiles_run1/
SORTSUFFIX=_sorted.bam
RMVDIR=/media/bigvol/afiston/Work/4-project_PopGenMouse/5-Demultiplexage/NovaSEQ_run1/rmpcr_sorted_bamfiles_run1/
RMVSUFFIX=_rmpcr_sorted.bam

for SAMPLEFILE in `cat $SAMPLELIST`; do
sudo samtools markdup -r $SORTDIR$SAMPLEFILE$SORTSUFFIX $RMVDIR$SAMPLEFILE$RMVSUFFIX
done


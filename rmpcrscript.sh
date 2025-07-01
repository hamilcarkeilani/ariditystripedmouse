#!/bin/bash

# script ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â  mettre dans le rÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â©pertoire juste avant les rÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â©pertoires avec les fastq et le rÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â©pertoire d'output

SAMPLELIST=list_sample #path to the list of PREFIX for each fastq file (basically without the 1.fq or 2.fq)
SORTDIR=/media/bigvol/afiston/Work/4-project_PopGenMouse/5-Demultiplexage/NovaSEQ_run1/sorted_bamfiles_run1/
SORTSUFFIX=_sorted.bam
RMVDIR=/media/bigvol/afiston/Work/4-project_PopGenMouse/5-Demultiplexage/NovaSEQ_run1/rmpcr_sorted_bamfiles_run1/
RMVSUFFIX=_rmpcr_sorted.bam

for SAMPLEFILE in `cat $SAMPLELIST`; do
sudo samtools markdup -r $SORTDIR$SAMPLEFILE$SORTSUFFIX $RMVDIR$SAMPLEFILE$RMVSUFFIX
done


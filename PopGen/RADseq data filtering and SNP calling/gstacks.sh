#Code to run gstacks with minimal mapping quality of 40, and removing unpaired reads
gstacks -I . -M popmap2 -O ./gstacks2/ --rm-unpaired-reads --min-mapq 40 -t 8

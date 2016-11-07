# RNAseq

Scripts used to run RNAseq pipelines on a cluster running SLURM



#Quality Control (Trimmomatic)
#Initial trimming and read checks for quality
#parameters are bash viarbles that can be set inside of script or using flags. Recommend using flags if altering default params
run_trimmomatic_batch

#alignment (Tophat2)
#uses bowtie two and a indexed reference file. indexing needs to be done prior to running this step
run_Tophat_batch


#Count tables (Python)
#needed to be activated to run all python scripts including HTseq-count (in path)
Python virtual environment created using /usr/bin/python2.7
Required packages needed for python found in Requirements.txt


#Differential expression (R)
# R pacakges need to be  installed for DiffExpression
#created  local R package library at ~/R/
source("https://bioconductor.org/biocLite.R")
biocLite("DESeq2")






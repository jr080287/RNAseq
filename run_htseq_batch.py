#!/usr/bin/python

import os.path
import sys
from subprocess import call

file = sys.argv[1]
directory = os.path.dirname(file)

sample = directory.split('/')[-1].replace('_tophat_output','')
print (file)
outfile = "%s.counts" % sample
with open(outfile, "w") as f:
    call(['htseq-count','-s','no','-q','-f','bam',file,'/home/tue39618/Programs/bowtie2indexes/Ensembl/GRCh37/Annotation/Genes/genes.gtf'],stdout=f)

#!/bin/sh
#SBATCH -p all
#SBATCH -N 1	
#SBATCH -n 1
#SBATCH -o slurm.%N.%j.out	
#SBATCH --job-name="Counts"
#SBATCH -e slurm.%N.%j.err	
#SBATCH -t 0-5:00
#SBATCH --mem=5120
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=craig.stanley@temple.edu


#import sample (file) from environment when launching the job
#--export=ALL,SAMPLE=$value

module load scipy/0.16.1
module load numpy/1.10.2

export PATH=/home/tue39618/bin:$PATH
export PATH=/home/tue39618/Scripts:$PATH
export PATH=/home/tue39618/bin:$PATH

cd ${TMPDIR}
echo $SAMPLE 
mkdir $SLURM_JOB_ID.$SLURM_JOB_NAME.tmp

cd  $SLURM_JOB_ID.$SLURM_JOB_NAME.tmp
pwd
#running htseq-count (must be in your env path already)


python /home/tue39618/Scripts/run_htseq_batch.py $SAMPLE

wait

#compress and move results
tar -cvzf  $SLURM_JOB_ID.$SLURM_JOB_NAME.tmp.tar.gz  $SLURM_JOB_ID.$SLURM_JOB_NAME.tmp

wait
mv  $SLURM_JOB_ID.$SLURM_JOB_NAME.tmp.tar.gz /home/tue39618/Results/Counts/

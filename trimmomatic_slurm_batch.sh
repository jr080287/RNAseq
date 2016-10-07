#!/bin/sh
#SBATCH	-p all
#SBATCH -N 1	
#SBATCH -n 4
#SBATCH --mem=10240
#SBATCH -o slurm.%N.%j.out	
#SBATCH --job-name="TESTING.%j"
#SBATCH -e slurm.%N.%j.err	
#SBATCH -t 0-6:00
#SBATCH -N 1	
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=craig.stanley@temple.edu


export PATH=/home/tue39618/Scripts:$PATH
# create TMPDIR for job and move into
cd  ${TMPDIR}
#pwd
mkdir $SLURM_JOB_ID.$SLURM_JOB_NAME.tmp
cd $SLURM_JOB_ID.$SLURM_JOB_NAME.tmp
echo $SAMPLE
#run tophat
bash run_trimmomatic_batch -t 4 -s $SAMPLE
wait;

#compress tmpdir and send back to home
#cd $LOCALSCRATCH
cd ${TMPDIR}
tar -cvzf $SLURM_JOB_ID.$SLURM_JOB_NAME.tmp.tar.gz  $SLURM_JOB_ID.$SLURM_JOB_NAME.tmp
mv $SLURM_JOB_ID.$SLURM_JOB_NAME.tmp.tar.gz /home/tue39618/Results/Trimmomatic

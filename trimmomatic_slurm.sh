#!/bin/sh
#SBATCH	-p all
#SBATCH -N 1	
#SBATCH -n 16
#SBATCH -o slurm.%N.%j.out	
#SBATCH --job-name="TESTING"
#SBATCH -e slurm.%N.%j.err	
#SBATCH -t 0-4:00
#SBATCH -N 1	
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=craig.stanley@temple.edu


export PATH=/home/tue39618/Programs/bowtie2-2.2.9:$PATH
export
PATH=/home/tue39618/Programs/tophat-2.1.1.Linux_x86_64:$PATH
export PATH=/home/tue39618/Scripts:$PATH
# create TMPDIR for job and move into
cd  ${TMPDIR}
#pwd
mkdir $SLURM_JOB_ID.$SLURM_JOB_NAME.tmp
cd $SLURM_JOB_ID.$SLURM_JOB_NAME.tmp


#run tophat
bash run_trimmomatic_batch -t 16 -s "/data/craig/4TB.NEW/4TB.NEW/131022_SN388_0085_BC2L02ACXX_et_al/131022_SN388_0085_BC2L02ACXX/Project_DLDR_0001_1_O2ODR/Sample_DLDR_0001_1_LV_Whole_C1_O2ODR_L03243_C2L02ACXX/DLDR_0001_1_LV_Whole_C1_O2ODR_L03243_C2L02ACXX_AAGGGA_L001"
wait;

#compress tmpdir and send back to home
#cd $LOCALSCRATCH
cd ${TMPDIR}
tar -cvzf $SLURM_JOB_ID.$SLURM_JOB_NAME.tmp.tar.gz  $SLURM_JOB_ID.$SLURM_JOB_NAME.tmp
mv $SLURM_JOB_ID.$SLURM_JOB_NAME.tmp.tar.gz
~/Results/Trimmomatic

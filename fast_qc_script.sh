#!/bin/bash                        #-- what is the language of this shell
#                                  #-- Any line that starts with #$ is an instruction to SGE
#$ -S /bin/bash                    #-- the shell for the job
#$ -o ./                        #-- output directory (fill in)
#$ -e ./                        #-- error directory (fill in)
#$ -cwd                            #-- tell the job that it should start in your working directory
#$ -r y                            #-- tell the system that if a job crashes, it should be restarted
#$ -j y                            #-- tell the system that the STDERR and STDOUT should be joined
#$ -l mem_free=1G                  #-- submits on nodes with enough free memory (required)
#$ -l scratch=1G                   #-- SGE resources (home and scratch disks)
#$ -l h_rt=24:00:00                #-- runtime limit (see above; this requests 24 hours)
##$ -t 1-10                        #-- remove first '#' to specify the number of
                                   #-- tasks if desired (see Tips section on this page)

# Anything under here can be a bash script

# If you used the -t option above, this same script will be run for each task,
# but with $SGE_TASK_ID set to a different value each time (1-10 in this case).
# The commands below are one way to select a different input (PDB codes in
# this example) for each task.  Note that the bash arrays are indexed from 0,
# while task IDs start at 1, so the first entry in the tasks array variable
# is simply a placeholder

#tasks=(0 1bac 2xyz 3ijk 4abc 5def 6ghi 7jkl 8mno 9pqr 1stu )
#input="${tasks[$SGE_TASK_ID]}"

date
hostname

conda activate DNA_seq
cd raw_data
fastqc O1_S13_L002_R2_001.fastq.gz       
fastqc O2_S14_L002_R1_001.fastq.gz       
fastqc O1_S13_L002_R1_001.fastq.gz       
fastqc O2_S14_L002_R2_001.fastq.gz       
fastqc O3_S15_L002_R1_001.fastq.gz       
fastqc T1_S10_L002_R1_001.fastq.gz
fastqc T1_S10_L002_R2_001.fastq.gz
fastqc O3_S15_L002_R2_001.fastq.gz
fastqc T2_S11_L002_R1_001.fastq.gz
fastqc T2_S11_L002_R2_001.fastq.gz
fastqc T3_S12_L002_R1_001.fastq.gz
fastqc T3_S12_L002_R2_001.fastq.gz
fastqc W1_S7_L002_R2_001.fastq.gz
fastqc W2_S8_L002_R1_001.fastq.gz
fastqc W1_S7_L002_R1_001.fastq.gz
fastqc W2_S8_L002_R2_001.fastq.gz
fastqc W3_S9_L002_R1_001.fastq.gz
fastqc W3_S9_L002_R2_001.fastq.gz   

## End-of-job summary, if running as a job
[[ -n "$JOB_ID" ]] && qstat -j "$JOB_ID"          # This is useful for debugging and usage purposes,
                                                  # e.g. "did my job exceed its memory request?"
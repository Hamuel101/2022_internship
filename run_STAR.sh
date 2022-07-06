#!/bin/bash                        #-- what is the language of this shell
#                                  #-- Any line that starts with #$ is an instruction to SGE
#$ -S /bin/bash                    #-- the shell for the job
#$ -o ./                        #-- output directory (fill in)
#$ -e ./                        #-- error directory (fill in)
#$ -cwd                            #-- tell the job that it should start in your working directory
#$ -r y                            #-- tell the system that if a job crashes, it should be restarted
#$ -j y                            #-- tell the system that the STDERR and STDOUT should be joined
#$ -l mem_free=100G                  #-- submits on nodes with enough free memory (required)
#$ -l scratch=100G                   #-- SGE resources (home and scratch disks)
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
cd /wynton/home/hwillsey/samr/raw_data

STAR --genomeDir /wynton/home/hwillsey/samr/Xentr10/Xentr_STAR_index --runThreadN 16 --quantMode GeneCounts --readFilesIn O1_S13_L002_R1_001.fastq.gz,O1_S13_L002_R2_001.fastq.gz --readFilesCommand gunzip -c --outFileNamePrefix ../CHD2_O1/CHD2_STAR_results --outSAMtype BAM SortedByCoordinate --outSAMunmapped Within --outSAMattributes Standard 
STAR --genomeDir /wynton/home/hwillsey/samr/Xentr10/Xentr_STAR_index --runThreadN 16 --quantMode GeneCounts --readFilesIn O2_S14_L002_R1_001.fastq.gz,O2_S14_L002_R2_001.fastq.gz --readFilesCommand gunzip -c --outFileNamePrefix ../CHD2_O2/CHD2_STAR_results --outSAMtype BAM SortedByCoordinate --outSAMunmapped Within --outSAMattributes Standard 
STAR --genomeDir /wynton/home/hwillsey/samr/Xentr10/Xentr_STAR_index --runThreadN 16 --quantMode GeneCounts --readFilesIn O3_S15_L002_R1_001.fastq.gz,O3_S15_L002_R2_001.fastq.gz --readFilesCommand gunzip -c --outFileNamePrefix ../CHD2_O3/CHD2_STAR_results --outSAMtype BAM SortedByCoordinate --outSAMunmapped Within --outSAMattributes Standard 
STAR --genomeDir /wynton/home/hwillsey/samr/Xentr10/Xentr_STAR_index --runThreadN 16 --quantMode GeneCounts --readFilesIn T1_S10_L002_R1_001.fastq.gz,T1_S10_L002_R2_001.fastq.gz --readFilesCommand gunzip -c --outFileNamePrefix ../CHD2_T1/CHD2_STAR_results --outSAMtype BAM SortedByCoordinate --outSAMunmapped Within --outSAMattributes Standard 
STAR --genomeDir /wynton/home/hwillsey/samr/Xentr10/Xentr_STAR_index --runThreadN 16 --quantMode GeneCounts --readFilesIn T2_S11_L002_R1_001.fastq.gz,T2_S11_L002_R2_001.fastq.gz --readFilesCommand gunzip -c --outFileNamePrefix ../CHD2_T2/CHD2_STAR_results --outSAMtype BAM SortedByCoordinate --outSAMunmapped Within --outSAMattributes Standard 
STAR --genomeDir /wynton/home/hwillsey/samr/Xentr10/Xentr_STAR_index --runThreadN 16 --quantMode GeneCounts --readFilesIn T3_S12_L002_R1_001.fastq.gz,T3_S12_L002_R2_001.fastq.gz --readFilesCommand gunzip -c --outFileNamePrefix ../CHD2_T3/CHD2_STAR_results --outSAMtype BAM SortedByCoordinate --outSAMunmapped Within --outSAMattributes Standard 
STAR --genomeDir /wynton/home/hwillsey/samr/Xentr10/Xentr_STAR_index --runThreadN 16 --quantMode GeneCounts --readFilesIn W1_S7_L002_R1_001.fastq.gz,W1_S7_L002_R2_001.fastq.gz --readFilesCommand gunzip -c --outFileNamePrefix ../CHD2_W1/CHD2_STAR_results --outSAMtype BAM SortedByCoordinate --outSAMunmapped Within --outSAMattributes Standard 
STAR --genomeDir /wynton/home/hwillsey/samr/Xentr10/Xentr_STAR_index --runThreadN 16 --quantMode GeneCounts --readFilesIn W2_S8_L002_R1_001.fastq.gz,W2_S8_L002_R2_001.fastq.gz --readFilesCommand gunzip -c --outFileNamePrefix ../CHD2_W2/CHD2_STAR_results --outSAMtype BAM SortedByCoordinate --outSAMunmapped Within --outSAMattributes Standard 
STAR --genomeDir /wynton/home/hwillsey/samr/Xentr10/Xentr_STAR_index --runThreadN 16 --quantMode GeneCounts --readFilesIn W3_S9_L002_R1_001.fastq.gz,W3_S9_L002_R2_001.fastq.gz --readFilesCommand gunzip -c --outFileNamePrefix ../CHD2_W3/CHD2_STAR_results --outSAMtype BAM SortedByCoordinate --outSAMunmapped Within --outSAMattributes Standard 
## End-of-job summary, if running as a job
[[ -n "$JOB_ID" ]] && qstat -j "$JOB_ID"          # This is useful for debugging and usage purposes,
                                                  # e.g. "did my job exceed its memory request?"
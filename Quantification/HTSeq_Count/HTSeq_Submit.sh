#!/bin/bash

#-------------------------------------------------------------------------------------------#
#  Author      : Andrew J Skelton                                                           |
#  Language    : Bash                                                                       |
#  Study       : Gene Level RNA Seq (Single-end Nextseq)                                    |
#  Data Owner  : Newcastle University - Dr. Ken Baker                                       |
#  Description : Submit jobs to queue for Quantification using HTSeq Count                  |
#-------------------------------------------------------------------------------------------#


##'Set Base Directory and Variables
##'-----------------------------------------------------------------------------------------#
PROJ_BASE="/home/nas151/WORKING_DATA/Ken/Data/"
SCRIPTS=${PROJ_BASE}../Scripts/
GTF="/opt/databases/STAR_Index/Human/GRCh38_76bp/gencode.v25.annotation.gtf"
##'-----------------------------------------------------------------------------------------#


##' Run HTSeq Count for each sample
##'-----------------------------------------------------------------------------------------#
for i in ${PROJ_BASE}*
do
  SAMPLE=$(basename "${i}")
  SAMPLE=${SAMPLE##*_}
  echo $SAMPLE
  OUT_DIR=${i}/Quantification/HTSeq_Count/
  BAM_FILE=`find ${i} -type f -name "*.bam"`
  mkdir -p ${OUT_DIR}

  qsub -N "HTSeq_${SAMPLE}" \
          ${SCRIPTS}/HTSeq_Run.sh \
          ${BAM_FILE} \
          ${OUT_DIR} \
          ${SAMPLE} \
          ${GTF}
done
##'-----------------------------------------------------------------------------------------#

#!/bin/bash

#-------------------------------------------------------------------------------------------#
#  Author      : Andrew J Skelton                                                           |
#  Language    : Bash                                                                       |
#  Study       : Gene Level RNA Seq (Single-end Nextseq)                                    |
#  Data Owner  : Newcastle University - Dr. Ken Baker                                       |
#  Description : Submit jobs to queue for Alignment using STAR                              |
#-------------------------------------------------------------------------------------------#


##'Set Base Directory and Variables
##'-----------------------------------------------------------------------------------------#
PROJ_BASE="/home/nas151/WORKING_DATA/Ken/Data/"
SCRIPTS=${PROJ_BASE}../Scripts/
STAR_IDX="/opt/databases/STAR_Index/Human/GRCh38_76bp/"
##'-----------------------------------------------------------------------------------------#


##' Run STAR Alignment for each sample
##'-----------------------------------------------------------------------------------------#
for i in ${PROJ_BASE}*
do
  SAMPLE=$(basename "${i}")
  SAMPLE=${SAMPLE##*_}
  echo $SAMPLE
  OUT_DIR=${i}/Alignment/STAR_1P/
  FQ_FILE=`find ${i} -type f -name "*.fastq.gz"`
  mkdir -p ${OUT_DIR}

  qsub -N "STAR_${SAMPLE}" \
          ${SCRIPTS}/STAR_Run.sh \
          ${FQ_FILE} \
          ${OUT_DIR} \
          ${STAR_IDX} \
          ${SAMPLE}
done
##'-----------------------------------------------------------------------------------------#

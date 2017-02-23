#!/bin/bash

#-------------------------------------------------------------------------------------------#
#  Author      : Andrew J Skelton                                                           |
#  Language    : Bash                                                                       |
#  Study       : Gene Level RNA Seq                                                         |
#  Data Owner  : Newcastle University - Dr. Desa Lilic                                      |
#  Description : Parent Script Project Preprocessing                                        |
#-------------------------------------------------------------------------------------------#

##'Set Base Directory and Capture Kits
##'-----------------------------------------------------------------------------------------#
PROJ_BASE="/home/nas151/WORKING_DATA/Ken/Data/"
SCRIPTS=${PROJ_BASE}../Scripts/
##'-----------------------------------------------------------------------------------------#


##' Run Kallisto for each sample
##'-----------------------------------------------------------------------------------------#
for i in ${PROJ_BASE}*
do
  SAMPLE=$(basename "${i}")
  SAMPLE=${SAMPLE##*_}
  echo $SAMPLE
  OUT_DIR=${i}/Quantification/Kallisto/
  FQ_FILE=`find ${i} -type f -name "*.fastq.gz"`
  mkdir -p ${OUT_DIR}

  qsub -N "Kallisto_${SAMPLE}" \
          ${SCRIPTS}/Kallisto_Run.sh \
          ${FQ_FILE} \
          ${OUT_DIR}
done

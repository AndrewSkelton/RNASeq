#!/bin/bash
#$ -cwd -V
#$ -pe smp 1
#$ -l h_vmem=5G
#$ -e ~/log
#$ -o ~/log


#-------------------------------------------------------------------------------------------#
#  Author      : Andrew J Skelton                                                           |
#  Language    : R Statistical Programming Language                                         |
#  Study       : RNA Seq - NOF and OA Samples                                               |
#  Data Owner  : Newcastle University - Prof. David Young                                   |
#  System      : Sulaco                                                                     |
#  Tool        : Kallisto                                                                   |
#  Description : Execute Kallisto on all samples                                            |
#-------------------------------------------------------------------------------------------#


##' Add Module
##'-----------------------------------------------------------------------------------------#
module add apps/kallisto/0.43.0_linux
##'-----------------------------------------------------------------------------------------#


##'Set Variables
##'-----------------------------------------------------------------------------------------#
KALLISTO_IDX="/home/nas151/WORKING_DATA/Ken/Reference/Kallisto/gencode.v24.transcripts.kallisto"
TRANS_FA="/home/nas151/WORKING_DATA/Ken/Reference/Kallisto/gencode.v24.transcripts.fa"
GENE_MAP="/home/nas151/WORKING_DATA/Ken/Reference/Kallisto/gencode_v24.gene_map.txt"
##'-----------------------------------------------------------------------------------------#


##'Copy File to Scratch
##'-----------------------------------------------------------------------------------------#
cp ${KALLISTO_IDX} ${TMPDIR}
cp ${TRANS_FA} ${TMPDIR}
cp ${GENE_MAP} ${TMPDIR}
cp ${1} ${TMPDIR}
##'-----------------------------------------------------------------------------------------#


##'Get Basenames
##'-----------------------------------------------------------------------------------------#
KALLISTO_IDX=$(basename "${KALLISTO_IDX}")
TRANS_FA=$(basename "${TRANS_FA}")
GENE_MAP=$(basename "${GENE_MAP}")
FQ_IN=$(basename "${1}")
##'-----------------------------------------------------------------------------------------#


##'Execute Kallisto
##'-----------------------------------------------------------------------------------------#
kallisto quant \
  -b 1 \
  -t 1 \
  -i ${TMPDIR}/${KALLISTO_IDX} \
  -o ${2} \
  --single \
  -l 200 \
  -s 20 \
  ${TMPDIR}/${FQ_IN}
##'-----------------------------------------------------------------------------------------#

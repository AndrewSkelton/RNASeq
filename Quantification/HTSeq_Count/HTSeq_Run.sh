#!/bin/bash
#$ -cwd -V
#$ -pe smp 1
#$ -l h_vmem=20G
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
module add apps/HTSeq/0.6.1
##'-----------------------------------------------------------------------------------------#


##'Copy File to Scratch
##'-----------------------------------------------------------------------------------------#
cp ${1}* ${TMPDIR}
cp ${4} ${TMPDIR}
##'-----------------------------------------------------------------------------------------#


##'Get Basenames
##'-----------------------------------------------------------------------------------------#
BAM_IN=$(basename "${1}")
REF_GTF=$(basename "${4}")
##'-----------------------------------------------------------------------------------------#


##'Execute HTSeq Count
##'-----------------------------------------------------------------------------------------#
htseq-count -f bam \
            -s no \
            -m intersection-nonempty \
            ${TMPDIR}/${BAM_IN} \
            ${TMPDIR}/${REF_GTF} > ${TMPDIR}/${3}'.count'
##'-----------------------------------------------------------------------------------------#


##' Move output files from node scratch to lustre filesystem
##'-----------------------------------------------------------------------------------------#
mv ${TMPDIR}/${3}.count ${2}
##'-----------------------------------------------------------------------------------------#
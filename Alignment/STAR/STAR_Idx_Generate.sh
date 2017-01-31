#!/bin/bash

GENOME=/data/genomes/grcm38/

mkdir ${GENOME}/star_75_idx

STAR --runMode genomeGenerate --genomeDir ${GENOME}/star_75_idx \
     --genomeFastaFiles ${GENOME}/grcm38_primary_assembly.fa \
     --sjdbGTFfile ${GENOME}/grcm38.gtf --sjdbOverhang 74 --runThreadN 20

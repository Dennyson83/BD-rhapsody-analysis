#!/bin/bash

### demultiplexing cbcl nova seq 6000 - professor steiner
nohup bcl2fastq --runfolder-dir /home/otavio/asteiner/single_cell/data --output-dir /home/otavio/asteiner/fastq_files --sample-sheet /home/otavio/asteiner/single_cell/data/SampleSheet.csv &

### download genome and transcriptome reference
wget https://ftp.ensembl.org/pub/release-109/fasta/rattus_norvegicus/dna/Rattus_norvegicus.mRatBN7.2.dna_sm.toplevel.fa.gz #genome
(transcriptome)

### building decoys.txt
## create file with sample tags [sampletags.fa] informations use the nano 
nano norvegicus_sampleTags.fa

## we need create the decoys files with three informations, cDNA.fa, genome.fa, and sampletags.fa
## for this use:

grep "^>" < Rattus_norvegicus.mRatBN7.2.dna_sm.toplevel.fa | cut -d " " -f 1 > norvegicus_decoys.txt
grep "^>" < norvegicus_sampleTags.fa | cut -d " " -f 1 >> norvegicus_decoys.txt
sed -i.bak -e 's/>//g' norvegicus_decoys.txt

### concatenat informations of transcripts, genomes and sampletags to index
cat Rattus_norvegicus.mRatBN7.2.cdna.all.fa Rattus_norvegicus.mRatBN7.2.dna_sm.toplevel.fa norvegicus_sampleTags.fa > norvegicus_gentrome.fa.gz
cat sampleTags.fa Mus_musculus.GRCm39.dna_sm.primary_assembly.fa > gentrome.fa.gz

### create index with salmon
nohup salmon index -t norvegicus_gentrome.fa.gz -d norvegicus_decoys.txt -p 12 -i norvegicus_salmon_index --gencode &

#salmon alevin -l ISR -1  Library1_WTA_S1_L001_R1_001.fastq Library1_WTA_S1_L002_R1_001.fastq -2 Library1_WTA_S1_L001_R2_001.fastq Library1_WTA_S1_L002_R2_001.fastq --dropseq  -i /home/otavio/reference_genome/salmon_index -p 10 -o alevin_output --tgMap /home/otavio/reference_genome/txp2gene.tsv --dumpFeatures

gunzip *fastq.gz
gffread  -EL Rattus_norvegicus.mRatBN7.2.109.gtf --table @id,@geneid  > txp2gene.tsv

"cart 3"
salmon alevin -l ISR -1  peritoneo_SHAM_S3_L001_R1_001.fastq peritoneo_SHAM_S3_L002_R1_001.fastq -2 peritoneo_SHAM_S3_L001_R2_001.fastq peritoneo_SHAM_S3_L002_R2_001.fastq -i /home/otavio/reference_genome/rattus_norvegicus/norvegicus_salmon_index/ --whitelist /home/otavio/reference_genome/bd_rhapsody_barcode.txt -p 10 -o norvegius_alevin_output --tgMap /home/otavio/reference_genome/rattus_norvegicus/txp2gene.tsv --umi-geometry '1[53-60]' --bc-geometry '1[1-9,22-30,44-52]' --read-geometry '2[1-50q]' --dumpBfh --dumpArborescences --dumpUmiGraph --dumpCellEq --dumpFeatures --dumpMtx

"cart 4"
salmon alevin -l ISR -1  peritoneo_SplancX_S4_L001_R1_001.fastq peritoneo_SplancX_S4_L002_R1_001.fastq -2 peritoneo_SplancX_S4_L001_R2_001.fastq peritoneo_SplancX_S4_L002_R2_001.fastq -i /home/otavio/reference_genome/rattus_norvegicus/norvegicus_salmon_index/ --whitelist /home/otavio/reference_genome/bd_rhapsody_barcode.txt -p 10 -o norvegius_alevin_output --tgMap /home/otavio/reference_genome/rattus_norvegicus/txp2gene.tsv --umi-geometry '1[53-60]' --bc-geometry '1[1-9,22-30,44-52]' --read-geometry '2[1-50]' --dumpBfh --dumpArborescences --dumpUmiGraph --dumpCellEq --dumpFeatures --dumpMtx

"cart 1"
salmon alevin -l ISR -1  spleen-SHAM_S1_L001_R1_001.fastq spleen-SHAM_S1_L002_R1_001.fastq -2 spleen-SHAM_S1_L001_R2_001.fastq spleen-SHAM_S1_L002_R2_001.fastq -i /home/otavio/reference_genome/rattus_norvegicus/norvegicus_salmon_index/ --whitelist /home/otavio/reference_genome/bd_rhapsody_barcode.txt -p 10 -o norvegius_alevin_output --tgMap /home/otavio/reference_genome/rattus_norvegicus/txp2gene.tsv --umi-geometry '1[53-60]' --bc-geometry '1[1-9,22-30,44-52]' --read-geometry '2[1-50]' --dumpBfh --dumpArborescences --dumpUmiGraph --dumpCellEq --dumpFeatures --dumpMtx

"cart 2"
salmon alevin -l ISR -1  spleen-SplancX_S2_L001_R1_001.fastq spleen-SplancX_S2_L002_R1_001.fastq -2 spleen-SplancX_S2_L001_R2_001.fastq spleen-SplancX_S2_L002_R2_001.fastq -i /home/otavio/reference_genome/rattus_norvegicus/norvegicus_salmon_index/ --whitelist /home/otavio/reference_genome/bd_rhapsody_barcode.txt -p 10 -o norvegius_alevin_output --tgMap /home/otavio/reference_genome/rattus_norvegicus/txp2gene.tsv --umi-geometry '1[53-60]' --bc-geometry '1[1-9,22-30,44-52]' --read-geometry '2[1-50]' --dumpBfh --dumpArborescences --dumpUmiGraph --dumpCellEq --dumpFeatures --dumpMtx



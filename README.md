# BD-rhapsody-analysis
Here you will find the comprehensive script for quality control analysis of Single Cell RNA sequencing data in BD Rhapsody output format. Essentially, the script employs the software tools bcl2fastq for Illumina NovaSeq 6000 output, fastqc, trimmomatic, and salmon-alevin. Furthermore, for a comprehensive analysis, it is imperative that alevin accurately maps the SampleTags (File is avaliable bd_barcode.txt), enabling us to differentiate the samples in the Seurat pipeline effectively.

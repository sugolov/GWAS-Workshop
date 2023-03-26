# GWAS Workshop

In the summer of 2021 our team designed and offered this (online) workshop to 17 senior high school students from the University of Toronto Schools (UTS) in Toronto, Ontario, Canada, selected based on their interests and readiness in statistics, genetics or computing.
Throughout the 4.5-day workshop, the mornings were used for lectures, providing the necessary background in genetics and statistics. The afternoons were guided tutorials, providing hands-on experience.

## Data download 

To download all files, use `Code > Download ZIP` or command line `git clone https://github.com/sugolov/GWAS-Workshop.git`. 
`GWAS_Manual.pdf` contains instructions for conducting the workshop. For downloading genetic data used in the workshop, please see The Center for Applied Genomics `http://www.tcag.ca/tools/1000genomes.html`.

- `http://www.tcag.ca/documents/tools/omni25_indep.tar.gz`: cleaned, independent samples from 1000 Genomes project


### Datasets

Directory containing gene expression data for selected 1000 Genomes populations.

- `Datasets/ERAP2_YRI_phenotypes.txt`: YRI dataset required for tutorial.
- `Datasets/ERAP2_CEU_phenotypes.txt`: CEU dataset for independent analysis.
- `Datasets/ERAP2_CEU_YRI_phenotypes.txt`: YRI and CEU dataset for mixed population analysis.

### Scripts

Contains all scripts mentioned throughout the manual.

### Notebooks

Guided walkthrough of the scripts.


## Provided workshop materials
- The detailed hands-on manual and the most updated version is [Open Access](https://github.com/sugolov/GWAS-Workshop) by [Anton Sugolov](https://ca.linkedin.com/in/anton-sugolov?trk=public_profile_browsemap)  and [Eric Emmenegger](https://ca.linkedin.com/in/eric-e-62a57b155?trk=people-guest_people_search-card)
- The lecture notes (1 set) in genetics by [Dr. Andrew Paterson](https://www.sickkids.ca/en/staff/p/andrew-paterson/)
- The lecture notes (5 subsets) in statistics by [Dr. Lei Sun](https://utstat.toronto.edu/sun/).

## Workshop details

We perform three Genome-Wide Association Studies on endoplasmic reticulum aminopeptidase 2 gene expression data collected by the 
Illumina microarray of HapMap3 individuals, having significant overlap with 1000 Genomes Project individuals. The association tests are performed with 
88 YRI (Yoruba in Nigeria) individuals and 102 CEU (Northern Europeans in Utah) from the 1KG project that pass quality control at the Centre 
for Applied Genomics. Analyses on the YRI, CEU, and combined CEU and YRI individuals are performed in order to demonstrate the intersection 
of statistics and genomics for interested students. The workshop focuses on using PLINK and R to perform association tests and to 
interpret their results. Statistical methods and considerations for genetic data, visualization and interpretation of large amounts of data, 
population stratification through principal component analysis, and reproducibility research are at the forefront of this workshop.

Please see the workshop manual for a complete bibliography, and below for relevant links.

https://www.internationalgenome.org/category/gene-expression/
https://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-198/
https://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-264/
http://tcag.ca/tools/1000genomes.html

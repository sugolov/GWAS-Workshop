# Below are all the plots used in visualizing results after a GWAS.
#
# When using this script, modify:
#     - the location/name of the data table being read
#     - the names of the output image files
#     - the axis and main titles in the plots
#     - the names of the columns of the input tables, as Plink v1.90 and Plink v2.0 sometimes use different column names


#load the library needed for qq, manhattan plots
library("qqman")

#read the data table with the --linear association results
#for plink v1.90, input the NA_removed.assoc.linear file of the desired analysis
#for plink v2.0, input the NA_removed.glm.linear file of the desired analysis
#   header=TRUE - reads the top row as names for the columns
#   sep = ""    - reads the any length whitespace between text as separator
#   fill = TRUE - matches row length with NA values where applicable
#   quote = ""  - indicates no data is quoted
#
#   https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/read.table
#   Code shown for Plink v1.90

data <- read.table(
  "ERAP2_CEU_YRI_bin_sex_test_clean.assoc.linear",
  header=TRUE,  
  sep = "", 
  fill = TRUE, 
  quote = "")

### Histogram ###

#specifies output as a 5in x 5in .jpeg with a resolution of 600 dots per inch, 
#   first parameter is the name of the file

jpeg("ERAP2_sample_Histogram.jpeg", 
     width = 5, 
     height  = 5,
     units = "in",
     res = 600)

#generates the histogram
#
#   as.numeric(data$P)    - the data being plotted, numeric type of P-value column in the data table
#   main =                - the main title
#   xlab =                - the x axis title
#   ylab =                - the y axis title
#   breaks=seq(0,1,0.05)  - plots bins of width 0.05 taking values from 0 to 1
#   freq = TRUE           - plots frequencies
#   cex = 3               - increases scaling for better resolution

hist(as.numeric(data$P), 
     main="p-value distribution",
     xlab="p-Values",
     ylab="Frequency",
     breaks = seq(0,1,0.05),
     freq = TRUE, 
     cex = 3
     )

#saves the output .jpeg in the current directory
dev.off()


### Manhattan Plot ###

#specifies output as 5in x 5in .jpeg with a resolution of 600 dots per inch, 
#   first parameter is the title

jpeg("ERAP2_sample_Manhattan.jpeg", 
     width = 5, 
     height  = 5,
     units = "in",
     res = 600)


#generates the Manhattan plot 
#For Plink v1.90
#   data        - the data frame data is being taken from
#   chr="CHR"   - name of column with chromosome number
#   bp="BP"     - name of column with base pair position of SNPs
#   p="P"       - name of column with p-values of SNPs
#   snp="SNP"   - name of column with SNP id
#   main=       - the main title
#
#For Plink v2.0
#   data        - the data frame data is being taken from
#   chr="CHROM"   - name of column with chromosome number
#   bp="POS"     - name of column with base pair position of SNPs
#   p="P"       - name of column with p-values of SNPs
#   snp="ID"   - name of column with SNP id
#   main=       - the main title
#
#   https://www.rdocumentation.org/packages/qqman/versions/0.1.2
#   Code shown for Plink v1.90

manhattan(data, 
          chr="CHR",
          bp="BP",
          p="P",
          snp="SNP", 
          main = "Manhattan plot"
          )

#saves the output .jpeg in the current directory
dev.off()

### QQ-Plot ###

#specifies output as 5in x 5in .jpeg with a resolution of 600 dots per inch, 
#   first parameter is the title
jpeg("ERAP2_sample_QQ.jpeg", 
     width = 5, 
     height = 5,
     units = "in",
     res = 600)

#generates the QQ plot
#
#   data$P      - p-values being plotted
#   main=       - the main title
#
#   https://www.rdocumentation.org/packages/qqman/versions/0.1.2

qq(data$P, 
   main = "QQ-Plot"
   )

#saves the output .jpeg in the current directory
dev.off()
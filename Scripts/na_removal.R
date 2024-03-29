#------------------------------------------------------------------------------#
# Below is the script used to remove NA values from the GWAS results
#
# When using this script, modify:
#     - the location/name of the input file being read
#     - the names of the output files
#------------------------------------------------------------------------------#

#read the data table with the linear regression results
#for plink v1.90, input the .assoc.linear file of the desired analysis
#for plink v2.0, input the .glm.linear file of the desired analysis
#   header=TRUE - reads the top row as names for the columns
#   sep = ""    - reads the any length whitespace between text as separator
#   fill = TRUE - matches row length with NA values where applicable
#   quote = ""  - indicates no data is quoted
#
#   https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/read.table
#   Code shown for Plink v1.90

results <- read.table("ERAP2_CEU_pca_sex_test.assoc.linear",  
                      header = TRUE, 
                      sep = "", 
                      fill = TRUE, 
                      quote = "", 
                      check.names = FALSE)

#write a new data frame that excludes rows containing NA values from the 
#   'results' table. as.data.frame() is used since results is a list after 
#   na.omit()

NA_removed <- as.data.frame( na.omit(results))

#write the data table 'NA_removed' (can be used to write any data table)
#   NA_removed      - first argument specifies data table to be written
#   "GWAS_results_na_removed.assoc.linear"    - second argument specifies the 
#                       name of the file to which the table is written
#   append = FALSE  - does not append table to an already existing file
#   sep = '\t'      - specifies tab character as separator for data
#   row.names=FALSE - does not include row names in output file
#   col.names=TRUE  - includes column names in output file 
#   quote = FALSE   - indicates not to quote the written data
#
#   https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/write.table

write.table(NA_removed, 
            "GWAS_results_na_removed.assoc.linear", 
            append=FALSE, 
            sep='\t', 
            row.names=FALSE, 
            col.names=TRUE, 
            quote=FALSE)

#sorts the rows of the NA_removed data table by increasing p-value
#   order()   - returns indices of the sorted list as an argument
#
#   https://www.guru99.com/r-sort-data-frame.html

sorted <- NA_removed[order(NA_removed$"P"),]

#assigns the first 50 rows of the sorted data frame to the table top50
#             - this is done by subseting the table with the indices 1,...,50
top50 <- sorted[1:50,]

write.table(NA_removed, 
            "GWAS_results_top50_SNPs.assoc.linear", 
            append=FALSE, 
            sep='\t', 
            row.names=FALSE, 
            col.names=TRUE, 
            quote=FALSE)
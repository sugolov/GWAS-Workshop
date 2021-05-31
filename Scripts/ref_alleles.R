#------------------------------------------------------------------------------#
# Below is the script used to specify reference alleles for SNPs within a 500kb 
#  window of the desired SNP. After this, the data may be plotted on LocusZoom.
#
# When using this script, modify:
#     - (!!!) the ID of the TOP SNP
#     - the location/name of the data table being read
#     - the names of the output image files
#     - the axis and main titles in the plots
#
#     - (!!!) you will need to specify the .bim file for the dataset you are 
#        working with, as it contains the desired reference alleles
#
#     - for the purpose of this workshop, the implementation is not essential,
#        so less details are included
#------------------------------------------------------------------------------#


# loads dplyr library
#       - this library should be installed with GGplot2
#       - will be used for filtering data table

library(dplyr)

#########################   SCRIPT ARGUMENTS     #############################


#change the ID of this SNP 
#   - a 500KB window will be created around this SNP
top_snp = "rs10044354"

#change to the name of the .bim file corresponding to your dataset
bim_file = "LRAP_CEU.bim"

###############################################################################

#read the data table with the --linear association results
#   header=TRUE - reads the top row as names for the columns
#   sep = ""    - reads the any length whitespace between text as separator
#   fill = TRUE - matches row length with NA values where applicable
#   quote = ""  - indicates no data is quoted
#
#   https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/read.table

results <- read.table("LRAP_CEU_YRI_pca_sex.assoc.linear",
                      header = TRUE, 
                      sep = "", 
                      fill = TRUE, 
                      quote = "", 
                      check.names = FALSE)

#write a new data frame that excludes rows containing NA values from the 
#   'results' table. as.data.frame() is used since results is a list after 
#   na.omit()

NA_removed <- as.data.frame(na.omit(results))

#assigns the chromosome and basepair of the top snp by using indices in dataframe

chr_top_snp = NA_removed[NA_removed$SNP == top_snp,1]
bp_top_snp = NA_removed[NA_removed$SNP == top_snp,3]

#subsets the 'NA_removed' dataframe where the chromosome column matches 
# the chromosome of the top snp, and the base pair positions are within 500,000
# bp of the top snp

window = subset(NA_removed, 
                CHR==chr_top_snp 
                & BP >= bp_top_snp - 500000 
                & BP <= bp_top_snp + 500000)

#creates an NA column named A2 in the window dataframe

window[,"A2"] <- NA


# reads the .bim file table specified by the bim_file argument earlier
bim = read.table(bim_file,  
                 header = FALSE, 
                 sep = "", 
                 fill = TRUE, 
                 quote = "", 
                 check.names = FALSE)

# assigns readable names to the .bim file

colnames(bim) <- c("CHR", "SNP", "MORG", "BP", "A1", "A2")

# subsets the bim file in the same way as the NA_removed data table to improve
#   computational time

bim_subset = subset(bim, 
                      CHR==chr_top_snp 
                      & BP >= bp_top_snp - 500000 
                      & BP <= bp_top_snp + 500000)


#iterates through the window file and assigns the corresponding reference allele
#   from the .bim file
for(i in 1:nrow(window)){
     window$A2[i] <- bim_subset[bim_subset$SNP == window[i,2],6]
}


# writes the window table with specified reference alleles to a .txt file.
# the paste command concatenates the first string with the top_snp argument
# specified earlier.
write.table(window, 
            paste("LocusZoom_data_", top_snp, ".txt"), 
            append=FALSE, 
            sep='\t',
            row.names=FALSE, 
            col.names=TRUE, 
            quote=FALSE)

#prints base pair positions of window
print(writeLines(paste(top_snp, "\n",
            "BP position: ", bp_top_snp, "\n", 
            "WINDOW LOWER BOUND: ", bp_top_snp - 500000, "\n",
            "WINDOW LOWER BOUND: ", bp_top_snp + 500000)))

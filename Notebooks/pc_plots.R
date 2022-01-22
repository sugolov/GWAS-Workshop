# Below is the script to generate a plot of the principal components in R.
#
# When using this script, modify:
#     - the location/name of the data table being read
#     - the names of the output image files
#     - the axis and main titles in the plots

#reads the data table with the --linear association results
#   header=TRUE - reads the top row as names for the columns
#   sep = ""    - reads the any length whitespace between text as separator
#   fill = TRUE - matches row length with NA values where applicable
#   quote = ""  - indicates no data is quoted
#
#   https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/read.table

kb = read.table("PC.eigenvec",  header = FALSE, sep = "", fill = TRUE, quote = "")

#renames default column names to something clearer
# FID - family ID
# IID - individual ID
# PC1 - principal component 1, etc.

colnames(kb) = c("FID", "IID", "PC1", "PC2", "PC3")

#specifies output as 1920p x 1920p .jpeg, 
#   first parameter is the title
jpeg("PC_plots.jpeg",width=1920,height=1920,units="px")

#organizes the plots into a 2x2 grid, specifie by mfrow= c(2,2)
par(mfrow=c(2,2))


#generates a plot between each of the first 3 principal components
#   kb$PC1                - first principal component vector
#   kb$PC2                - second principal component vector
#   main =                - the main title
#   xlab =                - the x axis title
#   ylab =                - the y axis title
#   cex = 3               - increases scaling for better resolution
#   pch = 20              - changes the style of the points
#
#   https://www.rdocumentation.org/packages/graphics/versions/3.6.2/topics/plot   


plot(kb$PC1,
     kb$PC2,
     main="Principal Components 1 and 2",
     xlab="PC1",
     ylab="PC2", 
     cex=3, 
     pch = 20)

plot(kb$PC1,
     kb$PC3,
     main="Principal Components 1 and 3",
     xlab="PC1",
     ylab="PC3", 
     cex=3, 
     pch = 20)

plot(kb$PC2,
     kb$PC3,
     main="Principal Components 2 and 3",
     xlab="PC2",
     ylab="PC3", 
     cex=3, 
     pch = 20)

#turns off graphics generation device and saves file as jpeg

dev.off()



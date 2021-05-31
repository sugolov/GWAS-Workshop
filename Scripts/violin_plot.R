#load the ggplot2 library used in these plots
library(ggplot2)


#read the data table with the --linear association results
#   header=FALSE - does not read the top row as names for the columns
#   sep = ""    - reads the any length whitespace between text as separator
#   fill = TRUE - matches row length with NA values where applicable
#   quote = ""  - indicates no data is quoted
#
#   https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/read.table

data = read.table("LRAP_CEU_top_alleles.ped",
                  header = FALSE, 
                  sep = "", 
                  fill = TRUE, 
                  quote = "")


#generates the ggplot
#   data                      - specifies the table being used
#   aes(x=V7, y=V6, fill=V7)  - takes x,y, and fill values from columns
#                               7,6,7 in the data table respectively  
#   + geom_violin()           - makes the plot a violin plot

ggplot(
  data, 
  aes(x=V7, 
      y=V6, 
      fill=V7)
  ) 

+ geom_violin()

#adds features to make plot look better
#   +ggtitle()                - adds main title
#   +xlab()                   - adds x axis title
#   +ylab()                   - adds y axis title
#   +labs(fill=)              - adds a legend
#   +scale_color_manual()     - makes plot a nice colour (don't worry abt this)
#   +theme(legend.position=)  - changes legend position
#   +geom_boxplot(width = 0.1)  - adds a boxplot onto the violin plot to show
#                                 quartiles and median
#
#   http://www.sthda.com/english/wiki/ggplot2-violin-plot-quick-start-guide-r-software-and-data-visualization

+ ggtitle("gene expression distributions against snp genotypes") 
+ xlab("Genotype") 
+ ylab("Gene expression") 
+ labs(fill = "Genotype") 
+ scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9")) 
+ theme(legend.position="right" ) 
+ geom_boxplot(width=0.1)

#saves plot with specified file name and resolution
ggsave('Sample_violin.jpeg', dpi=300)


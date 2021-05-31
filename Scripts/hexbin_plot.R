#Call the package needed for hexbin plots.
library("hexbin")

#Name a jpeg file to which the plot will be saved.
jpeg("Hexbin_Plot.jpeg",width=4,height=4,units="in",res=400)

#Read the two results files from the different analyses, 
#   making sure that the file names are correct.

xs <- read.table("logistic_results.assoc_2.logistic",header=TRUE)
ys <- read.table("assoc_results.assoc",header=TRUE)

#Take the -log10 of the p-values
xsp <- -log10(as.vector(xs$P))
ysp <- -log10(as.vector(ys$P))

#Generate the plot, noting the main string for the title, 
#   and the xlab and ylab strings for the x and y axis 
#   labels respectively.

hexbinplot(ysp~xsp,main="Hexbin Plot",
           xlab="--logistic results (-log10(p))",
           ylab="--assoc results (-log10(p))",
           style="nested.lattice",
           type="r",
           minarea=0.125,
           inner=0.1,
           cex.title=0.75)

hbin <- hexbin(xsp,ysp)
hvp <- hexViewport(hbin)
dev.off()
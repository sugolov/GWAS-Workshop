#syntax for this script: Rscript --vanilla kg_expression.R <gene> <b/c> for binary/continuous
#modify subpop vector for different results. Original vector is c("CEU", "CHB", "GIH", "JPT", "LWK", "MEX", "MKK", "YRI")
subpop = c("YRI")


########################### VARIABLES ###########################
args = commandArgs(trailingOnly=TRUE) #takes arguments from command line
gene = args[1]
form = args[2]
subpop_string_file = ""
subpop_string_title = ""
for(s in subpop) {
  subpop_string_file = paste(subpop_string_file, s, sep="_")
  subpop_string_title = paste(subpop_string_title, s, sep=" ")
}
clean = read.table("sampleTable.txt",  header = TRUE, sep = '\t', fill = TRUE, quote = "")
illumina = read.table("GPL6102_Illumina_HumanWG-6_V2_0_R1_11223189_A.bgx",  header = TRUE, sep = '\t', fill = TRUE, quote = "")
#eric = read.table("Individuals.txt",  header = FALSE, sep = "", fill = TRUE, quote = "")
probe = illumina[illumina$Symbol == gene,]$Probe_Id

################ GENE EXPRESSION DATAFRAME ###################

for (p in subpop) {
  tab = read.table(paste("exp_tables/", p, "_p3_expression.txt", sep=""),  header = TRUE, sep = '\t', fill = TRUE, quote = "")
  row.names(tab) <- tab$Normalization.REF
  s <- data.frame(t(tab)[,probe])
  colnames(s) = probe
  if(p == subpop[1]){
    phenos <- s
  }
  else {
    phenos <- rbind(phenos, s)
  }
}

FID <- clean$Ped
IID <- clean$ID
PHEN <- c()
for(id in IID) {
  if(id %in% rownames(phenos)) {
    PHEN <- c(PHEN, phenos[id, probe])
  } else {
    PHEN <- c(PHEN, -9)
  }
}
temp = cbind(FID, IID, PHEN)
names(temp) = c("FID", "IID", "PHEN")
out = as.data.frame(temp)

################ POPULATION COUNTER, OUTPUT ###################

pop_counter = c(0,0,0,0,0,0,0,0)
l = as.data.frame(cbind(pop_counter))
rownames(l) = c("CEU", "CHB", "GIH", "JPT", "LWK", "MEX", "MKK", "YRI")

for(id in out$IID) {
  if(out[out$IID == id,]$PHEN > -9){
    sp = clean[clean$ID == id,]$Population
    l[sp, "pop_counter"] = l[sp, "pop_counter"] + 1
  }
}
write.table(l, paste(gene, "_phenos_plink_format_population_counts_", form, ".txt", sep = ""), append=FALSE, sep='\t', dec=".", row.names=TRUE, col.names=TRUE, quote=FALSE)

if(form == "c") {
  write.table(out, paste(gene, "_phenos_plink_format_", subpop_string_file, "_", form, ".txt", sep = ""), append=FALSE, sep='\t', dec=".", row.names=FALSE, col.names=FALSE, quote=FALSE)
}

true_pheno = c()
for(p in as.numeric(out$PHEN)) {
  if(p>-9){
    true_pheno = c(true_pheno, p)
  }
}

################ binarization ###################

for(i in 1:nrow(out)) {
  if(clean[clean$ID == out[i,2],]$Population == "CEU" && out[i,3] > -9){
    out[i,3] = 1
  }
  if(clean[clean$ID == out[i,2],]$Population == "YRI" && out[i,3] > -9){
    out[i,3] = 2
  }
}

colnames(out) <- c("FID", "IID", "BIN")
write.table(out, paste(gene, "_two_pop_binary_covariate_", subpop_string_file, "_", form, ".txt", sep = ""), append=FALSE, sep='\t', dec=".", row.names=FALSE, col.names=FALSE, quote=FALSE)

################ SUMMARY STATISTICS DATAFRAME ###################

summary_stats_pheno <- data.frame(matrix(ncol = 1, nrow = 6))
colnames(summary_stats_pheno) <- c("summary")
rownames(summary_stats_pheno) <- c("mean", "median", "sd", "var", "min", "max")

  summary_stats_pheno[1,1] <- mean(true_pheno)
  summary_stats_pheno[2,1] <- median(true_pheno)
  summary_stats_pheno[3,1] <- sd(true_pheno)
  summary_stats_pheno[4,1] <- var(true_pheno)
  summary_stats_pheno[5,1] <- min(true_pheno)
  summary_stats_pheno[6,1] <- max(true_pheno)

write.table(summary_stats_pheno, paste(gene, "_summary_statistics_", subpop_string_file, "_", form, ".txt", sep = ""), append=FALSE, sep='\t', dec=".", row.names=TRUE, col.names=TRUE, quote=FALSE)


################ GENE EXPRESSION HISTOGRAM ###################

jpeg(paste(gene, "_expression_histogram", subpop_string_file, ".jpeg", sep = ""), height=500, width=500)
hist(true_pheno, main=paste(gene, " Expression Histogram", subpop_string_title, sep = ""),xlab="Gene Expression",ylab="Frequency",xlim=c(6,15),breaks=seq(6,15,0.5),freq = TRUE)
dev.off()


################ MAKING BINARY ###################

if(form == "b") {
  vals = c()
  for(x in phenos[,probe]) {
    if(x != probe) {
      vals = c(vals, x)
    }
  }
  med = median(as.numeric(vals))
  bin = c()
  for(ph in out$PHEN) {
    if (ph <= med) {
      if(ph < 0) {
        bin = c(bin, -9)
      }
      if (ph >= 0) {
        bin = c(bin, 1)
      }
    }
    if (ph > med) {
      bin = c(bin, 2)
    }
  }
  binary = cbind(FID, IID, bin)
  names(binary) = c("FID", "IID", "PHEN")
  out = as.data.frame(binary)
  write.table(out, paste(gene, "_phenos_plink_format", subpop_string_file, "_", form, ".txt", sep = ""), append=FALSE, sep='\t', dec=".", row.names=FALSE, col.names=FALSE, quote=FALSE)
}

#!/usr/bin/env Rscript

# Load libraries
require(data.table)
require(tidyverse)

# Read in data, filter and save output
grmMASTER <- fread("GRM/GRM_matrix.noDups.grm.gz")
grmMASTER1 <- subset(grmMASTER, grmMASTER$V1 != grmMASTER$V2) %>% filter(V4 > 0.125)
write.table(grmMASTER1, "GRM/GRM_matrix.noDups_related.grm", quote=F, sep="\t", col.names=F,row.names=F)

grm <- fread("GRM/GRM_matrix.noDups_related.grm", header=F)
ids <- fread("GRM/GRM_matrix.noDups.grm.id", header = F)
ids$index <- as.numeric(row.names(ids))
grm1 <- subset(grm, grm$V1 != grm$V2) %>% rename(Sample1_idx = V1, Sample2_idx=V2)
fam <- fread("GRM/pruned_temp.noDups.fam", header = F)
grm0125 <- fread("GRM/GRM_matrix.noDups_0125.grm.id", header = F)
grm0125_related <- subset(fam, !fam$V2 %in% grm0125$V2)

merge1 <- merge(grm1,ids[,c(2,3)],by.x="Sample1_idx",by.y="index",all.x=T) %>% rename(Sample1 = V2)
merge2 <- merge(merge1,ids[,c(2,3)],by.x="Sample2_idx",by.y="index",all.x=T) %>% rename(Sample2 = V2)
merge3 <- merge(merge2[,c(5,6,3,4)],fam[,c(2,5,6)],by.x="Sample1",by.y="V2",all.x=T) %>% rename(Sample1_SEX=V5,Sample1_PHENO=V6)
merge4 <- merge(merge3,fam[,c(2,5,6)],by.x="Sample2",by.y="V2",all.x=T) %>% rename(Sample2_SEX=V5,Sample2_PHENO=V6)
merge4 <- merge4[,c(2,1,3:8)] %>% rename(No.Non.missing.SNP=V3,est.genetic.relatedness=V4)
merge4$BothDiffPHENO <- merge4$Sample1_PHENO != merge4$Sample2_PHENO
write.table(merge4,"GRM/FILTERED.to.remove.GRM_matrix.noDups_related.grm.SampleINFO.txt", sep="\t",quote=F,col.names=T,row.names=F)

list1 <- merge4[,"Sample1",drop=T] %>% distinct()
list2 <- merge4[,"Sample2",drop=T] %>% distinct()
mergeList <- merge(list1,list2,by.x="Sample1",by.y="Sample2") %>% rename(Sample = Sample1)
subset1 <- subset(merge4, !merge4$Sample1 %in% mergeList$Sample)
subset2 <- subset(subset1, !subset1$Sample2 %in% mergeList$Sample)

diffPHENO <- subset(subset2, subset2$BothDiffPHENO == "TRUE")
sampleToExclude1 <- diffPHENO[Sample1_PHENO == "2","Sample2"] %>% rename(Sample = Sample2)
sampleToExclude2 <- diffPHENO[Sample2_PHENO == "2","Sample1"] %>% rename(Sample = Sample1)

missingSEX1 <- subset(merge4, merge4$Sample1_SEX == "0") %>% select(Sample1) %>% rename(Sample=Sample1)
missingSEX2 <- subset(merge4, merge4$Sample2_SEX == "0") %>% select(Sample2) %>% rename(Sample=Sample2)
sampleToExclude_missingSEX <- unique(rbind(missingSEX1,missingSEX2))

sampleToExclude3 <- rbind(sampleToExclude1,sampleToExclude2,sampleToExclude_missingSEX)

temp01 <- subset(merge4, !merge4$Sample1 %in% sampleToExclude3$Sample)
temp02 <- subset(merge4, !merge4$Sample2 %in% sampleToExclude3$Sample)
temp03 <- merge(temp01,temp02, by=c("Sample1","Sample2","No.Non.missing.SNP","est.genetic.relatedness","Sample1_SEX","Sample1_PHENO","Sample2_SEX","Sample2_PHENO","BothDiffPHENO"))

temp04 <- subset(grm0125_related, grm0125_related$V2 %in% temp03$Sample1)
temp05 <- subset(grm0125_related, grm0125_related$V2 %in% temp03$Sample2)
list04 <- temp04[,"V2",drop=T] %>% rename(Sample=V2)
list05 <- temp05[,"V2",drop=T] %>% rename(Sample=V2)
list06 <- unique(rbind(list04,list05))

sampleToExcludeFINAL <- rbind(sampleToExclude3,list06)
write.table(sampleToExcludeFINAL,"GRM/FILTERED.to.remove.GRM_matrix.noDups.relatedSamples_IID.txt", sep=" ",quote=F,col.names=F,row.names=F)


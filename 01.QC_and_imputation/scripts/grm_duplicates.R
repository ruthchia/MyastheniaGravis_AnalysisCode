#!/usr/bin/env Rscript

require(data.table)
require(tidyverse)

# Read in data
noDups <- fread("GRM/SampleList.noDups.IID.txt",header=F)
fam <- fread("GRM/pruned_temp.fam",header=F)
Dups <- subset(fam, !(fam$V2 %in% noDups$V1))

dim(noDups)
dim(fam)
dim(Dups)

write.table(Dups[,c("V1","V2")], "GRM/Dups.ToRemove.FIDspaceIID.txt", sep=" ", quote=F, col.name=F,row.names=F)


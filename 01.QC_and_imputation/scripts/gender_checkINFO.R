#!/usr/bin/env Rscript

require("data.table")
library(tidyverse)
fam <- fread("after_heterozyg_call_rate.fam", header = F)
check1 <- fread("gender_check1.sexcheck",header=T)
check2 <- fread("gender_check2.sexcheck",header=T)
merged_problem <- merge(check1,check2,by=c("FID","IID","PEDSEX","SNPSEX","STATUS")) %>% filter(STATUS == "PROBLEM")
merged_problemINFO <- merge(merged_problem, fam[,c(1,2,6)], by.x=c("FID","IID"),by.y=c("V1","V2"))
colnames(merged_problemINFO)[6:8] <- c("check1_F","check2_F","PHENO")
write.table(merged_problemINFO, "../failedGenderCheck_stats_INFO.txt",sep="\t",quote=F,col.names=T,row.names=F)


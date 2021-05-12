#! /bin/bash

# Script written by: Ruth Chia (LNG/NIA/NIH)
# Updated on: 07-07-2020

plinkFILE=$1
outFILENAME=$2
email=$3

# Warning message to indicate argument requirement for script to run
if [ $# -eq 3 ]
then
    echo "QC_preimputation_v2_keepRelated_1part1o2 running"
    echo "This script should be executed in biowulf. If not, please terminate job."
    echo "Additional file requirement: hapmap3_EUR_ASIA_AFR_only in .bed/.bim/fam format for PCA plotting and sample-level filtering for European samples"
    echo "Notification email will be sent when task is complete."
else
    echo "Need plink input file for merged case/control data and output file name"
    echo "Note: This script is written to be executed in biowulf."
    exit
fi

### How to use: sh QC_preimputation_v3_keepRelated_wgs.sh $plinkINPUT $outputNAME $email
### How to run as a swarm job. Be sure to specify processor that supports AVX2/Haswell
# echo "sh ./scripts/QC_preimputation_v2_keepRelated_part1of2.mg.sh $plinkINPUT $outputNAME $email" > qc.swarm
# swarm --file qc.swarm --logdir swarmOE_qc --gres=lscratch:200 -g 120 -t auto --time 03:00:00 --sbatch '--constraint=ibfdr'


###################
### QC OVERVIEW ###
###################

### PART 1of2 ###

# STEP 1  : SAMPLE-LEVEL FILTERING (HETEROZYGOSITY, CALL RATE, GENDER CHECK, ANCESTRY)
# STEP 1.1: Sample-level filtering (Heterozygosity check, removal of het outliers)
# STEP 1.2: Sample-level filtering (sample call rate check, maximum missing calls per sample --mind 0.05)
# STEP 1.3: Sample-level filtering (Gender check, remove samples that failed gender check)
# STEP 1.4: Sample-level filtering (Ancestry check, remove samples that are not european)
# STEP 1.5: Generate list of duplicates; remove duplicates
# STEP 1.6: Generate list of related samples

# STEP 2  : VARIANT-LEVEL FILTERING (Variant inclusion criteria to account for genotyping batch differences; then make final bfiles with --geno 0.05)
# STEP 2.1: Case/control nonrandom missingness test \(i.e. exclude SNPs with P \< 1E-4\)
# STEP 2.2: Haplotype-based test for non-random missing genotype data \(i.e. exclude SNPs with P \< 1E-4\)
# STEP 2.3: Make list of varaints that failed HWE \(controls\) \(i.e. exclude SNPs with midP \< 1E-10\)
# STEP 2.4: Final --geno 0.05 to account for final variant missingness



# Load necessary modules on biowulf
module load plink/1.9.0-beta4.4
module load R/3.5.2
module load GCTA/1.92.0beta3
module load flashpca/2.0

# Date stamp to record when the script run was started
start_date=$(date)
echo "Start date and time = $start_date"
res1=$(date +%s.%N)

mkdir QC
cd QC

### Sample cleaning inclusion:

# NOTE do all samples have a gender??
# NOTE do all your samples have an affection status??

# Make lists for plink to remove samples with uncertain/unknown gender, monomorphic SNPs, palindromic SNPs
echo List of samples with uncertain/unknown gender
awk '{if($6 == -9 || $5 == 0) print $1, $2}' ../${plinkFILE}.fam > SamplesToDelete.txt

echo List of monomorphic SNPs
awk '{if(($5 == $6) || $5 == 0 || $6 == 0) print $2}' ../${plinkFILE}.bim > MonomorphicBadSNPs.txt

echo List of palindromic SNPs
awk '{if(($5 == "A" && $6 == "T") || ($5 == "T" && $6 == "A") || ($5 == "G" && $6 == "C") || ($5 == "C" && $6 == "G")) print $2}' ../${plinkFILE}.bim > PalindromicSNPs.txt

echo Remove bad samples and bad SNPs and update bfiles ready for downstream QC of sample and SNP filtering
plink --bfile ../${plinkFILE} --remove SamplesToDelete.txt --exclude MonomorphicBadSNPs.txt --make-bed --out merged2

echo Remove palindromic SNPs
plink --bfile merged2 --exclude PalindromicSNPs.txt --make-bed --out merged3


# Optional: TO GET REPORT FOR SAMPLE-BASED and VARIANT-BASED MISSING DATA
# plink --bfile merged2 --missing --out call_rates

# Rename file
# mv call_rates.imiss CALL_RATES_ALL_SAMPLES.txt

# rm call_rates.lmiss
# rm call_rates.log
# rm call_rates.hh
# rm call_rates.nosex
# mv call_rates.imiss CALL_RATES_ALL_SAMPLES.txt


# STEP 1: SAMPLE-LEVEL FILTERING (HETEROZYGOSITY, CALL RATE, GENDER CHECK, ANCESTRY)
echo
echo STEP 1.1: Sample-level filtering \(Heterozygosity check, removal of het outliers\)
echo
## What happens here:
## Check sample heterozygosity -> remove heterozygosity outliers --> remake binary files removing het_outliers
## No heterozygosity outliers: --het from LD pruned data > use F cut-off of -0.15 and <- 0.15 for inclusion

plink --bfile merged3 --geno 0.01 --maf 0.05 --indep-pairwise 50 5 0.5 --out pruning
plink --bfile merged3 --extract pruning.prune.in --make-bed --out pruned_data
plink --bfile pruned_data --het --out prunedHet

awk '{if ($6 <= -0.15 || $6 >= 0.15 ) print $1"\t"$2}' prunedHet.het > het_outliers.txt

# OPTIONAL: rename .het file as a record of this step
# mv prunedHet.het HETEROZYGOSITY_DATA.txt

# Remove samples with bad heterozygosity from genotype dataset, and make new bfiles
plink --bfile merged2 --remove het_outliers.txt --make-bed --out after_heterozyg


echo
echo STEP 1.2: Sample-level filtering \(sample call rate check, maximum missing calls per sample --mind 0.05\)
echo
## Filter out samples with missing call rates (i.e. maximum missing calls per sample) set at --mind 0.05 (i.e. maximum missing calls per sample is 5%)
## No call rate outliers

plink --bfile after_heterozyg --mind 0.05 --make-bed --out after_heterozyg_call_rate

# OPTIONAL: rename .irem file as a record of this step
# mv after_heterozyg_call_rate.irem CALL_RATE_OUTLIERS.txt


echo
echo STEP 1.3: Sample-level filtering \(Gender check, remove samples that failed gender check\)
echo
# (Note for neuroX data that does not have GWAS back bone, use F cut-off of 0.50 instead of 0.25/0.75 and only use the PAR region’s common variants always)
# PAR (hg19) =  --chr 23 --from-bp 2699520 --to-bp 154931043 --maf 0.05 --geno 0.05 --hwe 1E-5

plink --bfile after_heterozyg_call_rate --check-sex 0.25 0.75 --maf 0.05 --out gender_check1
plink --bfile after_heterozyg_call_rate --chr 23 --from-bp 2699520 --to-bp 154931043 --maf 0.05 --geno 0.05 --hwe 1E-5 --check-sex  0.25 0.75 --out gender_check2

###  Make list of samples (FID, IID) that failed gender check
grep "PROBLEM" gender_check1.sexcheck | awk '{print $1"\t"$2}' > failedGenderCheck_samples_to_remove.txt
grep "PROBLEM" gender_check2.sexcheck | awk '{print $1"\t"$2}' >> failedGenderCheck_samples_to_remove.txt
sort failedGenderCheck_samples_to_remove.txt | uniq > failedGenderCheck_samples_to_remove_noDups.txt

###  Merge .fam file info with list of samples that failed gender check to figure which case or control failed
Rscript ../scripts/gender_checkINFO.R --no-save

#R
#require("data.table")
#library(tidyverse)
#fam <- fread("after_heterozyg_call_rate.fam", header = F)
#check1 <- fread("gender_check1.sexcheck",header=T)
#check2 <- fread("gender_check2.sexcheck",header=T)
#merged_problem <- merge(check1,check2,by=c("FID","IID","PEDSEX","SNPSEX","STATUS")) %>% filter(STATUS == "PROBLEM")
#merged_problemINFO <- merge(merged_problem, fam[,c(1,2,6)], by.x=c("FID","IID"),by.y=c("V1","V2"))
#colnames(merged_problemINFO)[6:8] <- c("check1_F","check2_F","PHENO")
#write.table(merged_problemINFO, "../failedGenderCheck_stats_INFO.txt",sep="\t",quote=F,col.names=T,row.names=F)
#q()
#n

# Remove samples that failed sex check --> remake plink2 binary files
plink --bfile after_heterozyg_call_rate --remove failedGenderCheck_samples_to_remove.txt --make-bed --out after_gender

# OPTIONAL: rename .sexcheck file as a record of this step
# mv gender_check1.sexcheck GENDER_CHECK1
# mv gender_check2.sexcheck GENDER_CHECK1


echo
echo STEP 1.4: Sample-level filtering \(Ancestry check, remove samples that are not european\)
echo
## No ancestry outliers (i.e. europeans) -> based on Hapmap3 PCA plot, should be near combined CEU/TSI

## First, download hapmap3 data. Prep data to include only EUROPEAN (TSI,CEU), ASIAN (CHB, CHD, JPT) and AFRICAN (LWK, YRI, ASW) and update IID to a format that can be used with the PCA_in_R.R. The hapmap3 version that is ready for us is hapmap3_EUR_ASIA_AFR_only in .bed/.bim/fam format.
## The script used to generate the working hapmap3 version is hapmap3_prep_v1.sh

# Make a list of common SNPs from after_gender.bim and hapmap3.
awk '{print $2}' ../scripts/hapmap3_EUR_ASIA_AFR_only.bim > temp1.txt
awk '{print $2}' after_gender.bim >> temp1.txt
awk '{print $1}' temp1.txt | sort | uniq -d > commonSNPs.txt

# Pull common SNPs out from after_gender.bim
plink --bfile after_gender --extract commonSNPs.txt --make-bed --out temp2 --allow-no-sex

# Make SNP map update; then update common SNPs positions to build37/hg19
## hapmap3 is in build36. case/control data is in build37. Update hapmap positions based on case/control temp2.bim file
awk '{print $2, $4}' temp2.bim > updateMap.txt
plink --bfile ../scripts/hapmap3_EUR_ASIA_AFR_only --extract commonSNPs.txt --update-map updateMap.txt --make-bed --out hapmap3_hg19_new --allow-no-sex

# Merge hapmap3_EUR_ASIA_AFR_only bfiles with after_gender bfiles
plink --bfile after_gender --bmerge hapmap3_hg19_new --out hapmap3_DISEASE_snplis --make-bed --allow-no-sex
plink --bfile after_gender --flip hapmap3_DISEASE_snplis-merge.missnp --make-bed --out after_gender3 --allow-no-sex
plink --bfile after_gender3 --bmerge hapmap3_hg19_new --out hapmap3_DISEASE_snplis --make-bed --allow-no-sex
plink --bfile after_gender3 --exclude hapmap3_DISEASE_snplis-merge.missnp --out after_gender4 --make-bed --allow-no-sex
plink --bfile after_gender4 --bmerge hapmap3_hg19_new --out hapmap3_DISEASE_snplis --make-bed --allow-no-sex

# Generate pca with additional filter to account for genotype missingness set at --geno 0.05.
plink --bfile hapmap3_DISEASE_snplis --geno 0.05 --out pca --make-bed --pca --allow-no-sex

# Prepare files for input into R for PCA plots
grep "EUROPE" pca.eigenvec > eur.txt
grep "ASIA" pca.eigenvec > asia.txt
grep "AFRICA" pca.eigenvec > afri.txt

grep -v -f eur.txt pca.eigenvec | grep -v -f asia.txt | grep -v -f afri.txt | awk '{print "0     "$0}' > pca.eigenvec2

awk '{print "1     "$0}' eur.txt >> pca.eigenvec2
awk '{print "2     "$0}' asia.txt >> pca.eigenvec2
awk '{print "3     "$0}' afri.txt >> pca.eigenvec2


# Run R script for PCA plotting and filtering; then make new bfiles
echo
echo \(continued\) STEP 2.4: Run PCA_in_R.R to filter out non-europeans
echo
Rscript ../scripts/PCA_in_R_AncestryCheck_SD6.R --no-save
echo
plink --bfile after_gender --keep ../PCA_filtered_europeans.txt --make-bed --out after_gender_heterozyg_hapmap_keepEUR


echo
echo STEP 1.5: Generate list of duplicate; remove duplicates
echo
mkdir GRM

# Prune genotype for GRM
plink \
--bfile after_gender_heterozyg_hapmap_keepEUR \
--geno 0.01 \
--maf 0.05 \
--hwe 5e-6 \
--indep-pairwise 50 5 0.5 \
--autosome \
--out GRM/temp.pruning

plink \
--bfile after_gender_heterozyg_hapmap_keepEUR \
--extract GRM/temp.pruning.prune.in \
--keep-allele-order \
--allow-no-sex \
--make-bed \
--out GRM/pruned_temp

rm GRM/temp.pruning*

# Generate grm matrix with GCTA
gcta \
--bfile GRM/pruned_temp \
--make-grm-gz \
--out GRM/GRM_matrix \
--autosome \
--maf 0.05 \
--thread-num 32

# Identify duplicates (i.e. pihat > 0.8)
gcta --grm-cutoff 0.8 \
--grm-gz GRM/GRM_matrix \
--out GRM/GRM_matrix_08 \
--make-grm \
--thread-num 32


# Make list of duplicates
awk '{print $2}' GRM/GRM_matrix_08.grm.id > GRM/SampleList.noDups.IID.txt

# Run script to generate sample list of duplicates
Rscript ../scripts/grm_duplicates.R

#R
#!/usr/bin/env Rscript

#require(data.table)
#require(tidyverse)

# Read in data
#noDups <- fread("GRM/SampleList.noDups.IID.txt",header=F)
#fam <- fread("GRM/pruned_temp.fam",header=F)
#Dups <- subset(fam, !(fam$V2 %in% noDups$V1))

#dim(noDups)
#dim(fam)
#dim(Dups)

#write.table(Dups[,c("V1","V2")], "GRM/Dups.ToRemove.FIDspaceIID.txt", sep=" ", quote=F, col.name=F,row.names=F)
#q()
#n


# Remove dups (i.e. keep related samples) and remake plink binaries
grep -Ewf GRM/Dups.ToRemove.FIDspaceIID.txt after_gender_heterozyg_hapmap_keepEUR.fam | awk '{print $1,$2}' OFS=" " > Dups.ToRemove.FIDspaceIID.txt

plink \
--bfile after_gender_heterozyg_hapmap_keepEUR \
--remove Dups.ToRemove.FIDspaceIID.txt \
--make-bed \
--out after_gender_heterozyg_hapmap_keepEUR_noDups

echo
echo STEP 1.6: Generate list of related samples
echo
# Remove dups from pruned data in Step 1.5 above, rerun gcta to generate GRM matrix of samples without duplicates)
plink \
--bfile GRM/pruned_temp \
--remove GRM/Dups.ToRemove.FIDspaceIID.txt \
--make-bed \
--out GRM/pruned_temp.noDups

gcta \
--bfile GRM/pruned_temp.noDups \
--make-grm-gz \
--out GRM/GRM_matrix.noDups \
--autosome \
--maf 0.05 \
--thread-num 32

gcta \
--grm-cutoff 0.125 \
--grm-gz GRM/GRM_matrix.noDups \
--out GRM/GRM_matrix.noDups_0125 \
--make-grm \
--thread-num 32

# Run script to generate sample list of related samples
Rscript ../scripts/grm_unrelated.R
grep -Ewf GRM/FILTERED.to.remove.GRM_matrix.noDups.relatedSamples_IID.txt after_gender_heterozyg_hapmap_keepEUR.fam | awk '{print $1,$2}' OFS=" " > ../FILTERED.to.remove.GRM_matrix.noDups.relatedSamples_FIDspaceIID.txt

#R
##!/usr/bin/env Rscript
#
## Load libraries
#require(data.table)
#require(tidyverse)
#
## Read in data, filter and save output
#grmMASTER <- fread("GRM/GRM_matrix.noDups.grm.gz")
#grmMASTER1 <- subset(grmMASTER, grmMASTER$V1 != grmMASTER$V2) %>% filter(V4 > 0.125)
#write.table(grmMASTER1, "GRM/GRM_matrix.noDups_related.grm", quote=F, sep="\t", col.names=F,row.names=F)
#
#grm <- fread("GRM/GRM_matrix.noDups_related.grm", header=F)
#ids <- fread("GRM/GRM_matrix.noDups.grm.id", header = F)
#ids$index <- as.numeric(row.names(ids))
#grm1 <- subset(grm, grm$V1 != grm$V2) %>% rename(Sample1_idx = V1, Sample2_idx=V2)
#fam <- fread("GRM/pruned_temp.noDups.fam", header = F)
#grm0125 <- fread("GRM/GRM_matrix.noDups_0125.grm.id", header = F)
#grm0125_related <- subset(fam, !fam$V2 %in% grm0125$V2)
#
#merge1 <- merge(grm1,ids[,c(2,3)],by.x="Sample1_idx",by.y="index",all.x=T) %>% rename(Sample1 = V2)
#merge2 <- merge(merge1,ids[,c(2,3)],by.x="Sample2_idx",by.y="index",all.x=T) %>% rename(Sample2 = V2)
#merge3 <- merge(merge2[,c(5,6,3,4)],fam[,c(2,5,6)],by.x="Sample1",by.y="V2",all.x=T) %>% rename(Sample1_SEX=V5,Sample1_PHENO=V6)
#merge4 <- merge(merge3,fam[,c(2,5,6)],by.x="Sample2",by.y="V2",all.x=T) %>% rename(Sample2_SEX=V5,Sample2_PHENO=V6)
#merge4 <- merge4[,c(2,1,3:8)] %>% rename(No.Non.missing.SNP=V3,est.genetic.relatedness=V4)
#merge4$BothDiffPHENO <- merge4$Sample1_PHENO != merge4$Sample2_PHENO
#write.table(merge4,"GRM/FILTERED.to.remove.GRM_matrix.noDups_related.grm.SampleINFO.txt", sep="\t",quote=F,col.names=T,row.names=F)
#
#list1 <- merge4[,"Sample1",drop=T] %>% distinct()
#list2 <- merge4[,"Sample2",drop=T] %>% distinct()
#mergeList <- merge(list1,list2,by.x="Sample1",by.y="Sample2") %>% rename(Sample = Sample1)
#subset1 <- subset(merge4, !merge4$Sample1 %in% mergeList$Sample)
#subset2 <- subset(subset1, !subset1$Sample2 %in% mergeList$Sample)
#
#diffPHENO <- subset(subset2, subset2$BothDiffPHENO == "TRUE")
#sampleToExclude1 <- diffPHENO[Sample1_PHENO == "2","Sample2"] %>% rename(Sample = Sample2)
#sampleToExclude2 <- diffPHENO[Sample2_PHENO == "2","Sample1"] %>% rename(Sample = Sample1)
#
#missingSEX1 <- subset(merge4, merge4$Sample1_SEX == "0") %>% select(Sample1) %>% rename(Sample=Sample1)
#missingSEX2 <- subset(merge4, merge4$Sample2_SEX == "0") %>% select(Sample2) %>% rename(Sample=Sample2)
#sampleToExclude_missingSEX <- unique(rbind(missingSEX1,missingSEX2))
#
#sampleToExclude3 <- rbind(sampleToExclude1,sampleToExclude2,sampleToExclude_missingSEX)
#
#temp01 <- subset(merge4, !merge4$Sample1 %in% sampleToExclude3$Sample)
#temp02 <- subset(merge4, !merge4$Sample2 %in% sampleToExclude3$Sample)
#temp03 <- merge(temp01,temp02, by=c("Sample1","Sample2","No.Non.missing.SNP","est.genetic.relatedness","Sample1_SEX","Sample1_PHENO","Sample2_SEX","Sample2_PHENO","BothDiffPHENO"))
#
#temp04 <- subset(grm0125_related, grm0125_related$V2 %in% temp03$Sample1)
#temp05 <- subset(grm0125_related, grm0125_related$V2 %in% temp03$Sample2)
#list04 <- temp04[,"V2",drop=T] %>% rename(Sample=V2)
#list05 <- temp05[,"V2",drop=T] %>% rename(Sample=V2)
#list06 <- unique(rbind(list04,list05))
#
#sampleToExcludeFINAL <- rbind(sampleToExclude3,list06)
#write.table(sampleToExcludeFINAL,"GRM/FILTERED.to.remove.GRM_matrix.noDups.relatedSamples_IID.txt", sep=" ",quote=F,col.names=F,row.names=F)
#
#q()
#n


# STEP 2: Variant inclusion criteria to account for genotyping batch differences; then make final bfiles with --geno 0.05
echo
echo STEP 2. Variant inclusion criteria to account for genotyping batch differences

echo STEP 2.1: Case/control nonrandom missingness test \(i.e. exclude SNPs with P \< 1E-4\)
echo
plink \
--bfile after_gender_heterozyg_hapmap_keepEUR \
--test-missing \
--out missing_snps

awk '{if ($5 <= 0.0001) print $2 }' missing_snps.missing > missing_snps_1E4.txt

plink \
--bfile after_gender_heterozyg_hapmap_keepEUR_noDups \
--exclude missing_snps_1E4.txt \
--make-bed \
--out after_gender_heterozyg_hapmap_keepEUR_noDups_CaseConMissingness

sort -u missing_snps_1E4.txt > VARIANT_TEST_MISSING_SNPS.txt

echo
echo STEP 2.2: Haplotype-based test for non-random missing genotype data \(i.e. exclude SNPs with P \< 1E-4\)
echo
plink \
--bfile after_gender_heterozyg_hapmap_keepEUR_noDups_CaseConMissingness \
--test-mishap \
--out missing_hap

awk '{if ($8 <= 0.0001) print $9 }' missing_hap.missing.hap > missing_haps_1E4.txt

sed 's/|/\
/g' missing_haps_1E4.txt > missing_haps_1E4_final.txt

sort -u missing_haps_1E4_final.txt > HAPLOTYPE_TEST_MISSING_SNPS.txt

plink \
--bfile after_gender_heterozyg_hapmap_keepEUR_noDups_CaseConMissingness \
--exclude missing_haps_1E4_final.txt \
--make-bed \
--out after_gender_heterozyg_hapmap_keepEUR_noDups_CaseConMissingness_HaploMissingness

echo
echo STEP 2.3: Make list of varaints that failed HWE \(controls\) \(i.e. exclude SNPs with midP \< 1E-10\)
echo
plink \
--bfile after_gender_heterozyg_hapmap_keepEUR_noDups_CaseConMissingness_HaploMissingness \
--filter-controls \
--hwe 1e-6 midp \
--write-snplist \
--out Vars.passhwecontrols1e-10


echo
echo STEP 2.4: Final --geno 0.05 to account for final variant missingness
echo
plink \
--bfile after_gender_heterozyg_hapmap_keepEUR_noDups_CaseConMissingness_HaploMissingness \
--extract Vars.passhwecontrols1e-6.snplist \
--geno 0.05 \
--make-bed \
--out ../FILTERED.${outFILENAME}_keepRelated

# Save log files in new log directory
mkdir logFiles
mv *.log ./logFiles


# Gives runtime
res2=$(date +%s.%N)
dt=$(echo "$res2 - $res1" | bc)
dd=$(echo "$dt/86400" | bc)
dt2=$(echo "$dt-86400*$dd" | bc)
dh=$(echo "$dt2/3600" | bc)
dt3=$(echo "$dt2-3600*$dh" | bc)
dm=$(echo "$dt3/60" | bc)
ds=$(echo "$dt3-60*$dm" | bc)

end_date=$(date)
echo "End date and time = $end_date"
printf "Total runtime: %d:%02d:%02d:%02.4f\n" $dd $dh $dm $ds
printf "Total runtime: %d:%02d:%02d:%02.4f\n" $dd $dh $dm $ds > Runtime_summary.txt

mailx -s "biowulf swarm alert message: QC_preimputation_v2_keepRelated_part1of2.mg.sh TASK COMPLETE" $email < Runtime_summary.txt
sleep 10s
rm Runtime_summary.txt


####### REMOVE A LOT...
### Remove intermediate files
rm merged2.*
rm merged3.*
rm pruning.*
rm pruned_data.*
rm prunedHet.*
rm after_heterozyg.*
rm after_heterozyg_call_rate.*
rm gender_check2.*
rm gender_check1.*
rm after_gender.*
rm commonSNPs.txt
rm temp1.txt
rm temp2.*
rm updateMap.txt
rm after_gender3.*
rm after_gender4.*
rm hapmap3_DISEASE_snplis*
rm afri.txt
rm asia.txt
rm eur.txt
rm pca.bed
rm pca.bim
rm pca.fam
rm pca.hh
rm pca.eigenval
rm after_gender_heterozyg_hapmap_keepEUR*
rm missing_snps_1E4.txt
rm missing_snps.*
rm missing_haps_1E4_final.txt
rm missing_haps_1E4.txt
rm missing_hap.*




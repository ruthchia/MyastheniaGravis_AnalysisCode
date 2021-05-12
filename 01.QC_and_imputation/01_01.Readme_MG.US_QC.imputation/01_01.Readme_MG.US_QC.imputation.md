# MG US: QC and imputation

**Start date:** 04-15-2020

**End date:** 04-17-2020

**Analysed by:** Ruth Chia

**Working directory:** `/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US`

___


<h1>Table of Contents<span class="tocSkip"></span></h1>
<div class="toc"><ul class="toc-item"><li><span><a href="#Files-needed-as-the-starting-point" data-toc-modified-id="Files-needed-as-the-starting-point-1">Files needed as the starting point</a></span></li><li><span><a href="#What-needs-to-be-done" data-toc-modified-id="What-needs-to-be-done-2">What needs to be done</a></span></li><li><span><a href="#Run-QC" data-toc-modified-id="Run-QC-3">Run QC</a></span><ul class="toc-item"><li><span><a href="#Run-QC-part1" data-toc-modified-id="Run-QC-part1-3.1">Run QC part1</a></span></li><li><span><a href="#Create-'CLEAN'-genotype-files-from-QC-(step1)-files" data-toc-modified-id="Create-'CLEAN'-genotype-files-from-QC-(step1)-files-3.2">Create 'CLEAN' genotype files from QC (step1) files</a></span><ul class="toc-item"><li><span><a href="#without-duplicates,-keepRelated" data-toc-modified-id="without-duplicates,-keepRelated-3.2.1">without duplicates, keepRelated</a></span></li><li><span><a href="#without-duplicates,-UNRELATED" data-toc-modified-id="without-duplicates,-UNRELATED-3.2.2">without duplicates, UNRELATED</a></span></li></ul></li><li><span><a href="#Run-QC-part-2" data-toc-modified-id="Run-QC-part-2-3.3">Run QC part 2</a></span></li></ul></li><li><span><a href="#Generate-PCs-(with-genotype-data)--->--create-covariate-file" data-toc-modified-id="Generate-PCs-(with-genotype-data)--->--create-covariate-file-4">Generate PCs (with genotype data) --&gt;  create covariate file</a></span><ul class="toc-item"><li><ul class="toc-item"><li><span><a href="#Results-from-step();-covariates-to-adjust-for" data-toc-modified-id="Results-from-step();-covariates-to-adjust-for-4.0.1">Results from step(); covariates to adjust for</a></span></li><li><span><a href="#PC-plots-for-cases-and-controls" data-toc-modified-id="PC-plots-for-cases-and-controls-4.0.2">PC plots for cases and controls</a></span></li></ul></li></ul></li><li><span><a href="#Subset-data-set-to-two-equal-parts-stratified-by-PC,-age-and-sex-for-hg38-imputation-on-Topmed-Imputation-Server" data-toc-modified-id="Subset-data-set-to-two-equal-parts-stratified-by-PC,-age-and-sex-for-hg38-imputation-on-Topmed-Imputation-Server-5">Subset data set to two equal parts stratified by PC, age and sex for hg38 imputation on Topmed Imputation Server</a></span><ul class="toc-item"><li><span><a href="#US_mg_noDups.keepRelated.subset1" data-toc-modified-id="US_mg_noDups.keepRelated.subset1-5.1">US_mg_noDups.keepRelated.subset1</a></span></li><li><span><a href="#US_mg_noDups.UNRELATED.subset1" data-toc-modified-id="US_mg_noDups.UNRELATED.subset1-5.2">US_mg_noDups.UNRELATED.subset1</a></span><ul class="toc-item"><li><span><a href="#Imputation-download-US-subset1" data-toc-modified-id="Imputation-download-US-subset1-5.2.1">Imputation download US subset1</a></span><ul class="toc-item"><li><span><a href="#Create-index-files-for-vcf.gz" data-toc-modified-id="Create-index-files-for-vcf.gz-5.2.1.1">Create index files for vcf.gz</a></span></li><li><span><a href="#Check-total-number-of-variants-imputed" data-toc-modified-id="Check-total-number-of-variants-imputed-5.2.1.2">Check total number of variants imputed</a></span></li><li><span><a href="#Create-list-variants-to-keep-for-analysis-based-on-Rsq->-0.3-and-MAF->-0.0001" data-toc-modified-id="Create-list-variants-to-keep-for-analysis-based-on-Rsq->-0.3-and-MAF->-0.0001-5.2.1.3">Create list variants to keep for analysis based on Rsq &gt; 0.3 and MAF &gt; 0.0001</a></span></li></ul></li></ul></li><li><span><a href="#US_mg_noDups.keepRelated.subset2" data-toc-modified-id="US_mg_noDups.keepRelated.subset2-5.3">US_mg_noDups.keepRelated.subset2</a></span></li><li><span><a href="#US_mg_noDups.UNRELATED.subset2" data-toc-modified-id="US_mg_noDups.UNRELATED.subset2-5.4">US_mg_noDups.UNRELATED.subset2</a></span><ul class="toc-item"><li><span><a href="#Imputation-download-US-subset2" data-toc-modified-id="Imputation-download-US-subset2-5.4.1">Imputation download US subset2</a></span><ul class="toc-item"><li><span><a href="#Create-index-files-for-vcf.gz" data-toc-modified-id="Create-index-files-for-vcf.gz-5.4.1.1">Create index files for vcf.gz</a></span></li><li><span><a href="#Check-total-number-of-variants-imputed" data-toc-modified-id="Check-total-number-of-variants-imputed-5.4.1.2">Check total number of variants imputed</a></span></li><li><span><a href="#Create-list-variants-to-keep-for-analysis-based-on-Rsq->-0.3-and-MAF->-0.0001" data-toc-modified-id="Create-list-variants-to-keep-for-analysis-based-on-Rsq->-0.3-and-MAF->-0.0001-5.4.1.3">Create list variants to keep for analysis based on Rsq &gt; 0.3 and MAF &gt; 0.0001</a></span></li></ul></li></ul></li></ul></li><li><span><a href="#Merge-US.subset1-and-US.subset2" data-toc-modified-id="Merge-US.subset1-and-US.subset2-6">Merge US.subset1 and US.subset2</a></span><ul class="toc-item"><li><span><a href="#Make-list-of-shared--post-imputatation-variants-shared-between-US.subset1-and-US.subset2" data-toc-modified-id="Make-list-of-shared--post-imputatation-variants-shared-between-US.subset1-and-US.subset2-6.1">Make list of shared  post-imputatation variants shared between US.subset1 and US.subset2</a></span></li><li><span><a href="#Merge-vcf.gz-files-from-US.subset1-and-US.subset2-containing-dosage-info" data-toc-modified-id="Merge-vcf.gz-files-from-US.subset1-and-US.subset2-containing-dosage-info-6.2">Merge vcf.gz files from US.subset1 and US.subset2 containing dosage info</a></span></li><li><span><a href="#Make-list-of-dbGAP-samples-to-remove-from-analysis" data-toc-modified-id="Make-list-of-dbGAP-samples-to-remove-from-analysis-6.3">Make list of dbGAP samples to remove from analysis</a></span></li></ul></li><li><span><a href="#Generate-plink-files-for-PRS-analysis" data-toc-modified-id="Generate-plink-files-for-PRS-analysis-7">Generate plink files for PRS analysis</a></span><ul class="toc-item"><li><span><a href="#USmerged" data-toc-modified-id="USmerged-7.1">USmerged</a></span></li></ul></li></ul></div>

## Files needed as the starting point

1. Raw genotype plink binaries
2. Phenotype file with minimum sex and age information


## What needs to be done

1. Run sample- and variant-level QC on raw genotype plink files.
    
2. Submit for imputation using Topmed Imputation Server (hg38).
    - Download imputed data, filter to keep only variants with Rsq > 0.3 and maf > 0.001
    
3. Generate PCs and covariate file.

4. Run GLM (dosages) using imputed data

## Run QC

QC script is written in two parts i.e. 
- part1: performs sample- and variant-level QC
- part2: prepares files in the correct format for upload to imputation server. 

___

Sample-level QC includes:

**STEP 1  :** SAMPLE-LEVEL FILTERING (HETEROZYGOSITY, CALL RATE, GENDER CHECK, ANCESTRY)

`STEP 1.1:` Sample-level filtering (Heterozygosity check, removal of het outliers)

`STEP 1.2:` Sample-level filtering (sample call rate check, maximum missing calls per sample --mind 0.05)

`STEP 1.3:` Sample-level filtering (Gender check, remove samples that failed gender check)

`STEP 1.4:` Sample-level filtering (Ancestry check, remove samples that are not european)

`STEP 1.5:` Generate list of duplicates; remove duplicates

`STEP 1.6:` Generate list of related samples

___

Variant-level QC includes:

**STEP 2  :** VARIANT-LEVEL FILTERING (Variant inclusion criteria to account for genotyping batch differences; then make final bfiles with --geno 0.05)

`STEP 2.1:` Case/control nonrandom missingness test \(i.e. exclude SNPs with P \< 1E-4\)

`STEP 2.2:` Haplotype-based test for non-random missing genotype data \(i.e. exclude SNPs with P \< 1E-4\)

`STEP 2.3:` Make list of varaints that failed HWE \(controls\) \(i.e. exclude SNPs with midP \< 1E-10\)

`STEP 2.4:` Final --geno 0.05 to account for final variant missingness


### Run QC part1


```bash
%%bash
echo "sh ./scripts/QC_preimputation_v2_keepRelated_part1of2.mg.sh merged1 US_mg chiarp@mail.nih.gov" > qc1.swarm

swarm --file qc1.swarm --gres=lscratch:200 --logdir swarmOE_qc --partition quick \
-g 64 -t auto --time 4:00:00 --sbatch "--mail-type=BEGIN,FAIL,TIME_LIMIT_80"
```

### Create 'CLEAN' genotype files from QC (step1) files

1. without duplicates, keepRelated
2. without duplicates, UNRELATED

#### without duplicates, keepRelated

**Notes:**
Previously submitted job for imputation but 275 samples failed imputation QC. made the list of 'bad samples' from statistic report generated and used this list remove bad samples and generated a set of 'good samples'. 
List was created locally on my computer using find and replace to remove unwanted texts and copied to working directory on biowulf. File is: `/data/chiarp/MG_GWAS/Discovery_US_keepRelated/badSamples_failedImputationQC_toRemove.txt`



```bash
%%bash
# Copy scripts folder and 'badSamples' list to here
cp -r /data/NDRS_LNG/ALS_imputationHG19_withChrX_2020/scripts .
cp /data/chiarp/MG_GWAS/Discovery_US_keepRelated/badSamples_failedImputationQC_toRemove.txt .
```


```bash
%%bash
module load plink/1.9.0-beta4.4

mkdir CLEAN.rawGenotype.keepRelated

plink \
--bfile FILTERED.US_mg_keepRelated \
--remove badSamples_failedImputationQC_toRemove.txt \
--allow-no-sex \
--keep-allele-order \
--make-bed \
--out CLEAN.rawGenotype.keepRelated/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005

```

#### without duplicates, UNRELATED


```bash
%%bash
module load plink/1.9.0-beta4.4

mkdir CLEAN.rawGenotype.UNRELATED

plink \
--bfile CLEAN.rawGenotype.keepRelated/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005 \
--remove FILTERED.to.remove.GRM_matrix.noDups.relatedSamples_FIDspaceIID.txt \
--extract hwe/Vars.passhwecontrols1e-10.geno005.snplist \
--keep-allele-order \
--allow-no-sex \
--make-bed \
--out CLEAN.rawGenotype.UNRELATED/FILTERED.US_mg_noDups.UNRELATED.hwe1e-10.geno005

```

### Run QC part 2


```bash
%%bash
cp CLEAN.rawGenotype.keepRelated/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005.* .

chmod u+x ./scripts/QC_preimputation_v2_keepRelated_part2of2.sh

echo "./scripts/QC_preimputation_v2_keepRelated_part2of2.sh FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005 chiarp@mail.nih.gov" > QC_preimputation_part2.swarm
swarm --file QC_preimputation_part2.swarm --gres=lscratch:200 \
--module plink,R -g 32 --time 24:00:00 -t auto \
--sbatch "--mail-type=BEGIN,FAIL,END,TIME_LIMIT_80"
```


```bash
%%bash
# Remove some intermediate files that are not needed to save some space
rm FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005-chr*.check.*
rm FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005X.*
rm FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005[0-9].*
rm FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005[0-9][0-9].*
rm FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005-updated-chr*.*
rm *-FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005-HRC.txt
rm Run-plink.sh
rm FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005.*
```

## Generate PCs (with genotype data) -->  create covariate file

**To create covariate files for:**
1. `RELATED+UNRELATED` samples 
2. `UNRELATED samples only`

***Additional notes:***
Removed 464 dbGAP samples that cannot be included due to permission issues. 



```bash
%%bash

DATA="/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US"

grep "phs000372" $DATA/CLEAN.rawGenotype.keepRelated/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005.fam | awk '{print $1,$2}' > $DATA/SamplesToRemove.dbGAP.FIDspaceIID.txt
grep "phs000397-4433" $DATA/CLEAN.rawGenotype.keepRelated/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005.fam | awk '{print $1,$2}' >> $DATA/SamplesToRemove.dbGAP.FIDspaceIID.txt
grep "phs000428-13949" $DATA/CLEAN.rawGenotype.keepRelated/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005.fam | awk '{print $1,$2}' >> $DATA/SamplesToRemove.dbGAP.FIDspaceIID.txt

echo "Number of dbGAP samples to remove:"
wc -l $DATA/SamplesToRemove.dbGAP.FIDspaceIID.txt

head $DATA/SamplesToRemove.dbGAP.FIDspaceIID.txt | column -t
```

    Number of dbGAP samples to remove:
    464 /data/NDRS_LNG/MyastheniaGravis/updated.April2020/US/SamplesToRemove.dbGAP.FIDspaceIID.txt
    phs000372-0  phs000372-NACC001075
    phs000372-0  phs000372-NACC001628
    phs000372-0  phs000372-NACC002326
    phs000372-0  phs000372-NACC003397
    phs000372-0  phs000372-NACC010563
    phs000372-0  phs000372-NACC011643
    phs000372-0  phs000372-NACC013871
    phs000372-0  phs000372-NACC016407
    phs000372-0  phs000372-NACC017867
    phs000372-0  phs000372-NACC021590



```bash
%%bash
module load plink/1.9.0-beta4.4
module load R/3.5.2
module load GCTA/1.92.0beta3
module load flashpca/2.0

mkdir PCAcovs

# Prune snps
plink \
--bfile CLEAN.rawGenotype.keepRelated/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005 \
--remove /data/NDRS_LNG/MyastheniaGravis/updated.April2020/US/SamplesToRemove.dbGAP.FIDspaceIID.txt \
--allow-no-sex \
--maf 0.01 \
--geno 0.01 \
--hwe 5e-6 \
--autosome \
--exclude range ./scripts/exclusion_regions_hg19.txt \
--make-bed \
--out PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter \
--memory 119500 --threads 19

plink \
--bfile PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter \
--allow-no-sex \
--geno 0.01 \
--maf 0.05 \
--indep-pairwise 1000 10 0.02 \
--out PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter_pruning \
--memory 119500 --threads 19

# All samples (related + unrelated samples; no dups)
plink \
--bfile PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter \
--remove /data/NDRS_LNG/MyastheniaGravis/updated.April2020/US/SamplesToRemove.dbGAP.FIDspaceIID.txt \
--allow-no-sex \
--extract PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter_pruning.prune.in \
--keep-allele-order \
--make-bed \
--out PCAcovs/pruned.US_mg_noDups.keepRelated \
--memory 119500 --threads 19

# Unrelated samples only (no dups)
plink \
--bfile PCAcovs/pruned.US_mg_noDups.keepRelated \
--remove GRM/FILTERED.to.remove.GRM_matrix.noDups.relatedSamples_FIDspaceIID.txt \
--allow-no-sex \
--extract PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter_pruning.prune.in \
--keep-allele-order \
--make-bed \
--out PCAcovs/pruned.US_mg_noDups.UNRELATED \
--memory 119500 --threads 19;

# Calculate/generate PCs based on pruned data set
cd PCAcovs
flashpca --bfile pruned.US_mg_noDups.keepRelated -d 10 --suffix _US_mg_noDups.keepRelated_forPCA --numthreads 19
flashpca --bfile pruned.US_mg_noDups.UNRELATED -d 10 --suffix _US_mg_noDups.UNRELATED_forPCA --numthreads 19

# Move all log files to a new folder
mkdir logFiles
mv *.log logFiles

# Remove intermediate files
rm FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter.bed
rm FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter.bim
rm FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter.fam
rm FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter_pruning.prune.in
rm FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter_pruning.prune.out

```

    PLINK v1.90b4.4 64-bit (21 May 2017)           www.cog-genomics.org/plink/1.9/
    (C) 2005-2017 Shaun Purcell, Christopher Chang   GNU General Public License v3
    Logging to PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter.log.
    Options in effect:
      --allow-no-sex
      --autosome
      --bfile CLEAN.rawGenotype.keepRelated/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005
      --exclude range ./scripts/exclusion_regions_hg19.txt
      --geno 0.01
      --hwe 5e-6
      --maf 0.01
      --make-bed
      --memory 119500
      --out PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter
      --remove /data/NDRS_LNG/MyastheniaGravis/updated.April2020/US/SamplesToRemove.dbGAP.FIDspaceIID.txt
      --threads 19
    
    257653 MB RAM detected; reserving 119500 MB for main workspace.
    508747 out of 520854 variants loaded from .bim file.
    40733 people (13086 males, 27647 females) loaded from .fam.
    40733 phenotype values loaded from .fam.
    --exclude range: 6906 variants excluded.
    --exclude range: 501841 variants remaining.
    --remove: 40269 people remaining.
    Using 1 thread (no multithreaded calculations invoked).
    Before main variant filters, 40269 founders and 0 nonfounders present.
    Calculating allele frequencies... 0%1%2%3%4%5%6%7%8%9%10%11%12%13%14%15%16%17%18%19%20%21%22%23%24%25%26%27%28%29%30%31%32%33%34%35%36%37%38%39%40%41%42%43%44%45%46%47%48%49%50%51%52%53%54%55%56%57%58%59%60%61%62%63%64%65%66%67%68%69%70%71%72%73%74%75%76%77%78%79%80%81%82%83%84%85%86%87%88%89%90%91%92%93%94%95%96%97%98%99% done.
    Total genotyping rate in remaining samples is 0.998544.
    4892 variants removed due to missing genotype data (--geno).
    --hwe: 922 variants removed due to Hardy-Weinberg exact test.
    43907 variants removed due to minor allele threshold(s)
    (--maf/--max-maf/--mac/--max-mac).
    452120 variants and 40269 people pass filters and QC.
    Among remaining phenotypes, 968 are cases and 39301 are controls.
    --make-bed to
    PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter.bed +
    PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter.bim +
    PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter.fam ... 0%1%2%3%4%5%6%7%8%9%10%11%12%13%14%15%16%17%18%19%20%21%22%23%24%25%26%27%28%29%30%31%32%33%34%35%36%37%38%39%40%41%42%43%44%45%46%47%48%49%50%51%52%53%54%55%56%57%58%59%60%61%62%63%64%65%66%67%68%69%70%71%72%73%74%75%76%77%78%79%80%81%82%83%84%85%86%87%88%89%90%91%92%93%94%95%96%97%98%99%done.
    PLINK v1.90b4.4 64-bit (21 May 2017)           www.cog-genomics.org/plink/1.9/
    (C) 2005-2017 Shaun Purcell, Christopher Chang   GNU General Public License v3
    Logging to PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter_pruning.log.
    Options in effect:
      --allow-no-sex
      --bfile PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter
      --geno 0.01
      --indep-pairwise 1000 10 0.02
      --maf 0.05
      --memory 119500
      --out PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter_pruning
      --threads 19
    
    257653 MB RAM detected; reserving 119500 MB for main workspace.
    452120 variants loaded from .bim file.
    40269 people (12919 males, 27350 females) loaded from .fam.
    40269 phenotype values loaded from .fam.
    Using 1 thread (no multithreaded calculations invoked).
    Before main variant filters, 40269 founders and 0 nonfounders present.
    Calculating allele frequencies... 0%1%2%3%4%5%6%7%8%9%10%11%12%13%14%15%16%17%18%19%20%21%22%23%24%25%26%27%28%29%30%31%32%33%34%35%36%37%38%39%40%41%42%43%44%45%46%47%48%49%50%51%52%53%54%55%56%57%58%59%60%61%62%63%64%65%66%67%68%69%70%71%72%73%74%75%76%77%78%79%80%81%82%83%84%85%86%87%88%89%90%91%92%93%94%95%96%97%98%99% done.
    Total genotyping rate is 0.998655.
    0 variants removed due to missing genotype data (--geno).
    32508 variants removed due to minor allele threshold(s)
    (--maf/--max-maf/--mac/--max-mac).
    419612 variants and 40269 people pass filters and QC.
    Among remaining phenotypes, 968 are cases and 39301 are controls.
    Pruned 33587 variants from chromosome 1, leaving 1461.
    Pruned 33337 variants from chromosome 2, leaving 1358.
    Pruned 27972 variants from chromosome 3, leaving 1178.
    Pruned 22974 variants from chromosome 4, leaving 1092.
    Pruned 24462 variants from chromosome 5, leaving 1084.
    Pruned 23848 variants from chromosome 6, leaving 1014.
    Pruned 21769 variants from chromosome 7, leaving 961.
    Pruned 20785 variants from chromosome 8, leaving 864.
    Pruned 19096 variants from chromosome 9, leaving 834.
    Pruned 22446 variants from chromosome 10, leaving 927.
    Pruned 20550 variants from chromosome 11, leaving 870.
    Pruned 20591 variants from chromosome 12, leaving 880.
    Pruned 15585 variants from chromosome 13, leaving 666.
    Pruned 13593 variants from chromosome 14, leaving 624.
    Pruned 12813 variants from chromosome 15, leaving 634.
    Pruned 13233 variants from chromosome 16, leaving 688.
    Pruned 11599 variants from chromosome 17, leaving 665.
    Pruned 12530 variants from chromosome 18, leaving 623.
    Pruned 7671 variants from chromosome 19, leaving 578.
    Pruned 11096 variants from chromosome 20, leaving 576.
    Pruned 5935 variants from chromosome 21, leaving 333.
    Pruned 5869 variants from chromosome 22, leaving 361.
    Pruning complete.  401341 of 419612 variants removed.
    Marker lists written to
    PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter_pruning.prune.in
    and
    PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter_pruning.prune.out
    .
    PLINK v1.90b4.4 64-bit (21 May 2017)           www.cog-genomics.org/plink/1.9/
    (C) 2005-2017 Shaun Purcell, Christopher Chang   GNU General Public License v3
    Logging to PCAcovs/pruned.US_mg_noDups.keepRelated.log.
    Options in effect:
      --allow-no-sex
      --bfile PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter
      --extract PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter_pruning.prune.in
      --keep-allele-order
      --make-bed
      --memory 119500
      --out PCAcovs/pruned.US_mg_noDups.keepRelated
      --remove /data/NDRS_LNG/MyastheniaGravis/updated.April2020/US/SamplesToRemove.dbGAP.FIDspaceIID.txt
      --threads 19
    
    257653 MB RAM detected; reserving 119500 MB for main workspace.
    452120 variants loaded from .bim file.
    40269 people (12919 males, 27350 females) loaded from .fam.
    40269 phenotype values loaded from .fam.
    --extract: 18271 variants remaining.
    --remove: 40269 people remaining.
    Using 1 thread (no multithreaded calculations invoked).
    Before main variant filters, 40269 founders and 0 nonfounders present.
    Calculating allele frequencies... 0%1%2%3%4%5%6%7%8%9%10%11%12%13%14%15%16%17%18%19%20%21%22%23%24%25%26%27%28%29%30%31%32%33%34%35%36%37%38%39%40%41%42%43%44%45%46%47%48%49%50%51%52%53%54%55%56%57%58%59%60%61%62%63%64%65%66%67%68%69%70%71%72%73%74%75%76%77%78%79%80%81%82%83%84%85%86%87%88%89%90%91%92%93%94%95%96%97%98%99% done.
    Total genotyping rate is 0.998631.
    18271 variants and 40269 people pass filters and QC.
    Among remaining phenotypes, 968 are cases and 39301 are controls.
    --make-bed to PCAcovs/pruned.US_mg_noDups.keepRelated.bed +
    PCAcovs/pruned.US_mg_noDups.keepRelated.bim +
    PCAcovs/pruned.US_mg_noDups.keepRelated.fam ... 0%1%2%3%4%5%6%7%8%9%10%11%12%13%14%15%16%17%18%19%20%21%22%23%24%25%26%27%28%29%30%31%32%33%34%35%36%37%38%39%40%41%42%43%44%45%46%47%48%49%50%51%52%53%54%55%56%57%58%59%60%61%62%63%64%65%66%67%68%69%70%71%72%73%74%75%76%77%78%79%80%81%82%83%84%85%86%87%88%89%90%91%92%93%94%95%96%97%98%99%done.
    PLINK v1.90b4.4 64-bit (21 May 2017)           www.cog-genomics.org/plink/1.9/
    (C) 2005-2017 Shaun Purcell, Christopher Chang   GNU General Public License v3
    Logging to PCAcovs/pruned.US_mg_noDups.UNRELATED.log.
    Options in effect:
      --allow-no-sex
      --bfile PCAcovs/pruned.US_mg_noDups.keepRelated
      --extract PCAcovs/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005_filter_pruning.prune.in
      --keep-allele-order
      --make-bed
      --memory 119500
      --out PCAcovs/pruned.US_mg_noDups.UNRELATED
      --remove GRM/FILTERED.to.remove.GRM_matrix.noDups.relatedSamples_FIDspaceIID.txt
      --threads 19
    
    257653 MB RAM detected; reserving 119500 MB for main workspace.
    18271 variants loaded from .bim file.
    40269 people (12919 males, 27350 females) loaded from .fam.
    40269 phenotype values loaded from .fam.
    --extract: 18271 variants remaining.
    --remove: 36088 people remaining.
    Using 1 thread (no multithreaded calculations invoked).
    Before main variant filters, 36088 founders and 0 nonfounders present.
    Calculating allele frequencies... 0%1%2%3%4%5%6%7%8%9%10%11%12%13%14%15%16%17%18%19%20%21%22%23%24%25%26%27%28%29%30%31%32%33%34%35%36%37%38%39%40%41%42%43%44%45%46%47%48%49%50%51%52%53%54%55%56%57%58%59%60%61%62%63%64%65%66%67%68%69%70%71%72%73%74%75%76%77%78%79%80%81%82%83%84%85%86%87%88%89%90%91%92%93%94%95%96%97%98%99% done.
    Total genotyping rate in remaining samples is 0.998608.
    18271 variants and 36088 people pass filters and QC.
    Among remaining phenotypes, 964 are cases and 35124 are controls.
    --make-bed to PCAcovs/pruned.US_mg_noDups.UNRELATED.bed +
    PCAcovs/pruned.US_mg_noDups.UNRELATED.bim +
    PCAcovs/pruned.US_mg_noDups.UNRELATED.fam ... 0%1%2%3%4%5%6%7%8%9%10%11%12%13%14%15%16%17%18%19%20%21%22%23%24%25%26%27%28%29%30%31%32%33%34%35%36%37%38%39%40%41%42%43%44%45%46%47%48%49%50%51%52%53%54%55%56%57%58%59%60%61%62%63%64%65%66%67%68%69%70%71%72%73%74%75%76%77%78%79%80%81%82%83%84%85%86%87%88%89%90%91%92%93%94%95%96%97%98%99%done.
    [Thu Mar  4 23:16:32 2021] arguments: flashpca flashpca --bfile pruned.US_mg_noDups.keepRelated -d 10 --suffix _US_mg_noDups.keepRelated_forPCA --numthreads 19 
    [Thu Mar  4 23:16:32 2021] Start flashpca (version 2.0)
    [Thu Mar  4 23:16:32 2021] seed: 1
    [Thu Mar  4 23:16:32 2021] blocksize: 6616 (2131357632 bytes per block)
    [Thu Mar  4 23:16:32 2021] PCA begin
    [Thu Mar  4 23:19:52 2021] PCA done
    [Thu Mar  4 23:19:52 2021] Writing 10 eigenvalues to file eigenvalues_US_mg_noDups.keepRelated_forPCA
    [Thu Mar  4 23:19:52 2021] Writing 10 eigenvectors to file eigenvectors_US_mg_noDups.keepRelated_forPCA
    [Thu Mar  4 23:19:52 2021] Writing 10 PCs to file pcs_US_mg_noDups.keepRelated_forPCA
    [Thu Mar  4 23:19:52 2021] Writing 10 proportion variance explained to file pve_US_mg_noDups.keepRelated_forPCA
    [Thu Mar  4 23:19:53 2021] Goodbye!
    [Thu Mar  4 23:19:53 2021] arguments: flashpca flashpca --bfile pruned.US_mg_noDups.UNRELATED -d 10 --suffix _US_mg_noDups.UNRELATED_forPCA --numthreads 19 
    [Thu Mar  4 23:19:53 2021] Start flashpca (version 2.0)
    [Thu Mar  4 23:19:53 2021] seed: 1
    [Thu Mar  4 23:19:53 2021] blocksize: 7386 (2132367744 bytes per block)
    [Thu Mar  4 23:19:53 2021] PCA begin
    [Thu Mar  4 23:33:40 2021] PCA done
    [Thu Mar  4 23:33:40 2021] Writing 10 eigenvalues to file eigenvalues_US_mg_noDups.UNRELATED_forPCA
    [Thu Mar  4 23:33:40 2021] Writing 10 eigenvectors to file eigenvectors_US_mg_noDups.UNRELATED_forPCA
    [Thu Mar  4 23:33:41 2021] Writing 10 PCs to file pcs_US_mg_noDups.UNRELATED_forPCA
    [Thu Mar  4 23:33:41 2021] Writing 10 proportion variance explained to file pve_US_mg_noDups.UNRELATED_forPCA
    [Thu Mar  4 23:33:41 2021] Goodbye!


    [-] Unloading plink  1.9.0-beta4.4  on cn2968 
    [+] Loading plink  1.9.0-beta4.4  on cn2968 
    [-] Unloading gcc  9.2.0  ... 
    [-] Unloading GSL 2.6 for GCC 9.2.0 ... 
    [-] Unloading openmpi 3.1.4  for GCC 9.2.0 
    [-] Unloading ImageMagick  7.0.8  on cn2968 
    [-] Unloading HDF5  1.10.4 
    [-] Unloading NetCDF 4.7.4_gcc9.2.0 
    [-] Unloading pandoc  2.11.4  on cn2968 
    [-] Unloading pcre2 10.21  ... 
    [-] Unloading R 4.0.3 
    [+] Loading gcc  7.3.0  ... 
    [+] Loading GSL 2.4 for GCC 7.2.0 ... 
    [-] Unloading gcc  7.3.0  ... 
    [+] Loading gcc  7.3.0  ... 
    [+] Loading openmpi 3.0.2  for GCC 7.3.0 
    [+] Loading ImageMagick  7.0.8  on cn2968 
    [+] Loading HDF5  1.10.4 
    [+] Loading pandoc  2.11.4  on cn2968 
    [+] Loading R 3.5.2 
    
    The following have been reloaded with a version change:
      1) GSL/2.6_gcc-9.2.0 => GSL/2.4_gcc-7.2.0     3) gcc/9.2.0 => gcc/7.3.0
      2) R/4.0 => R/3.5.2
    
    [+] Loading GCTA  1.92.0beta3 
    [-] Unloading flashpca  2.0  on cn2968 
    [+] Loading flashpca  2.0  on cn2968 


Create covariate file

Phenotype file as input for here: `/data/chiarp/MG_GWAS/Discovery_US_keepRelated/phenoINFO_forPCAcovs.txt`. Then subset to only keep samples that made it to the 'CLEAN' plink1 files.


```bash
%%bash

module load R/3.5.2
R --vanilla --no-save

# Load libraries
require(data.table)
require(tidyverse)


# UNRELATED samples only (no dups)
## Read in files
pc <- fread("PCAcovs/pcs_US_mg_noDups.UNRELATED_forPCA", header=T)
fam <- fread("PCAcovs/pruned.US_mg_noDups.UNRELATED.fam", header=F)
fam <- fam %>% rename(FID = V1, IID = V2, MAT = V3, PAT = V4, SEX = V5, PHENO= V6)
pheno <- fread("/data/chiarp/MG_GWAS/Discovery_US_keepRelated/phenoINFO_forPCAcovs.txt", header=T)
pheno <- pheno %>% rename(genderONFILE = gender)

dim(pc)
dim(fam)
dim(pheno)

## Merge pc, fam and pheno files. 
## Also create additional column so that the sample ID matches the format in the dose.vcf.gz (i.e. FID_IID)
data1 <- merge(fam,pheno,by="IID")
data2 <- merge(data1, pc, by=c("FID","IID"))
data2$GENDER <- data2$SEX - 1
data2$genderONFILE[is.na(data2$genderONFILE)] <- "NA"
data2$FID_IID <- paste(data2$FID,data2$IID, sep="_")
data2$age_at_onset <- as.numeric(data2$age_at_onset)

dim(data2)
write.table(data2, "COVARIATES.US_mg_noDups.UNRELATED.txt", sep="\t",quote=F, col.names=T,row.names=F)

data3 <- data2 %>%
         mutate(FID = FID_IID,
                IID = FID_IID) %>%
         select(-FID_IID)
dim(data3)
head(data3)
write.table(data3, "COVARIATES.US_mg_noDups.UNRELATED.forImputed.txt", sep="\t",quote=F, col.names=T,row.names=F)        

## Summarise numbers by pheno or diagnosis and gender or sex
## Note that there is a mismatch of gender from pheno file compared to the actual SEX information in the plink file. 
## But since these samples survived gender check. 
## Decided to stick with information in the .fam file
table(data2$PHENO, data2$SEX)
table(data2$diagnosis, data2$SEX)
table(data2$diagnosis, data2$genderONFILE)
table(data2$diagnosis, data2$GENDER)

head(data2)

## Run step() to determine which covariate to correct for for association analysis
data2$CASE <- data2$PHENO - 1
unrelated <- glm(CASE ~ GENDER + age_at_onset + PC1 + PC2 + PC3 + PC4 + PC5 + PC6 + PC7 + PC8 + PC9 + PC10 , data = data2, family = "binomial"(link = "logit"))
summary(unrelated)
step(unrelated)

```

    
    R version 3.5.2 (2018-12-20) -- "Eggshell Igloo"
    Copyright (C) 2018 The R Foundation for Statistical Computing
    Platform: x86_64-pc-linux-gnu (64-bit)
    
    R is free software and comes with ABSOLUTELY NO WARRANTY.
    You are welcome to redistribute it under certain conditions.
    Type 'license()' or 'licence()' for distribution details.
    
    R is a collaborative project with many contributors.
    Type 'contributors()' for more information and
    'citation()' on how to cite R or R packages in publications.
    
    Type 'demo()' for some demos, 'help()' for on-line help, or
    'help.start()' for an HTML browser interface to help.
    Type 'q()' to quit R.
    
    > 
    > # Load libraries
    > require(data.table)
    > require(tidyverse)
    > 
    > 
    > # UNRELATED samples only (no dups)
    > ## Read in files
    > pc <- fread("PCAcovs/pcs_US_mg_noDups.UNRELATED_forPCA", header=T)
    > fam <- fread("PCAcovs/pruned.US_mg_noDups.UNRELATED.fam", header=F)
    > fam <- fam %>% rename(FID = V1, IID = V2, MAT = V3, PAT = V4, SEX = V5, PHENO= V6)
    > pheno <- fread("/data/chiarp/MG_GWAS/Discovery_US_keepRelated/phenoINFO_forPCAcovs.txt", header=T)
    > pheno <- pheno %>% rename(genderONFILE = gender)
    > 
    > dim(pc)
    [1] 36088    12
    > dim(fam)
    [1] 36088     6
    > dim(pheno)
    [1] 45107     4
    > 
    > ## Merge pc, fam and pheno files. 
    > ## Also create additional column so that the sample ID matches the format in the dose.vcf.gz (i.e. FID_IID)
    > data1 <- merge(fam,pheno,by="IID")
    > data2 <- merge(data1, pc, by=c("FID","IID"))
    > data2$GENDER <- data2$SEX - 1
    > data2$genderONFILE[is.na(data2$genderONFILE)] <- "NA"
    > data2$FID_IID <- paste(data2$FID,data2$IID, sep="_")
    > data2$age_at_onset <- as.numeric(data2$age_at_onset)
    > 
    > dim(data2)
    [1] 36088    21
    > #write.table(data2, "COVARIATES.US_mg_noDups.UNRELATED.txt", sep="\t",quote=F, col.names=T,row.names=F)
    > 
    > data3 <- data2 %>%
    +          mutate(FID = FID_IID,
    +                 IID = FID_IID) %>%
    +          select(-FID_IID)
    > dim(data3)
    [1] 36088    20
    > head(data3)
                  FID             IID MAT PAT SEX PHENO diagnosis genderONFILE
    1 BRC1058_BRC1058 BRC1058_BRC1058   0   0   1     1   control            0
    2   BRC618_BRC618   BRC618_BRC618   0   0   1     1   control            0
    3   BRC706_BRC706   BRC706_BRC706   0   0   2     1   control            1
    4   BRC710_BRC710   BRC710_BRC710   0   0   1     1   control            0
    5   BRC905_BRC905   BRC905_BRC905   0   0   1     1   control            0
    6   BRC991_BRC991   BRC991_BRC991   0   0   2     1   control            1
      age_at_onset          PC1          PC2           PC3          PC4
    1           70 -0.008753894 -0.008942471 -0.0005265611 -0.005780903
    2           21  0.004683084 -0.001838741  0.0181311300  0.005839165
    3           56  0.017012450 -0.005869365 -0.0076155020 -0.002113765
    4           62  0.007728595  0.013705830 -0.0070478520 -0.012808200
    5           72 -0.175320200  0.016046630  0.0763218500 -0.004372520
    6           35 -0.011514650  0.049522450 -0.0133695200  0.001673454
               PC5           PC6           PC7          PC8          PC9
    1 -0.004512923  0.0116358100  0.0032973190 -0.012263640  0.003986731
    2 -0.014278690  0.0312385300  0.0035149230 -0.011598180  0.006574303
    3 -0.001482595  0.0134148800 -0.0088170730  0.005291236 -0.022391430
    4 -0.007522605  0.0119805500  0.0113048200 -0.017552920 -0.009450363
    5 -0.007606517  0.0000122211  0.0209567700 -0.028167390  0.006911984
    6  0.004551437 -0.0013035370  0.0007596483 -0.014509600 -0.005563398
              PC10 GENDER
    1 -0.015868050      0
    2  0.013241020      0
    3 -0.006921480      1
    4 -0.004895789      0
    5  0.004399125      0
    6 -0.013608260      1
    > #write.table(data3, "COVARIATES.US_mg_noDups.UNRELATED.forImputed.txt", sep="\t",quote=F, col.names=T,row.names=F)        
    > 
    > ## Summarise numbers by pheno or diagnosis and gender or sex
    > ## Note that there is a mismatch of gender from pheno file compared to the actual SEX information in the plink file. 
    > ## But since these samples survived gender check. 
    > ## Decided to stick with information in the .fam file
    > table(data2$PHENO, data2$SEX)
       
            1     2
      1 10579 24545
      2   544   420
    > table(data2$diagnosis, data2$SEX)
             
                  1     2
      case      544   420
      control 10579 24545
    > table(data2$diagnosis, data2$genderONFILE)
             
                  0     1
      case      544   420
      control 10579 24545
    > table(data2$diagnosis, data2$GENDER)
             
                  0     1
      case      544   420
      control 10579 24545
    > 
    > head(data2)
           FID     IID MAT PAT SEX PHENO diagnosis genderONFILE age_at_onset
    1: BRC1058 BRC1058   0   0   1     1   control            0           70
    2:  BRC618  BRC618   0   0   1     1   control            0           21
    3:  BRC706  BRC706   0   0   2     1   control            1           56
    4:  BRC710  BRC710   0   0   1     1   control            0           62
    5:  BRC905  BRC905   0   0   1     1   control            0           72
    6:  BRC991  BRC991   0   0   2     1   control            1           35
                PC1          PC2           PC3          PC4          PC5
    1: -0.008753894 -0.008942471 -0.0005265611 -0.005780903 -0.004512923
    2:  0.004683084 -0.001838741  0.0181311300  0.005839165 -0.014278690
    3:  0.017012450 -0.005869365 -0.0076155020 -0.002113765 -0.001482595
    4:  0.007728595  0.013705830 -0.0070478520 -0.012808200 -0.007522605
    5: -0.175320200  0.016046630  0.0763218500 -0.004372520 -0.007606517
    6: -0.011514650  0.049522450 -0.0133695200  0.001673454  0.004551437
                 PC6           PC7          PC8          PC9         PC10 GENDER
    1:  0.0116358100  0.0032973190 -0.012263640  0.003986731 -0.015868050      0
    2:  0.0312385300  0.0035149230 -0.011598180  0.006574303  0.013241020      0
    3:  0.0134148800 -0.0088170730  0.005291236 -0.022391430 -0.006921480      1
    4:  0.0119805500  0.0113048200 -0.017552920 -0.009450363 -0.004895789      0
    5:  0.0000122211  0.0209567700 -0.028167390  0.006911984  0.004399125      0
    6: -0.0013035370  0.0007596483 -0.014509600 -0.005563398 -0.013608260      1
               FID_IID
    1: BRC1058_BRC1058
    2:   BRC618_BRC618
    3:   BRC706_BRC706
    4:   BRC710_BRC710
    5:   BRC905_BRC905
    6:   BRC991_BRC991
    > 
    > ## Run step() to determine which covariate to correct for for association analysis
    > data2$CASE <- data2$PHENO - 1
    > unrelated <- glm(CASE ~ GENDER + age_at_onset + PC1 + PC2 + PC3 + PC4 + PC5 + PC6 + PC7 + PC8 + PC9 + PC10 , data = data2, family = "binomial"(link = "logit"))
    > summary(unrelated)
    
    Call:
    glm(formula = CASE ~ GENDER + age_at_onset + PC1 + PC2 + PC3 + 
        PC4 + PC5 + PC6 + PC7 + PC8 + PC9 + PC10, family = binomial(link = "logit"), 
        data = data2)
    
    Deviance Residuals: 
        Min       1Q   Median       3Q      Max  
    -1.1940  -0.2497  -0.1728  -0.1329   3.4023  
    
    Coefficients:
                   Estimate Std. Error z value Pr(>|z|)    
    (Intercept)    0.086569   0.120174   0.720  0.47130    
    GENDER        -1.295215   0.067786 -19.107  < 2e-16 ***
    age_at_onset  -0.049581   0.001979 -25.053  < 2e-16 ***
    PC1            2.318830   0.842976   2.751  0.00595 ** 
    PC2           -8.185061   1.407405  -5.816 6.04e-09 ***
    PC3            1.946181   1.781616   1.092  0.27467    
    PC4            3.759608   1.978871   1.900  0.05745 .  
    PC5            5.523136   2.542336   2.172  0.02982 *  
    PC6           -7.179791   2.607688  -2.753  0.00590 ** 
    PC7            0.545631   2.607211   0.209  0.83423    
    PC8           -4.472572   2.615837  -1.710  0.08730 .  
    PC9           -7.353196   2.597336  -2.831  0.00464 ** 
    PC10         -11.594761   2.614139  -4.435 9.19e-06 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
    (Dispersion parameter for binomial family taken to be 1)
    
        Null deviance: 8822.2  on 34920  degrees of freedom
    Residual deviance: 7873.4  on 34908  degrees of freedom
      (1167 observations deleted due to missingness)
    AIC: 7899.4
    
    Number of Fisher Scoring iterations: 7
    
    > step(unrelated)
    Start:  AIC=7899.44
    CASE ~ GENDER + age_at_onset + PC1 + PC2 + PC3 + PC4 + PC5 + 
        PC6 + PC7 + PC8 + PC9 + PC10
    
                   Df Deviance    AIC
    - PC7           1   7873.5 7897.5
    - PC3           1   7874.6 7898.6
    <none>              7873.4 7899.4
    - PC8           1   7876.4 7900.4
    - PC4           1   7877.0 7901.0
    - PC5           1   7878.1 7902.1
    - PC6           1   7881.0 7905.0
    - PC9           1   7881.5 7905.5
    - PC1           1   7881.6 7905.6
    - PC10          1   7893.2 7917.2
    - PC2           1   7912.0 7936.0
    - GENDER        1   8238.8 8262.8
    - age_at_onset  1   8444.6 8468.6
    
    Step:  AIC=7897.49
    CASE ~ GENDER + age_at_onset + PC1 + PC2 + PC3 + PC4 + PC5 + 
        PC6 + PC8 + PC9 + PC10
    
                   Df Deviance    AIC
    - PC3           1   7874.7 7896.7
    <none>              7873.5 7897.5
    - PC8           1   7876.4 7898.4
    - PC4           1   7877.1 7899.1
    - PC5           1   7878.2 7900.2
    - PC6           1   7881.1 7903.1
    - PC9           1   7881.5 7903.5
    - PC1           1   7881.7 7903.7
    - PC10          1   7893.2 7915.2
    - PC2           1   7912.1 7934.1
    - GENDER        1   8238.8 8260.8
    - age_at_onset  1   8444.7 8466.7
    
    Step:  AIC=7896.68
    CASE ~ GENDER + age_at_onset + PC1 + PC2 + PC4 + PC5 + PC6 + 
        PC8 + PC9 + PC10
    
                   Df Deviance    AIC
    <none>              7874.7 7896.7
    - PC8           1   7877.6 7897.6
    - PC4           1   7878.3 7898.3
    - PC5           1   7879.0 7899.0
    - PC6           1   7882.2 7902.2
    - PC1           1   7882.7 7902.7
    - PC9           1   7882.8 7902.8
    - PC10          1   7894.4 7914.4
    - PC2           1   7913.7 7933.7
    - GENDER        1   8239.5 8259.5
    - age_at_onset  1   8445.3 8465.3
    
    Call:  glm(formula = CASE ~ GENDER + age_at_onset + PC1 + PC2 + PC4 + 
        PC5 + PC6 + PC8 + PC9 + PC10, family = binomial(link = "logit"), 
        data = data2)
    
    Coefficients:
     (Intercept)        GENDER  age_at_onset           PC1           PC2  
         0.08589      -1.29402      -0.04955       2.32264      -8.20819  
             PC4           PC5           PC6           PC8           PC9  
         3.77855       5.23643      -7.16125      -4.48210      -7.38956  
            PC10  
       -11.59624  
    
    Degrees of Freedom: 34920 Total (i.e. Null);  34910 Residual
      (1167 observations deleted due to missingness)
    Null Deviance:	    8822 
    Residual Deviance: 7875 	AIC: 7897
    > 


    [-] Unloading gcc  9.2.0  ... 
    [-] Unloading GSL 2.6 for GCC 9.2.0 ... 
    [-] Unloading openmpi 4.0.5  for GCC 9.2.0 
    [-] Unloading ImageMagick  7.0.8  on cn3454 
    [-] Unloading HDF5  1.10.4 
    [-] Unloading NetCDF 4.7.4_gcc9.2.0 
    [-] Unloading pandoc  2.13  on cn3454 
    [-] Unloading pcre2 10.21  ... 
    [-] Unloading R 4.0.5 
    [+] Loading gcc  7.3.0  ... 
    [+] Loading GSL 2.4 for GCC 7.2.0 ... 
    [-] Unloading gcc  7.3.0  ... 
    [+] Loading gcc  7.3.0  ... 
    [+] Loading openmpi 3.0.2  for GCC 7.3.0 
    [+] Loading ImageMagick  7.0.8  on cn3454 
    [+] Loading HDF5  1.10.4 
    [+] Loading pandoc  2.13  on cn3454 
    [+] Loading R 3.5.2 
    
    The following have been reloaded with a version change:
      1) GSL/2.6_gcc-9.2.0 => GSL/2.4_gcc-7.2.0     3) gcc/9.2.0 => gcc/7.3.0
      2) R/4.0 => R/3.5.2
    
    Loading required package: data.table
    Loading required package: tidyverse
    -- Attaching packages --------------------------------------- tidyverse 1.2.1 --
    v ggplot2 3.3.2     v purrr   0.3.4
    v tibble  3.0.3     v dplyr   0.8.5
    v tidyr   0.8.3     v stringr 1.4.0
    v readr   1.3.1     v forcats 0.5.0
    -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    x dplyr::between()   masks data.table::between()
    x dplyr::filter()    masks stats::filter()
    x dplyr::first()     masks data.table::first()
    x dplyr::lag()       masks stats::lag()
    x dplyr::last()      masks data.table::last()
    x purrr::transpose() masks data.table::transpose()


#### Results from step(); covariates to adjust for

UNRELATED samples only (no dups):
- Lowest AIC = `7896.68`
- Covariates to adjust for: `GENDER,age_at_onset,PC1,PC2,PC4,PC5,PC6,PC8,PC9,PC10`



```bash
%%bash
# Plot PCs to check to make sure cases and controls are not clustering out
module load R/3.5.2
Rscript ./scripts/PCplots_MG.GWAS.updated.R COVARIATES.US_mg_noDups.keepRelated.txt PCplots_US_mg_noDups.keepRelated
Rscript ./scripts/PCplots_MG.GWAS.updated.R COVARIATES.US_mg_noDups.UNRELATED.txt PCplots_US_mg_noDups.UNRELATED
```

    [-] Unloading gcc  9.2.0  ... 
    [-] Unloading GSL 2.6 for GCC 9.2.0 ... 
    [-] Unloading openmpi 3.1.4  for GCC 9.2.0 
    [-] Unloading ImageMagick  7.0.8  on cn2968 
    [-] Unloading HDF5  1.10.4 
    [-] Unloading NetCDF 4.7.4_gcc9.2.0 
    [-] Unloading pandoc  2.11.4  on cn2968 
    [-] Unloading pcre2 10.21  ... 
    [-] Unloading R 4.0.3 
    [+] Loading gcc  7.3.0  ... 
    [+] Loading GSL 2.4 for GCC 7.2.0 ... 
    [-] Unloading gcc  7.3.0  ... 
    [+] Loading gcc  7.3.0  ... 
    [+] Loading openmpi 3.0.2  for GCC 7.3.0 
    [+] Loading ImageMagick  7.0.8  on cn2968 
    [+] Loading HDF5  1.10.4 
    [+] Loading pandoc  2.11.4  on cn2968 
    [+] Loading R 3.5.2 
    
    The following have been reloaded with a version change:
      1) GSL/2.6_gcc-9.2.0 => GSL/2.4_gcc-7.2.0     3) gcc/9.2.0 => gcc/7.3.0
      2) R/4.0 => R/3.5.2
    
    Loading required package: data.table
    Loading required package: tidyverse
    -- Attaching packages --------------------------------------- tidyverse 1.2.1 --
    v ggplot2 3.3.2     v purrr   0.3.4
    v tibble  3.0.3     v dplyr   0.8.5
    v tidyr   0.8.3     v stringr 1.4.0
    v readr   1.3.1     v forcats 0.5.0
    -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    x dplyr::between()   masks data.table::between()
    x dplyr::filter()    masks stats::filter()
    x dplyr::first()     masks data.table::first()
    x dplyr::lag()       masks stats::lag()
    x dplyr::last()      masks data.table::last()
    x purrr::transpose() masks data.table::transpose()
    
    Attaching package: 'gridExtra'
    
    The following object is masked from 'package:dplyr':
    
        combine
    
    There were 42 warnings (use warnings() to see them)
    Loading required package: data.table
    Loading required package: tidyverse
    -- Attaching packages --------------------------------------- tidyverse 1.2.1 --
    v ggplot2 3.3.2     v purrr   0.3.4
    v tibble  3.0.3     v dplyr   0.8.5
    v tidyr   0.8.3     v stringr 1.4.0
    v readr   1.3.1     v forcats 0.5.0
    -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    x dplyr::between()   masks data.table::between()
    x dplyr::filter()    masks stats::filter()
    x dplyr::first()     masks data.table::first()
    x dplyr::lag()       masks stats::lag()
    x dplyr::last()      masks data.table::last()
    x purrr::transpose() masks data.table::transpose()
    
    Attaching package: 'gridExtra'
    
    The following object is masked from 'package:dplyr':
    
        combine
    


#### PC plots for cases and controls


```python
from IPython.display import display
from PIL import Image

print("PC plots for samples and cases (UNRELATED samples only)")
PCplot="PCplots_US_mg_noDups.UNRELATED_prunedSNPs_hwe5e-6.geno001.maf001.jpg"
display(Image.open(PCplot))
```

    PC plots for samples and cases (UNRELATED samples only)



![png](output_23_1.png)


## Subset data set to two equal parts stratified by PC, age and sex for hg38 imputation on Topmed Imputation Server



```bash
%%bash
module load R/3.5.2
R --vanilla --no-save

# Load libraries
require(data.table)
require(tidyverse)

# read in covariate file with PC, age and sex info
data <- fread("COVARIATES.US_mg_noDups.keepRelated.txt",header=T)
data$age_at_onset[is.na(data$age_at_onset)] <- "NA"

tags <- c("Age.bin0","Age.bin1","Age.bin2","Age.bin3", "Age.bin4", "Age.bin5", "Age.bin6", "Age.bin7", "Age.bin8","Age.bin9")
vgroup <- as_tibble(data) %>%
mutate(tag = case_when(
age_at_onset == "NA" ~ tags[1],
age_at_onset <= 20 ~ tags[2],
age_at_onset > 20 & age_at_onset <= 30 ~ tags[3],
age_at_onset > 30 & age_at_onset <= 40 ~ tags[4],
age_at_onset > 40 & age_at_onset <= 50 ~ tags[5],
age_at_onset > 50 & age_at_onset <= 60 ~ tags[6],
age_at_onset > 60 & age_at_onset <= 70 ~ tags[7],
age_at_onset > 70 & age_at_onset <= 80 ~ tags[8],
age_at_onset > 80 & age_at_onset <= 90 ~ tags[9],
age_at_onset > 90 ~ tags[10]
))

# subset to gender and pheno groups
female.cases <- data.frame(subset(vgroup, vgroup$SEX == "2" & vgroup$PHENO == "2"))
female.controls <- data.frame(subset(vgroup, vgroup$SEX == "2" & vgroup$PHENO == "1"))

male.cases <- data.frame(subset(vgroup, vgroup$SEX == "1" & vgroup$PHENO == "2"))
male.controls <- data.frame(subset(vgroup, vgroup$SEX == "1" & vgroup$PHENO == "1"))


## Female cases
datalist = list()
for (i in 1:dim(table(female.cases$tag)))
{
temp1 <- subset(female.cases, female.cases$tag == names(table(female.cases$tag)[i]))
pc1.center <- mean(temp1$PC1)
pc2.center <- mean(temp1$PC2)
temp1$dist.toCenter <- sqrt((temp1$PC1-pc1.center)^2 + (temp1$PC2-pc2.center)^2)
temp1 <- temp1 %>% arrange(dist.toCenter)
temp1$group <- factor(rep(1:2, length.out = nrow(temp1)))
datalist[[i]] <- temp1
}
female.cases2 = do.call(rbind, datalist)


## Female controls
datalist = list()
for (i in 1:dim(table(female.controls$tag)))
{
temp1 <- subset(female.controls, female.controls$tag == names(table(female.controls$tag)[i]))
pc1.center <- mean(temp1$PC1)
pc2.center <- mean(temp1$PC2)
temp1$dist.toCenter <- sqrt((temp1$PC1-pc1.center)^2 + (temp1$PC2-pc2.center)^2)
temp1 <- temp1 %>% arrange(dist.toCenter)
temp1$group <- factor(rep(1:2, length.out = nrow(temp1)))
datalist[[i]] <- temp1
}
female.controls2 = do.call(rbind, datalist)

## Female cases
datalist = list()
for (i in 1:dim(table(male.cases$tag)))
{
temp1 <- subset(male.cases, male.cases$tag == names(table(male.cases$tag)[i]))
pc1.center <- mean(temp1$PC1)
pc2.center <- mean(temp1$PC2)
temp1$dist.toCenter <- sqrt((temp1$PC1-pc1.center)^2 + (temp1$PC2-pc2.center)^2)
temp1 <- temp1 %>% arrange(dist.toCenter)
temp1$group <- factor(rep(1:2, length.out = nrow(temp1)))
datalist[[i]] <- temp1
}
male.cases2 = do.call(rbind, datalist)


## Female controls
datalist = list()
for (i in 1:dim(table(male.controls$tag)))
{
temp1 <- subset(male.controls, male.controls$tag == names(table(male.controls$tag)[i]))
pc1.center <- mean(temp1$PC1)
pc2.center <- mean(temp1$PC2)
temp1$dist.toCenter <- sqrt((temp1$PC1-pc1.center)^2 + (temp1$PC2-pc2.center)^2)
temp1 <- temp1 %>% arrange(dist.toCenter)
temp1$group <- factor(rep(1:2, length.out = nrow(temp1)))
datalist[[i]] <- temp1
}
male.controls2 = do.call(rbind, datalist)


# Merge subsets abck to single data frame and split by 'Set'
data0 <- rbind(female.cases2,female.controls2,male.cases2,male.controls2)
Set1 <- subset(data0, data0$group == "1")
Set2 <- subset(data0, data0$group == "2")

table(Set1$SEX,Set1$PHENO)
table(Set2$SEX,Set2$PHENO)

table(Set1$tag,Set1$PHENO)
table(Set2$tag,Set2$PHENO)

table(Set1$tag,Set1$SEX)
table(Set2$tag,Set2$SEX)

write.table(Set1,"US_mg_noDups.keepRelated.subset1.txt", sep="\t",quote=F,row.names=F,col.names=T)
write.table(Set2,"US_mg_noDups.keepRelated.subset2.txt", sep="\t",quote=F,row.names=F,col.names=T)

write.table(Set1[,c("FID","IID")],"US_mg_noDups.keepRelated.subset1.FIDspaceIID.txt", sep=" ",quote=F,row.names=F,col.names=T)
write.table(Set2[,c("FID","IID")],"US_mg_noDups.keepRelated.subset2.FIDspaceIID.txt", sep=" ",quote=F,row.names=F,col.names=T)

```

    
    R version 3.5.2 (2018-12-20) -- "Eggshell Igloo"
    Copyright (C) 2018 The R Foundation for Statistical Computing
    Platform: x86_64-pc-linux-gnu (64-bit)
    
    R is free software and comes with ABSOLUTELY NO WARRANTY.
    You are welcome to redistribute it under certain conditions.
    Type 'license()' or 'licence()' for distribution details.
    
    R is a collaborative project with many contributors.
    Type 'contributors()' for more information and
    'citation()' on how to cite R or R packages in publications.
    
    Type 'demo()' for some demos, 'help()' for on-line help, or
    'help.start()' for an HTML browser interface to help.
    Type 'q()' to quit R.
    
    > 
    > # Load libraries
    > require(data.table)
    > require(tidyverse)
    > 
    > # read in covariate file with PC, age and sex info
    > data <- fread("COVARIATES.US_mg_noDups.keepRelated.txt",header=T)
    > data$age_at_onset[is.na(data$age_at_onset)] <- "NA"
    > 
    > tags <- c("Age.bin0","Age.bin1","Age.bin2","Age.bin3", "Age.bin4", "Age.bin5", "Age.bin6", "Age.bin7", "Age.bin8","Age.bin9")
    > vgroup <- as_tibble(data) %>%
    + mutate(tag = case_when(
    + age_at_onset == "NA" ~ tags[1],
    + age_at_onset <= 20 ~ tags[2],
    + age_at_onset > 20 & age_at_onset <= 30 ~ tags[3],
    + age_at_onset > 30 & age_at_onset <= 40 ~ tags[4],
    + age_at_onset > 40 & age_at_onset <= 50 ~ tags[5],
    + age_at_onset > 50 & age_at_onset <= 60 ~ tags[6],
    + age_at_onset > 60 & age_at_onset <= 70 ~ tags[7],
    + age_at_onset > 70 & age_at_onset <= 80 ~ tags[8],
    + age_at_onset > 80 & age_at_onset <= 90 ~ tags[9],
    + age_at_onset > 90 ~ tags[10]
    + ))
    > 
    > # subset to gender and pheno groups
    > female.cases <- data.frame(subset(vgroup, vgroup$SEX == "2" & vgroup$PHENO == "2"))
    > female.controls <- data.frame(subset(vgroup, vgroup$SEX == "2" & vgroup$PHENO == "1"))
    > 
    > male.cases <- data.frame(subset(vgroup, vgroup$SEX == "1" & vgroup$PHENO == "2"))
    > male.controls <- data.frame(subset(vgroup, vgroup$SEX == "1" & vgroup$PHENO == "1"))
    > 
    > 
    > ## Female cases
    > datalist = list()
    > for (i in 1:dim(table(female.cases$tag)))
    + {
    + temp1 <- subset(female.cases, female.cases$tag == names(table(female.cases$tag)[i]))
    + pc1.center <- mean(temp1$PC1)
    + pc2.center <- mean(temp1$PC2)
    + temp1$dist.toCenter <- sqrt((temp1$PC1-pc1.center)^2 + (temp1$PC2-pc2.center)^2)
    + temp1 <- temp1 %>% arrange(dist.toCenter)
    + temp1$group <- factor(rep(1:2, length.out = nrow(temp1)))
    + datalist[[i]] <- temp1
    + }
    > female.cases2 = do.call(rbind, datalist)
    > 
    > 
    > ## Female controls
    > datalist = list()
    > for (i in 1:dim(table(female.controls$tag)))
    + {
    + temp1 <- subset(female.controls, female.controls$tag == names(table(female.controls$tag)[i]))
    + pc1.center <- mean(temp1$PC1)
    + pc2.center <- mean(temp1$PC2)
    + temp1$dist.toCenter <- sqrt((temp1$PC1-pc1.center)^2 + (temp1$PC2-pc2.center)^2)
    + temp1 <- temp1 %>% arrange(dist.toCenter)
    + temp1$group <- factor(rep(1:2, length.out = nrow(temp1)))
    + datalist[[i]] <- temp1
    + }
    > female.controls2 = do.call(rbind, datalist)
    > 
    > ## Female cases
    > datalist = list()
    > for (i in 1:dim(table(male.cases$tag)))
    + {
    + temp1 <- subset(male.cases, male.cases$tag == names(table(male.cases$tag)[i]))
    + pc1.center <- mean(temp1$PC1)
    + pc2.center <- mean(temp1$PC2)
    + temp1$dist.toCenter <- sqrt((temp1$PC1-pc1.center)^2 + (temp1$PC2-pc2.center)^2)
    + temp1 <- temp1 %>% arrange(dist.toCenter)
    + temp1$group <- factor(rep(1:2, length.out = nrow(temp1)))
    + datalist[[i]] <- temp1
    + }
    > male.cases2 = do.call(rbind, datalist)
    > 
    > 
    > ## Female controls
    > datalist = list()
    > for (i in 1:dim(table(male.controls$tag)))
    + {
    + temp1 <- subset(male.controls, male.controls$tag == names(table(male.controls$tag)[i]))
    + pc1.center <- mean(temp1$PC1)
    + pc2.center <- mean(temp1$PC2)
    + temp1$dist.toCenter <- sqrt((temp1$PC1-pc1.center)^2 + (temp1$PC2-pc2.center)^2)
    + temp1 <- temp1 %>% arrange(dist.toCenter)
    + temp1$group <- factor(rep(1:2, length.out = nrow(temp1)))
    + datalist[[i]] <- temp1
    + }
    > male.controls2 = do.call(rbind, datalist)
    > 
    > 
    > # Merge subsets abck to single data frame and split by 'Set'
    > data0 <- rbind(female.cases2,female.controls2,male.cases2,male.controls2)
    > Set1 <- subset(data0, data0$group == "1")
    > Set2 <- subset(data0, data0$group == "2")
    > 
    > table(Set1$SEX,Set1$PHENO)
       
            1     2
      1  6273   275
      2 13614   213
    > table(Set2$SEX,Set2$PHENO)
       
            1     2
      1  6267   271
      2 13611   209
    > 
    > table(Set1$tag,Set1$PHENO)
              
                  1    2
      Age.bin0  600    0
      Age.bin1  231   40
      Age.bin2  575   43
      Age.bin3  559   41
      Age.bin4  952   46
      Age.bin5 3551   96
      Age.bin6 6507  122
      Age.bin7 4584   82
      Age.bin8 2212   18
      Age.bin9  116    0
    > table(Set2$tag,Set2$PHENO)
              
                  1    2
      Age.bin0  599    0
      Age.bin1  230   39
      Age.bin2  574   42
      Age.bin3  558   41
      Age.bin4  951   44
      Age.bin5 3550   95
      Age.bin6 6507  121
      Age.bin7 4583   81
      Age.bin8 2210   17
      Age.bin9  116    0
    > 
    > table(Set1$tag,Set1$SEX)
              
                  1    2
      Age.bin0  399  201
      Age.bin1   99  172
      Age.bin2  134  484
      Age.bin3  132  468
      Age.bin4  340  658
      Age.bin5 1155 2492
      Age.bin6 1847 4782
      Age.bin7 1447 3219
      Age.bin8  952 1278
      Age.bin9   43   73
    > table(Set2$tag,Set2$SEX)
              
                  1    2
      Age.bin0  398  201
      Age.bin1   97  172
      Age.bin2  133  483
      Age.bin3  131  468
      Age.bin4  339  656
      Age.bin5 1154 2491
      Age.bin6 1847 4781
      Age.bin7 1446 3218
      Age.bin8  950 1277
      Age.bin9   43   73
    > 
    > write.table(Set1,"US_mg_noDups.keepRelated.subset1.txt", sep="\t",quote=F,row.names=F,col.names=T)
    > write.table(Set2,"US_mg_noDups.keepRelated.subset2.txt", sep="\t",quote=F,row.names=F,col.names=T)
    > 
    > write.table(Set1[,c("FID","IID")],"US_mg_noDups.keepRelated.subset1.FIDspaceIID.txt", sep=" ",quote=F,row.names=F,col.names=T)
    > write.table(Set2[,c("FID","IID")],"US_mg_noDups.keepRelated.subset2.FIDspaceIID.txt", sep=" ",quote=F,row.names=F,col.names=T)
    > 


    [+] Loading gcc  7.3.0  ... 
    [+] Loading GSL 2.4 for GCC 7.2.0 ... 
    [-] Unloading gcc  7.3.0  ... 
    [+] Loading gcc  7.3.0  ... 
    [+] Loading openmpi 3.0.2  for GCC 7.3.0 
    [+] Loading ImageMagick  7.0.8  on cn3169 
    [+] Loading HDF5  1.10.4 
    [+] Loading pandoc  2.9.2.1  on cn3169 
    [+] Loading R 3.5.2 
    Loading required package: data.table
    Loading required package: tidyverse
    -- Attaching packages --------------------------------------- tidyverse 1.2.1 --
    v ggplot2 3.3.0     v purrr   0.3.3
    v tibble  2.1.3     v dplyr   0.8.5
    v tidyr   0.8.3     v stringr 1.4.0
    v readr   1.3.1     v forcats 0.4.0
    -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    x dplyr::between()   masks data.table::between()
    x dplyr::filter()    masks stats::filter()
    x dplyr::first()     masks data.table::first()
    x dplyr::lag()       masks stats::lag()
    x dplyr::last()      masks data.table::last()
    x purrr::transpose() masks data.table::transpose()


### US_mg_noDups.keepRelated.subset1


```bash
%%bash
module load plink/1.9.0-beta4.4

mkdir CLEAN.rawGenotype.keepRelated.subset1

plink \
--bfile CLEAN.rawGenotype.keepRelated/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005 \
--remove badSamples_failedImputationQC_toRemove.txt \
--keep US_mg_noDups.keepRelated.subset1.FIDspaceIID.txt \
--allow-no-sex \
--keep-allele-order \
--make-bed \
--out CLEAN.rawGenotype.keepRelated.subset1/FILTERED.US_mg_noDups.keepRelated.subset1.hwe1e-10.geno005

```


```bash
%%bash
cp CLEAN.rawGenotype.keepRelated.subset1/FILTERED.US_mg_noDups.keepRelated.subset1.hwe1e-10.geno005.* .

chmod u+x ./scripts/QC_preimputation_v2_keepRelated_part2of2.updated.sh

echo "./scripts/QC_preimputation_v2_keepRelated_part2of2.updated.sh FILTERED.US_mg_noDups.keepRelated.subset1.hwe1e-10.geno005 chiarp@mail.nih.gov" > QC_preimputation_part2.subset1.swarm
swarm --file QC_preimputation_part2.subset1.swarm --gres=lscratch:200 \
--module plink,R -g 32 --time 24:00:00 -t auto \
--sbatch "--mail-type=BEGIN,FAIL,END,TIME_LIMIT_80"
```


```bash
%%bash
# Remove intermediate files
rm FILTERED.US_mg_noDups.keepRelated.subset1.hwe1e-10.geno005[0-9].log
rm FILTERED.US_mg_noDups.keepRelated.subset1.hwe1e-10.geno005[0-9][0-9].log
rm FILTERED.US_mg_noDups.keepRelated.subset1.hwe1e-10.geno005[0-9].vcf
rm FILTERED.US_mg_noDups.keepRelated.subset1.hwe1e-10.geno005[0-9][0-9].vcf
rm FILTERED.US_mg_noDups.keepRelated.subset1.hwe1e-10.geno005-updated-chr*.*
rm *-FILTERED.US_mg_noDups.keepRelated.subset1.hwe1e-10.geno005-HRC.txt
rm -r Imputation_HRC_bundle
rm Run-plink.sh
```

### US_mg_noDups.UNRELATED.subset1


```bash
%%bash
module load plink/1.9.0-beta4.4

mkdir CLEAN.rawGenotype.UNRELATED.subset1

plink \
--bfile CLEAN.rawGenotype.keepRelated.subset1/FILTERED.US_mg_noDups.keepRelated.subset1.hwe1e-10.geno005 \
--remove FILTERED.to.remove.GRM_matrix.noDups.relatedSamples_FIDspaceIID.txt \
--keep-allele-order \
--allow-no-sex \
--make-bed \
--out CLEAN.rawGenotype.UNRELATED.subset1/FILTERED.US_mg_noDups.UNRELATED.subset1.hwe1e-10.geno005
```

#### Imputation download US subset1


```bash
%%bash
echo "sh scripts/MG.US.subset1.hg38_ImputationResultsDownload_and_plink_06-26-2020.sh" > MG.US.subset1.hg38_ImputationDownload.swarm
swarm --file MG.US.subset1.hg38_ImputationDownload.swarm \
--logdir swarmOE_ImputationDownload \
--gres=lscratch:200 \
--module plink/1.9.0-beta4.4 \
-g 2 -t auto --time 12:00:00 \
--sbatch "--mail-type=BEGIN,FAIL,TIME_LIMIT_80"
```

##### Create index files for vcf.gz


```bash
%%bash
DIR="/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US"
cd $DIR/Imputation.subset1.hg38

for CHNUM in {1..22}
do
echo "tabix -p vcf chr${CHNUM}.dose.vcf.gz" >> tabix.swarm
done

swarm --file tabix.swarm \
--logdir swarmOE_ImputationDownload \
--gres=lscratch:200 \
--module samtools/1.11 \
-g 2 -t auto --time 12:00:00 \
--sbatch "--mail-type=BEGIN,FAIL,TIME_LIMIT_80"
```

##### Check total number of variants imputed


```bash
%%bash
DIR="/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US"
cd $DIR/Imputation.subset1.hg38
wc -l chr[0-9]*.info
```

       16967781 chr1.info
       10238762 chr10.info
       10371784 chr11.info
       10078551 chr12.info
        7535672 chr13.info
        6708645 chr14.info
        6227484 chr15.info
        7179575 chr16.info
        6344508 chr17.info
        5999245 chr18.info
        4956397 chr19.info
       18330154 chr2.info
        4866541 chr20.info
        2844727 chr21.info
        3109661 chr22.info
       15006839 chr3.info
       14647800 chr4.info
       13556622 chr5.info
       12677428 chr6.info
       12319814 chr7.info
       11703368 chr8.info
        9551884 chr9.info
      211223242 total


##### Create list variants to keep for analysis based on Rsq > 0.3 and MAF > 0.0001


```bash
%%bash
mkdir Imputation.subset1.hg38/Vars.Rsq03MAF00001
cd Imputation.subset1.hg38

for CHNUM in {1..22} X 
do
awk '{if($5 > 0.0001 && $7 > 0.3) print $1}' chr${CHNUM}.info | tail -n +2 > Vars.Rsq03MAF00001/Rsq03MAF00001.chr${CHNUM}.txt
done
```


```python
!wc -l Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr[0-9]*.txt
```

      3075906 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr1.txt
      1908112 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr10.txt
      1897389 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr11.txt
      1855080 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr12.txt
      1387954 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr13.txt
      1229222 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr14.txt
      1118799 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr15.txt
      1236421 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr16.txt
      1109710 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr17.txt
      1089479 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr18.txt
       880527 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr19.txt
      3324038 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr2.txt
       867472 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr20.txt
       517990 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr21.txt
       539991 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr22.txt
      2772496 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr3.txt
      2723244 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr4.txt
      2488970 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr5.txt
      2419712 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr6.txt
      2247034 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr7.txt
      2156622 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr8.txt
      1702972 Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr9.txt
     38549140 total


### US_mg_noDups.keepRelated.subset2


```bash
%%bash
module load plink/1.9.0-beta4.4

mkdir CLEAN.rawGenotype.keepRelated.subset2

plink \
--bfile CLEAN.rawGenotype.keepRelated/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005 \
--remove badSamples_failedImputationQC_toRemove.txt \
--keep US_mg_noDups.keepRelated.subset2.FIDspaceIID.txt \
--allow-no-sex \
--keep-allele-order \
--make-bed \
--out CLEAN.rawGenotype.keepRelated.subset2/FILTERED.US_mg_noDups.keepRelated.subset2.hwe1e-10.geno005

```


```bash
%%bash
cp CLEAN.rawGenotype.keepRelated.subset2/FILTERED.US_mg_noDups.keepRelated.subset2.hwe1e-10.geno005.* .

chmod u+x ./scripts/QC_preimputation_v2_keepRelated_part2of2.updated.sh

echo "./scripts/QC_preimputation_v2_keepRelated_part2of2.updated.sh FILTERED.US_mg_noDups.keepRelated.subset2.hwe1e-10.geno005 chiarp@mail.nih.gov" > QC_preimputation_part2.subset2.swarm
swarm --file QC_preimputation_part2.subset2.swarm --gres=lscratch:200 \
--module plink,R -g 32 --time 24:00:00 -t auto \
--sbatch "--mail-type=BEGIN,FAIL,END,TIME_LIMIT_80"
```


```bash
%%bash
# Remove intermediate files
rm FILTERED.US_mg_noDups.keepRelated.subset2.hwe1e-10.geno005-chr*.check.*
rm FILTERED.US_mg_noDups.keepRelated.subset2.hwe1e-10.geno005[0-9].log
rm FILTERED.US_mg_noDups.keepRelated.subset2.hwe1e-10.geno005[0-9][0-9].log
rm FILTERED.US_mg_noDups.keepRelated.subset2.hwe1e-10.geno005[0-9].vcf
rm FILTERED.US_mg_noDups.keepRelated.subset2.hwe1e-10.geno005[0-9][0-9].vcf
rm FILTERED.US_mg_noDups.keepRelated.subset2.hwe1e-10.geno005-updated-chr*.*
rm *-FILTERED.US_mg_noDups.keepRelated.subset2.hwe1e-10.geno005-HRC.txt
rm -r Imputation_HRC_bundle
rm Run-plink.sh
```

### US_mg_noDups.UNRELATED.subset2


```bash
%%bash
module load plink/1.9.0-beta4.4

mkdir CLEAN.rawGenotype.UNRELATED.subset2

plink \
--bfile CLEAN.rawGenotype.keepRelated.subset2/FILTERED.US_mg_noDups.keepRelated.subset2.hwe1e-10.geno005 \
--remove FILTERED.to.remove.GRM_matrix.noDups.relatedSamples_FIDspaceIID.txt \
--keep-allele-order \
--allow-no-sex \
--make-bed \
--out CLEAN.rawGenotype.UNRELATED.subset2/FILTERED.US_mg_noDups.UNRELATED.subset2.hwe1e-10.geno005
```

#### Imputation download US subset2


```bash
%%bash
echo "sh scripts/MG.US.subset2.hg38_ImputationResultsDownload_and_plink_06-26-2020.sh" > MG.US.subset2.hg38_ImputationDownload.swarm
swarm --file MG.US.subset2.hg38_ImputationDownload.swarm \
--logdir swarmOE_ImputationDownload \
--gres=lscratch:200 \
--module plink/1.9.0-beta4.4 \
-g 2 -t auto --time 12:00:00 \
--sbatch "--mail-type=BEGIN,FAIL,TIME_LIMIT_80"
```

##### Create index files for vcf.gz


```bash
%%bash
DIR="/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US"
cd $DIR/Imputation.subset2.hg38

for CHNUM in {1..22}
do
echo "tabix -p vcf chr${CHNUM}.dose.vcf.gz" >> tabix.swarm
done

swarm --file tabix.swarm \
--logdir swarmOE_ImputationDownload \
--gres=lscratch:200 \
--module samtools/1.11 \
-g 2 -t auto --time 12:00:00 \
--sbatch "--mail-type=BEGIN,FAIL,TIME_LIMIT_80"
```

##### Check total number of variants imputed


```bash
%%bash
DIR="/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US"
cd $DIR/Imputation.subset2.hg38
wc -l chr[0-9]*.info
```

       16935314 chr1.info
       10205874 chr10.info
       10374203 chr11.info
       10094425 chr12.info
        7528950 chr13.info
        6713357 chr14.info
        6223876 chr15.info
        7166731 chr16.info
        6343159 chr17.info
        5999494 chr18.info
        4955985 chr19.info
       18299571 chr2.info
        4855185 chr20.info
        2845622 chr21.info
        3105277 chr22.info
       14970532 chr3.info
       14636110 chr4.info
       13542280 chr5.info
       12659785 chr6.info
       12281741 chr7.info
       11675945 chr8.info
        9531930 chr9.info
      210945346 total


##### Create list variants to keep for analysis based on Rsq > 0.3 and MAF > 0.0001


```bash
%%bash
mkdir Imputation.subset2.hg38/Vars.Rsq03MAF00001
cd Imputation.subset2.hg38

for CHNUM in {1..22}
do
awk '{if($5 > 0.0001 && $7 > 0.3) print $1}' chr${CHNUM}.info | tail -n +2 > Vars.Rsq03MAF00001/Rsq03MAF00001.chr${CHNUM}.txt
done
```


```python
!wc -l Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr[0-9]*.txt
```

      3061804 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr1.txt
      1898897 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr10.txt
      1897749 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr11.txt
      1852379 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr12.txt
      1383618 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr13.txt
      1231290 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr14.txt
      1118324 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr15.txt
      1237993 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr16.txt
      1107263 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr17.txt
      1093755 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr18.txt
       881109 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr19.txt
      3314931 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr2.txt
       866003 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr20.txt
       516118 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr21.txt
       542453 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr22.txt
      2761280 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr3.txt
      2723181 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr4.txt
      2486856 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr5.txt
      2414701 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr6.txt
      2234890 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr7.txt
      2156363 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr8.txt
      1695638 Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr9.txt
     38476595 total


## Merge US.subset1 and US.subset2

### Make list of shared  post-imputatation variants shared between US.subset1 and US.subset2


```bash
%%bash
DATA="/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US"
DIR="/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US/Analysis.GLM.hg38/US.JointPostImputation"
mkdir $DIR/sharedVars.postImputation
cd $DIR/sharedVars.postImputation

for CHNUM in {1..22}
do
cat $DATA/Imputation.subset1.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr${CHNUM}.txt $DATA/Imputation.subset2.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr${CHNUM}.txt | sort | uniq -d > $DIR/SharedVars.postImputation.Rsq03MAF00001.chr${CHNUM}.txt
done
```

### Merge vcf.gz files from US.subset1 and US.subset2 containing dosage info


```bash
%%bash

DATA="/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US"
DIR="/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US/Analysis.GLM.hg38/US.JointPostImputation"

mkdir $DIR/merged.vcf
cd $DIR/merged.vcf

for CHNUM in {1..22};
  do
echo "bcftools merge \
--output US.chr${CHNUM}.vcf.gz \
--output-type z \
-m id \
--info-rules R2:avg \
--threads 32 \
$DATA/Imputation.subset1.hg38/chr${CHNUM}.dose.vcf.gz $DATA/Imputation.subset2.hg38/chr${CHNUM}.dose.vcf.gz" >> merge.vcf.swarm
done

swarm --file merge.vcf.swarm --logdir swarmOE_merge.vcf \
--gres=lscratch:200 --time 12:00:00 -g 120 -t auto --module bcftools/1.9
```

### Make list of dbGAP samples to remove from analysis


```bash
%%bash

DATA="/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US"
DIR="/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US/Analysis.GLM.hg38/US.JointPostImputation"

grep "phs000372" $DATA/CLEAN.rawGenotype.keepRelated/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005.fam | awk '{print $1"_"$2,$1"_"$2}' > $DIR/SamplesToRemove.dbGAP.FID_IID.forImputed.txt
grep "phs000397-4433" $DATA/CLEAN.rawGenotype.keepRelated/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005.fam | awk '{print $1"_"$2,$1"_"$2}' >> $DIR/SamplesToRemove.dbGAP.FID_IID.forImputed.txt
grep "phs000428-13949" $DATA/CLEAN.rawGenotype.keepRelated/FILTERED.US_mg_noDups.keepRelated.hwe1e-10.geno005.fam | awk '{print $1"_"$2,$1"_"$2}' >> $DIR/SamplesToRemove.dbGAP.FID_IID.forImputed.txt

echo "Number of dbGAP samples to remove:"
wc -l $DIR/SamplesToRemove.dbGAP.FID_IID.forImputed.txt

head $DIR/SamplesToRemove.dbGAP.FID_IID.forImputed.txt | column -t
```

    Number of dbGAP samples to remove:
    464 /data/NDRS_LNG/MyastheniaGravis/updated.April2020/US/Analysis.GLM.hg38/US.JointPostImputation/SamplesToRemove.dbGAP.FID_IID.forImputed.txt
    phs000372-0_phs000372-NACC001075  phs000372-0_phs000372-NACC001075
    phs000372-0_phs000372-NACC001628  phs000372-0_phs000372-NACC001628
    phs000372-0_phs000372-NACC002326  phs000372-0_phs000372-NACC002326
    phs000372-0_phs000372-NACC003397  phs000372-0_phs000372-NACC003397
    phs000372-0_phs000372-NACC010563  phs000372-0_phs000372-NACC010563
    phs000372-0_phs000372-NACC011643  phs000372-0_phs000372-NACC011643
    phs000372-0_phs000372-NACC013871  phs000372-0_phs000372-NACC013871
    phs000372-0_phs000372-NACC016407  phs000372-0_phs000372-NACC016407
    phs000372-0_phs000372-NACC017867  phs000372-0_phs000372-NACC017867
    phs000372-0_phs000372-NACC021590  phs000372-0_phs000372-NACC021590


## Generate plink files for PRS analysis

What is needed:
1. plink1 binaries containing variants with Rsq > 0.3, maf > 0.0001

Location of files:
 
1. USmerged
    - merged imputed files: `/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US/Analysis.GLM.hg38/US.JointPostImputation/merged.vcf/US.chr${CHNUM}.vcf.gz`
    - List of variants to keep: `/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US/Analysis.GLM.hg38/US.JointPostImputation/sharedVars.postImputation/SharedVars.postImputation.Rsq03MAF00001.chr${CHNUM}.txt `
    - Covariate file: `/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US/COVARIATES.US_mg_noDups.UNRELATED.forImputed.txt`
 
2. Italy
    - Imputed files: `/data/NDRS_LNG/MyastheniaGravis/updated.April2020/Itals/Imputation.hg38 /chr${CHNUM}.dose.vcf.gz`
    - List of variants to keep: `/data/NDRS_LNG/MyastheniaGravis/updated.April2020/Itals/Imputation.hg38/Vars.Rsq03MAF00001/Rsq03MAF00001.chr${CHNUM}.txt `
    - Covariate file: `/data/NDRS_LNG/MyastheniaGravis/updated.April2020/Itals/COVARIATES.Itals_mg_noDups.UNRELATED.forGLM.txt`



### USmerged

script: `vcfImputedToplink1.USmerged.sh`
```
#!/bin/bash

# Warning message to indicate argument requirement for script to run
if [ $# -eq 2 ]
then
    echo "vcfImputedToplink1.USmerged.sh running"
    echo "This script should be executed in biowulf. If not, please terminate job."
else
    echo "Need directory where file is in, CHNUM of imputed vcf.gz file"
    echo "Note: This script is written to be executed in biowulf."
    exit
fi

# Arguments to pass
DIR=$1
CHNUM=$2

# Load modules on biowulf
module load plink/1.9.0-beta4.4

DATA="/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US/Analysis.GLM.hg38/US.JointPostImputation"

plink \
--vcf $DATA/merged.vcf/US.chr${CHNUM}.vcf.gz \
--double-id \
--extract $DATA/sharedVars.postImputation/SharedVars.postImputation.Rsq03MAF00001.chr${CHNUM}.txt \
--remove /data/NDRS_LNG/MyastheniaGravis/updated.April2020/US/SamplesToRemove.dbGAP.FIDspaceIID.txt \
--pheno-name PHENO \
--pheno $DIR/COVARIATES.US_mg_noDups.UNRELATED.forImputed.txt \
--keep $DIR/Imputation.USmerged.hg38/SampleList.USmerged.UNRELATED.forImputed.txt \
--keep-allele-order \
--allow-no-sex \
--threads 32 \
--make-bed \
--out plinkForPRS/USmerged.UNRELATED.Imputed.pass.Rsq03MAF00001.chr${CHNUM}

```



```bash
%%bash
mkdir Imputation.USmerged.hg38
mkdir Imputation.USmerged.hg38/plinkForPRS
```


```bash
%%bash
cd Imputation.USmerged.hg38

DIR="/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US"

# Make list of unrelated samples to keep 
awk '{print $1,$2}' $DIR/COVARIATES.US_mg_noDups.UNRELATED.forImputed.txt > $DIR/Imputation.USmerged.hg38/SampleList.USmerged.UNRELATED.forImputed.txt


DATA="/data/NDRS_LNG/MyastheniaGravis/updated.April2020/US/Analysis.GLM.hg38/US.JointPostImputation"

for CHNUM in {1..22}
do 
echo "sh vcfImputedToplink1.USmerged.sh $DIR $CHNUM" >> generatePRSplink.swarm
done

```


```bash
%%bash
cd Imputation.USmerged.hg38
swarm --file generatePRSplink.swarm --logdir swarmOE_vcfToPlink -g 120 --time 12:00:00 -t auto --module plink/1.9.0-beta4.4
```

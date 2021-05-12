#! /bin/bash

# Script written by: Ruth Chia (LNG/NIA/NIH)
# Updated on: 07-07-2020

module load plink
module load vcftools

inFILENAME=$1
email=$2

if [ $# -eq 2 ]
then
    echo "QC_preimputation_v1_part2o2 running"
    echo "This script is meant to be executed on biowulf as a swarm job"
    echo "Notification email will be sent when task is complete."
else
    echo "Error: Need input file i.e. cleaned data from QC_preimputation_v1_part1o2 and email address to send notification when task is complete."
    echo "This script is meant to be executed on biowulf as a swarm job"
    exit
fi

start_date=$(date)
echo "Start date and time = $start_date"
res1=$(date +%s.%N)

echo Pre-imputation step:
echo To check plink file against HRC or 1000G reference SNP list prior to submitting job to Michigan imputation server

mkdir Imputation_HRC_bundle

# Download perl script for pre-check
wget -P ./Imputation_HRC_bundle http://www.well.ox.ac.uk/~wrayner/tools/HRC-1000G-check-bim-v4.2.9.zip

unzip ./Imputation_HRC_bundle/HRC-1000G-check-bim-v4.2.9.zip -d ./Imputation_HRC_bundle

rm ./Imputation_HRC_bundle/HRC-1000G-check-bim-v4.2.9.zip

# Download HRC reference panel
wget -P ./Imputation_HRC_bundle/ ftp://ngs.sanger.ac.uk/production/hrc/HRC.r1-1/HRC.r1-1.GRCh37.wgs.mac5.sites.tab.gz

gunzip ./Imputation_HRC_bundle/HRC.r1-1.GRCh37.wgs.mac5.sites.tab.gz ./Imputation_HRC_bundle

# Run perl script
echo
echo Running check against HRC
echo
plink --bfile $inFILENAME --freq --out $inFILENAME
perl ./Imputation_HRC_bundle/HRC-1000G-check-bim.pl -b $inFILENAME.bim -f $inFILENAME.frq -r ./Imputation_HRC_bundle/HRC.r1-1.GRCh37.wgs.mac5.sites.tab -h

# Run clean updata script generated from HRC check
sh Run-plink.sh

# Convert plink to vcf per chromosome
echo Convert plink to vcf per chromosome
for chnum in {1..23}; do plink --bfile $inFILENAME-updated-chr$chnum --recode vcf --chr $chnum --out $inFILENAME$chnum; done

# vcfsort and zip
echo
echo vcfsort and zip
for chnum in {1..23}; do vcf-sort $inFILENAME$chnum.vcf | bgzip -c > pre_impute_$inFILENAME-chr$chnum.vcf.gz; done

# Check to make sure all variants pass the checkVCF utility for input
echo
echo Download checkVCF.py script
wget -P ./Imputation_HRC_bundle http://csg.sph.umich.edu//zhanxw/software/checkVCF/checkVCF-20131123.tar.gz
tar xvzf ./Imputation_HRC_bundle/checkVCF-20131123.tar.gz -C ./Imputation_HRC_bundle

echo
echo Running checkVCF.py
for chnum in {1..23}; do python ./Imputation_HRC_bundle/checkVCF.py -r ./Imputation_HRC_bundle/hs37d5.fa -o $inFILENAME-chr$chnum pre_impute_$inFILENAME-chr$chnum.vcf.gz; done

## Concatenate all log files from checkVCF.py
cat $inFILENAME-chr*.check.log > log_file_check_vcf.$inFILENAME.txt


# Gives runtime and email notification for completed task
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

mailx -s "biowulf swarm alert message: QC_preimputation_v2_keepRelated_part2of2 TASK COMPLETE" $email < Runtime_summary.txt
sleep 10s
rm Runtime_summary.txt

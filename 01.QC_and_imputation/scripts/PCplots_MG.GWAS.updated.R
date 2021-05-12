#!/usr/bin/env Rscript

# read command line
args <- commandArgs(trailingOnly=TRUE)
if (length(args) != 2) {
    stop("USAGE: Rscript ./scripts/PCplots_MGmegaGWAS.R COVARIATEfile outputName")
}

# Load in required packages
require(data.table)
require(tidyverse)
library(gridExtra)
library(grid)

# Read in covariate file
COVS <- fread(args[1],header=T)
COVS$DIAGNOSIS <- COVS$PHENO
COVS$DIAGNOSIS <- gsub("1","Control",COVS$DIAGNOSIS)
COVS$DIAGNOSIS <- gsub("2","MG",COVS$DIAGNOSIS)
COVS$DIAGNOSIS <- factor(COVS$DIAGNOSIS, levels=c("Control","MG"))
COVS <- COVS %>% select(DIAGNOSIS,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10)

# +
# Plot PCs between cases and controls
## PC1 vs PC2-PC10
pc1_pc2 <- ggplot(data = COVS, aes(x = PC1, y = PC2, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title.x = element_blank())

pc1_pc3 <- ggplot(data = COVS, aes(x = PC1, y = PC3, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title.x = element_blank()) + theme(legend.position="none")

pc1_pc4 <- ggplot(data = COVS, aes(x = PC1, y = PC4, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title.x = element_blank()) + theme(legend.position="none")

pc1_pc5 <- ggplot(data = COVS, aes(x = PC1, y = PC5, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title.x = element_blank()) + theme(legend.position="none")

pc1_pc6 <- ggplot(data = COVS, aes(x = PC1, y = PC6, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title.x = element_blank()) + theme(legend.position="none")

pc1_pc7 <- ggplot(data = COVS, aes(x = PC1, y = PC7, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title.x = element_blank()) + theme(legend.position="none")

pc1_pc8 <- ggplot(data = COVS, aes(x = PC1, y = PC8, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title.x = element_blank()) + theme(legend.position="none")

pc1_pc9 <- ggplot(data = COVS, aes(x = PC1, y = PC9, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title.x = element_blank()) + theme(legend.position="none")

pc1_pc10 <- ggplot(data = COVS, aes(x = PC1, y = PC10, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) + theme(legend.position="none")

## PC2 vs PC3-PC10
pc2_pc3 <- ggplot(data = COVS, aes(x = PC2, y = PC3, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank())

pc2_pc4 <- ggplot(data = COVS, aes(x = PC2, y = PC4, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc2_pc5 <- ggplot(data = COVS, aes(x = PC2, y = PC5, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc2_pc6 <- ggplot(data = COVS, aes(x = PC2, y = PC6, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc2_pc7 <- ggplot(data = COVS, aes(x = PC2, y = PC7, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc2_pc8 <- ggplot(data = COVS, aes(x = PC2, y = PC8, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc2_pc9 <- ggplot(data = COVS, aes(x = PC2, y = PC9, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc2_pc10 <- ggplot(data = COVS, aes(x = PC2, y = PC10, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) + theme(legend.position="none") +
theme(axis.title.y = element_blank())

## PC3 vs PC4-PC10
pc3_pc4 <- ggplot(data = COVS, aes(x = PC3, y = PC4, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank())

pc3_pc5 <- ggplot(data = COVS, aes(x = PC3, y = PC5, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc3_pc6 <- ggplot(data = COVS, aes(x = PC3, y = PC6, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc3_pc7 <- ggplot(data = COVS, aes(x = PC3, y = PC7, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc3_pc8 <- ggplot(data = COVS, aes(x = PC3, y = PC8, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc3_pc9 <- ggplot(data = COVS, aes(x = PC3, y = PC9, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc3_pc10 <- ggplot(data = COVS, aes(x = PC3, y = PC10, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) + theme(legend.position="none") +
theme(axis.title.y = element_blank())

## PC4 vs PC5-PC10
pc4_pc5 <- ggplot(data = COVS, aes(x = PC4, y = PC5, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank())

pc4_pc6 <- ggplot(data = COVS, aes(x = PC4, y = PC6, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc4_pc7 <- ggplot(data = COVS, aes(x = PC4, y = PC7, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc4_pc8 <- ggplot(data = COVS, aes(x = PC4, y = PC8, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc4_pc9 <- ggplot(data = COVS, aes(x = PC4, y = PC9, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc4_pc10 <- ggplot(data = COVS, aes(x = PC4, y = PC10, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) + theme(legend.position="none") +
theme(axis.title.y = element_blank())

## PC5 vs PC6-PC10
pc5_pc6 <- ggplot(data = COVS, aes(x = PC5, y = PC6, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank())

pc5_pc7 <- ggplot(data = COVS, aes(x = PC5, y = PC7, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc5_pc8 <- ggplot(data = COVS, aes(x = PC5, y = PC8, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc5_pc9 <- ggplot(data = COVS, aes(x = PC5, y = PC9, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc5_pc10 <- ggplot(data = COVS, aes(x = PC5, y = PC10, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) + theme(legend.position="none") +
theme(axis.title.y = element_blank())


## PC6 vs PC7-PC10
pc6_pc7 <- ggplot(data = COVS, aes(x = PC6, y = PC7, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank())

pc6_pc8 <- ggplot(data = COVS, aes(x = PC6, y = PC8, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc6_pc9 <- ggplot(data = COVS, aes(x = PC6, y = PC9, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc6_pc10 <- ggplot(data = COVS, aes(x = PC6, y = PC10, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) + theme(legend.position="none") +
theme(axis.title.y = element_blank())

## PC7 vs PC8-PC10
pc7_pc8 <- ggplot(data = COVS, aes(x = PC7, y = PC8, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank())

pc7_pc9 <- ggplot(data = COVS, aes(x = PC7, y = PC9, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank()) + theme(legend.position="none")

pc7_pc10 <- ggplot(data = COVS, aes(x = PC7, y = PC10, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) + theme(legend.position="none") +
theme(axis.title.y = element_blank())


## PC8 vs PC9-PC10
pc8_pc9 <- ggplot(data = COVS, aes(x = PC8, y = PC9, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_alpha_manual(guide='none', values = list(Control = 0.4, MG = 0.75)) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title = element_blank())

pc8_pc10 <- ggplot(data = COVS, aes(x = PC8, y = PC10, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) + theme(legend.position="none") +
theme(axis.title.y = element_blank())


## PC9 vs PC10
pc9_pc10 <- ggplot(data = COVS, aes(x = PC9, y = PC10, colour=DIAGNOSIS)) +
geom_point(alpha = 0.4, position = position_jitter()) +
scale_colour_manual(values = c("#E69F00", "#56B4E9")) +
scale_x_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
scale_y_continuous(breaks = seq(-0.25,0.25,0.05), limits = c(-0.25,0.25)) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines')) +
theme(axis.title.y = element_blank())


library(gridExtra)
library(grid)

blank <- grid.rect(gp=gpar(col="white"))
all <- grid.arrange(pc1_pc2, blank, blank, blank, blank, blank, blank, blank, blank, pc1_pc3, pc2_pc3, blank, blank, blank, blank, blank, blank, blank, pc1_pc4, pc2_pc4, pc3_pc4, blank, blank, blank, blank, blank, blank, pc1_pc5, pc2_pc5, pc3_pc5, pc4_pc5, blank, blank, blank, blank, blank, pc1_pc6, pc2_pc6, pc3_pc6, pc4_pc6, pc5_pc6, blank, blank, blank, blank, pc1_pc7, pc2_pc7, pc3_pc7, pc4_pc7, pc5_pc7, pc6_pc7, blank, blank, blank, pc1_pc8, pc2_pc8, pc3_pc8, pc4_pc8, pc5_pc8, pc6_pc8, pc7_pc8, blank, blank, pc1_pc9, pc2_pc9, pc3_pc9, pc4_pc9, pc5_pc9, pc6_pc9, pc7_pc9, pc8_pc9, blank, pc1_pc10, pc2_pc10, pc3_pc10, pc4_pc10, pc5_pc10, pc6_pc10, pc7_pc10, pc8_pc10, pc9_pc10, ncol = 9)

ggsave(paste(args[2],"_prunedSNPs_hwe5e-6.geno001.maf001.pdf",sep=""), all, width = 30, height = 28, units = "in")
ggsave(paste(args[2],"_prunedSNPs_hwe5e-6.geno001.maf001.jpg",sep=""), all, width = 30, height = 28, units = "in")

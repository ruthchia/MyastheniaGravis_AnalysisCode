#!/usr/bin/env Rscript

require(tidyverse)

all_data <- read.table("pca.eigenvec2", header = F)

all_data$V1[all_data$V1 == 0] <- 4 # 4 is New Samples
all_data$V1[all_data$V1 == 1] <- 5 # 5 hapmap european, 2 is hapmap asia, 3 is hapmap africa

attach(all_data)
all_data <- all_data[order(V1),] 
head(all_data)
table(all_data$V1)

all_data$POPULATION <- all_data$V1
all_data$POPULATION <- gsub("2","Asia",all_data$POPULATION,perl=T)
all_data$POPULATION <- gsub("3","Africa",all_data$POPULATION,perl=T)
all_data$POPULATION <- gsub("4","New_Samples",all_data$POPULATION,perl=T)
all_data$POPULATION <- gsub("5","European",all_data$POPULATION,perl=T)
all_data$POPULATION <- factor(all_data$POPULATION, levels=c("Asia","Africa","European","New_Samples"))

raw <- ggplot(data = all_data, aes(x=V4,y=V5)) + 
       geom_point(aes(color=POPULATION), alpha=0.8, size=1) +
       scale_color_manual(name='POPULATION', values = c(Asia = "maroon", Africa = "chartreuse3",European = "cyan2", New_Samples = "royalblue1")) +
       xlab("PC1") + ylab("PC2") +
       theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines'))

ggsave("../raw_hapmap_plot.pdf", plot = raw, device = "pdf", scale = 1, width = 5, height = 5, units = "in", dpi = 300, limitsize = TRUE)

euros <- all_data[grep("EUROPE", all_data$V3,perl=T),]
asians <- all_data[grep("ASIA", all_data$V3,perl=T),]
africans <- all_data[grep("AFRICA", all_data$V3,perl=T),]

# Notes: V4 is PC1, V5 is PC2
eurosLowC1 <- mean(euros$V4) - (6*sd(euros$V4))
eurosHighC1 <- mean(euros$V4) + (6*sd(euros$V4))
eurosLowC2 <- mean(euros$V5) - (6*sd(euros$V5))
eurosHighC2 <- mean(euros$V5) + (6*sd(euros$V5))

asiansLowC1 <- mean(asians$V4) - (6*sd(asians$V4))
asiansHighC1 <- mean(asians$V4) + (6*sd(asians$V4))
asiansLowC2 <- mean(asians$V5) - (6*sd(asians$V5))
asiansHighC2 <- mean(asians$V5) + (6*sd(asians$V5))

africansLowC1 <- mean(africans$V4) - (6*sd(africans$V4))
africansHighC1 <- mean(africans$V4) + (6*sd(africans$V4))
africansLowC2 <- mean(africans$V5) - (6*sd(africans$V5))
africansHighC2 <- mean(africans$V5) + (6*sd(africans$V5))

## EUROPEAN
temp2 = all_data[(all_data$V4>=eurosLowC1),]
temp3 = temp2[(temp2$V4<=eurosHighC1),]
temp4 = temp3[(temp3$V5>=eurosLowC2),]
EURO = temp4[(temp4$V5<=eurosHighC2),]


euro <- ggplot(data = EURO, aes(x=V4,y=V5)) + 
       geom_point(aes(color=POPULATION), alpha=0.8, size=1) +
       scale_color_manual(name='POPULATION', values = c(Asia = "maroon", Africa = "chartreuse3",European = "cyan2", New_Samples = "royalblue1")) +
       xlab("PC1") + ylab("PC2") +
       theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines'))

ggsave("../EURO_confirmation_plot.pdf", plot = euro, device = "pdf", scale = 1, width = 5, height = 5, units = "in", dpi = 300, limitsize = TRUE)

## ASIAN
temp2 = all_data[(all_data$V4>=asiansLowC1),]
temp3 = temp2[(temp2$V4<=asiansHighC1),]
temp4 = temp3[(temp3$V5>=asiansLowC2),]
ASIA = temp4[(temp4$V5<=asiansHighC2),]

asia <- ggplot(data = ASIA, aes(x=V4,y=V5)) + 
       geom_point(aes(color=POPULATION), alpha=0.8, size=1) +
       scale_color_manual(name='POPULATION', values = c(Asia = "maroon", Africa = "chartreuse3",European = "cyan2", New_Samples = "royalblue1")) +
       xlab("PC1") + ylab("PC2") +
       theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines'))

ggsave("../ASIA_confirmation_plot.pdf", plot = asia, device = "pdf", scale = 1, width = 5, height = 5, units = "in", dpi = 300, limitsize = TRUE)

## AFRICA
temp2 = all_data[(all_data$V4>=africansLowC1),]
temp3 = temp2[(temp2$V4<=africansHighC1),]
temp4 = temp3[(temp3$V5>=africansLowC2),]
AFRICA = temp4[(temp4$V5<=africansHighC2),]

africa <- ggplot(data = AFRICA, aes(x=V4,y=V5)) + 
       geom_point(aes(color=POPULATION), alpha=0.8, size=1) +
       scale_color_manual(name='POPULATION', values = c(Asia = "maroon", Africa = "chartreuse3",European = "cyan2", New_Samples = "royalblue1")) +
       xlab("PC1") + ylab("PC2") +
       theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines'))

ggsave("../AFRICA_confirmation_plot.pdf", plot = africa, device = "pdf", scale = 1, width = 5, height = 5, units = "in", dpi = 300, limitsize = TRUE)

## MIXED RACE
library(dplyr)

main_data2 <- subset(all_data, !all_data$V2 %in% EURO$V2)

mixed_race1 <- anti_join(all_data, EURO)
mixed_race2 <- anti_join(mixed_race1, ASIA)
mixed_race3 <- anti_join(mixed_race2, AFRICA)
mixed_race3$POPULATION <- gsub("New_Samples","New_Samples_ADMIX",mixed_race3$POPULATION,perl=T)

total <- rbind(euros,asians,africans,mixed_race3)

mixed <- ggplot(data = total, aes(x=V4,y=V5)) + 
       geom_point(aes(color=POPULATION), alpha=0.8, size=1) +
       scale_color_manual(name='POPULATION', values = c(Asia = "maroon", Africa = "chartreuse3",European = "cyan2", New_Samples_ADMIX = "goldenrod1")) +
       xlab("PC1") + ylab("PC2") +
       theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.88,0.9)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines'))

ggsave("../MIXED_RACE_confirmation_plot.pdf", plot = mixed, device = "pdf", scale = 1, width = 5, height = 5, units = "in", dpi = 300, limitsize = TRUE)

## COMBINE ALL IN ONE PLOT
EURO$POPULATION <- gsub("New_Samples","New_Samples_EUROPEAN",EURO$POPULATION,perl=T)
ASIA$POPULATION <- gsub("New_Samples","New_Samples_ASIAN",ASIA$POPULATION,perl=T)
AFRICA$POPULATION <- gsub("New_Samples","New_Samples_AFRICAN",AFRICA$POPULATION,perl=T)

all <- rbind(EURO,ASIA,AFRICA,mixed_race3)
all$POPULATION <- factor(all$POPULATION, levels=c("Asia","Africa","European","New_Samples_EUROPEAN","New_Samples_AFRICAN","New_Samples_ADMIX"))

all_plots <- ggplot(data = all, aes(x=V4,y=V5)) + 
       geom_point(aes(color=POPULATION), alpha=0.8, size=1) +
       scale_color_manual(name='POPULATION', values = c(Asia = "maroon", Africa = "chartreuse3",European = "cyan2", New_Samples_EUROPEAN = "royalblue1", New_Samples_AFRICAN = "darkgreen", New_Samples_ADMIX = "goldenrod1")) +
       xlab("PC1") + ylab("PC2") +
       theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position= c(0.85,0.88)) +
theme(legend.title=element_text(size=7, face = "bold"), legend.text=element_text(size=6)) +
theme(legend.background = element_rect(fill=NA)) +
theme(legend.key.size = unit(0.6, 'lines'))

ggsave("../raw_confirmation_plot_ALLcombined.pdf", plot = all_plots, device = "pdf", scale = 1, width = 5, height = 5, units = "in", dpi = 300, limitsize = TRUE)


## PLOT ALL IN ONE GRAPH
library(gridExtra)
library(grid)
blank <- grid.rect(gp=gpar(col="white"))
combined <- grid.arrange(euro,asia,africa,mixed,ncol = 2)
ggsave("../AncestryCheck_POPULATIONplots.pdf", combined, width = 11, height = 8, units = "in")


## CREATE LIST OF NEW_SAMPLES IN EACH POPULATION

final_euro = subset(EURO, EURO$POPULATION != "European")
final_euro2 =  data.frame(final_euro$V2,final_euro$V3)

final_asia = subset(ASIA, ASIA$POPULATION != "Asia")
final_asia2 =  data.frame(final_asia$V2,final_asia$V3)

final_africa = subset(AFRICA, AFRICA$POPULATION != "Africa")
final_africa2 =  data.frame(final_africa$V2,final_africa$V3)

final_mixed_race = subset(mixed_race3, mixed_race3$POPULATION == "New_Samples_ADMIX")
final_mixed_race2 =  data.frame(final_mixed_race$V2,final_mixed_race$V3)

write.table(final_euro2,file = "../PCA_filtered_europeans.txt", quote = FALSE,row.names=F,col.names = F)
write.table(final_asia2,file = "../PCA_filtered_asians.txt", quote = FALSE,row.names=F,col.names = F)
write.table(final_africa2,file = "../PCA_filtered_africans.txt", quote = FALSE,row.names=F,col.names = F)
write.table(final_mixed_race2,file = "../PCA_filtered_mixed_race.txt", quote = FALSE,row.names=F,col.names = F)





#######################################################################################
# options, libraries

setwd("~/Dropbox/projects/ebiGWASplot/gwasSNPs")

options(stringsAsFactors=FALSE)

library(readr)
library(dplyr)
library(ggplot2)

#####################################################################################
# downloaded from http://www.ebi.ac.uk/gwas/ with search "cancer"

dat <- read_tsv("data/gwas-association-downloaded_2017-07-10-cancer.tsv")
head(dat)

# let's subset down a little and clean up names
names(dat)
dat <- dat %>% select(Cancer=`DISEASE/TRAIT`, Region=REGION, Chr=CHR_ID,
               Pos=CHR_POS, Context=CONTEXT, Intergenic=INTERGENIC, 
               RAF=`RISK ALLELE FREQUENCY`, OR=`OR or BETA`, CI=`95% CI (TEXT)`)
head(dat)

#####################################################################################
# plot distribution of OR

# first, clean up OR 
summary(dat$OR)
dat <- dat %>% filter(!is.na(OR))
# betas are indicated by "increase" or "decrease" in the CI
dat <- dat %>% filter(!grepl("increase", CI, ignore.case=TRUE))
dat <- dat %>% filter(!grepl("decrease", CI, ignore.case=TRUE))
summary(dat$OR)

N <- nrow(dat)
ggplot(dat, aes(1:N, OR)) + 
  geom_point(alpha = 1/10) +
  labs(x="Study", y = "OR") + 
  guides(fill=FALSE, colour=guide_legend(title=" ")) + 
  theme_classic()

# plot in a cancer-specific fashion
# there is some overlap in studies (e.g. some did lung/gastric/squamous)
dat$Cancer[grep("Melanoma", dat$Cancer, ignore.case=TRUE)] <- "Skin"
dat$Cancer[grep("Lymphoma", dat$Cancer, ignore.case=TRUE)] <- "Blood"
dat$Cancer[grep("Leukemia", dat$Cancer, ignore.case=TRUE)] <- "Blood"
dat$Cancer[grep("Prostate", dat$Cancer, ignore.case=TRUE)] <- "Prostate"
dat$Cancer[grep("Breast cancer", dat$Cancer, ignore.case=TRUE)] <- "Breast"
dat$Cancer[grep("Myeloma", dat$Cancer, ignore.case=TRUE)] <- "Myeloma"
dat$Cancer[grep("Colorectal", dat$Cancer, ignore.case=TRUE)] <- "Colorectal"
dat$Cancer[grep("Colon", dat$Cancer, ignore.case=TRUE)] <- "Colorectal"
dat$Cancer[grep("Esophageal", dat$Cancer, ignore.case=TRUE)] <- "Esophageal"
dat$Cancer[grep("Pancreatic", dat$Cancer, ignore.case=TRUE)] <- "Pancreatic"
dat$Cancer[grep("Lung", dat$Cancer, ignore.case=TRUE)] <- "Lung"
dat$Cancer[grep("Cervical", dat$Cancer, ignore.case=TRUE)] <- "Cervical"
dat$Cancer[grep("Ovarian", dat$Cancer, ignore.case=TRUE)] <- "Ovarian"
dat$Cancer[grep("Bladder", dat$Cancer, ignore.case=TRUE)] <- "Bladder"
dat$Cancer[grep("Glioma", dat$Cancer, ignore.case=TRUE)] <- "Glioma"
dat$Cancer[grep("Osteo", dat$Cancer, ignore.case=TRUE)] <- "Osteosarcoma"
dat$Cancer[grep("Gastric", dat$Cancer, ignore.case=TRUE)] <- "Gastric"
dat$Cancer[grep("Hepatoc", dat$Cancer, ignore.case=TRUE)] <- "Hepatocellular"

dat <- dat %>% filter(!grepl("adverse", Cancer, ignore.case=TRUE))
dat <- dat %>% filter(!grepl("obesity", Cancer, ignore.case=TRUE))
dat <- dat %>% filter(!grepl("smok", Cancer, ignore.case=TRUE))
dat <- dat %>% filter(!grepl("response", Cancer, ignore.case=TRUE))
dat <- dat %>% filter(!grepl("toxicity", Cancer, ignore.case=TRUE))

unique(dat$Cancer)

N <- nrow(dat)
ggplot(dat %>% arrange(Cancer), aes(1:N, OR, colour=Cancer)) + 
  geom_point(alpha = 1/10) +
  labs(x="Study", y = "OR") + 
  guides(fill=FALSE, colour=guide_legend(title=" ")) + 
  theme_classic() +
  theme(legend.position="none")



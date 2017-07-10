#######################################################################################
# options, libraries

setwd("~/Dropbox/projects/ebiGWASplot/gwasSNPs")

options(stringsAsFactors=FALSE)

library(readr)
library(dplyr)

#####################################################################################
# downloaded from http://www.ebi.ac.uk/gwas/ with search "cancer"

dat <- read_tsv("data/gwas-association-downloaded_2017-07-10-cancer.tsv")
head(dat)

# let's subset down a little and clean up names
names(dat)
dat <- dat %>% select(Cancer=`DISEASE/TRAIT`, Region=REGION, Chr=CHR_ID,
               Pos=CHR_POS, Context=CONTEXT, Intergenic=INTERGENIC, 
               RAF=`RISK ALLELE FREQUENCY`, OR=`OR or BETA`)

#####################################################################################
# 


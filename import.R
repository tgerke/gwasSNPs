#######################################################################################
# options, libraries

setwd("~/Dropbox/projects/ebiGWASplot")

options(stringsAsFactors=FALSE)

library(readr)
library(dplyr)

#####################################################################################

dat <- read_tsv("data/gwas-association-downloaded_2017-07-10-cancer.tsv")

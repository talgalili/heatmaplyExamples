## ----setup, include=FALSE------------------------------------------------
# knitr::opts_chunk$set(echo = TRUE, cache = TRUE)
knitr::opts_chunk$set(
   # cache = TRUE,
   dpi = 60,
  comment = '#>',
  tidy = FALSE)



## ------------------------------------------------------------------------
library(heatmaply)
library(dendextend)

## ------------------------------------------------------------------------
# rpkm50 <- read.delim("rpkm-50.txt",sep="\t",header=TRUE,dec=".",stringsAsFactors = FALSE,strip.white = TRUE)
### saveRDS(rpkm50, "data\\rpkm50.rda")
# http://r-pkgs.had.co.nz/data.html#data-data
# devtools::use_data(rpkm50)


library(heatmaplyExamples)
data(rpkm50)
head(rpkm50)

x <- as.matrix(rpkm50)
rc <- rainbow(nrow(x), start=0, end=.3)
cc <- rainbow(ncol(x), start=0, end=.3)
 
# pdf(file='heatmap-spearman.pdf')
hr <- hclust(as.dist(1-cor(t(x), method="spearman")), method="complete")# spearman clustering
hc <- hclust(as.dist(1-cor(x, method="spearman")), method="complete")# spearman clustering
library(gplots)
heatmap.2(x, col=bluered(75), Colv=as.dendrogram(hc), Rowv=as.dendrogram(hr), scale="row", key=T, keysize=1.5,density.info="none", trace="none",cexCol=0.9, cexRow=0.9,labRow=NA, dendrogram="both") # Z scores
# dev.off()
 



## ------------------------------------------------------------------------
library(heatmaply)
heatmaply(x, col=bluered(75), Colv=as.dendrogram(hc), Rowv=as.dendrogram(hr), scale="row",
          key=T, keysize=1.5,density.info="none", trace="none",
          cexCol=0.9, cexRow=0.9 ,
          labRow=NA, dendrogram="both"
          ) # Z scores

# heatmaply(x[1:100,])
# heatmaply(x[1:100,], labRow=NA)
# heatmaply(x[1:100,], # col=bluered(75), scale="row",
#           # key=T, keysize=1.5,density.info="none", trace="none",
#           cexCol=0.9,
#           # fontsize_row=.9,
#           # cexRow=0.9 ,
#           # labRow=NA,
#           dendrogram="both"
#           )


## ------------------------------------------------------------------------
sessionInfo()


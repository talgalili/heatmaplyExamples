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
# koala_gut_genes <- read.csv("Figure 3_table.csv")
# rownames(koala_gut_genes) <- koala_gut_genes[,1]
# koala_gut_genes <- koala_gut_genes[,-1]
# http://r-pkgs.had.co.nz/data.html#data-data
# devtools::use_data(koala_gut_genes)


library(heatmaplyExamples)
data(koala_gut_genes)
head(koala_gut_genes)




## ------------------------------------------------------------------------
library(heatmaply)
library(RColorBrewer)
library(scales) # for using a scaling of the colors which is similar to what appeared in the paper.

# display.brewer.all()
black_blue_fun <- gradient_n_pal(c("black", "royalblue1"), values = rescale(c(0,1:5,10,15,20,30,50,60,70,80,100)))
black_blue <- black_blue_fun(seq(0,1,length.out = 100))

heatmaply(koala_gut_genes, dendrogram=FALSE,
          col = black_blue, limits = c(0,100))



## ------------------------------------------------------------------------
library(viridis)
viridis_fun <- gradient_n_pal(viridis(100), values = rescale(c(0,1:5,10,15,20,30,50,60,70,80,100)))
viridis_cols <- viridis_fun(seq(0,1,length.out = 100))

heatmaply(koala_gut_genes, dendrogram=FALSE,
          col = viridis_cols, limits = c(0,100))



## ------------------------------------------------------------------------

heatmaply(koala_gut_genes, 
          col = viridis_cols, limits = c(0,100))


## ------------------------------------------------------------------------
sessionInfo()


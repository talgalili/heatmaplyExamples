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
mtcars2 <- datasets::mtcars
mtcars2$am <- factor(mtcars2$am)
mtcars2$gear <- factor(mtcars2$gear)
mtcars2$vs <- factor(mtcars2$vs)

library(heatmaply)
heatmaply(percentize(mtcars2), 
          xlab = "Features", ylab = "Cars", 
          main = "Motor Trend Car Road Tests",
          k_col = 2, k_row = NA,
          margins = c(60,100,40,20) )

## ------------------------------------------------------------------------
library(heatmaply)

heatmaply(cor(mtcars), margins = c(40, 40, 0, 0),
          k_col = 2, k_row = 2,
          colors = BrBG,
          limits = c(-1,1))

## ------------------------------------------------------------------------
iris <- datasets::iris

library(heatmaply)
library(dendextend)

iris2 <- iris[,-5]
rownames(iris2) <- 1:150
iris_dist <- iris2 %>% dist 
dend <- iris_dist %>% find_dend %>% seriate_dendrogram(., iris_dist)
dend_expend(iris_dist)$performance

heatmaply(iris, limits = c(0,8),
            xlab = "Lengths", ylab = "Flowers", 
            main = "Edgar Anderson's Iris Data",
          Rowv = dend,
          margins = c(85, 40),
          grid_gap = 0.2, k_row = 3)



## ------------------------------------------------------------------------

library(heatmaply)


airquality2 <- datasets::airquality
airquality2[,c(1:4,6)] <- is.na10(airquality2[,c(1:4,6)])
airquality2[,5] <- factor(airquality2[,5])

heatmaply(airquality2, grid_gap = 1,
            xlab = "Features", ylab = "Days", 
            main = "Missing values in 'New York Air Quality Measurements'",
            k_col =3, k_row = 3,
            margins = c(55, 30),
            colors = c("grey80", "grey20"))


# warning - using grid_color cannot handle a large matrix!
# airquality[1:10,] %>% is.na10 %>% 
#   heatmaply(color = c("white","black"), grid_color = "grey",
#             k_col =3, k_row = 3,
#             margins = c(40, 50)) 
# airquality %>% is.na10 %>% 
#   heatmaply(color = c("grey80", "grey20"), # grid_color = "grey",
#             k_col =3, k_row = 3,
#             margins = c(40, 50)) 
# 


## ----get_data------------------------------------------------------------

# Get needed packages:
if(!require("ALL")) {
  source("http://www.bioconductor.org/biocLite.R")
  biocLite("ALL")
}
if(!require("limma")) {
  source("http://www.bioconductor.org/biocLite.R")
  biocLite("limma")
}



library("ALL")
data("ALL")
eset <- ALL[, ALL$mol.biol %in% c("BCR/ABL", "ALL1/AF4")]
library("limma")
f <- factor(as.character(eset$mol.biol))
design <- model.matrix(~f)
fit <- eBayes(lmFit(eset,design))
selected  <- p.adjust(fit$p.value[, 2]) <0.05
esetSel <- eset [selected, ]
color.map <- function(mol.biol) { if (mol.biol=="ALL1/AF4") "#FF0000" else "#0000FF" }
patientcolors <- unlist(lapply(esetSel$mol.bio, color.map))
hm_data <- exprs(esetSel)


## ------------------------------------------------------------------------
heatmap(hm_data, col=topo.colors(100), ColSideColors=patientcolors)

## ------------------------------------------------------------------------
library("gplots")
heatmap.2(hm_data, col=topo.colors(100), scale="row", ColSideColors=patientcolors,
          key=TRUE, symkey=FALSE, density.info="none", trace="none", cexRow=0.5)

## ------------------------------------------------------------------------
library(heatmaply)


heatmaply(hm_data, color=topo.colors(100), ColSideColors=patientcolors, 
          seriate = "mean", scale="row", margin = c(65,120,10,10)) 
        # %>% layout(autosize = F, width = 500, height = 500)


## ------------------------------------------------------------------------
library(heatmaply)

heatmaply(hm_data, ColSideColors=patientcolors, 
          seriate = "mean", scale="row", margin = c(65,120,10,10)) 
        


## ------------------------------------------------------------------------
library(heatmaply)

heatmaply(hm_data, ColSideColors=patientcolors, 
          fontsize_row = 5,
          scale="row", margin = c(65,120,10,10), 
          k_col = 2, k_row = 5) 
        


## ---- eval = FALSE-------------------------------------------------------
#  
#  
#  heatmaply(hm_data, ColSideColors=patientcolors,
#            fontsize_row = 5,
#            scale="row", margin = c(50,50,10,10),
#            row_dend_left = TRUE, plot_method = "plotly",
#            k_col = 2, k_row = 5)
#  
#  

## ------------------------------------------------------------------------
votes.repub <- cluster::votes.repub

## ---- fig.height=5-------------------------------------------------------
years <- as.numeric(gsub("X", "", colnames(votes.repub)))

par(las = 2, mar = c(4.5, 3, 3, 2) + 0.1, cex = .8)
# MASS::parcoord(votes.repub, var.label = FALSE, lwd = 1)
matplot(1L:ncol(votes.repub), t(votes.repub), type = "l", col = 1, lty = 1,
        axes = F, xlab = "", ylab = "")
axis(1, at = seq_along(years), labels = years)
axis(2)
# Add Title
title("Votes for Republican Candidate\n in Presidential Elections \n (each line is a country - over the years)")

## ------------------------------------------------------------------------

# votes.repub[is.na(votes.repub)] <- 50

library(heatmaply)

heatmaply(votes.repub, 
          margins = c(60,150,110,10),
          k_row = NA,
          limits = c(0,100),
          main = "Votes for\n Republican Presidential Candidate\n (clustered using complete)",
          srtCol = 60,
          dendrogram = "row",
          ylab = "% Votes for Republican\n Presidential Candidate",
          colors = colorspace::diverge_hcl
         )
          # RowSideColors = rev(labels_colors(dend)), # to add nice colored strips		



## ------------------------------------------------------------------------
animals <- cluster::animals

colnames(animals) <- c("warm-blooded", 
                       "can fly",
                       "vertebrate",
                       "endangered",
                       "live in groups",
                       "have hair")

## ------------------------------------------------------------------------

# some_col_func <- function(n) rev(colorspace::heat_hcl(n, c = c(80, 30), l = c(30, 90), power = c(1/5, 1.5)))
# some_col_func <- colorspace::diverge_hcl
# some_col_func <- colorspace::sequential_hcl
some_col_func <- function(n) (colorspace::diverge_hcl(n, h = c(246, 40), c = 96, l = c(65, 90)))


library(heatmaply)

heatmaply(as.matrix(animals-1), 
          main = "Attributes of Animals",
          srtCol = 35,
          k_col = 3, k_row = 4,
          margins =c(80,50, 40,10),      
          col = some_col_func
         )


## ------------------------------------------------------------------------
sessionInfo()


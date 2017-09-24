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


## ---- eval=FALSE---------------------------------------------------------
#  
#  # measles
#  # bil gates (20 Feb 2015): https://twitter.com/BillGates/status/568749655112228865
#  # http://graphics.wsj.com/infectious-diseases-and-vaccines/#b02g20t20w15
#  # http://www.opiniomics.org/recreating-a-famous-visualisation/
#  # http://www.r-bloggers.com/recreating-the-vaccination-heatmaps-in-r-2/
#  
#  
#  
#  
#  # source: http://www.r-bloggers.com/recreating-the-vaccination-heatmaps-in-r/
#  # measles <- read.csv("https://raw.githubusercontent.com/blmoore/blogR/master/data/measles_incidence.csv", header=T,
#  #                     skip=2, stringsAsFactors=F)
#  # dir.create("data")
#  # write.csv(measles, file = "data\\measles.csv")
#  # measles[measles == "-"] <- NA
#  measles[,-(1:2)] <- apply(measles[,-(1:2)], 2, as.numeric)
#  
#  dim(measles)
#  # head(measles)
#  
#  d2 <- aggregate(measles, list(measles[, "YEAR"]), "sum", na.rm = T)
#  rownames(d2) <- d2[,1]
#  d2 <- d2[, -c(1:4)]
#  d2 <- t(d2)
#  # head(d2)
#  
#  dim(d2)
#  d2[1:5,1:5]
#  
#  md2 <- reshape2::melt(d2)
#  # head(md2)
#  #
#  # # per week
#  # d22 <- aggregate(measles, list(measles$YEAR, measles$WEEK), "sum", na.rm = T)
#  # rownames(d22) <- paste(d22[,1], d22[,2], sep = "_")
#  # d22 <- d22[, -c(1:5)]
#  # d22 <- t(d22)
#  # md22 <- reshape2::melt(d22)
#  # dim(d22) # 51 3952
#  
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  head(md2)

## ---- eval=FALSE---------------------------------------------------------
#  
#  # pander::pander(sqrt(d2))
#  if(!file.exists("data\\sqrt_d2.csv")) write.csv(sqrt(d2), file = "data\\sqrt_d2.csv")

## ---- eval=FALSE---------------------------------------------------------
#  
#  library(ggplot2)
#  ggplot(md2, aes(x = Var2, y = value)) + geom_line(aes(group = Var1)) + geom_smooth(size = 2)
#  ggplot(md2, aes(x = Var2, y = sqrt(value))) + geom_line(aes(group = Var1)) + geom_smooth(size = 2)
#  ggplot(md2, aes(x = Var2, y = log(value+.1))) + geom_line(aes(group = Var1)) + geom_smooth(size = 2)
#  
#  
#  
#  # ggplot(md22, aes(x = Var2, y = value)) + geom_line(aes(group = Var1)) # + geom_smooth(size = 2)
#  
#  #
#  # we miss the per state information and the patters of similarity
#  
#  
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  
#  
#  library(gplots)
#  library(viridis)
#  heatmap.2(d2)
#  heatmap.2(d2, margins = c(3, 9))
#  heatmap.2(d2,trace = "none", margins = c(3, 9))
#  heatmap.2(d2, trace = "none", margins = c(3, 9), dendrogram = "row", Colv = NULL)
#  # heatmap.2(sqrt(d2), Colv = NULL, trace = "none", margins = c(3, 9))
#  library(viridis)
#  heatmap.2(d2, Colv = NULL, trace = "none", col = viridis(200), margins = c(3, 9))
#  heatmap.2(sqrt(d2), Colv = NULL, trace = "none", col = viridis(200), margins = c(3, 9))
#  
#  # hist(d2, col = )
#  
#  library(ggplot2)
#  library(viridis)
#  hp <- qplot(x = as.numeric(d2), fill = ..count.., geom = "histogram")
#  hp + scale_fill_viridis(direction = -1) + xlab("Measles incedence") + theme_bw()
#  
#  
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  heatmap.2(d2, dendrogram = "row", Colv = NULL, trace = "none", margins = c(3, 9),
#            col = viridis(200),
#            scale = "row"
#            )
#  heatmap.2(d2, dendrogram = "row", Colv = NULL, trace = "none", margins = c(3, 9),
#            col = viridis(200),
#            scale = "column"
#            )
#  
#  
#  

## ---- eval=FALSE---------------------------------------------------------
#  DATA <- d2
#  d <- dist(sqrt(DATA))
#  
#  library(dendextend)
#  dend_expend(d)[[3]]
#  # average seems to make the most sense
#  
#  dend_row <- d %>% hclust(method = "average") %>% as.dendrogram
#  dend_row %>% highlight_branches %>% plot

## ---- eval=FALSE---------------------------------------------------------
#  
#  library(dendextend)
#  
#  dend_k <- find_k(dend_row)
#  plot(dend_k)
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  Rowv <- dend_row %>% color_branches(k = 3)
#  heatmap.2(sqrt(d2), Colv = NULL, Rowv = Rowv, trace = "none", col = viridis(200), margins = c(3, 9))
#  
#  Rowv <- dend_row %>% color_branches(k = 3) %>% seriate_dendrogram(x=d)
#  heatmap.2(sqrt(d2), Colv = NULL, Rowv = Rowv, trace = "none", col = viridis(200), margins = c(3, 9))
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  library(heatmaply)
#  heatmaply(sqrt(d2), Colv = NULL, hclust_method = "average",
#            fontsize_row = 8,fontsize_col = 6,
#            k_row = NA, margins = c(60,170, 70,40),
#            xlab = "Year", ylab = "State", main = "Project Tycho's heatmap visualization \nof the measles vaccine"
#          )
#  
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  heatmaply(sqrt(d2), Colv = NULL, hclust_method = "average",
#            fontsize_row = 8,fontsize_col = 6,
#            k_row = NA, margins = c(60,50, 70,90),
#            xlab = "Year", ylab = "State", main = "Project Tycho's heatmap visualization \nof the measles vaccine",
#            plot_method = "plotly", row_dend_left = TRUE
#          )
#  #
#  # heatmaply(sqrt(d2), Colv = NULL, hclust_method = "average",
#  #           fontsize_row = 8,fontsize_col = 6,
#  #           k_row = NA, margins = c(60,50, 70,90),
#  #           xlab = "Year", ylab = "State", main = "Project Tycho's heatmap visualization \nof the measles vaccine",
#  #           plot_method = "plotly", row_dend_left = TRUE, file = "measles.html"
#  #         )
#  

## ---- cache=FALSE--------------------------------------------------------
# save.image("example.Rdata")

## ------------------------------------------------------------------------
sessionInfo()


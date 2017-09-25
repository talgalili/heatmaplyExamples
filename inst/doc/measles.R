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
#  rownames(measles) <- d2[,1]
#  d2 <- d2[, -c(1:4)]
#  d2 <- t(measles)
#  # head(measles)
#  
#  dim(measles)
#  d2[1:5,1:5]
#  
#  # head(md2)
#  #
#  # # per week
#  # d22 <- aggregate(measles, list(measles$YEAR, measles$WEEK), "sum", na.rm = T)
#  # rownames(measles2) <- paste(measles2[,1], d22[,2], sep = "_")
#  # d22 <- d22[, -c(1:5)]
#  # d22 <- t(measles2)
#  # md22 <- reshape2::melt(measles2)
#  # dim(measles2) # 51 3952
#  
#  

## ---- eval=FALSE---------------------------------------------------------
#  
#  # pander::pander(sqrt(measles))
#  if(!file.exists("data\\sqrt_d2.csv")) write.csv(sqrt(measles), file = "data\\sqrt_d2.csv")

## ------------------------------------------------------------------------
library(heatmaplyExamples)
data(measles)
dim(measles)
md2 <- reshape2::melt(measles)
head(md2)

## ------------------------------------------------------------------------

library(ggplot2)
ggplot(md2, aes(x = Var2, y = value)) + geom_line(aes(group = Var1)) + geom_smooth(size = 2)
ggplot(md2, aes(x = Var2, y = sqrt(value))) + geom_line(aes(group = Var1)) + geom_smooth(size = 2)
ggplot(md2, aes(x = Var2, y = log(value+.1))) + geom_line(aes(group = Var1)) + geom_smooth(size = 2)



# ggplot(md22, aes(x = Var2, y = value)) + geom_line(aes(group = Var1)) # + geom_smooth(size = 2)

#
# we miss the per state information and the patters of similarity




## ------------------------------------------------------------------------



library(gplots)
library(viridis)
heatmap.2(measles)
heatmap.2(measles, margins = c(3, 9))
heatmap.2(measles,trace = "none", margins = c(3, 9))
heatmap.2(measles, trace = "none", margins = c(3, 9), dendrogram = "row", Colv = NULL)
# heatmap.2(sqrt(measles), Colv = NULL, trace = "none", margins = c(3, 9))
library(viridis)
heatmap.2(measles, Colv = NULL, trace = "none", col = viridis(200), margins = c(3, 9))
heatmap.2(sqrt(measles), Colv = NULL, trace = "none", col = viridis(200), margins = c(3, 9))

# hist(measles, col = )

library(ggplot2)
library(viridis)
hp <- qplot(x = as.numeric(measles), fill = ..count.., geom = "histogram")
hp + scale_fill_viridis(direction = -1) + xlab("Measles incedence") + theme_bw()




## ------------------------------------------------------------------------

heatmap.2(measles, dendrogram = "row", Colv = NULL, trace = "none", margins = c(3, 9),
          col = viridis(200), 
          scale = "row"
          )
heatmap.2(measles, dendrogram = "row", Colv = NULL, trace = "none", margins = c(3, 9),
          col = viridis(200), 
          scale = "column"
          )




## ------------------------------------------------------------------------
DATA <- measles
d <- dist(sqrt(DATA))

library(dendextend)
dend_expend(d)[[3]]
# average seems to make the most sense

dend_row <- d %>% hclust(method = "average") %>% as.dendrogram 
dend_row %>% highlight_branches %>% plot

## ------------------------------------------------------------------------

library(dendextend)

dend_k <- find_k(dend_row)
plot(dend_k)


## ------------------------------------------------------------------------

Rowv <- dend_row %>% color_branches(k = 3)
heatmap.2(sqrt(measles), Colv = NULL, Rowv = Rowv, trace = "none", col = viridis(200), margins = c(3, 9))

Rowv <- dend_row %>% color_branches(k = 3) %>% seriate_dendrogram(x=d)
heatmap.2(sqrt(measles), Colv = NULL, Rowv = Rowv, trace = "none", col = viridis(200), margins = c(3, 9))


## ---- fig.width=12, fig.height=8-----------------------------------------

library(heatmaply)
heatmaply(sqrt(measles), Colv = NULL, hclust_method = "average", 
          fontsize_row = 8,fontsize_col = 6,
          k_row = NA, margins = c(60,170, 70,40),
          xlab = "Year", ylab = "State", main = "Project Tycho's heatmap visualization \nof the measles vaccine"
        ) 



## ---- fig.width=12, fig.height=8-----------------------------------------

heatmaply(sqrt(measles), Colv = NULL, hclust_method = "average", 
          fontsize_row = 8,fontsize_col = 6,
          k_row = NA, margins = c(60,50, 70,90),
          xlab = "Year", ylab = "State", main = "Project Tycho's heatmap visualization \nof the measles vaccine",
          plot_method = "plotly", row_dend_left = TRUE
        ) 


## ---- cache=FALSE--------------------------------------------------------
# save.image("example.Rdata")

## ------------------------------------------------------------------------
sessionInfo()


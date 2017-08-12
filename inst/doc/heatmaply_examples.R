## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, cache = TRUE)

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
save.image("example.Rdata")


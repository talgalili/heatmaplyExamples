## ---- echo = FALSE, message = FALSE--------------------------------------
library(heatmaply)
library(heatmaplyExamples)
library(knitr)
knitr::opts_chunk$set(
   # cache = TRUE,
   dpi = 60,
  comment = '#>',
  tidy = FALSE)


## ------------------------------------------------------------------------
suppressPackageStartupMessages(library(glmnet))
## Example data from the glmnet package
data(CoxExample)

## Fit ridge regression model
fit1 <- glmnet(x, y, 
  family="cox", 
  nlambda=500, 
  alpha=0)

## Visualise coefficients at different values of lambda
plot(fit1, "lambda")



## Fit LASSO regression model
fit2 <- glmnet(x, y, 
  family="cox", 
  nlambda=500, 
  alpha=1)

## Visualise coefficients at different values of lambda
plot(fit2, "lambda")


## ---- warning=FALSE------------------------------------------------------
beta1 <- as.matrix(fit1$beta)
heatmaply(beta1, dendrogram="row",
  main = "Heatmap of ridge regression model coefficients over range of lambda values",
  margins = c(50,40),
  limits = c(-max(abs(beta1)), max(abs(beta1))), # to make sure 0 is in the center of the colors
  col = cool_warm, grid_gap = 0.5, k_row = 5
  )


## ---- warning=FALSE------------------------------------------------------
beta2 <- as.matrix(fit2$beta)
heatmaply(beta2, dendrogram="row", plot_method = "plotly",
    main = "Heatmap of LASSO model coefficients over range of lambda values",
    margins = c(50,40),
      limits = c(-max(abs(beta2)), max(abs(beta2))), # to make sure 0 is in the center of the colors
  col = cool_warm, grid_gap = 0.5, k_row = 5
    )


## ------------------------------------------------------------------------
sessionInfo()


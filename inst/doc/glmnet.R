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


## ------------------------------------------------------------------------
beta1 <- as.matrix(fit1$beta)
heatmaply(beta1, dendrogram="row",
  main = "Heatmap of ridge regression model coefficients over range of lambda values")

beta2 <- as.matrix(fit2$beta)
heatmaply(beta2, dendrogram="row",
    main = "Heatmap of LASSO model coefficients over range of lambda values")



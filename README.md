
# heatmaplyExamples

## heatmaply status

[![Build Status](https://travis-ci.org/talgalili/heatmaply.png?branch=master)](https://travis-ci.org/talgalili/heatmaply)
[![codecov.io](https://codecov.io/github/talgalili/heatmaply/coverage.svg?branch=master)](https://codecov.io/github/talgalili/heatmaply?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/heatmaply)](https://cran.r-project.org/package=heatmaply)
![](http://cranlogs.r-pkg.org/badges/heatmaply?color=yellow)
![](http://cranlogs.r-pkg.org/badges/grand-total/heatmaply?color=yellowgreen)


## Please submit examples

This package is still under active development. If you have examples you would like to have added, please submit them at: <https://github.com/talgalili/heatmaplyExamples/issues>  (or fork and open a PR)


## Introduction

The <https://github.com/talgalili/heatmaply/>(heatmaply) R package facilitates the creation of interactive heatmaps which allow the inspection of specific value by hovering the mouse over a cell, as well as zooming into a region of the heatmap by dragging a rectangle around the relevant area.

The heatmaplyExamples package hosts examples of using heatmaply on real-world datasets and use-cases. Due to the size of some of the datasets, and resulting vignettes, this package will only be available through this github. 


## Available examples

The following examples are available within the package. You may also view them online in the following links:

* [Using heatmaply with biological data](http://htmlpreview.github.com/?https://github.com/talgalili/heatmaplyExamples/blob/master/inst/doc/biological_data.html)
* [Using heatmaply with biological data - preprocessing](http://htmlpreview.github.com/?https://github.com/talgalili/heatmaplyExamples/blob/master/inst/doc/data_preprocessing.html)
* [Using heatmaply with non-centred RNAseq heatmaps (PAM50 genes) ](http://htmlpreview.github.com/?https://github.com/talgalili/heatmaplyExamples/blob/master/inst/doc/non_centred_heatmaps.html)
* [Using heatmaply with glmnet](http://htmlpreview.github.com/?https://github.com/talgalili/heatmaplyExamples/blob/master/inst/doc/glmnet.html)
* [Using heatmaply with famous data sets](http://htmlpreview.github.com/?https://github.com/talgalili/heatmaplyExamples/blob/master/inst/doc/heatmaply_examples.html)



## Reproducing the examples on your own computer

To run the examples from this repo, first install the following packages:

```r
install.packages("tidyverse")
install.packages("plotly")
install.packages('heatmaply')
install.packages('glmnet')



# In order to fully replicate the examples here, you will also need to install the following packages:

## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite("SummarizedExperiment")     ## R version 2.15 or later
biocLite("biomaRt")     
biocLite("limma")   
biocLite("voom")
biocLite("TCGAbiolinks")


```


And then you may install/load the package using:

```r
devtools::install_github("talgalili/heatmaplyExamples", build_vignettes = TRUE)

# if fetching the repo, you can also use:
# devtools::build_vignettes()
```

Finally, you may browse the vignettes using:

```r
# tools::pkgVignettes("heatmaplyExamples")
# tools::buildVignettes("heatmaplyExamples")
library("heatmaplyExamples")
browseVignettes("heatmaplyExamples")
```






## Acknowledgements


This package is thanks to the amazing work done by MANY people in the open source community. Beyond the many people working on the pipeline of R, thanks should go to the people working on ggplot2 (Hadley Wickham, etc.) and plotly (Carson Sievert, etc.). Also, many of the design elements were inspired by the work done on heatmap, heatmap.2 and d3heatmap, so special thanks goes to the R core team, Gregory R. Warnes, and Joe Cheng from RStudio. The dendrogram side of the package is based on the work in dendextend, in which special thanks should go to Andrie de Vries for his original work on bringing dendrograms to ggplot2 (which evolved into the richer ggdend objects, as implemented in dendextend). 

The work on heatmaply was done by Tal Galili, Alan O'Callaghan, and Jonathan Sidi (mostly on shinyHeatmaply).


**Funding**: This work was supported in part by the European Union Seventh Framework Programme (FP7/2007-2013) under grant agreement no. 604102 (Human Brain Project).  


## Contact

You are welcome to:

* submit suggestions and bug-reports at: <https://github.com/talgalili/heatmaplyExamples/issues>
* send a pull request on: <https://github.com/talgalili/heatmaplyExamples/>
* compose a friendly e-mail to: <tal.galili@gmail.com>


## Latest news

You can see the most recent changes to the package in the [NEWS.md file](https://github.com/talgalili/heatmaplyExamples/blob/master/NEWS.md)





## Code of conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.


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

pam50_genes <- intersect(pam50_genes, rownames(tcga_breast_expression))
raw_pam50_expression <- tcga_breast_expression[pam50_genes, ]


dge <- edgeR::DGEList(counts = tcga_breast_expression)
dge <- edgeR::calcNormFactors(dge, method = "TMM")
voomed_tcga_expression <- limma::voom(dge, normalize.method="quantile")
voomed_tcga_expression <- voomed_tcga_expression$E

voomed_pam50_expression <- voomed_tcga_expression[pam50_genes, ]

cor_distfun <- function(x) as.dist(1 - cor(t(x)))


log_raw_mat <- log2(raw_pam50_expression + 0.5)



heatmaply(t(log_raw_mat),
    row_side_colors = tcga_brca_clinical,
    showticklabels = c(TRUE, FALSE),
    fontsize_col = 7.5,
    distfun = cor_distfun,
    col = gplots::bluered(50),
    main = 'log2 expression of count data (pam50 genes)',
    plot_method = 'plotly')


heatmaply_cor(cor(log_raw_mat), 
    row_side_colors = tcga_brca_clinical,
    showticklabels = c(FALSE, FALSE),
    main = 'Sample correlation of raw count data (pam50 genes)',
    plot_method = 'plotly')

## ------------------------------------------------------------------------


heatmaply(t(voomed_pam50_expression), 
    row_side_colors = tcga_brca_clinical,
    showticklabels = c(TRUE, FALSE),
    fontsize_col = 7.5,
    distfun = cor_distfun,
    col = gplots::bluered(50),
    main = 'Normalised RNAseq gene expression data (pam50 genes)',
    plot_method = 'plotly')


heatmaply_cor(cor(voomed_pam50_expression), 
    row_side_colors = tcga_brca_clinical,
    showticklabels = c(FALSE, FALSE),
    main = 'Sample correlation of normalised pam50 genes',
    plot_method = 'plotly')




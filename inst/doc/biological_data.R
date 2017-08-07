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
cor_mat_raw_logged <- cor(log2(tcga_breast_expression + 0.5))

heatmaply(cor_mat_raw_logged, 
    row_side_colors = tcga_brca_clinical,
    main = 'Correlation of log2 count data (all genes)',
    showticklabels = c(FALSE, FALSE),
    subplot_widths = c(0.7, 0.1, 0.2),
    plot_method = 'plotly')


## ------------------------------------------------------------------------


dge <- edgeR::DGEList(counts = tcga_breast_expression)
dge <- edgeR::calcNormFactors(dge, method = "TMM")
voomed_tcga_expression <- limma::voom(dge, normalize.method="quantile")


voomed_tcga_expression <- limma::voom(tcga_breast_expression)
voomed_tcga_expression <- voomed_tcga_expression$E

cor_mat_voomed <- cor(voomed_tcga_expression)

heatmaply(cor_mat_voomed,
    row_side_colors = tcga_brca_clinical,
    main = 'Correlation of normalised data (all genes)',
    showticklabels = c(FALSE, FALSE),
    subplot_widths = c(0.7, 0.1, 0.2),
    plot_method = 'plotly')


## ------------------------------------------------------------------------
pam50_genes <- intersect(pam50_genes, rownames(tcga_breast_expression))
raw_pam50_expression <- tcga_breast_expression[pam50_genes, ]
voomed_pam50_expression <- voomed_tcga_expression[pam50_genes, ]


log_mat <- log2(raw_pam50_expression + 0.5)
center_raw_mat <- log_mat - 
    apply(log_mat, 1, median)

raw_max <- max(abs(center_raw_mat), na.rm=TRUE)
raw_limits <- c(-raw_max, raw_max)

cor_distfun <- function(x) as.dist(1 - cor(t(x)))

heatmaply(t(center_raw_mat),
    distfun = cor_distfun,
    row_side_colors = tcga_brca_clinical,
    showticklabels = c(TRUE, FALSE),
    fontsize_col = 7.5,
    col = gplots::bluered(50),
    main = 'Centred log2 counts of pam50 genes',
    limits = raw_limits,
    plot_method = 'plotly')



## ------------------------------------------------------------------------
center_voom_mat <- voomed_pam50_expression - 
    apply(voomed_pam50_expression, 1, median)

voom_max <- max(abs(center_voom_mat))
voom_limits <- c(-voom_max, voom_max)



heatmaply(t(center_voom_mat),
    distfun = cor_distfun,
    row_side_colors=tcga_brca_clinical,
    fontsize_col = 7.5,
    showticklabels = c(TRUE, FALSE),
    col = gplots::bluered(50),
    limits = voom_limits,
    main = 'Normalised expression of pam50 genes',
    plot_method = 'plotly')



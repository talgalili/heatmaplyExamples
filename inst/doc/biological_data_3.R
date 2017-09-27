## ---- echo = FALSE, message = FALSE--------------------------------------
library(knitr)
knitr::opts_chunk$set(
   # cache = TRUE,
   dpi = 60,
  comment = '#>',
  tidy = FALSE)


## ------------------------------------------------------------------------
# Let's load the packages
library(heatmaply)
library(heatmaplyExamples)

## ------------------------------------------------------------------------
center_voom_mat <- voomed_pam50_expression - 
    apply(voomed_pam50_expression, 1, median)

voom_max <- max(abs(center_voom_mat))
voom_limits <- c(-voom_max, voom_max)


heatmaply(t(center_voom_mat), 
    row_side_colors=tcga_brca_clinical,
    fontsize_col = 7.5,
    showticklabels = c(TRUE, FALSE),
    col = cool_warm(50),
    limits = voom_limits,
    main = 'Normalised, centred log2 CPM, PAM50 genes',
    plot_method = 'plotly')


## ---- fig.width=13, fig.height=10----------------------------------------

heatmaply_cor(cor(center_voom_mat), 
    row_side_colors = tcga_brca_clinical,
    showticklabels = c(FALSE, FALSE),
    main = 'Sample-sample correlation based on centred, normalised PAM50 gene expression',
    plot_method = 'plotly')


## ------------------------------------------------------------------------
sessionInfo()


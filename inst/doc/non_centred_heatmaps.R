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

pam50_genes <- intersect(pam50_genes, rownames(raw_expression))
raw_pam50_expression <- raw_expression[pam50_genes, ]
voomed_pam50_expression <- voomed_expression[pam50_genes, ]

log_raw_mat <- log2(raw_pam50_expression + 0.5)

heatmaply(t(log_raw_mat), 
    row_side_colors = tcga_brca_clinical,
    showticklabels = c(TRUE, FALSE),
    fontsize_col = 7.5,
    col = gplots::bluered(50),
    main = 'raw pam50',
    plot_method = 'plotly')


heatmaply_cor(cor(log_raw_mat), 
    row_side_colors = tcga_brca_clinical,
    showticklabels = c(FALSE, FALSE),
    main = 'correlation of raw pam50',
    plot_method = 'plotly')




heatmaply(t(voomed_pam50_expression), 
    row_side_colors = tcga_brca_clinical,
    showticklabels = c(TRUE, FALSE),
    fontsize_col = 7.5,
    col = gplots::bluered(50),
    main = 'voomed pam50',
    plot_method = 'plotly')


heatmaply_cor(cor(voomed_pam50_expression), 
    row_side_colors = tcga_brca_clinical,
    showticklabels = c(FALSE, FALSE),
    main = 'correlation of voomed pam50',
    plot_method = 'plotly')




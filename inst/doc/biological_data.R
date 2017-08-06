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
cor_mat_raw_logged <- cor(log2(raw_expression + 0.5))

heatmaply(cor_mat_raw_logged, 
    row_side_colors = tcga_brca_clinical,
    main = 'log2 Count data correlation',
    showticklabels = c(FALSE, FALSE),
    subplot_widths = c(0.7, 0.1, 0.2),
    plot_method = 'plotly')


## ------------------------------------------------------------------------

cor_mat_voomed <- cor(voomed_expression)

heatmaply(cor_mat_voomed, 
    row_side_colors = tcga_brca_clinical,
    main = 'log2 cpm data correlation',
    showticklabels = c(FALSE, FALSE),
    subplot_widths = c(0.7, 0.1, 0.2),
    plot_method = 'plotly')


## ------------------------------------------------------------------------
pam50_genes <- intersect(pam50_genes, rownames(raw_expression))
raw_pam50_expression <- raw_expression[pam50_genes, ]
voomed_pam50_expression <- voomed_expression[pam50_genes, ]

center_raw_mat <- cor_mat_raw_logged - 
    apply(cor_mat_raw_logged, 1, median)

raw_max <- max(abs(center_raw_mat), na.rm=TRUE)
raw_limits <- c(-raw_max, raw_max)


heatmaply(t(center_raw_mat), 
    row_side_colors = tcga_brca_clinical,
    showticklabels = c(TRUE, FALSE),
    fontsize_col = 7.5,
    col = gplots::bluered(50),
    main = 'raw centered pam50',
    limits = raw_limits,
    plot_method = 'plotly')


heatmaply_cor(cor(center_raw_mat), 
    row_side_colors = tcga_brca_clinical,
    showticklabels = c(FALSE, FALSE),
    main = 'correlation of raw centered pam50',
    plot_method = 'plotly')



## ------------------------------------------------------------------------
center_voom_mat <- voomed_pam50_expression - 
    apply(voomed_pam50_expression, 1, median)

voom_max <- max(abs(center_voom_mat))
voom_limits <- c(-voom_max, voom_max)


heatmaply(t(center_voom_mat), 
    row_side_colors=tcga_brca_clinical,
    fontsize_col = 7.5,
    showticklabels = c(TRUE, FALSE),
    col = gplots::bluered(50),
    limits = voom_limits,
    main = 'voomed pam50',
    plot_method = 'plotly')


heatmaply_cor(cor(center_voom_mat), 
    row_side_colors = tcga_brca_clinical,
    showticklabels = c(FALSE, FALSE),
    main = 'correlation of voomed pam50',
    plot_method = 'plotly')



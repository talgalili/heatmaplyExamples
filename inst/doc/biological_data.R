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
    main = 'Sample-sample correlation, log2 counts',
    showticklabels = c(FALSE, FALSE),
    plot_method = 'plotly')


## ------------------------------------------------------------------------

cor_mat_voomed <- cor(voomed_expression)

heatmaply(cor_mat_voomed, 
    row_side_colors = tcga_brca_clinical,
    main = 'Sample-sample correlation, log2 CPM',
    showticklabels = c(FALSE, FALSE),
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
    showticklabels = c(FALSE, FALSE),
    fontsize_col = 7.5,
    col = gplots::bluered(50),
    main = 'Centred log2 read counts, PAM50 genes',
    limits = raw_limits,
    plot_method = 'plotly')


heatmaply_cor(cor(center_raw_mat), 
    row_side_colors = tcga_brca_clinical,
    showticklabels = c(FALSE, FALSE),
    main = 'Sample-sample correlation based on centred, log2 PAM50 read counts',
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
    main = 'Normalised, centred log2 CPM, PAM50 genes',
    plot_method = 'plotly')


heatmaply_cor(cor(center_voom_mat), 
    row_side_colors = tcga_brca_clinical,
    showticklabels = c(FALSE, FALSE),
    main = 'Sample-sample correlation based on centred, normalised PAM50 gene expression',
    plot_method = 'plotly')



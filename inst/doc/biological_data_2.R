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
pam50_genes <- intersect(pam50_genes, rownames(raw_expression))
raw_pam50_expression <- raw_expression[pam50_genes, ]
voomed_pam50_expression <- voomed_expression[pam50_genes, ]

center_raw_mat <- cor_mat_raw_logged - 
    apply(cor_mat_raw_logged, 1, median)

raw_max <- max(abs(center_raw_mat), na.rm=TRUE)
raw_limits <- c(-raw_max, raw_max)


## ------------------------------------------------------------------------

heatmaply(t(center_raw_mat), 
    row_side_colors = tcga_brca_clinical,
    showticklabels = c(FALSE, FALSE),
    fontsize_col = 7.5,
    col = cool_warm(100),
    main = 'Centred log2 read counts, PAM50 genes',
    limits = raw_limits,
    plot_method = 'plotly')



## ---- fig.width=13, fig.height=10----------------------------------------
heatmaply_cor(cor(center_raw_mat), 
    row_side_colors = tcga_brca_clinical,
    showticklabels = c(FALSE, FALSE),
    main = 'Sample-sample correlation based on centred, log2 PAM50 read counts',
    plot_method = 'plotly')


## ------------------------------------------------------------------------
sessionInfo()


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

## ---- eval=FALSE---------------------------------------------------------
#  ## This script downloads the expression data for all breast cancer samples
#  ## from GDC/TCGA, and filters them to have only the genes in the
#  ## PAM50 gene set
#  
#  library('TCGAbiolinks')
#  library('SummarizedExperiment')
#  library('biomaRt')
#  library('voom')
#  
#  
#  query <- GDCquery(project = 'TCGA-BRCA',
#      data.category = 'Transcriptome Profiling',
#      data.type = 'Gene Expression Quantification',
#      workflow.type = 'HTSeq - Counts'
#  )
#  
#  GDCdownload(query)
#  data <- GDCprepare(query)
#  
#  ## Retain only tumour samples
#  ind_tumor <- colData(data)[['definition']]== 'Primary solid Tumor'
#  data <- data[, ind_tumor]
#  
#  ## Annotate using biomaRt
#  mart <- useDataset('hsapiens_gene_ensembl', useMart('ensembl'))
#  genes <- rownames(data)
#  symbols <- getBM(filters= 'ensembl_gene_id',
#      attributes= c('ensembl_gene_id','hgnc_symbol'),
#      values = genes,
#      mart= mart)
#  
#  ## Remove those not annotated
#  ind_nchar <- as.logical(nchar(symbols[['hgnc_symbol']]))
#  symbols <- symbols[ind_nchar, ]
#  data <- data[symbols[['ensembl_gene_id']], ]
#  rownames(data) <- symbols[['hgnc_symbol']]
#  
#  ## Subset to those annotated with a symbol here
#  pam50_genes <- intersect(pam50_genes, symbols[['hgnc_symbol']])
#  
#  
#  
#  clinical_cols <- c('subtype_Integrated.Clusters..with.PAM50.',
#      'subtype_ER.Status',
#      'subtype_PR.Status',
#      'subtype_HER2.Final.Status'
#  )
#  
#  ## Only interested in those which have all subtypes.
#  subtypes <- colData(data)[, clinical_cols]
#  ind_has_subtypes <- sapply(seq_len(nrow(subtypes)),
#      function(i) {
#          all(!is.na(subtypes[i, ]))
#      })
#  data <- data[, ind_has_subtypes]
#  
#  
#  tcga_brca_clinical <- colData(data)
#  tcga_brca_clinical <- tcga_brca_clinical[, clinical_cols]
#  colnames(tcga_brca_clinical) <- gsub('subtype_', '', colnames(tcga_brca_clinical))
#  
#  stypes <- c('ER.Status', 'PR.Status', 'HER2.Final.Status')
#  
#  tcga_brca_clinical[, stypes] <- lapply(tcga_brca_clinical[, stypes],
#      function(col) {
#          col <- as.character(col)
#          ifelse(col %in% c('Positive', 'Negative'), col, NA)
#      }
#  )
#  
#  ## Set up final objects
#  tcga_brca_clinical <- as.data.frame(tcga_brca_clinical)
#  expression <- assay(data, 'HTSeq - Counts')
#  expression <- expression[!duplicated(rownames(expression)), ]
#  
#  voomed_expression <- as.matrix(voom(expression))
#  raw_expression <- expression
#  

## ---- fig.width=13, fig.height=10----------------------------------------
cor_mat_raw_logged <- cor(log2(raw_expression + 0.5))

heatmaply(cor_mat_raw_logged, 
    row_side_colors = tcga_brca_clinical,
    main = 'Sample-sample correlation, log2 counts',
    showticklabels = c(FALSE, FALSE),
    plot_method = 'plotly')


## ------------------------------------------------------------------------
cor_mat_voomed <- cor(voomed_expression) 


## ---- fig.width=13, fig.height=10, eval = FALSE--------------------------
#  
#  heatmaply(cor_mat_voomed,
#      row_side_colors = tcga_brca_clinical,
#      main = 'Sample-sample correlation, log2 CPM',
#      showticklabels = c(FALSE, FALSE),
#      plot_method = 'plotly')
#  

## ------------------------------------------------------------------------
identical(as.vector(cor_mat_voomed) ,as.vector(cor_mat_raw_logged))
cor(as.vector(cor_mat_voomed) ,as.vector(cor_mat_raw_logged))


## ------------------------------------------------------------------------
pam50_genes <- intersect(pam50_genes, rownames(raw_expression))
raw_pam50_expression <- raw_expression[pam50_genes, ]
voomed_pam50_expression <- voomed_expression[pam50_genes, ]

center_raw_mat <- cor_mat_raw_logged - 
    apply(cor_mat_raw_logged, 1, median)

raw_max <- max(abs(center_raw_mat), na.rm=TRUE)
raw_limits <- c(-raw_max, raw_max)


## ---- eval = FALSE-------------------------------------------------------
#  
#  heatmaply(t(center_raw_mat),
#      row_side_colors = tcga_brca_clinical,
#      showticklabels = c(FALSE, FALSE),
#      fontsize_col = 7.5,
#      col = cool_warm(100),
#      main = 'Centred log2 read counts, PAM50 genes',
#      limits = raw_limits,
#      plot_method = 'plotly')
#  
#  

## ---- fig.width=13, fig.height=10, eval = FALSE--------------------------
#  heatmaply_cor(cor(center_raw_mat),
#      row_side_colors = tcga_brca_clinical,
#      showticklabels = c(FALSE, FALSE),
#      main = 'Sample-sample correlation based on centred, log2 PAM50 read counts',
#      plot_method = 'plotly')
#  

## ---- eval = FALSE-------------------------------------------------------
#  center_voom_mat <- voomed_pam50_expression -
#      apply(voomed_pam50_expression, 1, median)
#  
#  voom_max <- max(abs(center_voom_mat))
#  voom_limits <- c(-voom_max, voom_max)
#  
#  
#  heatmaply(t(center_voom_mat),
#      row_side_colors=tcga_brca_clinical,
#      fontsize_col = 7.5,
#      showticklabels = c(TRUE, FALSE),
#      col = cool_warm(50),
#      limits = voom_limits,
#      main = 'Normalised, centred log2 CPM, PAM50 genes',
#      plot_method = 'plotly')
#  

## ---- fig.width=13, fig.height=10, eval = FALSE--------------------------
#  
#  heatmaply_cor(cor(center_voom_mat),
#      row_side_colors = tcga_brca_clinical,
#      showticklabels = c(FALSE, FALSE),
#      main = 'Sample-sample correlation based on centred, normalised PAM50 gene expression',
#      plot_method = 'plotly')
#  

## ------------------------------------------------------------------------
sessionInfo()


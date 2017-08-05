---
title: "Using heatmaply with biological data (mutational and gene expression data)"
date: "2017-08-04"
author: "Alan O'Callaghan"
output:
  html_document:
    self_contained: yes
    toc: true
    fig_width: 15
    fig_height: 15
    depth: 3  # upto three depths of headings (specified by #, ## and ###)  
    number_sections: true  ## if you want number sections at each table header
    theme: yeti  # many options for theme, this one is my favorite.
    highlight: tango  # specifies the syntax highlighting style
---
<!--
%\VignetteEngine{knitr::rmarkdown}
%\VignetteIndexEntry{Using heatmaply with biological data}
-->



**Author**: Alan O'Callaghan (alan.b.ocallaghan@gmail.com)




Introduction
============

- Get data from TCGAbiolinks
- Remove samples
- See if samples cluster based on receptor status
- Subset to PAM50 genes
- See if samples cluster based on receptor status
- Compare voom and normal log2
- Demonstrate outlier detection


Data pre-processing
=================


```r
## This script downloads the expression data for all breast cancer samples
## from GDC/TCGA, and filters them to have only the genes in the 
## PAM50 gene set

library('TCGAbiolinks')
library('SummarizedExperiment')
library('biomaRt')
library('voom')


query <- GDCquery(project = 'TCGA-BRCA',
    data.category = 'Transcriptome Profiling',
    data.type = 'Gene Expression Quantification',
    workflow.type = 'HTSeq - Counts'
)

GDCdownload(query)
data <- GDCprepare(query)

## Retain only tumour samples
ind_tumor <- colData(data)[['definition']]== 'Primary solid Tumor'
data <- data[, ind_tumor]

## Annotate using biomaRt
mart <- useDataset('hsapiens_gene_ensembl', useMart('ensembl'))
genes <- rownames(data)
symbols <- getBM(filters= 'ensembl_gene_id', 
    attributes= c('ensembl_gene_id','hgnc_symbol'), 
    values = genes, 
    mart= mart)

## Remove those not annotated
ind_nchar <- as.logical(nchar(symbols[['hgnc_symbol']]))
symbols <- symbols[ind_nchar, ]
data <- data[symbols[['ensembl_gene_id']], ]
rownames(data) <- symbols[['hgnc_symbol']]

## Subset to those annotated with a symbol here
pam50_genes <- intersect(pam50_genes, symbols[['hgnc_symbol']])



clinical_cols <- c('subtype_ER.Status', 'subtype_PR.Status', 
    'subtype_HER2.Final.Status', 
    'subtype_Integrated.Clusters..with.PAM50.'
)

## Only interested in those which have all subtypes.
subtypes <- colData(data)[, clinical_cols]
ind_has_subtypes <- sapply(seq_len(nrow(subtypes)), 
    function(i) {
        all(!is.na(subtypes[i, ]))
    })
data <- data[, ind_has_subtypes]


tcga_brca_clinical <- colData(data)
tcga_brca_clinical <- tcga_brca_clinical[, clinical_cols]
colnames(tcga_brca_clinical) <- gsub('subtype_', '', colnames(tcga_brca_clinical))

stypes <- c('ER.Status', 'PR.Status', 'HER2.Final.Status')

tcga_brca_clinical[, stypes] <- lapply(tcga_brca_clinical[, stypes], 
    function(col) {
        col <- as.character(col)
        ifelse(col %in% c('Positive', 'Negative'), col, NA)
    }
)

## Set up final objects
tcga_brca_clinical <- as.data.frame(tcga_brca_clinical)
expression <- assay(data, 'HTSeq - Counts')
expression <- expression[!duplicated(rownames(expression)), ]

voomed_expression <- as.matrix(voom(expression))
raw_expression <- expression
```

heatmaply workflow
==================









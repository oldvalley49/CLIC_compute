# computing scores without pseudobulking

library(rtracklayer)
library(GenomicRanges)
library(Matrix)
library(ggplot2)
library(dplyr)
library(preprocessCore)
library(glue)
library(stringr)
library(Seurat)

# load samples
all_samples_tissue_df = read.csv("metadata/ENCODE_metadata_mouse.csv")
samples <- all_samples_tissue_df$multiomics_series
data_list <- list()
for (sample in samples){
    data <- readRDS(glue("output/init_obj/mouse/{sample}.rds"))
    colnames(data) <- paste0(sample, "_", colnames(data))
    data_list[[sample]] <- data
}


rna_list <- lapply(data_list, function(x) x[["RNA"]]$counts)
activity_list <- lapply(data_list, function(x) x[["ACTIVITY"]]$counts)

rm(data_list)

# combine data into one matrix
rna_counts <- do.call(cbind, rna_list)
activity_counts <- do.call(cbind, activity_list)

rm(rna_list)
rm(activity_list)
rna_counts <- rna_counts[rownames(activity_counts), ]

rna_counts <- NormalizeData(rna_counts)
rna_data <- as.data.frame(normalize.quantiles(as.matrix(rna_counts), keep.names = TRUE))
rm(rna_counts)

activity_counts <- NormalizeData(activity_counts)
activity_data <- as.data.frame(normalize.quantiles(as.matrix(activity_counts), keep.names = TRUE))
rm(activity_counts)

saveRDS(rna_data, "output/normalized_data/mouse_rna_sc.rds")
saveRDS(activity_data, "output/normalized_data/mouse_activity_sc.rds")

rna_data <- as.matrix(rna_data)
activity_data <- as.matrix(activity_data)
genes <- rownames(rna_data)
correlation <- data.frame(matrix(NA, nrow = length(genes), ncol = 1 ))
colnames(correlation) <- c("pearson_correlation")
rownames(correlation) <- genes
for (gene in genes){
    correlation[gene, "pearson_correlation"] <- cor(rna_data[gene, ], activity_data[gene, ], method = "pearson")
}
write.csv(correlation, "output/scores/mouse_scores_sc.csv")
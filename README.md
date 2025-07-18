# ENCODE_score
This repository contains code for computing CLIC scores used to guide feature selection in integration scRNA-seq and scATAC-seq data. 

Software: link pending
Preprint: link pending
Benchmark: link pending

# Reproducing
For those who may want to recompute CLIC scores with new/additional data, please use the following steps

1. Download the ENCODE raw sequencing data
2. Process using Cell Ranger and deposit the output in `data/{species}/` for human and mouse respectively
3. Add accession numbers in `ENCODE_human.txt` or `ENCODE_mouse.txt`
4. For each species, run `init_seurat.sh`, `integrate_harmonny.sh`, `pseudobulk.sh`
5. (Optional) If you would like to compute CLIC scores without pseudobulking, run `scores_sc.sh`
6. CSV files containing CLIC scores will be in `output/scores` directory. 

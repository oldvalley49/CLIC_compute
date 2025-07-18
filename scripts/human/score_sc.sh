#!/bin/bash

#SBATCH --job-name=human_score_sc
#SBATCH --time=10:00:00
#SBATCH --mem=400G

module load R

Rscript --no-save --no-restore src/human/score_sc.R















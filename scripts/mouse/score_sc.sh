#!/bin/bash

#SBATCH --job-name=mouse_score_sc
#SBATCH --time=10:00:00
#SBATCH --mem=400G

module load R

Rscript --no-save --no-restore src/mouse/score_sc.R















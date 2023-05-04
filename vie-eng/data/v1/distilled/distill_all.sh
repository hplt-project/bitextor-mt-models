#!/usr/bin/env bash
# Switch to distill-slurm (if available) for better parallelization
DISTILL_SCRIPT="distill.sh"

SRC="vi"

for ds in ../clean/*.$SRC.gz; do
  bash $DISTILL_SCRIPT ${ds/%.$SRC.gz/} $"$@"
done

#!/usr/bin/env bash
set -euo pipefail

MARIAN="/fs/surtr0/gnail/hplt/browsermt-marian-dev/build-sigyn"

BASE="/fs/surtr0/gnail/hplt/bitextor-mt-models/ara-eng"
MODEL="model/model.npz.best-chrf.npz"
VOCAB="${BASE}/vocab/v2/model.ar-en.spm"
SHORTLIST="--shortlist ${BASE}/vocab/v2/align/lex.s2t.gz 200 200 0"

INPUT="${BASE}/data/train-alt/test.ar.gz"
OUTPUT="quant.out"


$MARIAN/marian-decoder --relative-paths -m $MODEL -v $VOCAB $VOCAB --dump-quantmult \
            -i $INPUT -o $OUTPUT \
            --beam-size 1 --mini-batch 32 --maxi-batch 100 --maxi-batch-sort src -w 128 \
            --skip-cost $SHORTLIST --cpu-threads 1 \
            --quiet --quiet-translation --log quant_dump.log 2> quantmults.dump


$MARIAN/../scripts/alphas/extract_stats.py quantmults.dump $MODEL "$MODEL.alphas.npz"
$MARIAN/marian-conv -f "$MODEL.alphas.npz" -t "$MODEL.alphas.bin" --gemm-type intgemm8

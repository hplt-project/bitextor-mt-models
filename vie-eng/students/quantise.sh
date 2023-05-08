#!/usr/bin/env bash
set -e

# NOTE: requires Bergamot branch of Marian!

MARIAN="/lnet/troja/projects/hplt/bergamot/marian-dev/build"
BASE="/lnet/troja/projects/hplt/bitextor-mt-models/vie-eng"

SRC=vi
TRG=en

MODEL_DIR=$1
VOCAB_DIR=$2

MODEL="$MODEL_DIR/model/model.npz.best-bleu-detok.npz"
SHORTLIST="$VOCAB_DIR/align/lex.s2t.gz"

INPUT="${BASE}/data/v1/train/test.$SRC.gz"
OUTPUT="$MODEL_DIR/quant.out"

$MARIAN/marian-decoder \
    --relative-paths \
    -m $MODEL \
    -v ${VOCAB_DIR}/model.$SRC-$TRG.spm{,} \
    --dump-quantmult \
    -i $INPUT \
    -o $OUTPUT \
    --beam-size 1 \
    --mini-batch 32 \
    --maxi-batch 100 \
    --maxi-batch-sort src \
    -w 128 \
    --skip-cost \
    --shortlist $SHORTLIST 200 200 0 \
    --cpu-threads 1 \
    --quiet \
    --quiet-translation \
    --log $MODEL_DIR/quant_dump.log \
    2> $MODEL_DIR/quantmults.dump

$MARIAN/../scripts/alphas/extract_stats.py $MODEL_DIR/quantmults.dump $MODEL "$MODEL.alphas.npz"
$MARIAN/marian-conv -f "$MODEL.alphas.npz" -t "$MODEL.alphas.bin" --gemm-type intgemm8

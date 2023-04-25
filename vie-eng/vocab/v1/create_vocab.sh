#!/usr/bin/env bash
set -eu
MARIAN="/lnet/troja/projects/hplt/marian-dev/build-$(hostname)"

SRC="vi"
TRG="en"
PREFIX="--model_prefix=model.${SRC}-${TRG}"

CHAR_COV=0.9995
VOCAB_SIZE=32000

$MARIAN/spm_train \
    --bos_id=-1 \
    --eos_id=0 \
    --unk_id=1 \
    ${PREFIX} \
    --character_coverage=${CHAR_COV} \
    --vocab_size=${VOCAB_SIZE} \
    --input=<(sed 's/\t/\n/g' < ../../data/train/train.tsv) \
    --input_sentence_size=20000000 \
    --train_extremely_large_corpus \
    --byte_fallback

#!/usr/bin/env bash
# General training script that can be used by various versions of the student models for training.
set -e

compute='--cpu-threads 1'
[[ -n "$CUDA_VISIBLE_DEVICES" ]] \
    && compute="--devices ${CUDA_VISIBLE_DEVICES//,/ }"

MARIAN="/lnet/troja/projects/hplt/marian-dev/build-$(hostname)"
BASE="/lnet/troja/projects/hplt/bitextor-mt-models/vie-eng"

MODEL_DIR=$1  # e.g. "v1/base", needs to exist and contain the training configs
VOCAB_DIR=$2
shift 2

SRC=vi
TRG=en

TRAIN_SETS="${BASE}/data/v1/train/train.$SRC.gz ${BASE}/data/v1/train/train.$TRG.gz"
VALID_SETS="${BASE}/data/v1/train/valid.$SRC.gz ${BASE}/data/v1/train/valid.$TRG.gz"

test -e $MODEL_DIR || exit 1
for f in ${TRAIN_SETS}; do test -e $f || exit 1; done
for f in ${VALID_SETS}; do test -e $f || exit 1; done
for f in ${VOCABS}; do     test -e $f || exit 1; done

mkdir -p $MODEL_DIR/model
$MARIAN/marian -c training.yml -c student*.yml -c extra.yml \
    --model $MODEL_DIR/model/model.npz \
    --train-sets ${TRAIN_SETS} \
    --tempdir /tmp \
    --vocabs ${VOCAB_DIR}/model.$SRC-$TRG.spm{,} \
    --dim-vocabs 32000 32000 \
    --valid-metrics bleu-detok chrf ce-mean-words \
    --valid-sets ${VALID_SETS} --valid-translation-output $MODEL_DIR/devset.out \
    --quiet-translation \
    --log-level info \
    --log $MODEL_DIR/train.log --valid-log $MODEL_DIR/valid.log \
    ${compute} "${@}"

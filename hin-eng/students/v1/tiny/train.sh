#!/usr/bin/env bash

# compute='--cpu-threads 1'
# if [ -n "$CUDA_VISIBLE_DEVICES" ]; then
#     compute="--devices ${CUDA_VISIBLE_DEVICES//,/ }"
# fi
compute="-d 0 1 2 3 4 5 6 7"

MARIAN="/fs/surtr0/gnail/hplt/marian-dev/build-sigyn"
BASE="/fs/surtr0/gnail/hplt/bitextor-mt-models/hin-eng"

SRC=hi
TRG=en

mkdir -p model
$MARIAN/marian -c training.yml -c student*.yml -c extra.yml \
    --model model/model.npz \
    --train-sets ${BASE}/training_data/train.{$SRC,$TRG}.gz \
    --tempdir /tmp \
    --vocabs ${BASE}/students/model.$SRC-$TRG.spm{,} \
    --dim-vocabs 32000 32000 \
    --valid-metrics chrf bleu ce-mean-words \
    --valid-sets ${BASE}/training_data/valid.{$SRC,$TRG}.gz --valid-translation-output devset.out --quiet-translation \
    --log-level=info \
    --log train.log --valid-log valid.log \
    ${compute} "${@}"

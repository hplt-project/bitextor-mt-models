#!/usr/bin/env bash

compute='--cpu-threads 1'
[[ -n "$CUDA_VISIBLE_DEVICES" ]] \
    && compute="--devices ${CUDA_VISIBLE_DEVICES//,/ }"

MARIAN="/lnet/troja/projects/hplt/marian-dev/build-$(hostname)"
BASE="/lnet/troja/projects/hplt/bitextor-mt-models/vie-eng"

MODEL_DIR=$1
VOCAB_DIR=$2
shift 2

SRC=vi
TRG=en

MODEL="$MODEL_DIR/model/model.npz.best-bleu-detok.npz"

for testset in valid test; do
    pigz -dc ${BASE}/data/v1/train/$testset.$SRC.gz \
        | $MARIAN/marian-decoder \
            -c $MODEL.decoder.yml \
            -m $MODEL \
            --vocabs ${VOCAB_DIR}/model.$SRC-$TRG.spm{,} \
            --quiet --quiet-translation \
            --log $MODEL_DIR/test.log \
            ${compute} "${@}" \
        | sacrebleu -m bleu chrf -- <(zcat ${BASE}/data/v1/train/$testset.$TRG.gz) \
        | tee "$MODEL_DIR/scores_$testset.log"
done

FLORES="/net/data/flores-200"
for testset in dev devtest; do
    cat ${FLORES}/${testset}/vie_Latn.$testset \
        | $MARIAN/marian-decoder \
            -c $MODEL.decoder.yml \
            -m $MODEL \
            --vocabs ${VOCAB_DIR}/model.$SRC-$TRG.spm{,} \
            --quiet --quiet-translation \
            --log $MODEL_DIR/test.log \
            ${compute} "${@}" \
        | sacrebleu -m bleu chrf -- ${FLORES}/$testset/eng_Latn.$testset \
        | tee "$MODEL_DIR/scores_flores_$testset.log"
done

NTREX="/net/data/NTREX/NTREX-128"
cat ${NTREX}/newstest2019-ref.vie.txt \
    | $MARIAN/marian-decoder \
        -c $MODEL.decoder.yml \
        -m $MODEL \
        --vocabs ${VOCAB_DIR}/model.$SRC-$TRG.spm{,} \
        --quiet --quiet-translation \
        --log $MODEL_DIR/test.log \
        ${compute} "${@}" \
    | sacrebleu -m bleu chrf -- ${NTREX}/newstest2019-src.eng.txt \
    | tee "$MODEL_DIR/scores_ntrex_$testset.log"

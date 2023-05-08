#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
echo $SCRIPT_DIR
# exit

MARIAN="/lnet/troja/projects/hplt/bergamot/marian-dev/build" 
BASE="/lnet/troja/projects/hplt/bitextor-mt-models/vie-eng"

MODEL_DIR=$1
VOCAB_DIR=$2
shift 2

SRC=vi
TRG=en

MODEL="$MODEL_DIR/model/model.npz.best-bleu-detok.npz.alphas.bin"
opts="-c $SCRIPT_DIR/quant_decode.yml --int8shiftAlphaAll --shortlist ${VOCAB_DIR}/align/lex.s2t.gz 200 200 0"

for testset in valid test; do
    echo $testset
    pigz -dc ${BASE}/data/v1/train/$testset.$SRC.gz \
        | $MARIAN/marian-decoder \
            -m $MODEL \
            --vocabs ${VOCAB_DIR}/model.$SRC-$TRG.spm{,} \
            --quiet --quiet-translation --log $MODEL_DIR/quant_test.log \
            ${compute} "${@}" \
            ${opts} \
        | sacrebleu -m bleu chrf -- <(zcat ${BASE}/data/v1/train/$testset.$TRG.gz) \
        | tee "$MODEL_DIR/quant_scores_$testset.log"
done

FLORES="/net/data/flores-200"
for testset in dev devtest; do
    echo $testset
    cat ${FLORES}/${testset}/vie_Latn.$testset \
        | $MARIAN/marian-decoder \
            -m $MODEL \
            --vocabs ${VOCAB_DIR}/model.$SRC-$TRG.spm{,} \
            --quiet --quiet-translation --log test.log \
            ${compute} "${@}" \
            ${opts} \
        | sacrebleu -m bleu chrf -- ${FLORES}/$testset/eng_Latn.$testset \
        | tee "$MODEL_DIR/quant_scores_flores_$testset.log"
done

NTREX="/net/data/NTREX/NTREX-128"
cat ${NTREX}/newstest2019-ref.vie.txt \
    | $MARIAN/marian-decoder \
        -m $MODEL \
        --vocabs ${VOCAB_DIR}/model.$SRC-$TRG.spm{,} \
        --quiet --quiet-translation \
        --log $MODEL_DIR/test.log \
        ${compute} "${@}" \
        ${opts} \
    | sacrebleu -m bleu chrf -- ${NTREX}/newstest2019-src.eng.txt \
    | tee "$MODEL_DIR/scores_ntrex_$testset.log"


#!/usr/bin/env bash

compute="-d 0 1 2 3 4 5 6 7"

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
echo $SCRIPT_DIR
# exit

MARIAN="/fs/surtr0/gnail/hplt/browsermt-marian-dev/build-sigyn"
BASE="/fs/surtr0/gnail/hplt/bitextor-mt-models/hin-eng"

SRC=hi
TRG=en

model="model/model.npz.best-chrf.npz.alphas.bin"
opts="-c $SCRIPT_DIR/quant_decode.yml --int8shiftAlphaAll --shortlist ${BASE}/vocab/v1/align/lex.s2t.gz 200 200 0"

for testset in valid test; do
  echo $testset
  pigz -dc ${BASE}/data/train/$testset.$SRC.gz |
    $MARIAN/marian-decoder \
      -m ${model} \
      --vocabs ${BASE}/vocab/v1/model.$SRC-$TRG.spm{,} \
      --quiet --quiet-translation --log test.log \
      ${compute} ${opts} "${@}" |
    sacrebleu -m bleu chrf -- <(zcat ${BASE}/data/train/$testset.$TRG.gz) |
    tee "quant_scores_$testset.log"
done

FLORES="/fs/surtr0/gnail/hplt/bitextor-mt-models/flores200_dataset"
for testset in dev devtest; do
  echo $testset
  cat ${FLORES}/${testset}/hin_Deva.$testset |
    $MARIAN/marian-decoder \
      -m ${model} \
      --vocabs ${BASE}/vocab/v1/model.$SRC-$TRG.spm{,} \
      --quiet --quiet-translation --log test.log \
      ${compute} ${opts} "${@}" |
    sacrebleu -m bleu chrf -- ${FLORES}/$testset/eng_Latn.$testset |
    tee "quant_scores_flores_$testset.log"
done

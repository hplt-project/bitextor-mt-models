#!/usr/bin/env bash

compute="-d 0 1 2 3 4 5 6 7"

MARIAN="/fs/surtr0/gnail/hplt/marian-dev/build-bil"
BASE="/fs/surtr0/gnail/hplt/bitextor-mt-models/ara-eng"

SRC=ar
TRG=en

for testset in valid test; do
  pigz -dc ${BASE}/data/train/$testset.$SRC.gz |
    $MARIAN/marian-decoder -c model/model.npz.best-chrf.npz.decoder.yml \
      -m model/model.npz.best-chrf.npz \
      --vocabs ${BASE}/students/model.ar-en.spm{,} \
      --quiet --quiet-translation --log test.log \
      ${compute} "${@}" |
    sacrebleu -m bleu chrf -- <(zcat ${BASE}/data/train/$testset.$TRG.gz) |
    tee "scores_$testset.log"
done

# FLORES200
FLORES="/fs/surtr0/gnail/hplt/bitextor-mt-models/flores200_dataset"
for testset in dev devtest; do
  cat ${FLORES}/${testset}/arb_Arab.$testset |
    $MARIAN/marian-decoder -c model/model.npz.best-chrf.npz.decoder.yml \
      -m model/model.npz.best-chrf.npz \
      --vocabs ${BASE}/students/model.ar-en.spm{,} \
      --quiet --quiet-translation --log test.log \
      ${compute} "${@}" |
    sacrebleu -m bleu chrf -- ${FLORES}/$testset/eng_Latn.$testset |
    tee "scores_flores_$testset.log"
done

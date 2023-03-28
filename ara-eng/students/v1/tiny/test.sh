#!/usr/bin/env bash

compute="-d 0 1 2 3 4 5 6 7"

MARIAN="/fs/surtr0/gnail/hplt/marian-dev/build-bil"
BASE="/fs/surtr0/gnail/hplt/bitextor-mt-models/ara-eng"

SRC=ar
TRG=en

pigz -dc ${BASE}/data/train/test.$SRC.gz |
  $MARIAN/marian-decoder -c model/model.npz.best-chrf.npz.decoder.yml \
    -m model/model.npz.best-chrf.npz \
    --vocabs ${BASE}/students/model.ar-en.spm{,} \
    --quiet --quiet-translation --log test.log \
    ${compute} "${@}" |
  sacrebleu -m bleu chrf -- <(zcat ${BASE}/data/train/test.$TRG.gz) |
  tee scores.log

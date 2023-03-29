#!/usr/bin/env bash

set -eu
SPM_EXEC="/fs/surtr0/gnail/hplt/marian-dev/build-bil/spm_train"

src="ar"
trg="en"
PREFIX="--model_prefix=model.${src}-${trg}"
VOCAB_SIZE=32000

$SPM_EXEC \
  --bos_id=-1 \
  --eos_id=0 \
  --unk_id=1 \
  ${PREFIX} \
  --vocab_size=${VOCAB_SIZE} \
  --input=<(sed 's/\t/\n/g' <../../data/train/train.tsv) \
  --input_sentence_size=20000000 \
  --train_extremely_large_corpus \
  --byte_fallback

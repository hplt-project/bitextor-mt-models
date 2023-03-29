#!/usr/bin/env bash

compute="-d 0 1 2 3 4 5 6 7"

MARIAN="/fs/surtr0/gnail/hplt/marian-dev/build-bil"
BASE="/fs/surtr0/gnail/hplt/bitextor-mt-models/ara-eng"

SRC=ar
TRG=en

teachers=(
  teacher
  teacher-alt
)

preprocess() {
  # From the teacher
  sed -e 's/，/,/g' \
    -e 's/。 */. /g' \
    -e 's/、/,/g' \
    -e 's/”/"/g' \
    -e 's/“/"/g' \
    -e 's/∶/:/g' \
    -e 's/：/:/g' \
    -e 's/？/\?/g' \
    -e 's/《/"/g' \
    -e 's/》/"/g' \
    -e 's/）/\)/g' \
    -e 's/！/\!/g' \
    -e 's/（/\(/g' \
    -e 's/；/;/g' \
    -e 's/１/"/g' \
    -e 's/」/"/g' \
    -e 's/「/"/g' \
    -e 's/０/0/g' \
    -e 's/３/3/g' \
    -e 's/２/2/g' \
    -e 's/５/5/g' \
    -e 's/６/6/g' \
    -e 's/９/9/g' \
    -e 's/７/7/g' \
    -e 's/８/8/g' \
    -e 's/４/4/g' \
    -e 's/． */. /g' \
    -e 's/～/\~/g' \
    -e "s/’/\'/g" \
    -e 's/…/\.\.\./g' \
    -e 's/━/\-/g' \
    -e 's/〈/\</g' \
    -e 's/〉/\>/g' \
    -e 's/【/\[/g' \
    -e 's/】/\]/g' \
    -e 's/％/\%/g' |
    perl -C -pe 's/(?!\n)\p{C}/ /g;' |
    perl -CIOE -pe 's/[\x{2060}\x{200B}\x{feff}]//g' |
    sed 's/  */ /g;s/^ *//g;s/ *$//g'
}

teacher() {
  base=$1
  opts="" #"--quiet --quiet-translation"
  preprocess |
    $MARIAN/spm_encode --model $base/source.spm |
    $MARIAN/marian-decoder -c $base/decoder.yml \
      ${opts} ${compute} |
    $MARIAN/spm_decode --model $base/target.spm
}

for teacher_model in ${teachers[@]}; do
  teacher_base="${BASE}/$teacher_model"
  echo $teacher_base

  for testset in valid test; do
    pigz -dc ${BASE}/data/train/$testset.$SRC.gz |
      teacher $teacher_base |
      sacrebleu -m bleu chrf -- <(zcat ${BASE}/data/train/$testset.$TRG.gz) |
      tee "scores_${teacher_model}_${testset}.log"
  done

  # FLORES200
  FLORES="/fs/surtr0/gnail/hplt/bitextor-mt-models/flores200_dataset"
  for testset in dev devtest; do
    cat ${FLORES}/${testset}/arb_Arab.$testset |
      teacher $teacher_base |
      sacrebleu -m bleu chrf -- ${FLORES}/$testset/eng_Latn.$testset |
      tee "scores_flores_${teacher_model}_${testset}.log"
  done
done

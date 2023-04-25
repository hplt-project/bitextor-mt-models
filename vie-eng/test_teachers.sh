#!/usr/bin/env bash

compute=""
[[ -n "$CUDA_VISIBLE_DEVICES" ]] \
    && compute="-d `echo $CUDA_VISIBLE_DEVICES | tr ',' ' '`"

MARIAN="/lnet/troja/projects/hplt/marian-dev/build-$(hostname)"
MOSESHOME="/lnet/troja/projects/hplt/mosesdecoder"
BASE="."

SRC=vi
TRG=en

teachers=(
  teacher
  teacher-alt
)

preprocess() {
    # From the teacher (noflags)
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
        -e 's/％/\%/g' \
    | perl -C -pe 's/\p{C}/ /g;' \
    | sed 's/  */ /g;s/^ *//g;s/ *$//g'
}

teacher() {
    base=$1
    opts="" #"--quiet --quiet-translation"
    preprocess \
        | $MARIAN/spm_encode --model $base/source.spm \
        | $MARIAN/marian-decoder -c $base/decoder.yml ${opts} ${compute} \
        | $MARIAN/spm_decode --model $base/target.spm
}

for teacher_model in ${teachers[@]}; do
    teacher_base="${BASE}/$teacher_model"
    echo $teacher_base

    for testset in valid test; do
        pigz -dc ${BASE}/data/train/$testset.$SRC.gz \
            | teacher $teacher_base $teacher_model \
            | sacrebleu -m bleu chrf -- <(zcat ${BASE}/data/train/$testset.$TRG.gz) \
            | tee "scores_${teacher_model}_${testset}.log"
    done

    # FLORES200 (https://github.com/facebookresearch/flores/tree/main/flores200)
    FLORES="/net/data/flores-200"
    for testset in dev devtest; do
        cat ${FLORES}/${testset}/vie_Latn.$testset \
            | teacher $teacher_base $teacher_model \
            | sacrebleu -m bleu chrf -- ${FLORES}/$testset/eng_Latn.$testset \
            | tee "scores_flores_${teacher_model}_${testset}.log"
    done

    # NTREX (https://github.com/MicrosoftTranslator/NTREX.git)
    NTREX="/net/data/NTREX/NTREX-128"
    cat ${NTREX}/newstest2019-ref.vie.txt \
        | teacher $teacher_base $teacher_model \
        | sacrebleu -m bleu chrf -- ${NTREX}//newstest2019-src.eng.txt \
        | tee "scores_ntrex_${teacher_model}.log"
done

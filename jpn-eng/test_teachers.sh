#!/usr/bin/env bash
test -e

compute=""
[[ -n "$CUDA_VISIBLE_DEVICES" ]] \
    && compute="-d ${CUDA_VISIBLE_DEVICES//,/ }"

MARIAN="/lnet/troja/projects/hplt/marian-dev/build-$(hostname)"
MOSESHOME="/lnet/troja/projects/hplt/mosesdecoder"
TOKENIZER="$MOSESHOME/scripts/tokenizer"
BASE="."

SRC=ja
TRG=en

teachers=(
  teacher
  teacher-alt
)

preprocess() {
    # From the teacher
    if [[ $1 == "teacher" ]]; then
        ${TOKENIZER}/replace-unicode-punctuation.perl \
            | ${TOKENIZER}/remove-non-printing-char.perl \
            | ${TOKENIZER}/normalize-punctuation.perl -l $SRC \
            | sed 's/  */ /g;s/^ *//g;s/ *$$//g'
    elif [[ $1 == "teacher-alt" ]]; then
        ${TOKENIZER}/replace-unicode-punctuation.perl \
            | ${TOKENIZER}/remove-non-printing-char.perl \
            | sed 's/  */ /g;s/^ *//g;s/ *$$//g'
    fi
}

teacher() {
    base=$1
    opts=""  #"--quiet --quiet-translation"
    preprocess $2 \
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
        cat ${FLORES}/${testset}/jpn_Jpan.$testset \
            | teacher $teacher_base $teacher_model \
            | sacrebleu -m bleu chrf -- ${FLORES}/$testset/eng_Latn.$testset \
            | tee "scores_flores_${teacher_model}_${testset}.log"
    done

    # NTREX (https://github.com/MicrosoftTranslator/NTREX.git)
    NTREX="/net/data/NTREX/NTREX-128"
    cat ${NTREX}/newstest2019-ref.jpn.txt \
        | teacher $teacher_base $teacher_model \
        | sacrebleu -m bleu chrf -- ${NTREX}/newstest2019-src.eng.txt \
        | tee "scores_ntrex_${teacher_model}.log"
done

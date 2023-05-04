#!/usr/bin/env bash
set -e

compute=""
[[ -n "$CUDA_VISIBLE_DEVICES" ]] \
    && compute="-d ${CUDA_VISIBLE_DEVICES//,/ }"

MARIAN=${MARIAN:-"/lnet/troja/projects/hplt/marian-dev/build-$(hostname)"}
MOSESHOME=${MOSESHOME:-"/lnet/troja/projects/hplt/mosesdecoder"}
BERGAMOT_STUDENTS=${BERGAMOT_STUDENTS:-"/lnet/troja/projects/hplt/bergamot/students"}

TOKENIZER="$MOSESHOME/scripts/tokenizer"
TEACHER="../../../teacher"

SRC=ja
TRG=en

CORPUS_PREFIX=$1
shift

preprocess() {
    # From the teacher
    ${TOKENIZER}/replace-unicode-punctuation.perl \
        | ${TOKENIZER}/remove-non-printing-char.perl \
        | ${TOKENIZER}/normalize-punctuation.perl -l $SRC \
        | sed 's/  */ /g;s/^ *//g;s/ *$$//g'
}

CORPUS_SRC="$CORPUS_PREFIX.$SRC.gz"
CORPUS_TRG="$CORPUS_PREFIX.$TRG.gz"

test ! -e $CORPUS_SRC && echo "$CORPUS_SRC does not exist..." >&2 && exit 1
test ! -e $CORPUS_TRG && echo "$CORPUS_TRG does not exist..." >&2 && exit 1

prefix=$(basename $CORPUS_SRC)
prefix=${prefix/%.$SRC.gz/}

mkdir -p .shards
test -s .shards/${prefix}.0000.txt || pigz -dc $CORPUS_SRC \
    | split -a 4 -d -l 100000 - .shards/${prefix}.
test -s .shards/${prefix}.0000.txt || pigz -dc $CORPUS_TRG \
    | split -a 4 -d -l 100000 - .shards/${prefix}. --additional-suffix .ref

for shard in .shards/${prefix}.????; do
    echo "Distilling $shard..." >&2
    output=${shard}.nbest

    test -e $output || cat $shard \
        | preprocess \
        | $MARIAN/spm_encode --model $TEACHER/source.spm \
        | $MARIAN/marian-decoder \
            -c distill.yml \
            -o $output \
            --log ${shard}.log \
            --n-best \
            $compute \
            $@

    # Postprocess the n-best list outputs
    cat $output \
        | sed 's/ ||| /\t/g' \
        | cut -f2 \
        | $MARIAN/spm_decode --model $TEACHER/target.spm \
        > ${output/%.nbest/.detok}
    cat $output \
        | sed 's/ ||| /\t/g' \
        | cut -f1,3,4 \
        | paste ${output/%.nbest/.detok} - \
        | awk -F"\t" '{print $2,FS,$1,FS,$3,FS,$4}' \
        | sed 's/\t/|||/g' \
        > $output.detok
done

for shard in .shards/${prefix}.????; do
    echo "Scoring $shard n-best list..." >&2
    output=${shard}.nbest.out

    test -e $output || python3 $BERGAMOT_STUDENTS/train-student/data/bestbleu.py \
        -i $shard.nbest.detok -r $shard.ref -m bleu > $output
done

wc .shards/$prefix.*.nbest.out
cat .shards/$prefix.*.nbest.out | pigz > $prefix.$TRG.distilled.gz

rm -r .shards

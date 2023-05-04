#!/usr/bin/env bash
set -e

compute=""
[[ -n "$CUDA_VISIBLE_DEVICES" ]] \
    && compute="-d ${CUDA_VISIBLE_DEVICES//,/ }"

MARIAN=${MARIAN:-"/lnet/troja/projects/hplt/marian-dev/build-$(hostname)"}
BERGAMOT_STUDENTS=${BERGAMOT_STUDENTS:-"/lnet/troja/projects/hplt/bergamot/students"}

TEACHER="../../../teacher"

SRC=vi
TRG=en

CORPUS_PREFIX=$1
shift

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
    | perl -C -pe  's/(?!\n)\p{C}/ /g;' \
    | perl -CIOE -pe 's/[\x{2060}\x{200B}\x{feff}]//g' \
    | sed 's/  */ /g;s/^ *//g;s/ *$//g'
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

#!/usr/bin/env bash

get_seeded_random() {
    seed="${1:-42}"
    openssl enc -aes-256-ctr -pass pass:"$seed" -nosalt \
        < /dev/zero 2> /dev/null
}

VALID_SIZE=2500
TEST_SIZE=2500
NOTRAIN=$((VALID_SIZE + TEST_SIZE))

SRC=vi
TRG=en

CLEAN="../clean"
DISTIL="../distilled"

trainset=(
    bible-uedin-v1.en-vi
    NeuLab-TedTalks-v1.en-vi
    QED-v2.0a.en-vi
    StanfordNLP-NMT-v1.0.en-vi
    Tatoeba-v2022-03-03.en-vi
    TED2020-v1.en-vi
    WikiMatrix-v1.en-vi
    wikimedia-v20210402.en-vi
    Wikipedia-v1.0.en-vi
)

# Data
: > combined.tsv

for ds in ${trainset[@]}; do
    echo "[writing] $ds"
    paste \
        <(pigz -dc $CLEAN/$ds.$SRC.gz) \
        <(pigz -dc $DISTIL/$ds.$TRG.distilled.gz) \
        >> combined.tsv
done

# Shuffle and train/valid/test split
shuf --random-source=<(get_seeded_random 314) < combined.tsv \
    | awk -v "validtest=$NOTRAIN" -v "validonly=$VALID_SIZE" \
        '{  if (NR <= validtest) {
            if (NR <= validonly) {
                print > "valid.tsv";
            } else {
                print > "test.tsv";
            }
         } else {
            print > "train.tsv";
         }}'

for ds in train valid "test"; do
    echo "[separating] $ds"
    cat ${ds}.tsv \
        | tee \
            >(cut -f1 | pigz > ${ds}.$SRC.gz) \
            >(cut -f2 | pigz > ${ds}.$TRG.gz) \
            > /dev/null
done

sleep 1
zgrep -Ec "$" *.gz

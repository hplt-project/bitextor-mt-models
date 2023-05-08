#!/usr/bin/env bash

get_seeded_random() {
    seed="${1:-42}"
    openssl enc -aes-256-ctr -pass pass:"$seed" -nosalt \
        < /dev/zero 2> /dev/null
}

VALID_SIZE=2500
TEST_SIZE=2500
NOTRAIN=$((VALID_SIZE + TEST_SIZE))

SRC=ja
TRG=en

CLEAN="../clean"
DISTIL="../distilled"

trainset=(
    CCAligned-v1.en-ja
    CCMatrix-v1.en-ja
    EUbookshop-v2.en-ja
    JESC-v2019-12-05.en-ja
    JParaCrawl-v3.0.en-ja
    KFTT-v1.0.en-ja
    LinguaTools-WikiTitles-v2014.en-ja
    MultiCCAligned-v1.en-ja
    NeuLab-TedTalks-v1.en-ja
    OpenSubtitles-v2018.en-ja
    QED-v2.0a.en-ja
    Tanzil-v1.en-ja
    Tatoeba-v2022-03-03.en-ja
    TED2020-v1.en-ja
    WikiMatrix-v1.en-ja
    wikimedia-v20210402.en-ja
    WikiTitles-v3.en-ja
    XLEnt-v1.2.en-ja
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

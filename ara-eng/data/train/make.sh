#!/usr/bin/env bash

get_seeded_random() {
  seed="$1"
  openssl enc -aes-256-ctr -pass pass:"$seed" -nosalt \
    </dev/zero 2>/dev/null
}

VALID_SIZE=2500
TEST_SIZE=2500
NOTRAIN=$((VALID_SIZE + TEST_SIZE))

src="ar"
trg="en"

clean="../clean"
distil="../distilled"

trainset=(
  infopankki-v1.ar-en
  MultiUN-v1.ar-en
  News-Commentary-v9.1.ar-en
  Tatoeba-v2022-03-03.ar-en
  Ubuntu-v14.10.ar-en
  UNPC-v20090831.ar-en
  wikimedia-v20210402.ar-en
)

# Data
: >"combined.tsv"

for ds in ${trainset[@]}; do
  echo "[writing] $ds"
  paste \
    <(pigz -dc ${clean}/$ds.$src.gz) \
    <(pigz -dc ${distil}/$ds.$src.distilled.gz) \
    >>"combined.tsv"
done

# Shuffle and train/valid/test split
shuf --random-source=<(get_seeded_random 314) <combined.tsv |
  awk -v "validtest=$NOTRAIN" -v "validonly=$VALID_SIZE" \
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
  cat ${ds}.tsv | tee \
    >(cut -f1 | pigz >${ds}.$src.gz) \
    >(cut -f2 | pigz >${ds}.$trg.gz) \
    >/dev/null
done

sleep 1
zgrep -Ec "$" *.gz

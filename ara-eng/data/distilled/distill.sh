#!/usr/bin/env bash
set -eu
MARIAN=${MARRIAN:-"/fs/surtr0/gnail/hplt/marian-dev/build-bil"}
TEACHER="../../teacher"

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

input=$1
shift

prefix=$(basename $input)
prefix=${prefix/%.gz/}

mkdir -p .shards
test -s .shards/${prefix}.0000.txt ||
  pigz -dc $input |
  split -a 4 -d -l 1000000 \
    - .shards/${prefix}. --additional-suffix .txt

# set -x
cd .shards
for shard in ${prefix}.*.txt; do
  output=${shard/%.txt/.out}
  if [ -f "$output" ]; then
    echo "Skipping '$shard'"
    continue
  fi
  echo "Distill '$shard'"
  cat $shard |
    preprocess |
    $MARIAN/spm_encode --model $TEACHER/source.spm |
    $MARIAN/marian-decoder -c ../distill.yml \
      --log ${shard/%.txt/.log} \
      $@ |
    $MARIAN/spm_decode --model $TEACHER/target.spm >$output
done

wc $prefix.*.out
cat $prefix.*.out | pigz >$prefix.distilled.gz

mv $prefix.distilled.gz ..

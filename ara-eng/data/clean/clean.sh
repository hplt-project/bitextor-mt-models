#!/usr/bin/env bash
for pipeline in ../data/*.filters.json; do

  prefix=$(basename $pipeline)
  prefix=${prefix/%.filters.json/}

  (opuscleaner-clean $pipeline --parallel 8) > \
    >(
      tee \
        >(cut -f1 | pigz >${prefix}.ar.gz) \
        >(cut -f2 | pigz >${prefix}.en.gz) \
        >/dev/null
    ) \
    2> >(tee ${prefix}.log >&2)

done
wait

#!/usr/bin/env bash
for pipeline in ../raw/*.filters.json; do
  echo "Processing $pipeline..." >&2
  prefix=$(basename $pipeline)
  prefix=${prefix/%.filters.json/}

  (opuscleaner-clean $pipeline --parallel 8 -b ../raw) > \
    >(
      tee \
        >(cut -f1 | pigz >${prefix}.en.gz) \
        >(cut -f2 | pigz >${prefix}.vi.gz) \
        >/dev/null
    ) \
    2> >(tee ${prefix}.log >&2)

    # Cleanup
    rm `grep Merging ../clean/${prefix}.log | cut -d" " -f3`
done
wait

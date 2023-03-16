#!/usr/bin/env bash

for ds in ../clean/*.hi.gz; do
  bash distill.sh $ds "$@"
done

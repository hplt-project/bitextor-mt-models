#!/usr/bin/env bash

for ds in ../clean/*.ar.gz; do
  bash distill.sh $ds "$@"
done

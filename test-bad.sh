#!/bin/bash
pushd /challenge/tools
name=$1
test_num=$2
timeout=15
dir_build="/challenge/build/challenges/${name}"
bin_challenge="${dir_build}/${name}"
test_file="${dir_build}/pov_${test_num}.pov"
python cb-replay-pov.py \
  "${test_file}" \
  --cbs "${bin_challenge}" \
  --negotiate \
  --pov_seed 0 \
  --timeout ${timeout}

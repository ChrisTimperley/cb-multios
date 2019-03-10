#!/bin/bash
pushd /challenge/tools
name=$1
test_num=$(printf '%05d' $2)
bin_challenge="/challenge/build/challenges/${name}"
dir_challenge="/challenge/challenges/${name}"
dir_xml="${dir_challenge}/poller/for-release"
test_file="${dir_xml}/GEN_00000_${test_num}.xml"
python cb-replay.py \
  --cbs "${bin_challenge}" \
  --failure_ok \
  --negotiate \
  "${test_file}"

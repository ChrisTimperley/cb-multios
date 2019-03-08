#!/bin/bash
name=$1
pushd /challenge/tools
python cb-test.py \
  --directory "/challenge/build/challenges/${name}" \
  --xml_dir "/challenge/build/challenges/${name}" \
  --concurrent 1 \
  --timeout 5 \
  --negotiate_seed \
  --cb "${name}"

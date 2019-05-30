#!/bin/bash
# https://cgc-docs.legitbs.net/cb-testing/cb-test/
pushd /challenge/tools
timeout=15
name=$1
test_name=$2
dir_challenge="/challenge/challenges/${name}"
dir_xml="${dir_challenge}/poller/for-release"
dir_build="/challenge/build/challenges/${name}"
bin_challenge="${dir_build}/${name}"

case $test_name in
  p*)
    test_name=${test_name#"p"}
    test_name=$((test_name-1))
    test_file="${dir_xml}/GEN_00000_$(printf '%05d' ${test_name}).xml"
    # --failure_ok
    python cb-test.py --cb "${bin_challenge}" \
      --dir /challenge/build \
      --negotiate --xml "${test_file}" \
    && (echo "PASS: ${test_name}" && exit 0) \
    || (echo "FAIL: ${test_name}" && exit 1);;

  n*)
    test_name=${test_name#"n"}
    test_file="${dir_build}/pov_${test_name}.pov"
    python cb-replay-pov.py \
      "${test_file}" \
      --cbs "${bin_challenge}" \
      --negotiate \
      --pov_seed 0 \
      --timeout ${timeout} \
    && (echo "PASS: ${test_name}" && exit 0) \
    || (echo "FAIL: ${test_name}" && exit 1);;

  *) echo "NOT FOUND: ${test_name}" && exit 1;;
esac

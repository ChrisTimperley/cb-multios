#!/bin/bash
NAME=$1
DIR_POLLER="/challenge/challenges/${NAME}/poller/for-release"
pushd /challenge/tools/generate-polls
./generate-polls \
  "${DIR_POLLER}/machine.py" \
  "${DIR_POLLER}/state-graph.yaml"
  "${DIR_POLLER}"

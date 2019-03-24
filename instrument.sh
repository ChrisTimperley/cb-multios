#!/bin/bash
challenge=$1
pushd /challenge/build
cmake \
  -DCMAKE_C_FLAGS=--coverage \
  -DCMAKE_CXX_FLAGS=--coverage \
  -DCMAKE_EXE_LINKER_FLAGS=--coverage \
  -DCMAKE_SHARED_LINKER_FLAGS=--coverage \
  ..
pushd "/challenge/build/challenges/${challenge}"
make

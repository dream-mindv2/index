#!/bin/sh
# The toolchain this index's workflows run: the VM, without the JIT, and
# `mind`, compiled by the checked-in seed -- each at a pinned commit, so the
# code that appends to and checkpoints the index is code someone reviewed.
# Moving a pin is a change to this file, and so to the cache key.
set -eu
DREAM=57055da1c19927886e14006304de45d890db18a8
DREAMS=32c192aee1b8007414012195679e96765398188f
STD=3a1c0f3355f37bc64e9e07aeb5f6fdbb44d34d1e
MIND=b3cb9a807b33421b2f02a60026e0e0ffced2e3ee

mkdir -p toolchain
cd toolchain
if [ -x build/bin/dream ] && [ -f mind.dream ]; then exit 0; fi

# fetch REPO DIR COMMIT -- one commit of a dream-mindv2 repository, and no history.
fetch() {
    rm -rf "$2"
    git init -q "$2"
    git -C "$2" fetch -q --depth 1 "https://github.com/dream-mindv2/$1" "$3"
    git -C "$2" checkout -q FETCH_HEAD
}
fetch dream dream "$DREAM"
fetch dreams dreams "$DREAMS"
fetch std mind/std "$STD"
fetch mind mind/tool "$MIND"

cmake -S dream -B build -DDREAM_ENABLE_JIT=OFF -DCMAKE_BUILD_TYPE=Release
cmake --build build --parallel 4 --target dream_cli
build/bin/dream dreams/bootstrap/dreams.dream -L mind/std mind/tool/src/main.dr -o mind.dream

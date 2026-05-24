#!/usr/bin/env bash
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
g++ $SCRIPT_DIR/../src/main.cpp -std=c++23 -o $SCRIPT_DIR/main.out -I$SCRIPT_DIR/../../lib/cpp/

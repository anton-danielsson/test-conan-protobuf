#!/bin/bash -e

cmake -S . -B cmake-build -DCMAKE_BUILD_TYPE=Release

cmake --build cmake-build --config Release

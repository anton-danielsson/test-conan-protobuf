#!/bin/bash -e

cmake -S . -B cmake-build -DCONAN_CMAKE=ON -DCMAKE_BUILD_TYPE=Release

cmake --build cmake-build
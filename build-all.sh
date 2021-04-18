#!/bin/bash -e

./build-with-cmake.sh
./build-with-conan.sh
./build-with-conan-cross.sh

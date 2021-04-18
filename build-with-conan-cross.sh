#!/bin/bash -e

conan install --install-folder conan-build-cross \
  --profile:host android-ndk-r22-api-21-arm64-v8a-clang-c++_static.txt \
  --build outdated \
  --profile:build default .

conan build --build-folder conan-build-cross .

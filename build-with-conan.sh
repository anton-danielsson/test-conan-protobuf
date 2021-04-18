#!/bin/bash -e

conan install --install-folder conan-build --build outdated .

conan build --build-folder conan-build .

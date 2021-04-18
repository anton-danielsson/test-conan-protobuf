

conan install --install-folder conan-build .
conan build --build-folder conan-build .

conan install --install-folder conan-build-cross \
  --profile:host profiles_host/android-ndk-r22-api-21-arm64-v8a-clang-c++_static.txt
  --profile:build default \
  .
conan build --build-folder conan-build-cross .



cmake -S . -B cmake-build -DCONAN_CMAKE=ON -DCMAKE_BUILD_TYPE=Release
cmake_minimum_required(VERSION 3.1)
project(test_package)

if(CONAN_EXPORTED) # in conan local cache
    # standard conan installation, deps will be defined in conanfile.py
    # and not necessary to call conan again, conan is already running
    include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
    conan_basic_setup()
else() # in user space
    list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})
    list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR})
    if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
      message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
      file(DOWNLOAD "https://raw.githubusercontent.com/conan-io/cmake-conan/v0.16.1/conan.cmake"
                    "${CMAKE_BINARY_DIR}/conan.cmake"
                    EXPECTED_HASH SHA256=396e16d0f5eabdc6a14afddbcfff62a54a7ee75c6da23f32f7a31bc85db23484
                    TLS_VERIFY ON)
    endif()
    include("${CMAKE_BINARY_DIR}/conan.cmake")
    # Make sure to use conanfile.py to define dependencies, to stay consistent
    conan_cmake_configure(REQUIRES protobuf/3.15.5 GENERATORS cmake_find_package_multi)
    conan_cmake_autodetect(settings)
    conan_cmake_install(PATH_OR_REFERENCE . BUILD outdated REMOTE conan-center PROFILE default SETTINGS ${settings})
endif()

find_package(protobuf CONFIG REQUIRED)

message("PATH is: $ENV{PATH}")
message("Protobuf_PROTOC_EXECUTABLE is: ${Protobuf_PROTOC_EXECUTABLE}")
message("PROTOBUF_PROTOC_EXECUTABLE is: ${Protobuf_PROTOC_EXECUTABLE}")

add_executable(${PROJECT_NAME} test_package.cpp addressbook.proto)
set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 11)
target_include_directories(${PROJECT_NAME} PRIVATE "${CMAKE_BINARY_DIR}")
if (protobuf_LITE)
    target_link_libraries(${PROJECT_NAME} protobuf::libprotobuf-lite)
else()
    target_link_libraries(${PROJECT_NAME} protobuf::libprotobuf)
endif()

target_link_libraries(${PROJECT_NAME} protobuf::libprotoc)

protobuf_generate_cpp(PROTO_SRCS PROTO_HDRS TARGET ${PROJECT_NAME})
protobuf_generate(LANGUAGE cpp TARGET ${PROJECT_NAME} PROTOS addressbook.proto)

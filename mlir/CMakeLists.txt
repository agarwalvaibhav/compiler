cmake_minimum_required(VERSION 3.13.4)
project(mlir-coding-exercise LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard to conform to")
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Find MLIR and LLVM
find_package(MLIR REQUIRED CONFIG)
find_package(LLVM REQUIRED CONFIG)

# Set CMake paths for MLIR and LLVM
list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")

# Include required macros
include(TableGen)
include(HandleLLVMOptions)
include(AddLLVM)
include(AddMLIR)

# Set includes and libraries
include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${MLIR_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

# Add top-level target
add_custom_target(${PROJECT_NAME})

# Add examples/toy subdirectory
add_subdirectory(examples/toy)

# Ensure top-level target depends on the Toy example
add_dependencies(${PROJECT_NAME} Toy)
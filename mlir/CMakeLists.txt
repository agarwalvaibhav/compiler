# Minimum CMake version required
cmake_minimum_required(VERSION 3.13.4)

# Define the project name and languages used
project(mlir-coding-exercise LANGUAGES C CXX)

# Set C++ standard to C++17
set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard to conform to")

# Generate position-independent code (needed for shared libraries and LLVM)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# ---- Find MLIR and LLVM ----

# Find the installed MLIR package using its CMake config
find_package(MLIR REQUIRED CONFIG)

# Find the installed LLVM package using its CMake config
find_package(LLVM REQUIRED CONFIG)

# Print paths used by MLIR and LLVM for CMake configuration (for debugging)
message(STATUS "MLIR_CMAKE_DIR: ${MLIR_CMAKE_DIR}")
message(STATUS "LLVM_DIR: ${LLVM_DIR}")
message(STATUS "LLVM_CMAKE_DIR: ${LLVM_CMAKE_DIR}")

# Add the MLIR and LLVM CMake directories to the module path so we can use their macros
list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")

# ---- Include MLIR/LLVM Macros ----

# TableGen is needed for generating MLIR/LLVM dialect/interface definitions
include(TableGen)

# Set appropriate LLVM compiler/linker flags
include(HandleLLVMOptions)

# Adds helper functions for creating LLVM-compatible targets
include(AddLLVM)

# Adds helper functions for building MLIR libraries and tools
include(AddMLIR)

# ---- Set include directories and definitions ----

# Add LLVM and MLIR include directories to the build
include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${MLIR_INCLUDE_DIRS})

# Add any necessary preprocessor definitions from LLVM
add_definitions(${LLVM_DEFINITIONS})

# ---- Create a top-level phony target ----

# This is a dummy target that helps organize dependencies across subprojects
add_custom_target(${PROJECT_NAME})

# ---- Add subdirectories ----

# Add the Toy tutorial directory (examples/toy)
add_subdirectory(examples/toy)

# Ensure the main target depends on the Toy target
add_dependencies(${PROJECT_NAME} Toy)
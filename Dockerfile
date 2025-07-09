################################
### builder stage           ####
################################

FROM ubuntu:24.04 AS builder

# Install basic build packages
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    cmake \
    curl \
    git \
    lld \
    ninja-build \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    wget \
    xxd \
    sudo

#RUN pip3 install --upgrade setuptools pip

RUN git clone --depth 1 https://github.com/llvm/llvm-project.git /usr/src/llvm-project
WORKDIR /usr/src/llvm-project
RUN mkdir build

RUN cmake -GNinja -B build -S llvm      \
    -DCMAKE_BUILD_TYPE=Debug          \
    -DCMAKE_C_COMPILER=clang            \
    -DCMAKE_CXX_COMPILER=clang++        \
    -DLLVM_ENABLE_LLD=ON                \
    -DLLVM_ENABLE_PROJECTS=mlir         \
    -DLLVM_BUILD_EXAMPLES=ON            \
    -DLLVM_TARGETS_TO_BUILD=host        \
    -DCMAKE_BUILD_TYPE=Release          \
    -DCMAKE_CXX_FLAGS_RELEASE="-O0"     \
    -DLLVM_ENABLE_ASSERTIONS=ON

RUN cmake --build ./build && cmake --install ./build --prefix /usr/local
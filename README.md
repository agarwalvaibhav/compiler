# Compiler Coding exercise!!

## Setup
1. Fork this repo, clone it and cd into it.
    ``` bash
    git clone https://github.com/agarwalvaibhav/compiler.git
    cd compiler
    ```
2. Build LLVM: A dockerfile is provided in this repo to build llvm and run your tests. You can also build llvm directly from source https://github.com/llvm/llvm-project.git. This takes about 15 mins and could take about 20-30GB of your storage.
    ``` bash
    # Builds docker image, takes ~15mins
    make docker-build
    
    # Launch a bash shell into docker image and mounts repo dir as /work
    make shell
    ```
3. Code: You can code the passes in the src directory. A example CMakeLists.txt with a simple example source and header file are also provided. Update the CMakeLists.txt with the source and header files. Then compile your changes inside the docker environment. Note this creates a build directory in the repo folder.
    ``` bash
    make shell     # Enter docker.
    
    # The following commands only work in the docker shell
    
    make config                                                     # cmake configure setp 
    mkdir build && cd build && cmake .. -G Ninja && ninja toyc-ch1  # To build toy utility
    make clean                                                      # Removes build dir
    ```
4. Run the test cases
``` bash
make shell

# Modify script/runtest.sh and add your own tests in here
make test
```


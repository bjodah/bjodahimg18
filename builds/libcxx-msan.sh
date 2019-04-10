    curl -Ls https://github.com/llvm/llvm-project/archive/llvmorg-8.0.0.tar.gz | tar xz -C /tmp && \
    mkdir /tmp/build_libcxx_msan && cd /tmp/build_libcxx_msan && \
    cmake -DCMAKE_INSTALL_PREFIX=/opt/libcxx-8-msan -DCMAKE_BUILD_TYPE=Release -DLLVM_USE_SANITIZER=Memory -DCMAKE_C_COMPILER=clang-8 -DCMAKE_CXX_COMPILER=clang++-8 /tmp/llvm-project-llvmorg-8.0.0/libcxx && make install && \
    mkdir /tmp/build_libcxxabi_msan && cd /tmp/build_libcxxabi_msan && \
    CMAKE_PREFIX_PATH=/opt/libcxx-8-msan cmake -DCMAKE_INSTALL_PREFIX=/opt/libcxx-8-msan -DCMAKE_BUILD_TYPE=Release -DLLVM_USE_SANITIZER=Memory -DCMAKE_C_COMPILER=clang-8 -DCMAKE_CXX_COMPILER=clang++-8 /tmp/llvm-project-llvmorg-8.0.0/libcxxabi && make install && \

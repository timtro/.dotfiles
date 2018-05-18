#!/usr/bin/env bash

# Based on 

LLVM_CONFIG_PATH="/usr/bin/llvm-config-7"

svn co http://llvm.org/svn/llvm-project/libcxx/trunk libcxx
svn co http://llvm.org/svn/llvm-project/libcxxabi/trunk libcxxabi

mkdir -p libcxx/build libcxxabi/build

#To run libc++ on Linux one needs ABI compatibility to the standard library, e.g. libstdc++. This is where libc++abi comes into game. The only problem is that it needs libc++ to be on the system for which it is build. Thus libc++ is built in 2 steps. First: without any ABI compatibility. But it will be used for bootstrapping of ABI lib and than the second step is to recompile libc++ with the proper ABI present on system:

cd ./libcxx/build
cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_CONFIG_PATH=$LLVM_CONFIG_PATH\
      -DCMAKE_INSTALL_PREFIX=/usr ..
make
sudo make install
cd ../..

# Building libc++abi with libstdc++ compatible ABI:
cd libcxxabi/build
CPP_INCLUDE_PATHS=echo | c++ -Wp,-v -x c++ - -fsyntax-only 2>&1 \
  |grep ' /usr'|tr '\n' ' '|tr -s ' ' |tr ' ' ';'
CPP_INCLUDE_PATHS="/usr/include/c++/v1/;$CPP_INCLUDE_PATHS"
cmake -G "Unix Makefiles" -DLIBCXX_CXX_ABI=libstdc++ \
      -DLIBCXX_LIBSUPCXX_INCLUDE_PATHS="$CPP_INCLUDE_PATHS" \
      -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr \
      -DLLVM_CONFIG_PATH=$LLVM_CONFIG_PATH \
      -DLIBCXXABI_LIBCXX_INCLUDES=../../libcxx/include  ..
make
make test
sudo make install
cd ../..

# Rebuild libc++ with proper ABI lib deployed on system:
cd libcxx/build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr \
      -DLIBCXX_CXX_ABI=libcxxabi -DLLVM_CONFIG_PATH=$LLVM_CONFIG_PATH\
      -DLIBCXX_CXX_ABI_INCLUDE_PATHS=../../libcxxabi/include ..
make
make test
sudo make install
cd ../..

clang++-7 -std=c++17 -stdlib=libc++ -lc++abi -o strem  stream_tests.cpp
./stream
clang++-7 -std=c++17 -stdlib=libc++ -lc++abi -o vers  version_and_feature_detector.cpp
./vers

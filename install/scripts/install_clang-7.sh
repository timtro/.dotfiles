# /bin/bash

if [ ! -f /etc/apt/sources.list.d/llvm.list ]; then
cat << EOF > llvm.list
deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main
deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic main
# 5.0
deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-5.0 main
deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-5.0 main
# 6.0
deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-6.0 main
deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-6.0 main
EOF

sudo mv llvm.list /etc/apt/sources.list.d/.
fi


wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
# Fingerprint: 6084 F3CF 814B 57C1 CF12 EFD5 15CF 4D18 AF4F 7421

sudo apt update
sudo apt install clang-7 \
                  clang-tools-7 \
                  clang-7-doc \
                  libclang-common-7-dev \
                  libclang-7-dev \
                  libclang1-7 \
                  libllvm7 \
                  lldb-7 \
                  llvm-7 \
                  llvm-7-dev \
                  llvm-7-doc \
                  llvm-7-examples \
                  llvm-7-runtime \
                  clang-format-7 \
                  python-clang-7 \
                  lld-7 \
                  libfuzzer-7-dev

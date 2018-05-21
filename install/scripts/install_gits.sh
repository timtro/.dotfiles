#! /bin/bash

if [ ! -f ~/git ]; then
  mkdir ~/git
fi

cd ~/git
git clone https://github.com/kovidgoyal/kitty
git clone https://github.com/catchorg/Catch2
git clone https://github.com/nholthaus/units
git clone https://github.com/google/googletest
git clone https://github.com/google/benchmark
git clone https://github.com/ericniebler/range-v3
git clone https://github.com/boostorg/hana

cd kitty
make -j8

cd ..; cd Catch2
mkdir build; cd build
cmake ..
make -j8
make test
sudo make install

cd ~/git
cd units
mkdir build; cd build
cmake ..
make -j8
sudo make install

cd ~/git
cd googletest
mkdir build; cd build
cmake ..
make -j8
sudo make install

cd ~/git
cd benchmark
mkdir build; cd build
cmake ..
make -j8
make test
sudo make install

cd ~/git
cd range-v3
mkdir build; cd build
cmake ..
make -j8
make test
sudo make install

cd ~/git
cd hana
mkdir build; cd build
cmake ..
make -j8
sudo make install

git clone https://github.com/JetBrains/libdbusmenu.git
git -C libdbusmenu checkout d8a49303f908a272e6670b7cee65a2ba7c447875
cd ./libdbusmenu
CFLAGS="-Wno-error -fPIC" ./configure
gmake
cd ..
mkdir build
cd build
cmake ..
make

rm -rf config.h blocks
make clean
make || exit 1
sudo make install || exit 1


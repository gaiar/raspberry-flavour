export PERL_USE_UNSAFE_INC=1

./configure --prefix=$PREFIX
make -j4
make check
make install

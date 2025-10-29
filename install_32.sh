#!/bin/bash
set -euo pipefail

# Setup
cd ~/cross-gdb

# Create separate build and install directories (explicit i686 names)
mkdir -p build-binutils-i686 build-gdb-i686 install-i686

# Clean previous builds (optional)
rm -rf build-binutils-i686/* build-gdb-i686/*

# Define target and prefix
export TARGET=i686-elf
export PREFIX="$HOME/cross-gdb/install-i686"
export PATH="$PREFIX/bin:$PATH"

# Extract sources if not already present
[[ -d binutils-2.42 ]] || tar xf binutils-2.42.tar.gz
[[ -d gdb-13.2 ]] || tar xf gdb-13.2.tar.gz

# Build binutils
cd build-binutils-i686
../binutils-2.42/configure \
	--target=$TARGET \
	--prefix=$PREFIX \
	--with-sysroot \
	--disable-nls \
	--disable-werror
make -j"$(nproc)"
make install

# Build GDB
cd ~/cross-gdb/build-gdb-i686
../gdb-13.2/configure \
	--target=$TARGET \
	--prefix=$PREFIX \
	--with-python=/usr/bin/python3.11 \
	--disable-nls \
	--enable-tui \
	CC=/usr/bin/gcc-12
make -j"$(nproc)"
make install

echo "✅ Cross GDB for i686 ($TARGET) built successfully at: $PREFIX"

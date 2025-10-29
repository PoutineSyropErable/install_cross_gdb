#!/bin/bash
set -euo pipefail

# Setup
cd ~/cross-gdb

# Create separate build and install directories (explicit ia16 names)
mkdir -p build-binutils-ia16 build-gdb-ia16 install-ia16

# Clean previous builds (optional)
rm -rf build-binutils-ia16/* build-gdb-ia16/*

# Set environment variables
export TARGET=ia16-elf
export PREFIX="$HOME/cross-gdb/install-ia16"
export PATH="$PREFIX/bin:$PATH"

# Extract sources if not already present
[[ -d binutils-2.42 ]] || tar xf binutils-2.42.tar.gz
[[ -d gdb-13.2 ]] || tar xf gdb-13.2.tar.gz

# Build binutils
cd build-binutils-ia16
../binutils-2.42/configure \
	--target=$TARGET \
	--prefix=$PREFIX \
	--disable-nls \
	--disable-werror
make -j"$(nproc)"
make install

# Build GDB
cd ~/cross-gdb/build-gdb-ia16
../gdb-13.2/configure \
	--target=$TARGET \
	--prefix=$PREFIX \
	--with-python=/usr/bin/python3.11 \
	--disable-nls \
	--enable-tui \
	CC=/usr/bin/gcc-12
make -j"$(nproc)"
make install

echo "✅ Cross GDB for ia16 ($TARGET) built successfully at: $PREFIX"

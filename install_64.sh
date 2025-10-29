#!/usr/bin/env bash
set -euo pipefail

# Setup
cd ~/cross-gdb

# Create separate build and install directories (explicit x86_64 names)
mkdir -p build-binutils-x86_64 build-gdb-x86_64 install-x86_64

# Set up environment variables
export PREFIX="$HOME/cross-gdb/install-x86_64"
export TARGET=x86_64-elf
export PATH="$PREFIX/bin:$PATH"

# Clean previous builds (optional)
rm -rf build-binutils-x86_64/* build-gdb-x86_64/*

# Extract sources if not already present
[[ -d binutils-2.42 ]] || tar xf binutils-2.42.tar.gz
[[ -d gdb-13.2 ]] || tar xf gdb-13.2.tar.gz

# Build binutils
cd build-binutils-x86_64
../binutils-2.42/configure \
	--target=$TARGET \
	--prefix=$PREFIX \
	--with-sysroot \
	--disable-nls \
	--disable-werror
make -j"$(nproc)"
make install

# Build GDB
cd ~/cross-gdb/build-gdb-x86_64
../gdb-13.2/configure \
	--target=$TARGET \
	--prefix=$PREFIX \
	--with-python=/usr/bin/python3.11 \
	--disable-nls \
	--enable-tui \
	CC=/usr/bin/gcc-12
make -j"$(nproc)"
make install

echo "✅ Cross GDB for x86_64 ($TARGET) built successfully at: $PREFIX"

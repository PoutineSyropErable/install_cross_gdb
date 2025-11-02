#!/usr/bin/env bash
set -euo pipefail

# Setup
cd ~/cross-gdb-new

# Create separate build and install directories (explicit ia16 names)
mkdir -p build-binutils-ia16 build-gdb-ia16 install-ia16

# Clean previous builds (optional)
rm -rf build-binutils-ia16/* build-gdb-ia16/*

# Set environment variables
export TARGET=ia16-elf
export PREFIX="$HOME/cross-gdb-new/install-ia16"
export PATH="$PREFIX/bin:$PATH"

# Extract sources if not already present
[[ -d binutils-2.45 ]] || tar xf binutils-2.45.tar.gz
[[ -d gdb-16.3 ]] || tar xf gdb-16.3.tar.gz

# Build binutils
cd build-binutils-ia16
../binutils-2.45/configure \
	--target=$TARGET \
	--prefix=$PREFIX \
	--disable-nls \
	--disable-werror
make -j"$(nproc)"
make install

# Build GDB
cd ~/cross-gdb/build-gdb-ia16
../gdb-16.3/configure \
	--target=$TARGET \
	--prefix=$PREFIX \
	--with-python=/usr/bin/python3 \
	--disable-nls \
	--enable-tui \
	CC=gcc
make -j"$(nproc)"
make install

echo "✅ Cross GDB for ia16 ($TARGET) built successfully at: $PREFIX"

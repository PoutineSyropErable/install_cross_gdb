#!/usr/bin/env bash
set -euo pipefail

# Setup
CROSS_DIR="$HOME/cross-gdb-new"
cd "$CROSS_DIR"

# Create separate build and install directories (explicit i686 names)
mkdir -p build-binutils-i686 build-gdb-i686 install-i686

# Clean previous builds (optional)
rm -rf build-binutils-i686/* build-gdb-i686/*

# Define target and prefix
export TARGET=i686-elf
export PREFIX="$CROSS_DIR/install-i686"
export PATH="$PREFIX/bin:$PATH"

# Extract sources if not already present
[[ -d binutils-2.45 ]] || tar xf binutils-2.45.tar.gz
[[ -d gdb-16.3 ]] || tar xf gdb-16.3.tar.gz

# Build binutils
cd build-binutils-i686
../binutils-2.45/configure \
	--target=$TARGET \
	--prefix=$PREFIX \
	--with-sysroot \
	--disable-nls \
	--disable-werror
make -j"$(nproc)"
make install

# Build GDB
cd "$CROSS_DIR/build-gdb-i686"
../gdb-16.3/configure \
	--target=$TARGET \
	--prefix=$PREFIX \
	--with-python=/usr/bin/python3.11 \
	--disable-nls \
	--enable-tui \
	CC=/usr/bin/gcc
make -j"$(nproc)"
make install

echo "✅ Cross GDB for i686 ($TARGET) built successfully at: $PREFIX"

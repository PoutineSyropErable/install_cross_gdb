#!/usr/bin/env bash
set -euo pipefail

# --- Install host dependencies ---
yay -S --needed gcc12 python311

# --- Setup directories ---
CROSS_DIR="$HOME/cross-gdb-new"
mkdir -p "$CROSS_DIR"

# --- Binutils variables ---
BINUTILS_FILE="binutils-2.45.tar.gz"
BINUTILS_URL="https://ftp.gnu.org/gnu/binutils/$BINUTILS_FILE"
BINUTILS_PATH="$CROSS_DIR/$BINUTILS_FILE"

# --- GDB variables ---
GDB_FILE="gdb-16.3.tar.gz"
GDB_URL="https://ftp.gnu.org/gnu/gdb/$GDB_FILE"
GDB_PATH="$CROSS_DIR/$GDB_FILE"

# --- Download Binutils if needed ---
if [[ ! -f "$BINUTILS_PATH" ]]; then
	wget -O "$BINUTILS_PATH" "$BINUTILS_URL"
else
	echo "$BINUTILS_FILE already exists, skipping download."
fi

# --- Download GDB if needed ---
if [[ ! -f "$GDB_PATH" ]]; then
	wget -O "$GDB_PATH" "$GDB_URL"
else
	echo "$GDB_FILE already exists, skipping download."
fi

# --- Build cross-GDB toolchains ---
./install_16.sh
./install_32.sh
./install_64.sh

echo "✅ All cross-GDB toolchains (ia16, i686, x86_64) installed successfully."

./move_to_user_local_syswide.sh
